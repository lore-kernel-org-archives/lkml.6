Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BA3ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9F221479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nanometrics.ca header.i=@nanometrics.ca header.b="l91QPysW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9F221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nanometrics.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeJJAt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:49:26 -0400
Received: from mail-it1-f182.google.com ([209.85.166.182]:56147 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJJAtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:49:25 -0400
Received: by mail-it1-f182.google.com with SMTP id c23-v6so3882954itd.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanometrics.ca; s=google;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zBWkjNzk11427+WOtJ7+ZWiA+nYFUEXDOZ1d8kfXQLU=;
        b=l91QPysWTLf/MWgXCMChIdMqPjui8kU9g1RH49lnT569AyRBzfrnyGa0mootRdfhnM
         +DLj3+xz5zljEsm1OZcIOEvG3ancXsDT0qiPWAEdNP1R2lJFabu8BqCK0KeZgGVqzXgD
         QbenUXhojdykvnqIkDioZtT4FoSyRXluBwDGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=zBWkjNzk11427+WOtJ7+ZWiA+nYFUEXDOZ1d8kfXQLU=;
        b=p5Cx2hCFXOZT3v6lILqYzbRjN2IWLsdHlwXspFOeeWMI2N61SggAS+QKmbCMoeeFrI
         AREOeFvmecibgaQw3UujrDltzPLRh6O1VQ5vFY4EGmhM/GEretgt7mDsgp9PTIhspvYy
         kWwtJ65E9yBgCVvzCs1STyqIuVsVrSGbXWpqMFSajQxXAlEFiginEq+ftWnZE3NiJCfJ
         n/G6hPg3iSdo28U35RtOAGYSiBSWa+sRoo/E5+jJVstPyoCR4rnpVO7Wy5OiuFKpoo/K
         mGw7UcYCVz/VuKyioVBbN+0/Rswq2ROnRzMvCcVEWm/txV6jpBPF/M04BknCxBWrySmc
         30QQ==
X-Gm-Message-State: ABuFfojOIGdXiPiBv9HHWFoCCFDWwlz2k1XMPYWDfurGeVGxMCfCjg27
        i+RDlwP95NiU00va0mFKV2UGtjVyk+rfUpm/7ErdGp/6Ddb3KhFAcZYo+L2ylvI2wP4PXknmGrS
        Ox4QsiRL3X1W7d4FJ
MIME-Version: 1.0
X-Google-Smtp-Source: ACcGV63VgDlbg9UGfze9Jl+qfXnZZ4XGn895Azyo4+O/yyEaarBj/AnfMdEkPJpA4otY9b72dn1G8g==
X-Received: by 2002:a02:31d:: with SMTP id y29-v6mr23302372jad.98.1539106282589;
        Tue, 09 Oct 2018 10:31:22 -0700 (PDT)
Received: from jamesnuss-kubuntu.nanometrics.ca ([72.142.127.130])
        by smtp.gmail.com with ESMTPSA id c24-v6sm6321018iod.44.2018.10.09.10.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 10:31:21 -0700 (PDT)
From:   James Nuss <jamesnuss@nanometrics.ca>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] mmc-utils: interpret OPTIMAL_*_SIZE fields in extcsd
Date:   Tue,  9 Oct 2018 13:31:05 -0400
Message-Id: <4a016f761d388a989059467507f2bc948ba26c6c.1539103468.git.jamesnuss@nanometrics.ca>
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

eMMC 5.0 introduced OPTIMAL_READ_SIZE, OPTIMAL_WRITE_SIZE and OPTIMAL
TRIM_UNIT_SIZE fields in the extcsd

Interpret these fields when reading out the extcsd with human-readable
results

Signed-off-by: James Nuss <jamesnuss@nanometrics.ca>
---
 mmc.h      |  3 +++
 mmc_cmds.c | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/mmc.h b/mmc.h
index 285c1f1..5d8a7e3 100644
--- a/mmc.h
+++ b/mmc.h
@@ -56,6 +56,9 @@
 #define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B 	269	/* RO */
 #define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A 	268	/* RO */
 #define EXT_CSD_PRE_EOL_INFO		267	/* RO */
+#define EXT_CSD_OPTIMAL_READ_SIZE	266	/* RO */
+#define EXT_CSD_OPTIMAL_WRITE_SIZE	265	/* RO */
+#define EXT_CSD_OPTIMAL_TRIM_UNIT_SIZE	264	/* RO */
 #define EXT_CSD_FIRMWARE_VERSION	254	/* RO */
 #define EXT_CSD_CACHE_SIZE_3		252
 #define EXT_CSD_CACHE_SIZE_2		251
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 44623fe..97ea111 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1766,6 +1766,24 @@ int do_read_extcsd(int nargs, char **argv)
 			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]);
 		printf("eMMC Pre EOL information [EXT_CSD_PRE_EOL_INFO]: 0x%02x\n",
 			ext_csd[EXT_CSD_PRE_EOL_INFO]);
+
+		reg = ext_csd[EXT_CSD_OPTIMAL_READ_SIZE];
+		printf("Minimum optimal read unit size (for the device) "
+			"[OPTIMAL_READ_SIZE]: 0x%02x\n", reg);
+		printf(" i.e. %lu KiB\n", reg * 4UL);
+
+		reg = ext_csd[EXT_CSD_OPTIMAL_WRITE_SIZE];
+		printf("Minimum optimal write unit size (for the device) "
+			"[OPTIMAL_WRITE_SIZE]: 0x%02x\n", reg);
+		printf(" i.e. %lu KiB\n", reg * 4UL);
+
+		reg = ext_csd[EXT_CSD_OPTIMAL_TRIM_UNIT_SIZE];
+		printf("Minimum optimal trim unit size (for the device) "
+			"[OPTIMAL_TRIM_UNIT_SIZE]: 0x%02x\n", reg);
+		if (reg == 0 || reg > 21)
+			printf("error: invalid OPTIMAL_TRIM_UNIT_SIZE\n");
+		else
+			printf(" i.e. %lu KiB\n", (1UL << (reg - 1)) * 4);
 	}
 
 	if (ext_csd_rev >= 8) {
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
