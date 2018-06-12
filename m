Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 15190C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2F1208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J5B01KS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2F1208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934624AbeFLAVZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:21:25 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39708 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeFLAVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:21:22 -0400
Received: by mail-qt0-f194.google.com with SMTP id p23-v6so22165056qtn.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IZIfWT68EKnh4aKZ+y6h6kxODbJlO32QgXTeN2RggQA=;
        b=J5B01KS1HBV2x4WfSmTn8/jIG+0Zrn/XxjpGdDClngz5TCUxDMnc4Q4CpGLuUjKgBC
         li2MPi2kbk+N1zPa5whV7ZLgBbBOzDgPOPQg2xL3rsG0Ztcm9vDgFZTnaw2CUaXw/+wF
         CAiy+mCSToGJ6sYKh/r9T+lMZvo8/iReJZ5AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IZIfWT68EKnh4aKZ+y6h6kxODbJlO32QgXTeN2RggQA=;
        b=tY/vgBUsiWy1RMAMK32RFTFGBP/V4grj9IjL71k8IEsQoR7NaM5hqCQEN53XGG4iXG
         7Hwa6l7/i912BYkwiCZh2hkLTtrm7ckxpd2vo2zbw6bYrosvpTiHsPPDSfkJKgMf6YWV
         wiNRwxBrX/Vkyq4zuvCPWskwjeIaVALBP5ev3Ms6N2qP6kCEfiGiI19zaH1LXYB7If/0
         otTjSiUGGEWrjsor/vBIyv9zKECMAiUbhnQPyEX+knOpvIHHa+29FJSaRCwrovHQbFNg
         B6cx3yDluu5ZNnAADA5xIoiHM2vbulzbY75yepKmIKVMisF+7U+yC2sQAQ8Bw3oInwZY
         mp+A==
X-Gm-Message-State: APt69E06OKM4IgUqc2XfGvbE0oDXcLlS4TDXXiEyj23d5245U35rr5yN
        XWeI0TDF5wNua8yWgqmIzUmqKH4aiY8=
X-Google-Smtp-Source: ADUXVKKkiZeag/umgVXd02Otiw/yaxVeWnJZQb0XALDvFflIQcZNVMSMlcK6SR41oIgw2yzXLc4C1g==
X-Received: by 2002:ac8:2c37:: with SMTP id d52-v6mr1426010qta.108.1528762881854;
        Mon, 11 Jun 2018 17:21:21 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v26-v6sm31470299qtc.12.2018.06.11.17.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jun 2018 17:21:20 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 1/5] PCI: iproc: Activate PAXC bridge quirk for more devices
Date:   Mon, 11 Jun 2018 17:21:03 -0700
Message-Id: <1528762867-16823-2-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Activate PAXC bridge quirk for more PAXC based PCIe root complex with
the following PCIe device ID:
0xd750, 0xd802, 0xd804

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/pci/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2990ad1..47dfea0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2195,6 +2195,9 @@ static void quirk_paxc_bridge(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
 #endif
 
 /* Originally in EDAC sources for i82875P:
-- 
2.1.4

