Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F60ECDFA4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DA221479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nanometrics.ca header.i=@nanometrics.ca header.b="nPq2JYf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DA221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nanometrics.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeJJAta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:49:30 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55412 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbeJJAt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:49:29 -0400
Received: by mail-it1-f194.google.com with SMTP id c23-v6so3883339itd.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanometrics.ca; s=google;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LsxidQGqg9D6Q/MsjzTFCuWHocGJG7qCsrhu+BRg8xE=;
        b=nPq2JYf68sRYye8XxsqH09FXDFv11xFS+hH4c76YkMK6PSie+fO0hXEO/y7D0xpiyD
         C9ZGLCKjS5c+eQCYFS6boOzpBrbbu86C4wtiPW13MQNFcsyBWBi/dV2BeHCKEDVX12eP
         Z8BcE65Upm0VKBrggLt3Zw0rZWH/TFXCL0/HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=LsxidQGqg9D6Q/MsjzTFCuWHocGJG7qCsrhu+BRg8xE=;
        b=lIXX81LRobD9f5EWMl6fLbzxal1uwEscB8V7Vojw/h980K3/AsSu2oHBE1Dnb5H9Mi
         OYDkyIO1CcWis0t9GOtxKxXszN1gih9E3Ti0gpD+MOBQdO4Em8GhLDWlu6Sy76Y+pI2g
         WxnoFJRXQlN/SuGRwLkG21HYc6sx/jSg1dPazsQUn/rpviCnDdKkAxzoFXhr8Bi+GuQd
         RY1WuUsp/jJ3xQdFgjOiSD6T8Y1LZeJcoGsVF0ymfJ36UUjsjQzCRYdxC2KmN0G8cXPL
         cQJ7un/nxSYhE68ArGE23L9METR2MZgC+eVVSFroHtA/am9/ZWvP0TkfdIsB2h/2/DYt
         w8mA==
X-Gm-Message-State: ABuFfohz6Sxx9uq3t73nkueBdyOQU71HpTURTrtRAMegF8rtIxXedTp5
        0LxSQtfDrLW0RgOnr+PrWXa0/UZDrKR0W7V8LKepf3OaC9nWJaTn2xVcy5Av2NXfpWbT9UnKjYd
        7xPS8Tjauf0hcZfT9
MIME-Version: 1.0
X-Google-Smtp-Source: ACcGV62m64izao7wWPhXgnN5rhIIa/D4g7js8tN2rTiPBjsXOQTkd9FI4mm+kHGP42hYWMeh+RFW7w==
X-Received: by 2002:a24:e08f:: with SMTP id c137-v6mr2658549ith.71.1539106286808;
        Tue, 09 Oct 2018 10:31:26 -0700 (PDT)
Received: from jamesnuss-kubuntu.nanometrics.ca ([72.142.127.130])
        by smtp.gmail.com with ESMTPSA id c24-v6sm6321018iod.44.2018.10.09.10.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 10:31:25 -0700 (PDT)
From:   James Nuss <jamesnuss@nanometrics.ca>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] mmc-utils: Introduce write_reliability set_register command
Date:   Tue,  9 Oct 2018 13:31:08 -0400
Message-Id: <09cceeb5de497ac2abd19de93a364af747ce51b1.1539103468.git.jamesnuss@nanometrics.ca>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1539103468.git.jamesnuss@nanometrics.ca>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
In-Reply-To: <cover.1539103468.git.jamesnuss@nanometrics.ca>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"write-reliability" setting must be performed on all required partitions
in one command.

Introduce new command "write_reliability set_register" to allow setting
of write-reliability for all required partitions.

This command is a one-time programmable action. It cannot not be undone
by power-cycling the unit.

Signed-off-by: James Nuss <jamesnuss@nanometrics.ca>
---
 mmc.c      |  9 +++++++++
 mmc_cmds.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |  1 +
 3 files changed, 69 insertions(+)

