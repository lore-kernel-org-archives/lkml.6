Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84F9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3B1208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIJh3ceo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3B1208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754852AbeFRGHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:07:21 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45733 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754458AbeFRGHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:07:20 -0400
Received: by mail-lf0-f67.google.com with SMTP id a13-v6so2654645lfk.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 23:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TYdgGtAUZgdonklPmw9db3u5DotkG5GQ4FXvZy0fcaU=;
        b=cIJh3ceoKKMPGqN6263C3kp2uHTO7pdHWpHVhIzQDVMxFqg4kMfu6QF2K8l6hdufvC
         h5hc36ScI59DU3Zv+qG+q8eNp+XaqO2+6gNtaf4CWT5j992hqu8m3T0OsdnzKPVo4OSo
         djTfK/zTPcrJKX0oWTJCv6sPOSW0vGSWTu+i8G/LuaM1QmFYh0K10yHj9BjkSKPJEzud
         LDBf+mMx5acu5yhA8ly0LgWiZFJIiBqBo0H0Qg1R62QvmY3+Ulj6BjTwvZaqEcmiGI1C
         CIDMD+SXTn5KE68qKKU4oubv8Gu2bboNqaqzaoGv4MS5nL+wIGHYWgycFmEfq7YZnY6R
         rzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TYdgGtAUZgdonklPmw9db3u5DotkG5GQ4FXvZy0fcaU=;
        b=KyCksot16GaHyGwMTaj0kkdNSDy+hmfJ9n6cHHwGqzC+olHql0S1oSdwEF4JkXELgT
         MOITH7b4ptaHLX1KUcSM9YHmgcVnk5PI6k1LIBfI4xhMbYOJlUcabvsucsl5pchKS3ir
         hvoYZU3S1RPcZIWq6x/CDl5EFTBsXsT4smgiHQtnDGff9EHDjNFPBydVNLmYQmGFkZDe
         vMHh2x/WPubnroSdDXJQ5F9iWFHh5nBcKI2qk2PQXYsDaq4oJgI/QejO+OxZzCfSzT5f
         UaxGCnTxBurPANYwALN3IQB60EEIlTox7ASRlYvfSClnRE9pKCNAigT7b6WCNLHZo+Cj
         ciKQ==
X-Gm-Message-State: APt69E34X43hyiKdIS3iU17Ii3cngxl6iXtI+IKTg3zgb6mBXHVpxVmT
        0jZ7CuejvyXCuSjSEvqhmNo=
X-Google-Smtp-Source: ADUXVKLnzyTJW6OKQgjnKJwGaahH37KoBRalm2pjw6d4KIKgugpl8ll1l4p8OPAY/RhMHVmrPm4L1g==
X-Received: by 2002:a19:f03:: with SMTP id e3-v6mr4137607lfi.83.1529302038711;
        Sun, 17 Jun 2018 23:07:18 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id c74-v6sm2627134lfh.78.2018.06.17.23.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jun 2018 23:07:17 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        dan.carpenter@oracle.com
Cc:     andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v2] drm: Replace NULL with error value in drm_prime_pages_to_sg
Date:   Mon, 18 Jun 2018 09:07:09 +0300
Message-Id: <20180618060709.14290-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Dan Carpenter has reported that there is the following static checker
warning:
	drivers/gpu/drm/drm_prime.c:317 drm_gem_map_dma_buf()
	warn: 'sgt' can also be NULL

314	sgt = obj->dev->driver->gem_prime_get_sg_table(obj);
315
316	if (!IS_ERR(sgt)) {
317		if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,

Problematic functions are xen_drm_front_gem_get_sg_table and
drm_gem_cma_prime_get_sg_table. Fix those by replacing NULL with error value.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/drm_gem_cma_helper.c    | 2 +-
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index 80a5115c3846..ce868ce288fb 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -436,7 +436,7 @@ struct sg_table *drm_gem_cma_prime_get_sg_table(struct drm_gem_object *obj)
 
 	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
 	if (!sgt)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	ret = dma_get_sgtable(obj->dev->dev, sgt, cma_obj->vaddr,
 			      cma_obj->paddr, obj->size);
diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index c85bfe7571cb..47ff019d3aef 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -179,7 +179,7 @@ struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
 	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
 
 	if (!xen_obj->pages)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
 }
-- 
2.17.1

