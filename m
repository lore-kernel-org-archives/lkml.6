Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8353ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8011F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GySLXx12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8011F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeJ3P2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:28:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46500 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeJ3P2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:28:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id 74-v6so3009678wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 23:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GQ8kn1fetX7XhuAQYL8yonlNWHow4RFgKVn1hXis0Fw=;
        b=GySLXx12FYTmcif9SiDaf7Mi7vsmVRGsf0+SZmSXN1YwvAHy+Wzo9sQeo2QetGHU25
         qaZW3pgojIo+rMBLz/v9BTrpiWkRTL9rNY0w4tmHX0bTIAgy4Z4C4T5a4CfvHflQaWbp
         eSFKlXgGUvdsiZeKXSRuD8e3H797HZ26oiNrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GQ8kn1fetX7XhuAQYL8yonlNWHow4RFgKVn1hXis0Fw=;
        b=DRtluHGmZKmOkV9f4JHxYQIjtglBfb6K5Cd6+IDZ9bek6xpYlB54pP5d9cL03Gfq52
         wob/e56SeuRX4lsnKzxvldem/52ReRLyNPMlCpL6ILYfbFTMQLs9d3Sz0OGIqxsDmQVw
         ibgODX+/5+230V397No906EQXBpHmRFU6uC6jvA89y9gcBO85UonU4LRWvBVJVti9FV8
         gIHNJwEp8+P9WTClVDrlNYsGSY/Qs9UC+IOBwYCqOsAB8fEbs+3cGN6mjwfSjmzcG0Il
         rpj5s4O0/BmuS5ekhwx4FaZi0L3PLGdGLSswwA0tMfpNRaxpx8ttt2bRK7106JVIvbGd
         IRnw==
X-Gm-Message-State: AGRZ1gLBSx8o2j9O7sEu7Ytrf83RoLXikSBQ2fK7gIYIi1CZn+QjHFB8
        dy9ouND1Ed+XmqjIJg74Xsmheg==
X-Google-Smtp-Source: AJdET5fVM7DUyX+9tXLyO9RuzZVmMUdk99G4uV7mcVhtDYmu8OCaGno/Ux1pIZMW21O+Rn9QwjRW6Q==
X-Received: by 2002:a5d:6585:: with SMTP id q5-v6mr5543009wru.141.1540881365397;
        Mon, 29 Oct 2018 23:36:05 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c64-v6sm11924731wma.44.2018.10.29.23.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 23:36:04 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [v1 2/2] mpt3sas: Add support to Aero PCI IDs.
Date:   Tue, 30 Oct 2018 12:05:16 +0530
Message-Id: <1540881316-13577-3-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540881316-13577-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1540881316-13577-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Aero/Sea controllers and
add warning for configurable secure type IOC.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index df56cbe..e13ff84 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -10284,6 +10284,10 @@ _scsih_determine_hba_mpi_version(struct pci_dev *pdev)
 	case MPI26_MFGPAGE_DEVID_SAS3516_1:
 	case MPI26_MFGPAGE_DEVID_SAS3416:
 	case MPI26_MFGPAGE_DEVID_SAS3616:
+	case MPI26_MFGPAGE_DEVID_CFG_SEC_3916:
+	case MPI26_MFGPAGE_DEVID_HARD_SEC_3916:
+	case MPI26_MFGPAGE_DEVID_CFG_SEC_3816:
+	case MPI26_MFGPAGE_DEVID_HARD_SEC_3816:
 		return MPI26_VERSION;
 	}
 	return 0;
@@ -10336,6 +10340,7 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ioc->hba_mpi_version_belonged = hba_mpi_version;
 		ioc->id = mpt2_ids++;
 		sprintf(ioc->driver_name, "%s", MPT2SAS_DRIVER_NAME);
+		sprintf(ioc->name, "%s_cm%d", ioc->driver_name, ioc->id);
 		switch (pdev->device) {
 		case MPI2_MFGPAGE_DEVID_SSS6200:
 			ioc->is_warpdrive = 1;
@@ -10361,7 +10366,11 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ioc->hba_mpi_version_belonged = hba_mpi_version;
 		ioc->id = mpt3_ids++;
 		sprintf(ioc->driver_name, "%s", MPT3SAS_DRIVER_NAME);
+		sprintf(ioc->name, "%s_cm%d", ioc->driver_name, ioc->id);
 		switch (pdev->device) {
+		case MPI26_MFGPAGE_DEVID_CFG_SEC_3816:
+		case MPI26_MFGPAGE_DEVID_CFG_SEC_3916:
+			ioc_warn(ioc, "HBA is in Configurable Secure mode\n");
 		case MPI26_MFGPAGE_DEVID_SAS3508:
 		case MPI26_MFGPAGE_DEVID_SAS3508_1:
 		case MPI26_MFGPAGE_DEVID_SAS3408:
@@ -10369,6 +10378,8 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		case MPI26_MFGPAGE_DEVID_SAS3516_1:
 		case MPI26_MFGPAGE_DEVID_SAS3416:
 		case MPI26_MFGPAGE_DEVID_SAS3616:
+		case MPI26_MFGPAGE_DEVID_HARD_SEC_3816:
+		case MPI26_MFGPAGE_DEVID_HARD_SEC_3916:
 			ioc->is_gen35_ioc = 1;
 			break;
 		default:
@@ -10437,8 +10448,6 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	INIT_LIST_HEAD(&ioc->delayed_tr_volume_list);
 	INIT_LIST_HEAD(&ioc->reply_queue_list);
 
-	sprintf(ioc->name, "%s_cm%d", ioc->driver_name, ioc->id);
-
 	/* init shost parameters */
 	shost->max_cmd_len = 32;
 	shost->max_lun = max_lun;
@@ -10830,6 +10839,23 @@ static const struct pci_device_id mpt3sas_pci_table[] = {
 	/* Mercator ~ 3616*/
 	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3616,
 		PCI_ANY_ID, PCI_ANY_ID },
+
+	/* Aero SI 0x00E1 Configurable Secure
+	 * 0x00E2 Hard Secure
+	 */
+	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_CFG_SEC_3916,
+		PCI_ANY_ID, PCI_ANY_ID },
+	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_HARD_SEC_3916,
+		PCI_ANY_ID, PCI_ANY_ID },
+
+	/* Sea SI 0x00E5 Configurable Secure
+	 * 0x00E6 Hard Secure
+	 */
+	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_CFG_SEC_3816,
+		PCI_ANY_ID, PCI_ANY_ID },
+	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_HARD_SEC_3816,
+		PCI_ANY_ID, PCI_ANY_ID },
+
 	{0}     /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(pci, mpt3sas_pci_table);
-- 
1.8.3.1

