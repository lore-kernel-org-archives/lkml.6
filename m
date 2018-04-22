Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49oBvad5GM+vslivykK7AdcZl+4bNju9AdIvtSuGlD8IgHAkQ6lTyH5sNLRCPjGGDcwrX8s
ARC-Seal: i=1; a=rsa-sha256; t=1524406120; cv=none;
        d=google.com; s=arc-20160816;
        b=AAu4Zr7x7Dk6NIaGDaV9NKqTGQtoGt9ptqasp44p1u3YScDQVMra/uMdWhvdF/4STs
         2O74BzQV4NMkEC/sat2FDS0I1lfLDtyIHxLpwNKzIUHHSdz8Zr7DU2Y0rnJcXZYoHdcD
         b0UiKxL63VjY/P7FPMc0ZoheV/dsClG9jednhTR7P8D7V7dXw+ncKyav/f3HSpLArcFk
         siEj/G99px3zL4RgyHe41jSpU7b7+o1Nww3QUTuJ0Z0VLVshO7zHMEi1EElBloiw22RA
         vE7z8iRiCFh+SIlhiMZhVtjw+OYDcfwzw7wTQe2A85iYJdiAStzeyTX7Qce+707esKHd
         0FXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZXXa6IE8nmK7+UUqMj/ZtgXfXvZYN+fEXSrhfD7JOkg=;
        b=BHa8tCOJzJss3q4++pjGpwA7YHiZ0KaX5UtwGTpy6xQ4HuLRhKWNe9ThuC6g8ZLAU9
         Q8GYeK+vYnC7b9HhbNMCyErmtZgD6Ygox5gh0yYPmIM/iZf5RXDmq0axk3+dk2hZcw46
         0F0cmknIzPSinPUUrsXD84sb42k8yp7T2rxqdiP8uT94jKSGgyqxftqJovD3cCtDVFqR
         Kr+X4kvJA1Xo6IT1J/QCIYTfw3ebeijR4Uo1T2QXwMGlPa05XZ3hBsx5OatCIsADdaYB
         i5Xy8Q0atF3eBJQsb7OduuzuHa/RQWdjBDhNXfrLaBm1GsUV+bwXwcz74a6G+BiP+d3S
         HiGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bas Nieuwenhuizen <basni@chromium.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 121/164] drm/amdgpu: Fix always_valid bos multiple LRU insertions.
Date: Sun, 22 Apr 2018 15:53:08 +0200
Message-Id: <20180422135140.362057993@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455202380225514?=
X-GMAIL-MSGID: =?utf-8?q?1598455672563002822?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bas Nieuwenhuizen <basni@chromium.org>

commit a20ee0b1f8b42e2568f3a4408003d22b2dfcc706 upstream.

If these bos are evicted and are in the validated list
things blow up, so do not put them in there. Notably,
that tries to add the bo to the LRU twice, which results
in a BUG_ON in ttm_bo.c.

While for the bo_list an alternative would be to not allow
always valid bos in there, that does not work for the user
fence.

v2: Fixed whitespace issue pointed out by checkpatch.pl

Signed-off-by: Bas Nieuwenhuizen <basni@chromium.org>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |    6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |    2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -233,8 +233,10 @@ void amdgpu_bo_list_get_list(struct amdg
 	for (i = 0; i < list->num_entries; i++) {
 		unsigned priority = list->array[i].priority;
 
-		list_add_tail(&list->array[i].tv.head,
-			      &bucket[priority]);
+		if (!list->array[i].robj->parent)
+			list_add_tail(&list->array[i].tv.head,
+				      &bucket[priority]);
+
 		list->array[i].user_pages = NULL;
 	}
 
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -522,7 +522,7 @@ static int amdgpu_cs_parser_bos(struct a
 	INIT_LIST_HEAD(&duplicates);
 	amdgpu_vm_get_pd_bo(&fpriv->vm, &p->validated, &p->vm_pd);
 
-	if (p->uf_entry.robj)
+	if (p->uf_entry.robj && !p->uf_entry.robj->parent)
 		list_add(&p->uf_entry.tv.head, &p->validated);
 
 	if (need_mmap_lock)
