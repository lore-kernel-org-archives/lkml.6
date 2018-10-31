Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0426ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A752054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EVKX/tXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A752054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbeJaWWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:22:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40086 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbeJaWWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:22:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id i17-v6so16431132wre.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 06:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jB9V45TEiYcrejn/2logmOePeieDZLWqOPmZPOnfT8k=;
        b=EVKX/tXKjrcASTlT+eldUGSd7RlsV8crz7rjAP3Dp+QBZUCwFEERJb9FazvyiWGQMf
         bDXBUp4f4CDrUzK6Z06dQ1NcP7kGyMjANLeipZOmPo/U38mnKN1fs9jVy3FisSbi187p
         w3UVJCkZBUGQjQpj4LiOVABnXreo88xoWVdXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jB9V45TEiYcrejn/2logmOePeieDZLWqOPmZPOnfT8k=;
        b=lRn/XyfZsmOW848DLfYzseCjnTGHk9Gq/PpvtOgw3gM336EJgjqL6aH4Uz6N4vtnyd
         izK+39X5AptWCDOCeXSIOs8cFIfN8rBBLUSRaiDHQt+ZlidaGOJiynvDB3lGWaFxeeKG
         PPyQ1YM3BGAKUwH+s80ILdLIM+H2oujWL6wnsrVFp2zqFibo0XGwUmpXRe5XxRuoShZR
         imrqTZYO35arVf0ou9+KUZkAsnBoXPFOURdquTAfx4CKQek6yBPmmISKGVfAfU/cDr6t
         rbEz9UZOES5oisIKx+hJVpyw3EVP5A8UE4JFs/rPbptACV2rtyBu8/cIXdpXQrq6ZNQg
         Cjqw==
X-Gm-Message-State: AGRZ1gIyXMJNkU+dAb4UFa2MgiBlJZcvx1Ont59Mju4nMadqpjb9S5nY
        W4Aoe4rwfjwE7MtWAuPQ1H/OAQ==
X-Google-Smtp-Source: AJdET5eXTnCTWhKvy2OCWvWOkY9n5Fs1pW845aUou399XgTEXZts1WwI514oVX7U61972Zp8E8uzAw==
X-Received: by 2002:a5d:4292:: with SMTP id k18-v6mr2733638wrq.225.1540992281488;
        Wed, 31 Oct 2018 06:24:41 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r16-v6sm25202614wrv.21.2018.10.31.06.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 06:24:41 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v7 5/8] mpt3sas: Fix Sync cache command failure during driver unload
Date:   Wed, 31 Oct 2018 18:53:36 +0530
Message-Id: <1540992219-20291-6-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to fix SYNC CACHE and START STOP command
failures with DID_NO_CONNECT during driver unload.

In driver's IO submission patch (i.e. in driver's .queuecommand())
driver won't allow any SCSI commands to the IOC when ioc->remove_host
flag is set and hence SYNC CACHE commands which are issued to the
target drives (where write cache is enabled) during driver unload time
is failed with DID_NO_CONNECT status.

Now modified the driver to allow SYNC CACHE and START STOP commands
to IOC, even when remove_host flag is set.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 12f565c..df56cbe 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -3748,6 +3748,40 @@ _scsih_tm_tr_complete(struct MPT3SAS_ADAPTER *ioc, u16 smid, u8 msix_index,
 	return _scsih_check_for_pending_tm(ioc, smid);
 }
 
+/** _scsih_allow_scmd_to_device - check whether scmd needs to
+ *				 issue to IOC or not.
+ * @ioc: per adapter object
+ * @scmd: pointer to scsi command object
+ *
+ * Returns true if scmd can be issued to IOC otherwise returns false.
+ */
+inline bool _scsih_allow_scmd_to_device(struct MPT3SAS_ADAPTER *ioc,
+	struct scsi_cmnd *scmd)
+{
+
+	if (ioc->pci_error_recovery)
+		return false;
+
+	if (ioc->hba_mpi_version_belonged == MPI2_VERSION) {
+		if (ioc->remove_host)
+			return false;
+
+		return true;
+	}
+
+	if (ioc->remove_host) {
+
+		switch (scmd->cmnd[0]) {
+		case SYNCHRONIZE_CACHE:
+		case START_STOP:
+			return true;
+		default:
+			return false;
+		}
+	}
+
+	return true;
+}
 
 /**
  * _scsih_sas_control_complete - completion routine
@@ -4571,7 +4605,7 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd *scmd)
 		return 0;
 	}
 
-	if (ioc->pci_error_recovery || ioc->remove_host) {
+	if (!(_scsih_allow_scmd_to_device(ioc, scmd))) {
 		scmd->result = DID_NO_CONNECT << 16;
 		scmd->scsi_done(scmd);
 		return 0;
-- 
1.8.3.1

