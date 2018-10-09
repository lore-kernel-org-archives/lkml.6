Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74667C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DE1214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="BlG1+qpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DE1214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeJIS3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:29:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33928 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbeJIS3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:29:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id g12-v6so659407pgs.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QBiCuSqsQ6+WNR8FSQ49WJsMpNMaJzrhxrzA2Q/GNME=;
        b=BlG1+qpffgM7kMthTojQIdEQPtFLTeu0V2EPszpeVWWFUvj3VUfV1SYOSM842Z588o
         a9qbdxea1eGGy5/nfYnmPj6oGwVV7iMPj3fWqO5NoQEtyhvu/C62uOoDgJ7b+chcem3b
         U7I3wQS1mYvyx3d2X6dBJL44Ya2b9jWFpygzh7hiotfXsStZP1QZoqj3FHsn+89CQO7b
         8D1TESN3NALLMA2/YLggPdt4m32M/8pUbFp5YQS0FoyKZPkldweTeGmXAB1wNF6hfWx5
         9EFXdaO2jtwuwPFoJyF9za8jLUDAMvceUI5oVFUZaRTkROSbNt9SGUJ8eAnddtuB0Rze
         morA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QBiCuSqsQ6+WNR8FSQ49WJsMpNMaJzrhxrzA2Q/GNME=;
        b=X1oOBrcfcW30cuA0Z0YedY+qqmcgpRnBkUccJzVsDGrgCxng+YDa/lGbEK9wrBgsi8
         fkEFHjWULg6OQPvmBWJHTGX0OmD8gikbFGauvIEgkFjJohRehHpXJ6z76SekzQIx+JGC
         nLcQCO8tm2ePCGQ978vgBaKGDElNV+tmrrik5qD0ojDqm9kbllM8MCUuqzJJ/y059OoH
         rOaPKUhpA0Rcjm73px+GRP6oPjV80IK3lbWKx2kbN7zEzE75qMPQxdfWRodnfUz35LKS
         oxskr6VU2TtSTYyRR/EPAB3taincj4b+hdS9RG2ul1/++v5dO6CpBb98LK2grioeC5V0
         M22A==
X-Gm-Message-State: ABuFfogK3nRvbl+r+HWEgaj0RS767o74aYlcBe8kfF8ZJ091+0q3e7TB
        XsV0mmrDLaGzc6zk+RngHGZgxw==
X-Google-Smtp-Source: ACcGV600mZpP5F098LsD2ceh3xX9/sZeD7IOkgKVb5Y3F9S7UxFa2L8eBfoCJNRc2+VYUMfGP41ZfQ==
X-Received: by 2002:a62:3047:: with SMTP id w68-v6mr5073292pfw.19.1539083607605;
        Tue, 09 Oct 2018 04:13:27 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:13:26 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 04/45] lightnvm: move device L2P detection to core
Date:   Tue,  9 Oct 2018 13:11:34 +0200
Message-Id: <20181009111215.7653-5-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 1.2 device is able to manage the logical to physical mapping
table internally or leave it to the host.

A target only supports one of those approaches, and therefore must
check on initialization. Move this check to core to avoid each target
implement the check.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c      | 5 +++++
 drivers/lightnvm/pblk-init.c | 7 -------
 include/linux/lightnvm.h     | 6 ++++++
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 68553c7ae937..964352720a03 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -355,6 +355,11 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 		return -EINVAL;
 	}
 
+	if ((tt->flags & NVM_TGT_F_HOST_L2P) != (dev->geo.dom & NVM_RSP_L2P)) {
+		pr_err("nvm: device is incompatible with target L2P type.\n");
+		return -EINVAL;
+	}
+
 	if (nvm_target_exists(create->tgtname)) {
 		pr_err("nvm: target name already exists (%s)\n",
 							create->tgtname);
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 537e98f2b24a..039f62d05e84 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1210,13 +1210,6 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (geo->version == NVM_OCSSD_SPEC_12 && geo->dom & NVM_RSP_L2P) {
-		pblk_err(pblk, "host-side L2P table not supported. (%x)\n",
-							geo->dom);
-		kfree(pblk);
-		return ERR_PTR(-EINVAL);
-	}
-
 	spin_lock_init(&pblk->resubmit_lock);
 	spin_lock_init(&pblk->trans_lock);
 	spin_lock_init(&pblk->lock);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 8acc2fe277d6..f4a84694e5e2 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -495,9 +495,15 @@ typedef void (nvm_tgt_exit_fn)(void *, bool);
 typedef int (nvm_tgt_sysfs_init_fn)(struct gendisk *);
 typedef void (nvm_tgt_sysfs_exit_fn)(struct gendisk *);
 
+enum {
+	NVM_TGT_F_DEV_L2P = 0,
+	NVM_TGT_F_HOST_L2P = 1 << 0,
+};
+
 struct nvm_tgt_type {
 	const char *name;
 	unsigned int version[3];
+	int flags;
 
 	/* target entry points */
 	nvm_tgt_make_rq_fn *make_rq;
-- 
2.17.1

