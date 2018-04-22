Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4//o3xsINp7sSX66PxD4ABmkL4K8bRCG3gbGF0qDRM4wY3+KQod010rB6JmdWunMggP//Sf
ARC-Seal: i=1; a=rsa-sha256; t=1524406519; cv=none;
        d=google.com; s=arc-20160816;
        b=EKURfOYav2iSFvOLVclizgEDFcw1rFJYTY+Csm5o3EOoDxebnsM99r5ApiodX8hlOr
         Ym9CiwPVXhuBisVgq6iZYhEFAvHeVcGa3hBA57dXMJcHvXAKU8iWuWOz46ZnTKHElO0D
         xmDOTzC5bpvOKlr1xg94PSgTjJXFcgQU37iTDg3/dLv87f15MLafwLAQE0BrGIS5W0bF
         5XhXB/vsJVCtCdZ9wuP49g9pp8bd4MpQ1mZeywNLlMfamwlzoTK2cIJWHxzFL5MRf+rM
         LcX2BfG1ovQ4WkYIKfL8oGTxacAgkgJvHYvrT2MujV6ngg6pzuEbVOMfq9Yg2Fsruft9
         Beog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=n1+igLkK2/EvFHeBdJzvmei3V4ZyoueIOCJdXPqWZAs=;
        b=GB4s8L5HjAVC6aC6FKl2kDZgINCMr6T5YcRee8k1OedM6rzJXbR2w3mbi1pkdz3YZa
         789bNb9t2KrHE36/sUGufaNnu7j2eALcqN9/wfmjZcxheTgbxMUDWyhIGIp1zCwxd6ZN
         kI9BT+7iGpl+fFdOkKIPBMYvU3UrBAi6oLBq8pWIh9xmKVMvoZts4B+MrvV/pas4EGz2
         B7i4dC/C7nx/GG1WNybFgzkkucIfOkL7uwKKW7V8XTx7GmBTjfLD7ueleCHtnoZYfFbF
         JFbbK0+NiZnD8jqLrZucWKw1CXXZkwJlmhIlvvRdSTaMD/HXJRaQm7VNGBaLstgQD7kY
         UaCw==
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
Subject: [PATCH 4.9 67/95] drm/amdgpu: Fix always_valid bos multiple LRU insertions.
Date: Sun, 22 Apr 2018 15:53:36 +0200
Message-Id: <20180422135213.168346682@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455202380225514?=
X-GMAIL-MSGID: =?utf-8?q?1598456090860480887?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -201,8 +201,10 @@ void amdgpu_bo_list_get_list(struct amdg
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
@@ -519,7 +519,7 @@ static int amdgpu_cs_parser_bos(struct a
 	INIT_LIST_HEAD(&duplicates);
 	amdgpu_vm_get_pd_bo(&fpriv->vm, &p->validated, &p->vm_pd);
 
-	if (p->uf_entry.robj)
+	if (p->uf_entry.robj && !p->uf_entry.robj->parent)
 		list_add(&p->uf_entry.tv.head, &p->validated);
 
 	if (need_mmap_lock)
