Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ECAC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355B820663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Uy2kcgxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfA2MPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:15:03 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41977 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbfA2MPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:15:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so8660104pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=60j29YiQO+NbAgDxRNhc0vRULzmZeAHIIxA4lYHbQg8=;
        b=Uy2kcgxCm1GTEti5saOOlqzBlQJFQjq/hi8O++a8DpnK5QUZLkMRbwt0HLacm04utU
         47D3S5buKgbATnO+Ol4ECQY/K7QL+NSG61I2aOYOW00JZodqYLInG1/WQqtflxgDgNAe
         LeZdZlLE2wn4W1uAuE/ZtOhB/fWCgSl5HWVbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=60j29YiQO+NbAgDxRNhc0vRULzmZeAHIIxA4lYHbQg8=;
        b=rPJWbfVHdQib2USf4T2SJJCoSJDeVv3/d1wYTfhvfL7sR8D+as8+rIuAImJjGu1QZf
         z7G/A12JULDqw8kYt6aCsYs3FVozynF4CAEVs3SIw0suh/WOe/LCc5ZEaLhTAFC/c2kh
         QiTODYu2CNg+3jDPwsxYe0r4IqQgH02bMiOgEs2WjVwvv/N2aAvurVmouy50JBqpLJM7
         cCD2MADn1uFeSCuBlxNMcqkn7oefUvMwSwJa7NjWzcoz/W2dzfxXOQXzv3hHuq8yd/Qu
         b/l+UYohMBNOrVyGhBUCskfdm239jKRy8L5vYhFsAtpbjRcHTEAAD7wI5UcpGlttZnUS
         JkAw==
X-Gm-Message-State: AJcUukc9llSpSXOTM1rR2DXzmd9gTK1667b2sBFlQTDEBkI7vdU217Hp
        Nw0xNN8und/mTNEkY4JQMJR1+g==
X-Google-Smtp-Source: ALg8bN6M52qvmq8fX6oiy5kv72t7XEaUY+6q9M3aNVMU4pyzrN/urIpMAF2nVU/Gp9b0QURcC0eUtw==
X-Received: by 2002:a65:4784:: with SMTP id e4mr23012858pgs.12.1548764101171;
        Tue, 29 Jan 2019 04:15:01 -0800 (PST)
Received: from dhcp-10-123-20-72.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g136sm48689876pfb.154.2019.01.29.04.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 04:15:00 -0800 (PST)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 3/4] mpt3sas: Add support for ATLAS PCIe switch.
Date:   Tue, 29 Jan 2019 07:14:42 -0500
Message-Id: <1548764083-5781-4-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1548764083-5781-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1548764083-5781-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Atlas PCIe Switch Management Port device PNPID,
Vendor Id: 0x1000
device Id: 0x00B2

This device is based on MPI 2.6 spec and it exposes one
SES device to accept management commands for the PCIe switch.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.h  | 3 +++
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 8003519..db12c1b 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -193,6 +193,9 @@ struct mpt3sas_nvme_cmd {
 #define SAS2_PCI_DEVICE_B0_REVISION	(0x01)
 #define SAS3_PCI_DEVICE_C0_REVISION	(0x02)
 
+/* Atlas PCIe Switch Management Port */
+#define MPI26_ATLAS_PCIe_SWITCH_DEVID	(0x00B2)
+
 /*
  * Intel HBA branding
  */
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 4a73753..8bb5b8f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -10283,6 +10283,7 @@ _scsih_determine_hba_mpi_version(struct pci_dev *pdev)
 	case MPI26_MFGPAGE_DEVID_SAS3516_1:
 	case MPI26_MFGPAGE_DEVID_SAS3416:
 	case MPI26_MFGPAGE_DEVID_SAS3616:
+	case MPI26_ATLAS_PCIe_SWITCH_DEVID:
 	case MPI26_MFGPAGE_DEVID_CFG_SEC_3916:
 	case MPI26_MFGPAGE_DEVID_HARD_SEC_3916:
 	case MPI26_MFGPAGE_DEVID_CFG_SEC_3816:
@@ -10373,6 +10374,7 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		case MPI26_MFGPAGE_DEVID_SAS3516_1:
 		case MPI26_MFGPAGE_DEVID_SAS3416:
 		case MPI26_MFGPAGE_DEVID_SAS3616:
+		case MPI26_ATLAS_PCIe_SWITCH_DEVID:
 			ioc->is_gen35_ioc = 1;
 			break;
 		case MPI26_MFGPAGE_DEVID_CFG_SEC_3816:
@@ -10853,6 +10855,10 @@ static const struct pci_device_id mpt3sas_pci_table[] = {
 	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_HARD_SEC_3916,
 		PCI_ANY_ID, PCI_ANY_ID },
 
+	/* Atlas PCIe Switch Management Port */
+	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_ATLAS_PCIe_SWITCH_DEVID,
+		PCI_ANY_ID, PCI_ANY_ID },
+
 	/* Sea SI 0x00E5 Configurable Secure
 	 * 0x00E6 Hard Secure
 	 */
-- 
1.8.3.1

