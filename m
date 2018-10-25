Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3D4ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD55E2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="blh2vAFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD55E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeJYSnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:43:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37294 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeJYSnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:43:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so902617wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 03:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mqeCcwAHk+aED55ENqtQKj4Jr6ZppbkD0DNkfQafTP0=;
        b=blh2vAFb10quhRGPk97Cii5LOguA1Nu1SY3CTc1fX0nq8flWKVujs4BWK+LThIwKFG
         pjw3QBp6mjgzSWEfJbixR+FRINtWViuBOsYBqY3FCcexXy4TJgmYU36DJtIkxmCgQ4/3
         8+BE4CilGPi/vlX//XiflUfDEkvSvx0NhKiPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mqeCcwAHk+aED55ENqtQKj4Jr6ZppbkD0DNkfQafTP0=;
        b=j4xsAEUNJFH7f8c9ks0vh3lNTfdSIfg2lgkn/I3Efvst4uvZZ6VyIhWg3GBdpFVadq
         3262oqmY9/Ukjvo4+AEk0V4RYXee7RZEGhO1vG42h+El+r3HsRbF7I+UsOu88vkxCXt2
         DHZyfbl2iUxlf1Gqevdo65V+ReCi50OS+MDTdeSdwmLjyZ6w0Jc2bxCV8rhrWASkNb2Z
         r94AowsiE55pWIDSQvLzEImR7qKUfelUz3ZjyD75Fb3W5vfwt6SFExdsUCSr2VQ5jNXH
         Q4IbVqaxfFeNMB7TB95U9w0UJWd0l3zKzTz9JnBrWgeMzkeO6xQPafXdzS/FeuI/eHf5
         ES8w==
X-Gm-Message-State: AGRZ1gKR2FlGZaEYAtvjV+XvdMRtvlf4lzwqQhrEhdKRKbV6jO5P9HdF
        A7swqetdoNCTsHADKYLGErkIaQ==
X-Google-Smtp-Source: AJdET5dUQz7AdDklsxdlEufuNysmL8LSpFII8MORy58mAD+K7c3kZDpRnT642BpbpLdPljBKClIftg==
X-Received: by 2002:a1c:58f:: with SMTP id 137-v6mr1209369wmf.37.1540462275584;
        Thu, 25 Oct 2018 03:11:15 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l11-v6sm5982513wrn.61.2018.10.25.03.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 03:11:15 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 2/2] mpt3sas: Add support to Aero PCI IDs.
Date:   Thu, 25 Oct 2018 15:40:49 +0530
Message-Id: <1540462249-9984-3-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540462249-9984-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1540462249-9984-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Aero/Sea controllers and
add warning for configurable secure type IOC.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.h  |  1 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 7fdaf29..b11f5f5 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -55,6 +55,7 @@
 #include "mpi/mpi2_tool.h"
 #include "mpi/mpi2_sas.h"
 #include "mpi/mpi2_pci.h"
+#include "mpi/mpi2_image.h"
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index df56cbe..5001439 100644
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
@@ -10369,6 +10373,11 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		case MPI26_MFGPAGE_DEVID_SAS3516_1:
 		case MPI26_MFGPAGE_DEVID_SAS3416:
 		case MPI26_MFGPAGE_DEVID_SAS3616:
+		case MPI26_MFGPAGE_DEVID_CFG_SEC_3816:
+		case MPI26_MFGPAGE_DEVID_CFG_SEC_3916:
+			ioc_warn(ioc, "HBA is in Configurable Secure mode\n");
+		case MPI26_MFGPAGE_DEVID_HARD_SEC_3816:
+		case MPI26_MFGPAGE_DEVID_HARD_SEC_3916:
 			ioc->is_gen35_ioc = 1;
 			break;
 		default:
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

