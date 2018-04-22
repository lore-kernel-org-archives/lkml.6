Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+jF87ZLnvyxPG2wm8/2dUVBm2GN8oj6p/X0qSVWqyRveJz8puzTbx8UWRDHmDXwLTYpbL6
ARC-Seal: i=1; a=rsa-sha256; t=1524405672; cv=none;
        d=google.com; s=arc-20160816;
        b=kGHhSBqyWpzbtEUm1nEaG599yaSbtvD3qQGPf3nddv2VDxU/M16IlUXEeN7tYRcKxl
         GsHr/1yCDJdQk0/yhKbGQdnmMnvBn/SfiFPP6g2TOZfrfA8P3rVRsNHLz3LYMzUooUl/
         9Zh2gTnuknI8dJ/HUPP0WL30k00q5NHJRWcGR+fxYJmnEFrWjiOTiq7ld+jAoru0f1yA
         tjXPvorkm2ZLHWs6j3BFGr2C4qLA/+cUWOmbewU/q+edvDrL/qOPCmU7qY5D2xJ+35Z0
         oNYr08RLR4c9w9A6+suQKsL1opTZX0nvhiT+799VDp4zOfeqjdGEKTLMS4kiQknjrUpZ
         YOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Uz5QCxbXWPpOWBgEbUDNWClhltcayp1djXTTc1Sxt+8=;
        b=XlTrxO68NHRqq2NAF1J+1XOE3tDO8ktoB2EcXqpvZWfvW05P3asr0IxgQqPKBn9zh4
         cAILGM6mKBkOU6VIJb6iUU4p98s11Z9/66mZMi1NArRpAQSMim8ia+hO2PR/kZKKWH15
         Dp/UkLgGDhEMjJeGqTFJOTgz/Qf/R7hLwQtjp67lnPrvGFbHOf241ZOBQsVA+fTvXLVF
         BsLDVxjXcj+JpyLFUo+eA4TYIn7iJaX7ZVN5mpVAFafRwCMAMhRO3PaaLrQ2HS1fpLuB
         LBH2xzfgmhiFVuYngymsOLK2bA+XZTAwIj4wibha5+iFgmtqKVtUof4hyK6Ou0Q633Gg
         lbbQ==
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
Subject: [PATCH 4.16 151/196] drm/amdgpu: Fix always_valid bos multiple LRU insertions.
Date: Sun, 22 Apr 2018 15:52:51 +0200
Message-Id: <20180422135112.043477422@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455202380225514?=
X-GMAIL-MSGID: =?utf-8?q?1598455202380225514?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -542,7 +542,7 @@ static int amdgpu_cs_parser_bos(struct a
 	INIT_LIST_HEAD(&duplicates);
 	amdgpu_vm_get_pd_bo(&fpriv->vm, &p->validated, &p->vm_pd);
 
-	if (p->uf_entry.robj)
+	if (p->uf_entry.robj && !p->uf_entry.robj->parent)
 		list_add(&p->uf_entry.tv.head, &p->validated);
 
 	while (1) {
