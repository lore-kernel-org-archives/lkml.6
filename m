Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECB2C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E414820879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170098;
	bh=RBtl9EAyNklUXg2EmS5UmrMUyGB94Y/v1rinAVtvXL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xyiegeiFDLxVvtaNAJRol7wsH95CuRvv/3mrrYjs+MqkepzrSuMwv3ws/7HftTOT0
	 bQTLJ+S6n1IyHghqXMKgpdLSsb26M1bobDmnj3NeF9pc3//Xz85sVyMTWEsI7L3pok
	 syG1UXf5+nr0L2nJB3K2HCEbNtu54OFRo9RaCG4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfAVPOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:14:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbfAVPOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:14:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31AE7217D4;
        Tue, 22 Jan 2019 15:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170092;
        bh=RBtl9EAyNklUXg2EmS5UmrMUyGB94Y/v1rinAVtvXL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thb4+7klLk/tbUGAFKXJbvEi9Ugc+4XLHxi8GC//bFBuZi4WORlSDHMp3pg/zlj7b
         +kxI6tO9Wb0BnCPkQFXmoHbFeEcgvZeNpNd2vvZtFVKr1y3HxVl6V3U2nZZkK1tm69
         rgO4yymmwM+A43uwMG95YlWmazENRoL61GKB6d/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Subject: [PATCH 7/7] crypto: caam: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:14:22 +0100
Message-Id: <20190122151422.14204-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122151422.14204-1-gregkh@linuxfoundation.org>
References: <20190122151422.14204-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/caam/ctrl.c   | 21 ++++++---------------
 drivers/crypto/caam/intern.h |  1 -
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 16bbc72f041a..87c13fb6028c 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -863,27 +863,18 @@ static int caam_probe(struct platform_device *pdev)
 	/* Internal covering keys (useful in non-secure mode only) */
 	ctrlpriv->ctl_kek_wrap.data = (__force void *)&ctrlpriv->ctrl->kek[0];
 	ctrlpriv->ctl_kek_wrap.size = KEK_KEY_SIZE * sizeof(u32);
-	ctrlpriv->ctl_kek = debugfs_create_blob("kek",
-						S_IRUSR |
-						S_IRGRP | S_IROTH,
-						ctrlpriv->ctl,
-						&ctrlpriv->ctl_kek_wrap);
+	debugfs_create_blob("kek", S_IRUSR | S_IRGRP | S_IROTH, ctrlpriv->ctl,
+			    &ctrlpriv->ctl_kek_wrap);
 
 	ctrlpriv->ctl_tkek_wrap.data = (__force void *)&ctrlpriv->ctrl->tkek[0];
 	ctrlpriv->ctl_tkek_wrap.size = KEK_KEY_SIZE * sizeof(u32);
-	ctrlpriv->ctl_tkek = debugfs_create_blob("tkek",
-						 S_IRUSR |
-						 S_IRGRP | S_IROTH,
-						 ctrlpriv->ctl,
-						 &ctrlpriv->ctl_tkek_wrap);
+	debugfs_create_blob("tkek", S_IRUSR | S_IRGRP | S_IROTH, ctrlpriv->ctl,
+			    &ctrlpriv->ctl_tkek_wrap);
 
 	ctrlpriv->ctl_tdsk_wrap.data = (__force void *)&ctrlpriv->ctrl->tdsk[0];
 	ctrlpriv->ctl_tdsk_wrap.size = KEK_KEY_SIZE * sizeof(u32);
-	ctrlpriv->ctl_tdsk = debugfs_create_blob("tdsk",
-						 S_IRUSR |
-						 S_IRGRP | S_IROTH,
-						 ctrlpriv->ctl,
-						 &ctrlpriv->ctl_tdsk_wrap);
+	debugfs_create_blob("tdsk", S_IRUSR | S_IRGRP | S_IROTH, ctrlpriv->ctl,
+			    &ctrlpriv->ctl_tdsk_wrap);
 #endif
 	return 0;
 
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index babc78abd155..5869ad58d497 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -106,7 +106,6 @@ struct caam_drv_private {
 	struct dentry *dfs_root;
 	struct dentry *ctl; /* controller dir */
 	struct debugfs_blob_wrapper ctl_kek_wrap, ctl_tkek_wrap, ctl_tdsk_wrap;
-	struct dentry *ctl_kek, *ctl_tkek, *ctl_tdsk;
 #endif
 };
 
-- 
2.20.1

