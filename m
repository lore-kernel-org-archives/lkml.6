Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqWaspGwuib7jqzN3YHTQ5mBve2bA40HWBKSoR0eX2SuoG8IWrxcUDjm7ihV3EQM/cMMp0z
ARC-Seal: i=1; a=rsa-sha256; t=1526281181; cv=none;
        d=google.com; s=arc-20160816;
        b=oVUkmbvwzwFuUOz2GNXuBx8xXYpUySsA7UmjJ1eMd6lsgYGhi3mXtBuRzng13/KhZ3
         VoIXWzI0uZlqAPsq4p2JkTgG6WNFO0kIRaaGGAn8ROXB71OIVVDeuYujooCxFPmDyzHV
         KaCCy7+kjl6iSShN/aCE8+T5Lu5M+DNq7WLGJwRF35dRmO49a1KDclVZ7CXAmjYitmJI
         d+5TWch2zBAQqDp8pMJpmLRV5xw2kjWegPevV9MJckZphFUFZ+1HkkLXm6ei5uBtBpsZ
         uJCUYK1EwYevhTsf+oVTK8/3EDP8l9azg+vB/U/M3T41GML0JlaAwAtQrNxLLkAIJGdM
         b9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=qpsQSRRae3to0hOdQjIuaPRhx9KoSE6LJC26lgw1zn0=;
        b=Wdhj7NoHRDRZlWakhkFERyUfEcA4b8Im9W5mhS1n0PL3l+NoqCH8iynQE1WhuDuFbf
         uaLy6nBwo4n2ktX6iaeHttrmNAu9I4g/352zERdnZUlK/orsF0PWM+G/jihfuN1t2sPy
         zj0NEUIsosis4ko+oGO55xXsyGM9GVRn3l1Noxylhy0aRllXNK0sPux1KJV/DOIEwrI4
         LrEz8Qh3h63QutzPaUFknK4Hb+lBsfq4kCxfLgJRnW6/1yh8jqIXU+hSnOr+ASdZnK+E
         LBCl7ZnUMKbKz9Fxaa2aTMCRIF4O2Vk6FJ98eERtivTESdrrdqrkHx5tV27W0j/NjCqH
         5Few==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NZeBDsBr;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NZeBDsBr;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.16 47/72] drm/nouveau/ttm: dont dereference nvbo::cli, it can outlive client
Date: Mon, 14 May 2018 08:49:04 +0200
Message-Id: <20180514064825.195750929@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421816026035020?=
X-GMAIL-MSGID: =?utf-8?q?1600421816026035020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Skeggs <bskeggs@redhat.com>

commit 0d5a03c3d9254813ca76d7886ff9ed76a0aea545 upstream.

Potentially responsible for some random OOPSes.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Cc: stable@vger.kernel.org [v4.15+]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/nouveau_bo.c  |    1 -
 drivers/gpu/drm/nouveau/nouveau_bo.h  |    2 --
 drivers/gpu/drm/nouveau/nouveau_ttm.c |    6 +++---
 3 files changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -214,7 +214,6 @@ nouveau_bo_new(struct nouveau_cli *cli,
 	INIT_LIST_HEAD(&nvbo->entry);
 	INIT_LIST_HEAD(&nvbo->vma_list);
 	nvbo->bo.bdev = &drm->ttm.bdev;
-	nvbo->cli = cli;
 
 	/* This is confusing, and doesn't actually mean we want an uncached
 	 * mapping, but is what NOUVEAU_GEM_DOMAIN_COHERENT gets translated
--- a/drivers/gpu/drm/nouveau/nouveau_bo.h
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.h
@@ -26,8 +26,6 @@ struct nouveau_bo {
 
 	struct list_head vma_list;
 
-	struct nouveau_cli *cli;
-
 	unsigned contig:1;
 	unsigned page:5;
 	unsigned kind:8;
--- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
@@ -63,7 +63,7 @@ nouveau_vram_manager_new(struct ttm_mem_
 			 struct ttm_mem_reg *reg)
 {
 	struct nouveau_bo *nvbo = nouveau_bo(bo);
-	struct nouveau_drm *drm = nvbo->cli->drm;
+	struct nouveau_drm *drm = nouveau_bdev(bo->bdev);
 	struct nouveau_mem *mem;
 	int ret;
 
@@ -103,7 +103,7 @@ nouveau_gart_manager_new(struct ttm_mem_
 			 struct ttm_mem_reg *reg)
 {
 	struct nouveau_bo *nvbo = nouveau_bo(bo);
-	struct nouveau_drm *drm = nvbo->cli->drm;
+	struct nouveau_drm *drm = nouveau_bdev(bo->bdev);
 	struct nouveau_mem *mem;
 	int ret;
 
@@ -131,7 +131,7 @@ nv04_gart_manager_new(struct ttm_mem_typ
 		      struct ttm_mem_reg *reg)
 {
 	struct nouveau_bo *nvbo = nouveau_bo(bo);
-	struct nouveau_drm *drm = nvbo->cli->drm;
+	struct nouveau_drm *drm = nouveau_bdev(bo->bdev);
 	struct nouveau_mem *mem;
 	int ret;
 
