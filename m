Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB252ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6164B21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRKfAs8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6164B21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbeIUBzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:55:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38740 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeIUBzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:55:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id j8-v6so6914893wrw.5;
        Thu, 20 Sep 2018 13:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+BsPXTjXx0/hErE0HcAlphN83P4XztM0OJLvpKXlb5c=;
        b=YRKfAs8aszhmsJOg5kbT5xjXNYG84th4w/aRJafb3kRPaFm8Z1OqGuDvu9piNjfRUD
         cEWQoSL4E5vvbkolL7HDSZAcHn87aK+07MohY1GkiSkMqgzMvCZZ1gZi2yCO0XlfSLfs
         Uwq30mf2HibtLXoCysfOwyDJRjB1bOYxE0VxRyJq1mE88vECpKJL4RS+camduzB6BhTl
         KDA7QgMIbpuUTzXvKLF0dcJYf2THUjX4mYxjtyEAGqIe3ckVQ4IBRi4O3vIRqb31mYsh
         KMyWpU36FRpPycaNXRq1IOtFty73/B+W4l5k1og69ZDwnNYDn4tTLYtCp0de2zgN7y1C
         s2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+BsPXTjXx0/hErE0HcAlphN83P4XztM0OJLvpKXlb5c=;
        b=D3qF3b+Mh/reJRrC7mv/0rSHTlI9j91vg/JzdaOMXvAHPtg5rcgKcw4U7TBlXGZD9V
         csvNkioWLnjrSehBjdTMyBj77R7Mg+giRzqqxO/MAgU5jOW0AV3Wmx0zNOTgxpPCdo42
         qOiGzIt5f7XCOgBUN74RWwmwxMaSQxETQ6IV25lKv+hx84rkgvESHRqE8jgmO/aVFNF0
         4fUDrHhgk8B6wuQq3uOdFgm0XxY0iQbgN2+lo3cvXEHRbp+QsAA31jdnlXbKDSmXCaMC
         No1HbA3niMA9EGcsplpb05cZV8Isa6cmKg7MFMGUNI92O1RIBx2ly5nIzulN3/gSnFWK
         fTnQ==
X-Gm-Message-State: APzg51D2BHMYB55IBcjQ9ZrhVnYCOANvqp6b5+5CAHct2KkASlhQURd2
        Z/ig+YE7yrLJx2F62UuJhNM=
X-Google-Smtp-Source: ANB0Vda0WYHoY2rSkvP4LkfJ9QYVZzX4g6f+NH0o8xH6zv6AgKeCC6Whj8/Hhxlu5H9xAgswysTCag==
X-Received: by 2002:adf:a4dc:: with SMTP id h28-v6mr23349152wrb.167.1537474209902;
        Thu, 20 Sep 2018 13:10:09 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id u7-v6sm3106126wmd.46.2018.09.20.13.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:10:08 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: mpt3sas: Remove unnecessary parentheses and simplify null checks
Date:   Thu, 20 Sep 2018 13:10:02 -0700
Message-Id: <20180920201002.23979-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when multiple pairs of parentheses are used for a single
conditional statement.

drivers/scsi/mpt3sas/mpt3sas_base.c:535:11: warning: equality comparison
with extraneous parentheses [-Wparentheses-equality]
        if ((ioc == NULL))
             ~~~~^~~~~~~
drivers/scsi/mpt3sas/mpt3sas_base.c:535:11: note: remove extraneous
parentheses around the comparison to silence this warning
        if ((ioc == NULL))
            ~    ^      ~
drivers/scsi/mpt3sas/mpt3sas_base.c:535:11: note: use '=' to turn this
equality comparison into an assignment
        if ((ioc == NULL))
                 ^~
                 =
drivers/scsi/mpt3sas/mpt3sas_base.c:539:12: warning: equality comparison
with extraneous parentheses [-Wparentheses-equality]
        if ((pdev == NULL))
             ~~~~~^~~~~~~
drivers/scsi/mpt3sas/mpt3sas_base.c:539:12: note: remove extraneous
parentheses around the comparison to silence this warning
        if ((pdev == NULL))
            ~     ^      ~
drivers/scsi/mpt3sas/mpt3sas_base.c:539:12: note: use '=' to turn this
equality comparison into an assignment
        if ((pdev == NULL))
                  ^~
                  =
2 warnings generated.

Remove them and while we're at it, simplify the NULL checks as '!var' is
used more than 'var == NULL'.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 59d7844ee022..a49f16fed4c8 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -532,11 +532,11 @@ static int mpt3sas_remove_dead_ioc_func(void *arg)
 	struct MPT3SAS_ADAPTER *ioc = (struct MPT3SAS_ADAPTER *)arg;
 	struct pci_dev *pdev;
 
-	if ((ioc == NULL))
+	if (!ioc)
 		return -1;
 
 	pdev = ioc->pdev;
-	if ((pdev == NULL))
+	if (!pdev)
 		return -1;
 	pci_stop_and_remove_bus_device_locked(pdev);
 	return 0;
-- 
2.19.0

