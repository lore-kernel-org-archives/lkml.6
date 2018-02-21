Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2250dMw1GnAeFfvTuGTgSUkcR51yB2cMOqZ6J+MS1RiInJ6tt2UxdUxTliH/Y9c0pvHaaw3h
ARC-Seal: i=1; a=rsa-sha256; t=1519218116; cv=none;
        d=google.com; s=arc-20160816;
        b=KJJImGZSIUGfJWAs8v2OCZI9tfUYgx9XFUN722vitVc+UvfdWzirhaUKTV4XSKHdd4
         JS03fg2nqM3OWA0VbDH7RDPezfHp0a1LlXFkKxQ/ahkSkkPg0ftaHLOvQoONQV8T9lX6
         vnKoAO/qnivBWuOWx5I+Tc8n+kkssLNtcrvG+ZyOMvjvef05AHSSsxzJ6QjbDY5wWaes
         G7D3D31aA/ExzT+daiXS8M5KkvPu30BuKB1KvEdLhaZnQml1/1zbBi7+JgKCG6QCojUe
         adhCQKp8CKLa/uBGO4rU8aTM470V4oaUjETbqhxg5rCEyBG+zZIOeCGUjJkvnyAAWAMz
         jWkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2MyYMAmoh1cCpST3PFbe2Kts4nPVfB48yRd92p00DNI=;
        b=EDYHxUWwHf6tpLHdSayNn2rKNFun5zYeF5k31J9Ld+FungLRPEZ3zr4rdDz4wGqfA8
         jnvlaOsPAkQvSitGjm6NWFMNGk2XI7D9lfFrx+tGQ6+vDrEa+IpOcPBeIgHIKxHqH7Ns
         mdrgYc/02B9BSXr4uau7ODzYc/rMoDn4M5ECzDqYldGlggVt/NwOmkuCrPwKvJSio3Rf
         CCJhdn7AOpx+QrdqLIjJWjs7OvDhUlBCZ8jMkhumt6AiCvk5JqzmGy7KlfclSM3AsY8b
         m93ABJtP8oRQ5xXXEOs+xZ5m22JSZxNUhNfn96X72UIuj6XmM2x2WIKVyTqdKNgZ1et+
         jv1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 090/167] drm/ttm: Dont add swapped BOs to swap-LRU list
Date: Wed, 21 Feb 2018 13:48:21 +0100
Message-Id: <20180221124529.313391102@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015655531949481?=
X-GMAIL-MSGID: =?utf-8?q?1593015655531949481?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Kuehling <Felix.Kuehling@amd.com>

commit fd5002d6a3c602664b07668a24df4ef7a43bf078 upstream.

A BO that's already swapped would be added back to the swap-LRU list
for example if its validation failed under high memory pressure. This
could later lead to swapping it out again and leaking previous swap
storage.

This commit adds a condition to prevent that from happening.

v2: Check page_flags instead of swap_storage

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/ttm/ttm_bo.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -175,7 +175,8 @@ void ttm_bo_add_to_lru(struct ttm_buffer
 		list_add_tail(&bo->lru, &man->lru[bo->priority]);
 		kref_get(&bo->list_kref);
 
-		if (bo->ttm && !(bo->ttm->page_flags & TTM_PAGE_FLAG_SG)) {
+		if (bo->ttm && !(bo->ttm->page_flags &
+				 (TTM_PAGE_FLAG_SG | TTM_PAGE_FLAG_SWAPPED))) {
 			list_add_tail(&bo->swap,
 				      &bo->glob->swap_lru[bo->priority]);
 			kref_get(&bo->list_kref);
