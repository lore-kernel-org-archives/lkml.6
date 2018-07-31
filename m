Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C822C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367C720870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AAyiPCtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367C720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732705AbeGaVfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:35:05 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46971 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732438AbeGaVd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:33:58 -0400
Received: by mail-pl0-f66.google.com with SMTP id t17-v6so7617303ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=45iL7Ldcofjua4QTthWpvp4bypb36mbYsmy1cy+Yls0=;
        b=AAyiPCtUyDcoscvOh6VqrE4faK+y6sGszIb03aty4g4GJ7LvA2bKrlIrd10WzkcoaQ
         gNsGPXjMkZXFSMBtxn6RsSKb6qxoVovZflOyksoajC12u3zy57C1oR4W+d/ng0/FqaaF
         VdjaQE4YRnqStB31UezeElhXH4fgbeWE3bZxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=45iL7Ldcofjua4QTthWpvp4bypb36mbYsmy1cy+Yls0=;
        b=ILriFcI/U6VCJaOeCsAoqDxfrfwKHZUSByPXtqhv9RbkZ1bqFs77Q9TvUr01i+zki/
         q/GwYy+Okb04s5DkkFTN6XfJhymab0TLcRkLo4ssGzpqF/6l1aXIkLYMzWusmyLS7aqX
         s2PKJTrKgGj4Qe1LLkw0EyVxSMoG3BUe93HMUCYeAkCJD8zymcrduQ1oUV4hxBSkX7FH
         +qi5So9wUMS3py/8Hb8Lv/uGLF1ywk6xhH2xRiWG3Wm9QZL8myOAgMTpz1u1pEvlxNBG
         zs7OFj7G8ppzNJoa8COqKLE8nUVePkse6wSSVl4yaaulaxqOfmCVnKNeisd8C/FT9I+i
         TDmQ==
X-Gm-Message-State: AOUpUlHbXa4ZXl/AQKZFOxE/IOctp6hdnr/GBupUkxCyKfk6wF3TyTcq
        YHBdBv8Mv3GSS0c+Xq7g/OxLug==
X-Google-Smtp-Source: AAOMgpd9f9YLQRSpPWxnszsPRpXgnrtmKuMAeE9ivm8Fs43l+rqaAJzz7PTrgC8gANg0yAPaK8gmAQ==
X-Received: by 2002:a17:902:64d7:: with SMTP id y23-v6mr21669490pli.53.1533066724978;
        Tue, 31 Jul 2018 12:52:04 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v30-v6sm24729153pgn.80.2018.07.31.12.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 12:52:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Juergen Gross <jgross@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vinod Koul <vinod.koul@intel.com>,
        David Kershner <david.kershner@unisys.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] scsi: build scsi_common.o for all scsi passthrough request users
Date:   Tue, 31 Jul 2018 12:51:48 -0700
Message-Id: <20180731195155.46664-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180731195155.46664-1-keescook@chromium.org>
References: <20180731195155.46664-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Split scsi_common.o out of SCSI so that non-SCSI users can pull it in
easily for future sense buffer helper usage.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/Makefile      | 2 +-
 drivers/scsi/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 24cd47014657..a6abd7a856c6 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -76,7 +76,7 @@ obj-$(CONFIG_DMA_SHARED_BUFFER) += dma-buf/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-y				+= macintosh/
 obj-$(CONFIG_IDE)		+= ide/
-obj-$(CONFIG_SCSI)		+= scsi/
+obj-y				+= scsi/
 obj-y				+= nvme/
 obj-$(CONFIG_ATA)		+= ata/
 obj-$(CONFIG_TARGET_CORE)	+= target/
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index e29f9b8fd66d..1f6218b98430 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -21,6 +21,7 @@ CFLAGS_gdth.o    = # -DDEBUG_GDTH=2 -D__SERIAL__ -D__COM2__ -DGDTH_STATISTICS
 obj-$(CONFIG_PCMCIA)		+= pcmcia/
 
 obj-$(CONFIG_SCSI)		+= scsi_mod.o
+obj-$(CONFIG_BLK_SCSI_REQUEST)	+= scsi_common.o
 
 obj-$(CONFIG_RAID_ATTRS)	+= raid_class.o
 
@@ -155,7 +156,6 @@ obj-$(CONFIG_SCSI_HISI_SAS) += hisi_sas/
 obj-$(CONFIG_SCSI_DEBUG)	+= scsi_debug.o
 scsi_mod-y			+= scsi.o hosts.o scsi_ioctl.o \
 				   scsicam.o scsi_error.o scsi_lib.o
-scsi_mod-y			+= scsi_common.o
 scsi_mod-$(CONFIG_SCSI_CONSTANTS) += constants.o
 scsi_mod-$(CONFIG_SCSI_DMA)	+= scsi_lib_dma.o
 scsi_mod-y			+= scsi_scan.o scsi_sysfs.o scsi_devinfo.o
-- 
2.17.1

