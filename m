Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE18C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9609421476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yhRsaTOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9609421476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbeJKXPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbeJKXPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:15:34 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0296F213A2;
        Thu, 11 Oct 2018 15:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272868;
        bh=+J2c62vK1W2WHTElnXHMLHP2UGne+WNiUDs5eWiG47A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yhRsaTOIKuimVo72nq353sUsI9AgzzueddAFHmHvTA0tvloYoZCU2DVTHsscewJXH
         YUNNS8/MuNv25eHuV+MQmSn1nUHEQ4Q2yNWU8OuAZ1Ow/yOxULuBbTr+Dty8wAgSzF
         /LBUXi5dnL+8Z1M23ti66AUIP2/xLeVxvog8RVAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Wu <peter@lekensteyn.nl>
Subject: [PATCH 4.18 22/44] PCI: Reprogram bridge prefetch registers on resume
Date:   Thu, 11 Oct 2018 17:40:00 +0200
Message-Id: <20181011152453.426767474@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Drake <drake@endlessm.com>

commit 083874549fdfefa629dfa752785e20427dde1511 upstream.

On 38+ Intel-based ASUS products, the NVIDIA GPU becomes unusable after S3
suspend/resume.  The affected products include multiple generations of
NVIDIA GPUs and Intel SoCs.  After resume, nouveau logs many errors such
as:

  fifo: fault 00 [READ] at 0000005555555000 engine 00 [GR] client 04
        [HUB/FE] reason 4a [] on channel -1 [007fa91000 unknown]
  DRM: failed to idle channel 0 [DRM]

Similarly, the NVIDIA proprietary driver also fails after resume (black
screen, 100% CPU usage in Xorg process).  We shipped a sample to NVIDIA for
diagnosis, and their response indicated that it's a problem with the parent
PCI bridge (on the Intel SoC), not the GPU.

Runtime suspend/resume works fine, only S3 suspend is affected.

We found a workaround: on resume, rewrite the Intel PCI bridge
'Prefetchable Base Upper 32 Bits' register (PCI_PREF_BASE_UPPER32).  In the
cases that I checked, this register has value 0 and we just have to rewrite
that value.

Linux already saves and restores PCI config space during suspend/resume,
but this register was being skipped because upon resume, it already has
value 0 (the correct, pre-suspend value).

Intel appear to have previously acknowledged this behaviour and the
requirement to rewrite this register:
https://bugzilla.kernel.org/show_bug.cgi?id=116851#c23

Based on that, rewrite the prefetch register values even when that appears
unnecessary.

We have confirmed this solution on all the affected models we have in-hands
(X542UQ, UX533FD, X530UN, V272UN).

Additionally, this solves an issue where r8169 MSI-X interrupts were broken
after S3 suspend/resume on ASUS X441UAR.  This issue was recently worked
around in commit 7bb05b85bc2d ("r8169: don't use MSI-X on RTL8106e").  It
also fixes the same issue on RTL6186evl/8111evl on an Aimfor-tech laptop
that we had not yet patched.  I suspect it will also fix the issue that was
worked around in commit 7c53a722459c ("r8169: don't use MSI-X on
RTL8168g").

Thomas Martitz reports that this change also solves an issue where the AMD
Radeon Polaris 10 GPU on the HP Zbook 14u G5 is unresponsive after S3
suspend/resume.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=201069
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-By: Peter Wu <peter@lekensteyn.nl>
CC: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci.c |   27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1125,12 +1125,12 @@ int pci_save_state(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_save_state);
 
 static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
-				     u32 saved_val, int retry)
+				     u32 saved_val, int retry, bool force)
 {
 	u32 val;
 
 	pci_read_config_dword(pdev, offset, &val);
-	if (val == saved_val)
+	if (!force && val == saved_val)
 		return;
 
 	for (;;) {
@@ -1149,25 +1149,36 @@ static void pci_restore_config_dword(str
 }
 
 static void pci_restore_config_space_range(struct pci_dev *pdev,
-					   int start, int end, int retry)
+					   int start, int end, int retry,
+					   bool force)
 {
 	int index;
 
 	for (index = end; index >= start; index--)
 		pci_restore_config_dword(pdev, 4 * index,
 					 pdev->saved_config_space[index],
-					 retry);
+					 retry, force);
 }
 
 static void pci_restore_config_space(struct pci_dev *pdev)
 {
 	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
-		pci_restore_config_space_range(pdev, 10, 15, 0);
+		pci_restore_config_space_range(pdev, 10, 15, 0, false);
 		/* Restore BARs before the command register. */
-		pci_restore_config_space_range(pdev, 4, 9, 10);
-		pci_restore_config_space_range(pdev, 0, 3, 0);
+		pci_restore_config_space_range(pdev, 4, 9, 10, false);
+		pci_restore_config_space_range(pdev, 0, 3, 0, false);
+	} else if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		pci_restore_config_space_range(pdev, 12, 15, 0, false);
+
+		/*
+		 * Force rewriting of prefetch registers to avoid S3 resume
+		 * issues on Intel PCI bridges that occur when these
+		 * registers are not explicitly written.
+		 */
+		pci_restore_config_space_range(pdev, 9, 11, 0, true);
+		pci_restore_config_space_range(pdev, 0, 8, 0, false);
 	} else {
-		pci_restore_config_space_range(pdev, 0, 15, 0);
+		pci_restore_config_space_range(pdev, 0, 15, 0, false);
 	}
 }
 