diff --git a/mmc.c b/mmc.c
index 50c9c9e..aaefd3d 100644
--- a/mmc.c
+++ b/mmc.c
@@ -102,6 +102,15 @@ static struct Command commands[] = {
 		"Enable write reliability per partition for the <device>.\nDry-run only unless -y or -c is passed.\nUse -c if more partitioning settings are still to come.\nNOTE!  This is a one-time programmable (unreversible) change.",
 	  NULL
 	},
+	{ do_write_reliability_set_register, -2,
+	  "write_reliability set_register", "<partition-mask> " "<device>\n"
+		"Set the write-reliability register (WR_REL_SET) for the <device>.\n"
+		"User area=bit0, GP1=bit1, GP2=bit2, GP3=bit3, GP4=bit4\n"
+		"e.g setting register to 0x03 will set 'User Area' and 'GP1' partitions \n"
+		"with write-reliability, and all others without write-reliability.\n"
+		"NOTE!  This is a one-time programmable (irreversible) change.",
+	  NULL
+	},
 	{ do_status_get, -1,
 	  "status get", "<device>\n"
 	  "Print the response to STATUS_SEND (CMD13).",
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 756aa2f..68c73ef 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1244,6 +1244,65 @@ int do_enh_area_set(int nargs, char **argv)
 	return 0;
 }
 
+int do_write_reliability_set_register(int nargs, char **argv)
+{
+	__u8 ext_csd[512];
+	int fd, ret;
+	long partition_mask;
+	char *device;
+	char *endptr;
+
+	if (nargs != 3) {
+		fprintf(stderr,"Usage: mmc write_reliability set_register <partition-mask> </path/to/mmcblkX>\n");
+		exit(1);
+	}
+
+	errno = 0;
+	partition_mask = strtol(argv[1], &endptr, 0);
+	if (errno != 0 || endptr == argv[1] || *endptr != 0 || partition_mask < 0 || partition_mask > 0x1f) {
+		fprintf(stderr, "Partition mask invalid: %s\n", argv[1]);
+		exit(1);
+	}
+
+	device = argv[2];
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	ret = read_extcsd(fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+		exit(1);
+	}
+
+	/* assert not PARTITION_SETTING_COMPLETED */
+	if (ext_csd[EXT_CSD_PARTITION_SETTING_COMPLETED])
+	{
+		fprintf(stderr, "Device is already partitioned\n");
+		exit(1);
+	}
+
+	/* assert HS_CTRL_REL */
+	if (!(ext_csd[EXT_CSD_WR_REL_PARAM] & HS_CTRL_REL)) {
+		fprintf(stderr, "Cannot set write reliability parameters, WR_REL_SET is "
+				"read-only\n");
+		exit(1);
+	}
+
+	ret = write_extcsd_value(fd, EXT_CSD_WR_REL_SET, (__u8)partition_mask);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
+				(__u8)partition_mask, EXT_CSD_WR_REL_SET, device);
+		exit(1);
+	}
+	fprintf(stderr, "Done setting EXT_CSD_WR_REL_SET to 0x%02x on %s\n",
+		(__u8)partition_mask, device);
+
+	return 0;
+}
+
 int do_write_reliability_set(int nargs, char **argv)
 {
 	__u8 value;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 9d3246c..8ca9ac9 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -35,6 +35,7 @@ int do_status_get(int nargs, char **argv);
 int do_create_gp_partition(int nargs, char **argv);
 int do_enh_area_set(int nargs, char **argv);
 int do_write_reliability_set(int nargs, char **argv);
+int do_write_reliability_set_register(int nargs, char **argv);
 int do_rpmb_write_key(int nargs, char **argv);
 int do_rpmb_read_counter(int nargs, char **argv);
 int do_rpmb_read_block(int nargs, char **argv);
-- 
2.7.4


-- 
This message is intended exclusively for the individual or entity to which 
it is addressed. This communication may contain information that is 
proprietary, privileged, confidential or otherwise legally exempt from 
disclosure. If you are not the named addressee, or have been inadvertently 
and erroneously referenced in the address line, you are not authorized to 
read, print, retain, copy or disseminate this message or any part of it. If 
you have received this message in error, please notify the sender 
immediately by e-mail and delete all copies of the message.
