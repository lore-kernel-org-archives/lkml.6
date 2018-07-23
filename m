Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99364ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C6920875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVXBawUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C6920875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbeGWRzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:55:18 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36831 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388283AbeGWRzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:55:18 -0400
Received: by mail-oi0-f65.google.com with SMTP id n21-v6so2365329oig.3;
        Mon, 23 Jul 2018 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dQLG0mNyRfCdnJvs632GE/CPpAlUSOPE8hbK+IFSBCo=;
        b=rVXBawUGjPH+mgL7YCcwd6+EQhy4Uw5eBuf7AW4ZGrP03PYgSe+cuJASNJwcrcn0ZF
         dvy6gHLyZSrekBJcgCeVgMatDaaZkvLrfLOKQNJl5OdWfpLAnaoBAEWmqy41IHskCnDk
         lhNsfMQHC1HQy6lbNnBZK9qQSv80QLNcHsOaE9e95+gzp5Ck+h07LQ9FWCoqihG2xS2E
         WelL9Z7mHzXVCjWymJFH/tQ2xr0za3v0SxQVzNb/2H+u96h2Am0CfLWCg+k4HhsjtzD3
         Rbxc5jyCw7/ikfKPfoUUAYf5dFSeGnEsCApOBm009bfuCRYwX+/4lob5nXuCg1Yz8fnS
         gd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dQLG0mNyRfCdnJvs632GE/CPpAlUSOPE8hbK+IFSBCo=;
        b=ZUysQgCy0CdOm7cwMuC0rOH//vMu4nNKotq36mUYBYKRWT/8o2HYvBS98w29MHNJ3V
         oBOT0OSucldMRKNLF/lQlI+TbHhj3zujoGmJAkI+JQIpQEz947FF1XcfG7voUwj0Bm4A
         aA4WvLuiVJj6VGkkkbMdF4oOXYlv6CPXRFZrRTqgmaQXG67TVwEvEbn4cfZA9UNuJbKK
         1LZePErMh1MY2GpEmmwVZMZDefjWradMOHZOlHsBMV9z3tGu/+6+E7gBWepCTlGQ64p6
         4rjFmZ8kU09Vrs+AeVSDBZcmQe0igaduNdeAVGt4bATkNOM2Ig7A5VlozEuSgJb/HzAJ
         5cCw==
X-Gm-Message-State: AOUpUlENdWLNym4Y1KdObS+gN/7YV10PxI7KsiIHrmFYRAd3G4Hkhe+T
        sqFYW/BUlFmGHJKTo93uS87j7Suel9E=
X-Google-Smtp-Source: AAOMgpeGrs8CLZsp4wVt8TqD3CHiYI6/Gz4NtA5JVE11YzWxPIIYxevUpRLq3+uhdsOrvVezd20OAg==
X-Received: by 2002:aca:c355:: with SMTP id t82-v6mr3194526oif.327.1532364791701;
        Mon, 23 Jul 2018 09:53:11 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id r3-v6sm6917610oig.49.2018.07.23.09.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 09:53:11 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI/AER: Do not clear AER bits if we don't own AER
Date:   Mon, 23 Jul 2018 11:52:33 -0500
Message-Id: <20180723165251.11424-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717153135.25925-1-mr.nuke.me@gmail.com>
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we don't own AER, we shouldn't touch the AER error bits. Clearing
error bits willy-nilly might cause firmware to miss some errors. In
theory, these bits get cleared by FFS, or via ACPI _HPX method. These
mechanisms are not subject to the problem.

This race is mostly of theoretical significance, since I can't
reasonably demonstrate this race in the lab.

On a side-note, pcie_aer_is_kernel_first() is created to alleviate the
need for two checks: aer_cap and get_firmware_first().

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pcie/aer.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e88386af28..85c3e173c025 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -307,6 +307,12 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
 		aer_set_firmware_first(dev);
 	return dev->__aer_firmware_first;
 }
+
+static bool pcie_aer_is_kernel_first(struct pci_dev *dev)
+{
+	return !!dev->aer_cap && !pcie_aer_get_firmware_first(dev);
+}
+
 #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
 				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 
@@ -337,10 +343,7 @@ bool aer_acpi_firmware_first(void)
 
 int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
-	if (pcie_aer_get_firmware_first(dev))
-		return -EIO;
-
-	if (!dev->aer_cap)
+	if (!pcie_aer_is_kernel_first(dev))
 		return -EIO;
 
 	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
@@ -349,7 +352,7 @@ EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
 
 int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 {
-	if (pcie_aer_get_firmware_first(dev))
+	if (!pcie_aer_is_kernel_first(dev))
 		return -EIO;
 
 	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
@@ -383,10 +386,10 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return -ENODEV;
 
-	pos = dev->aer_cap;
-	if (!pos)
+	if (pcie_aer_is_kernel_first(dev))
 		return -EIO;
 
+	pos = dev->aer_cap;
 	port_type = pci_pcie_type(dev);
 	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
 		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
-- 
2.17.1

