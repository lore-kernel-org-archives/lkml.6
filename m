Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B53AECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66702054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZNwk7IA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66702054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbeJaWWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:22:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36062 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbeJaWWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:22:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so14490238wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 06:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bv7K4P2YrFnq4grKjFyIjdfYWKU5HjVxgZEj4qgSKZ0=;
        b=ZNwk7IA0C1YxgXAYznDDfDiurdWL3qE70rbTFDY54Xnls+nltcIrKE+VZsDtuqkyxY
         3QF198nkOSRt4vHmv+uj+gW74XOIxGp08gIlqovvrq/6LPdn+LS6eS7wV6HgbZ85KRjb
         14LUby4/XN+MJKll/QgPszB//60k4Zo/yhTVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bv7K4P2YrFnq4grKjFyIjdfYWKU5HjVxgZEj4qgSKZ0=;
        b=YU5Vmt6tckcmCGT+EW9pAi6Uvf9Cw/rhP2zQbf46GKY1fXZnAh4rO1NgP3HxQ6rYwR
         lj9cFWS6l7Q9FmYvsAT2Vw5dGz58NFxvARaXTI9uwHVFbA1Za98+lbfoTdTTDr+8ucyi
         y68gzPCFdJkz78vJTMaomSj9jmp6j9lWyt07ijDjjK0bdNtHuvQRsLynKUBysBGciPjZ
         OYtaHS6Xh2ytp21YRg9JarxSL+Jq8LmRP62aFdccOwefb1HLWPzJZTJMz58VQYKU19bd
         ZR/nMMv6Cw0Tt6GDXrZC/n08vR0vTErnfVdaoWHewYHs+3hHfMNtcR3oe89QoSqVuS4c
         8log==
X-Gm-Message-State: AGRZ1gLTPrIXCiFmH3JdMZ9fJA3nT6g884CkIdAghzS3V+PLNL50A+ks
        bmbeNqIPlK6i2sBVqWbPwvVALw==
X-Google-Smtp-Source: AJdET5cLvEQq8le+lXrepdCMkgbs+5V9NQFQReJSDJAsF2eX1MFBiFWQSv29+S71SBAaSTu7KPEcTg==
X-Received: by 2002:a1c:e004:: with SMTP id x4-v6mr2381609wmg.71.1540992267673;
        Wed, 31 Oct 2018 06:24:27 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r16-v6sm25202614wrv.21.2018.10.31.06.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 06:24:27 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v7 1/8] mpt3sas: Added new #define variable IOC_OPERATIONAL_WAIT_COUNT
Date:   Wed, 31 Oct 2018 18:53:32 +0530
Message-Id: <1540992219-20291-2-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added new #define variable IOC_OPERATIONAL_WAIT_COUNT and
it replaces hard coded value '10' in all the places where driver is
waiting for the IOC to become operational.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c      | 4 ++--
 drivers/scsi/mpt3sas/mpt3sas_base.h      | 3 +++
 drivers/scsi/mpt3sas/mpt3sas_ctl.c       | 2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 8 ++++----
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 2500377..f6c7afa 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5230,7 +5230,7 @@ mpt3sas_base_sas_iounit_control(struct MPT3SAS_ADAPTER *ioc,
 	wait_state_count = 0;
 	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
 	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
+		if (wait_state_count++ == IOC_OPERATIONAL_WAIT_COUNT) {
 			ioc_err(ioc, "%s: failed due to ioc not operational\n",
 				__func__);
 			rc = -EFAULT;
@@ -5325,7 +5325,7 @@ mpt3sas_base_scsi_enclosure_processor(struct MPT3SAS_ADAPTER *ioc,
 	wait_state_count = 0;
 	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
 	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
+		if (wait_state_count++ == IOC_OPERATIONAL_WAIT_COUNT) {
 			ioc_err(ioc, "%s: failed due to ioc not operational\n",
 				__func__);
 			rc = -EFAULT;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 8f1d6b0..3ce8785 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -139,6 +139,9 @@
 #define DEFAULT_NUM_FWCHAIN_ELEMTS	8
 
 #define FW_IMG_HDR_READ_TIMEOUT	15
+
+#define IOC_OPERATIONAL_WAIT_COUNT	10
+
 /*
  * NVMe defines
  */
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 4afa597..a285e95 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -669,7 +669,7 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 	wait_state_count = 0;
 	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
 	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
+		if (wait_state_count++ == IOC_OPERATIONAL_WAIT_COUNT) {
 			ioc_err(ioc, "%s: failed due to ioc not operational\n",
 				__func__);
 			ret = -EFAULT;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index 6a8a3c0..f446c05 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -323,7 +323,7 @@ _transport_expander_report_manufacture(struct MPT3SAS_ADAPTER *ioc,
 	wait_state_count = 0;
 	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
 	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
+		if (wait_state_count++ == IOC_OPERATIONAL_WAIT_COUNT) {
 			ioc_err(ioc, "%s: failed due to ioc not operational\n",
 				__func__);
 			rc = -EFAULT;
@@ -1101,7 +1101,7 @@ _transport_get_expander_phy_error_log(struct MPT3SAS_ADAPTER *ioc,
 	wait_state_count = 0;
 	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
 	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
+		if (wait_state_count++ == IOC_OPERATIONAL_WAIT_COUNT) {
 			ioc_err(ioc, "%s: failed due to ioc not operational\n",
 				__func__);
 			rc = -EFAULT;
@@ -1406,7 +1406,7 @@ _transport_expander_phy_control(struct MPT3SAS_ADAPTER *ioc,
 	wait_state_count = 0;
 	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
 	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
+		if (wait_state_count++ == IOC_OPERATIONAL_WAIT_COUNT) {
 			ioc_err(ioc, "%s: failed due to ioc not operational\n",
 				__func__);
 			rc = -EFAULT;
@@ -1927,7 +1927,7 @@ _transport_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 	wait_state_count = 0;
 	ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
 	while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
-		if (wait_state_count++ == 10) {
+		if (wait_state_count++ == IOC_OPERATIONAL_WAIT_COUNT) {
 			ioc_err(ioc, "%s: failed due to ioc not operational\n",
 				__func__);
 			rc = -EFAULT;
-- 
1.8.3.1

