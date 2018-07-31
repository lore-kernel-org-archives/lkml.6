Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D225C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2518A20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wq8RpQQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2518A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbeGaVeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:34:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36596 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732554AbeGaVeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:34:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so1424532pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E44b1UBlsj2/IHAbzBckjiuffByHshaDmOrs2Gu2tI4=;
        b=Wq8RpQQOXsbyRWvbAOvLymq8ygV5dhwb5w1AiIoJ0NMSVIq4+ouSkwu6hGQmxWQhvr
         mwTZeAexVcv9Npla5vL9s7D1EkVQ0hoOzPkC5PupJnRdpk6AyYHf/2qOuiYKgt1xS49i
         Fstgr+OVl/UI5EpxJHJAmRt2ftgXqH93ad1qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E44b1UBlsj2/IHAbzBckjiuffByHshaDmOrs2Gu2tI4=;
        b=LofgwdOeNd4O2m74ba9BJM2MkQJNCEvXHvc36u6kQ5IwdZ1EoBMQuzTbBXFXG7CN77
         uWPYv/FWNKIVZgRQd5P26LjHktxrvQDW2tvZbmgbxMGvWGjPOwV+Kk6V02ZCsQNEFgKj
         tWnMqAQlwFjMCffAccoMKnqTUiTOzdycCModG0GRLgprMpnHAG0SqCO5i/Jf/wiQ822+
         9VLS9/RbhbxnwFtPwRNlAsGhgXSvsvw7z0EIskkDPP47Zy4NG64s7tqmv0kvVDsD5uXw
         mv/4MIeAL7EZs7zsKml+53UZ6D+kz4Y3Lc6sWfpeisIt6JH23stOaZV6Qwnz/qp67owl
         vCmA==
X-Gm-Message-State: AOUpUlGaVCCZ96O3c4nd1NAmcUAuUmKGTpHj/9+C5aJgZx1ppqf671ib
        BZuzqhcIy21xVJMPvyUXogDUTA==
X-Google-Smtp-Source: AAOMgpfoqWUqSKi64N6kyTOW2ld18UOH7YkZ1F6YlqQaU9eFa6C7Kovb5ksb3L/QNoK3gcIdM2XHQg==
X-Received: by 2002:a62:858c:: with SMTP id m12-v6mr23630798pfk.173.1533066730092;
        Tue, 31 Jul 2018 12:52:10 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x15-v6sm23735254pgc.46.2018.07.31.12.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 12:52:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kees Cook <keescook@chromium.org>,
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
Subject: [PATCH v2 8/9] libata-scsi: Move sense buffers onto stack
Date:   Tue, 31 Jul 2018 12:51:53 -0700
Message-Id: <20180731195155.46664-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180731195155.46664-1-keescook@chromium.org>
References: <20180731195155.46664-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support future compile-time sizeof() checks that will be able to
validate the length of sense buffers, this removes the only dynamically
allocated sense buffers in the tree by putting the 96 byte sense buffers
on the stack.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/ata/libata-scsi.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 89a9d4a2efc8..3a43d3a1ce2d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -597,8 +597,9 @@ static int ata_get_identity(struct ata_port *ap, struct scsi_device *sdev,
 int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg)
 {
 	int rc = 0;
+	u8 sensebuf[SCSI_SENSE_BUFFERSIZE];
 	u8 scsi_cmd[MAX_COMMAND_SIZE];
-	u8 args[4], *argbuf = NULL, *sensebuf = NULL;
+	u8 args[4], *argbuf = NULL;
 	int argsize = 0;
 	enum dma_data_direction data_dir;
 	struct scsi_sense_hdr sshdr;
@@ -610,10 +611,7 @@ int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg)
 	if (copy_from_user(args, arg, sizeof(args)))
 		return -EFAULT;
 
-	sensebuf = kzalloc(SCSI_SENSE_BUFFERSIZE, GFP_NOIO);
-	if (!sensebuf)
-		return -ENOMEM;
-
+	memset(sensebuf, 0, sizeof(sensebuf));
 	memset(scsi_cmd, 0, sizeof(scsi_cmd));
 
 	if (args[3]) {
@@ -685,7 +683,6 @@ int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg)
 	 && copy_to_user(arg + sizeof(args), argbuf, argsize))
 		rc = -EFAULT;
 error:
-	kfree(sensebuf);
 	kfree(argbuf);
 	return rc;
 }
@@ -704,8 +701,9 @@ int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg)
 int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)
 {
 	int rc = 0;
+	u8 sensebuf[SCSI_SENSE_BUFFERSIZE];
 	u8 scsi_cmd[MAX_COMMAND_SIZE];
-	u8 args[7], *sensebuf = NULL;
+	u8 args[7];
 	struct scsi_sense_hdr sshdr;
 	int cmd_result;
 
@@ -715,10 +713,7 @@ int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)
 	if (copy_from_user(args, arg, sizeof(args)))
 		return -EFAULT;
 
-	sensebuf = kzalloc(SCSI_SENSE_BUFFERSIZE, GFP_NOIO);
-	if (!sensebuf)
-		return -ENOMEM;
-
+	memset(sensebuf, 0, sizeof(sensebuf));
 	memset(scsi_cmd, 0, sizeof(scsi_cmd));
 	scsi_cmd[0]  = ATA_16;
 	scsi_cmd[1]  = (3 << 1); /* Non-data */
@@ -769,7 +764,6 @@ int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)
 	}
 
  error:
-	kfree(sensebuf);
 	return rc;
 }
 
-- 
2.17.1

