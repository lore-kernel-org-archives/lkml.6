Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E896ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6922054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ePaZ39gZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6922054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbeJaWW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:22:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33896 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbeJaWWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:22:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so2306011wre.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 06:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qx5wcL5y6HZkLAvJCMEMw3jq+pGbXjabHVOJwCwdMfo=;
        b=ePaZ39gZEziy4naiU5F8I3+fFZtN9OgqfIQ6hZOhMg2XxyIbwSqdMGheKPUU8QWyH8
         Xmn1OhqI5yfPKoH8ExpTIF+MDilcTDPli00FUCX+FrgMmkwBShqGwysHarBFFpEJrMsw
         T4y0DMuF0GMo3qn61KCDE0dS7++ISjmqGmHjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qx5wcL5y6HZkLAvJCMEMw3jq+pGbXjabHVOJwCwdMfo=;
        b=bwsrEf6smvxf3L/EfUJf1EAx8Yu3VbtTb06VowsAIucjFvDXO/OAwYikuGDHcWhcgn
         DZs6UYhK7+bPjp0s5NNVaB/htsiqZHY++rE3SKAwubIf8P+9oiWtzvPU+Hin3Oxww8PO
         8PtnhmYp4DaeIMyyl1/XESkit468a6Zi44Sj/OyZ8wRebSMprrcK3v+LDWzJas+ZJElf
         JAC5A/la5cL9/nGLQf0KJ3CNxPQncUoDiyaSiCSNHjw65idcbx+QvGfjEiqjoMM7ALn7
         J8I3t3H1YFRn8rIOXwg7gk8rOwDNqSRHWKfl6BcqyZsc5PgeEoz2/fRjxJTtWT6n6HgV
         t1Fg==
X-Gm-Message-State: AGRZ1gL58N8g/S7uq2hlh+gG3aa/HK9FdClhDGLpddzH/i/hKo3Yt6rA
        QdS3h6RIb7vFQCuETMmjLA84tg==
X-Google-Smtp-Source: AJdET5fkcBk69DafsE8iWeJhF7PKWDGuVmKzQ+gM9OmwaoWJMB0QpMXnEo+0qv5ugnN1wppEM7tHKg==
X-Received: by 2002:adf:fc8b:: with SMTP id g11-v6mr2738878wrr.78.1540992292440;
        Wed, 31 Oct 2018 06:24:52 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r16-v6sm25202614wrv.21.2018.10.31.06.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 06:24:51 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v7 8/8] mpt3sas: Bump driver version to 27.100.00.00.
Date:   Wed, 31 Oct 2018 18:53:39 +0530
Message-Id: <1540992219-20291-9-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify driver version to 27.100.00.00
(which is equivalent to PH8 OOB driver)

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 4e532b0..6922c3b 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -74,8 +74,8 @@
 #define MPT3SAS_DRIVER_NAME		"mpt3sas"
 #define MPT3SAS_AUTHOR "Avago Technologies <MPT-FusionLinux.pdl@avagotech.com>"
 #define MPT3SAS_DESCRIPTION	"LSI MPT Fusion SAS 3.0 Device Driver"
-#define MPT3SAS_DRIVER_VERSION		"26.100.00.00"
-#define MPT3SAS_MAJOR_VERSION		26
+#define MPT3SAS_DRIVER_VERSION		"27.100.00.00"
+#define MPT3SAS_MAJOR_VERSION		27
 #define MPT3SAS_MINOR_VERSION		100
 #define MPT3SAS_BUILD_VERSION		0
 #define MPT3SAS_RELEASE_VERSION	00
-- 
1.8.3.1

