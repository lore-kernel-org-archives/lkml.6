Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693E3ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C112054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XqJ9KU92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C112054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbeJaWWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:22:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32950 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbeJaWWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:22:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id u1-v6so16513310wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 06:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lIeXDghr755t8BBCSwmcHa9YGHWcATP9qR2jvztCXFU=;
        b=XqJ9KU92b8Vrvym64YyhjPvqGCK9SyUfma5Rf39bKUh9IvYEggZF657J5y+vENL24/
         fnesR1RBu2FR6eVc2wXZiEalzYMNBG+JfBmTW3ldtbIiyupMIVnJ2PrHJRIIlAEai/ZE
         YEdY8JMOl8jOoO4Xp/CXfHU8zNmsgn3sc9qIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lIeXDghr755t8BBCSwmcHa9YGHWcATP9qR2jvztCXFU=;
        b=PwKhrq/NARoXIdI07OvZqbpo5A/iKc1b/F4oQyjaW3QN7L0BV+alb6Ygu/2qkXn86B
         mOL9ZYRB7Z5fwNhH/9ougUYGFzgs94GtoUIuWJatIBXpxdgMc1OGu3f8ih+TDwTqfe/m
         j/cx2jlCA0p8CHgzN3ARf2Oes6AmuqooZxikT7g/2czE+UmDLzhVVD3mvs6qjikirnJ0
         /v3hscZ0UZKnlkRhkmAjnGVVa4Lw2tJKwYypd9ab3mhwTrWTFlWf2SVk0QRjyaUubM+R
         CtyIcAofFDu7sIKicNyqpsRaKRXwaWHbbw+ci0ELLF7fpijYqNUJEYuJP+Q5ADnCgH8V
         IEIA==
X-Gm-Message-State: AGRZ1gJXHizA99c2fqB3yyCHk3hMKhNOXJfIJBVd86fXjkkxU0CacHqk
        D6bSSk+fAdxjaSLUSMR3FpSNiw==
X-Google-Smtp-Source: AJdET5e1jzSIewOx/boEP+EtfoMJL4eGI72JZn2yUCFN0t5ZO2jZW1W0D7Y0X7CN4BWIMWk3Rs4q5Q==
X-Received: by 2002:adf:a512:: with SMTP id i18-v6mr3030268wrb.220.1540992274970;
        Wed, 31 Oct 2018 06:24:34 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r16-v6sm25202614wrv.21.2018.10.31.06.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 06:24:34 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v7 3/8] mpt3sas: Refactor mpt3sas_wait_for_ioc function
Date:   Wed, 31 Oct 2018 18:53:34 +0530
Message-Id: <1540992219-20291-4-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Doing code refactor of function
mpt3sas_wait_for_ioc() for better readability.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 3b5f28a..f25bc3c 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5093,22 +5093,20 @@ mpt3sas_wait_for_ioc(struct MPT3SAS_ADAPTER *ioc, int timeout)
 	int wait_state_count = 0;
 	u32 ioc_state;
 
-	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
-	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-
-		if (wait_state_count++ == timeout) {
-			ioc_err(ioc, "%s: failed due to ioc not operational\n",
-				__func__);
-			return -EFAULT;
-		}
-		ssleep(1);
+	do {
 		ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
+		if (ioc_state == MPI2_IOC_STATE_OPERATIONAL)
+			break;
+		ssleep(1);
 		ioc_info(ioc, "%s: waiting for operational state(count=%d)\n",
-			 __func__, wait_state_count);
+				__func__, ++wait_state_count);
+	} while (--timeout);
+	if (!timeout) {
+		ioc_err(ioc, "%s: failed due to ioc not operational\n", __func__);
+		return -EFAULT;
 	}
 	if (wait_state_count)
 		ioc_info(ioc, "ioc is operational\n");
-
 	return 0;
 }
 
-- 
1.8.3.1

