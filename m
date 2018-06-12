Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E1946C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8680920693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ks81H3Pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8680920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbeFLEOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:14:18 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35396 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeFLEOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:14:16 -0400
Received: by mail-pg0-f67.google.com with SMTP id 15-v6so10813619pge.2;
        Mon, 11 Jun 2018 21:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=53jmd6VBTwCu1hs5bt0XrHUyKAV/JcKLjrCANFnXVRk=;
        b=ks81H3PdQ/Mrsz2jHqxTgFeBZhxCJ2RraeVFFoLinfbHhWKABLyvaywnoZs0GCb3AZ
         C50oyFI6h2anyxEHJWtdJ9p9j5pea4/ZXcHw80oXQHHjXN62xrLMiipLxH6kZqg+57pc
         TlcqQU1Wkmxwr3x5Kq/pZXaBlHn7Wby+tkgMbpCeMoNuz/NC5o+k5lfOHaw60GSuhqoL
         lxha5+PU1U+xDw43ARA5Eb8QRCunnwfBz7Gb+pM5ZXgIaUlofaVz1zhACy74gsDFHxJq
         SgA2IADrgCziVUIJ0u6pJRHZJGMMITkLuDcQNmffLSY6y9ggl+H1ZgRvM+7Xn75dSmIk
         71fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=53jmd6VBTwCu1hs5bt0XrHUyKAV/JcKLjrCANFnXVRk=;
        b=YFPmwu1CRnFvb32LPcjtMKx6kSJ1LpZ1Pltk7jNpByF9viArli3YdHY5Evf5SQ3gBF
         cYWZqoeOWRjMoqxpTJzCax8vflYEcKQK6KO+/nX2pXU2zgVabELUdw4KBfCtLQIgBgBz
         mhru4Dgo6scfORqWi7cM6SqlAoUxmvIuyOvw1EMCh4dH0B5yvzqHdaw67kYHcOI/sIa3
         YdG2dhW49cDZwbq6+2hhPkkWHZbZymCdtnHmDoCHKIPpfo24+U5MhtLrzX3+8m+jakrF
         qGULhnVZNkVJzqYz+KkwypMBb7tck6pRQjetXSY+bUyuO0lxWraCp1RZAUARsO/4DGVL
         ZRbQ==
X-Gm-Message-State: APt69E3IqF5Ryb98cPw75lJJrdYU5k15AadpryVtnTB19uKuJbTmNPHt
        T7w5NguVdANb4pALSDKndLs=
X-Google-Smtp-Source: ADUXVKL7T0wVUe4odCbQoDTaFLKO6bXWbPUQ96RgmLrS2jeCcU4t7kUiaJvG1ZnyVBwACn6TuyOMnQ==
X-Received: by 2002:a62:9e0b:: with SMTP id s11-v6mr2080021pfd.198.1528776856378;
        Mon, 11 Jun 2018 21:14:16 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id a11-v6sm103309418pgn.64.2018.06.11.21.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:14:15 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Bradley Grove <linuxdrivers@attotech.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: esas2r: add error handling for pci_enable_device
Date:   Tue, 12 Jun 2018 12:14:09 +0800
Message-Id: <1528776850-39672-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pci_enable_device fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling pci_enable_device.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/scsi/esas2r/esas2r_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/esas2r/esas2r_init.c b/drivers/scsi/esas2r/esas2r_init.c
index 9dffcb2..364538c 100644
--- a/drivers/scsi/esas2r/esas2r_init.c
+++ b/drivers/scsi/esas2r/esas2r_init.c
@@ -707,6 +707,9 @@ int esas2r_resume(struct pci_dev *pdev)
 	esas2r_log_dev(ESAS2R_LOG_INFO, &(pdev->dev),
 		       "pci_enable_device() called");
 	rez = pci_enable_device(pdev);
+	if (rez)
+		goto error_exit;
+
 	pci_set_master(pdev);
 
 	if (!a) {
-- 
2.7.4

