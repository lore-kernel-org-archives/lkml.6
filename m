Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6581DECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF1321534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lG8gmv+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF1321534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbeIUCob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:44:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33152 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIUCoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:44:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id v90-v6so10783357wrc.0;
        Thu, 20 Sep 2018 13:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=95gzyQftGHVfH0A0QkzajjiA0zv54A4mRN0yR/dsPfg=;
        b=lG8gmv+PeCP2vUAYj//bJYjnYWGxgDlTLalEqaFB7681b3ELe3jfGrHERTpJXyBoR6
         7X787DPvIfKHlG/0vfJ4JHgE9303pT5gabibA9vE1Xs5hTBg6kb8alrxNIG10FvQEd35
         PqmViDO2gHdUsT9PYLIUT6BmPsqSgHOK2u/vJez98PK03eaS0VWzZ+wFKNcZVzbe1GzM
         k8DxwSAB5tvL3FXQRQeeDrVJUZIrtrsjiYd4HPMYu5dtfEgHt0qlGeWoRtKR4kOzY4+E
         yCe3anYO8rO18GTVTg9n5RUVOeOI+WwFsZd9PuP37hQj+cJuiZadc4oW1eenfsYNPm4F
         es0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=95gzyQftGHVfH0A0QkzajjiA0zv54A4mRN0yR/dsPfg=;
        b=OFBYwaQmCuwLgKW/4REKk0mDBhNQ5fZfxFS36fIzI4zbrrZ1dmHI1tax6Iax1455s0
         kPVAiU06Vgf8SODSYI+p4mOm+EJif5y1MpGgWCm7BsKQgktGJzp9qTmanOnnSWu5Qb2V
         LqvKvDs7Yn0H2KAyI9xyssvBbYC7aciIpgnjPvE9yvqexQNGTUCEKTtYynaIMfBq87yt
         BhXKC6Vwtr5c7PRjF5eQXky1ZcCNIafAv2BUKa320bZR6igpcH7vHRVrxngpinhosVmB
         Ngqv+3wb21Mf+HuijpHclQ1wEUHHNlbpuA3ai0ll9IFEmFFRMitw6xY0IIvrlcKfrayz
         blOw==
X-Gm-Message-State: APzg51A83d3jTrn0+Kmu4QUQQMJ1MmlCGM/3SIlXbHuD8Dx+VsTU1ole
        80KtmItByhmhQHl8V1vheHM=
X-Google-Smtp-Source: ANB0VdY1Tw7ZEOmxwRXo50lOPcnhsYEbHjMb99MNQ3PAgjAjpYfAzNxQVH9piZDE8SjsY5i++1Q23w==
X-Received: by 2002:adf:ef51:: with SMTP id c17-v6mr34946612wrp.182.1537477146160;
        Thu, 20 Sep 2018 13:59:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 198-v6sm4826840wmm.0.2018.09.20.13.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:59:05 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Matthew Wilcox <matthew@wil.cx>, Hannes Reinecke <hare@suse.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: advansys: Remove unnecessary parentheses
Date:   Thu, 20 Sep 2018 13:58:58 -0700
Message-Id: <20180920205858.6035-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when multiple pairs of parentheses are used for a single
conditional statement.

drivers/scsi/advansys.c:6451:20: warning: equality comparison with
extraneous parentheses [-Wparentheses-equality]
                                if ((sdtr_data == 0xFF)) {
                                     ~~~~~~~~~~^~~~~~~
drivers/scsi/advansys.c:6451:20: note: remove extraneous parentheses
around the comparison to silence this warning
                                if ((sdtr_data == 0xFF)) {
                                    ~          ^      ~
drivers/scsi/advansys.c:6451:20: note: use '=' to turn this equality
comparison into an assignment
                                if ((sdtr_data == 0xFF)) {
                                               ^~
                                               =
1 warning generated.

Link: https://github.com/ClangBuiltLinux/linux/issues/155
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/advansys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index 713f69033f20..44c96199e00a 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -6448,7 +6448,7 @@ static void AscIsrChipHalted(ASC_DVC_VAR *asc_dvc)
 				sdtr_data =
 				    AscCalSDTRData(asc_dvc, ext_msg.xfer_period,
 						   ext_msg.req_ack_offset);
-				if ((sdtr_data == 0xFF)) {
+				if (sdtr_data == 0xFF) {
 
 					q_cntl |= QC_MSG_OUT;
 					asc_dvc->init_sdtr &= ~target_id;
-- 
2.19.0

