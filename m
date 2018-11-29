Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5771CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A012146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSPiP0DQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A012146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbeK3Bcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:32:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:60754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731824AbeK3Bcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:32:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F027B2146D;
        Thu, 29 Nov 2018 14:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501618;
        bh=B5hcnHAOFD6Avd4iHyZmo88WobMOOBfE9Q2VFYz1fMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MSPiP0DQHzsMXyCVm4TxpBTXorciWkByn9r/A/1DmsknIa2px9VxmOC8yrjNSqgk1
         wGe69h96fJsLhs49LlgpTGo5B7QiUvoJy42Ah5XAG7fHLGVX9fVCRqJkCDnv99f183
         /b+QjppJfg73Ibdo15/lk2zILD9GNasjXwTx2/IE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        "Cherian, George" <George.Cherian@cavium.com>
Subject: [PATCH 4.14 071/100] xhci: Allow more than 32 quirks
Date:   Thu, 29 Nov 2018 15:12:41 +0100
Message-Id: <20181129140104.979952625@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 36b6857932f380fcb55c31ac75857e3e81dd583a upstream.

We now have 32 different quirks, and the field that holds them
is full. Let's bump it up to the next stage so that we can handle
some more... The type is now an unsigned long long, which is 64bit
on most architectures.

We take this opportunity to change the quirks from using (1 << x)
to BIT_ULL(x).

Tested-by: Domenico Andreoli <domenico.andreoli@linux.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Faiz Abbas <faiz_abbas@ti.com>
Tested-by: Domenico Andreoli <domenico.andreoli@linux.com>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: "Cherian, George" <George.Cherian@cavium.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.c |    6 ++--
 drivers/usb/host/xhci.h |   64 ++++++++++++++++++++++++------------------------
 2 files changed, 36 insertions(+), 34 deletions(-)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -43,8 +43,8 @@ static int link_quirk;
 module_param(link_quirk, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(link_quirk, "Don't clear the chain bit on a link TRB");
 
-static unsigned int quirks;
-module_param(quirks, uint, S_IRUGO);
+static unsigned long long quirks;
+module_param(quirks, ullong, S_IRUGO);
 MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
 
 static bool td_on_ring(struct xhci_td *td, struct xhci_ring *ring)
@@ -4956,7 +4956,7 @@ int xhci_gen_setup(struct usb_hcd *hcd,
 		return retval;
 	xhci_dbg(xhci, "Called HCD init\n");
 
-	xhci_info(xhci, "hcc params 0x%08x hci version 0x%x quirks 0x%08x\n",
+	xhci_info(xhci, "hcc params 0x%08x hci version 0x%x quirks 0x%016llx\n",
 		  xhci->hcc_params, xhci->hci_version, xhci->quirks);
 
 	return 0;
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1794,12 +1794,12 @@ struct xhci_hcd {
 #define XHCI_STATE_DYING	(1 << 0)
 #define XHCI_STATE_HALTED	(1 << 1)
 #define XHCI_STATE_REMOVING	(1 << 2)
-	unsigned int		quirks;
-#define	XHCI_LINK_TRB_QUIRK	(1 << 0)
-#define XHCI_RESET_EP_QUIRK	(1 << 1)
-#define XHCI_NEC_HOST		(1 << 2)
-#define XHCI_AMD_PLL_FIX	(1 << 3)
-#define XHCI_SPURIOUS_SUCCESS	(1 << 4)
+	unsigned long long	quirks;
+#define	XHCI_LINK_TRB_QUIRK	BIT_ULL(0)
+#define XHCI_RESET_EP_QUIRK	BIT_ULL(1)
+#define XHCI_NEC_HOST		BIT_ULL(2)
+#define XHCI_AMD_PLL_FIX	BIT_ULL(3)
+#define XHCI_SPURIOUS_SUCCESS	BIT_ULL(4)
 /*
  * Certain Intel host controllers have a limit to the number of endpoint
  * contexts they can handle.  Ideally, they would signal that they can't handle
@@ -1809,33 +1809,35 @@ struct xhci_hcd {
  * commands, reset device commands, disable slot commands, and address device
  * commands.
  */
-#define XHCI_EP_LIMIT_QUIRK	(1 << 5)
-#define XHCI_BROKEN_MSI		(1 << 6)
-#define XHCI_RESET_ON_RESUME	(1 << 7)
-#define	XHCI_SW_BW_CHECKING	(1 << 8)
-#define XHCI_AMD_0x96_HOST	(1 << 9)
-#define XHCI_TRUST_TX_LENGTH	(1 << 10)
-#define XHCI_LPM_SUPPORT	(1 << 11)
-#define XHCI_INTEL_HOST		(1 << 12)
-#define XHCI_SPURIOUS_REBOOT	(1 << 13)
-#define XHCI_COMP_MODE_QUIRK	(1 << 14)
-#define XHCI_AVOID_BEI		(1 << 15)
-#define XHCI_PLAT		(1 << 16)
-#define XHCI_SLOW_SUSPEND	(1 << 17)
-#define XHCI_SPURIOUS_WAKEUP	(1 << 18)
+#define XHCI_EP_LIMIT_QUIRK	BIT_ULL(5)
+#define XHCI_BROKEN_MSI		BIT_ULL(6)
+#define XHCI_RESET_ON_RESUME	BIT_ULL(7)
+#define	XHCI_SW_BW_CHECKING	BIT_ULL(8)
+#define XHCI_AMD_0x96_HOST	BIT_ULL(9)
+#define XHCI_TRUST_TX_LENGTH	BIT_ULL(10)
+#define XHCI_LPM_SUPPORT	BIT_ULL(11)
+#define XHCI_INTEL_HOST		BIT_ULL(12)
+#define XHCI_SPURIOUS_REBOOT	BIT_ULL(13)
+#define XHCI_COMP_MODE_QUIRK	BIT_ULL(14)
+#define XHCI_AVOID_BEI		BIT_ULL(15)
+#define XHCI_PLAT		BIT_ULL(16)
+#define XHCI_SLOW_SUSPEND	BIT_ULL(17)
+#define XHCI_SPURIOUS_WAKEUP	BIT_ULL(18)
 /* For controllers with a broken beyond repair streams implementation */
-#define XHCI_BROKEN_STREAMS	(1 << 19)
-#define XHCI_PME_STUCK_QUIRK	(1 << 20)
-#define XHCI_MTK_HOST		(1 << 21)
-#define XHCI_SSIC_PORT_UNUSED	(1 << 22)
-#define XHCI_NO_64BIT_SUPPORT	(1 << 23)
-#define XHCI_MISSING_CAS	(1 << 24)
+#define XHCI_BROKEN_STREAMS	BIT_ULL(19)
+#define XHCI_PME_STUCK_QUIRK	BIT_ULL(20)
+#define XHCI_MTK_HOST		BIT_ULL(21)
+#define XHCI_SSIC_PORT_UNUSED	BIT_ULL(22)
+#define XHCI_NO_64BIT_SUPPORT	BIT_ULL(23)
+#define XHCI_MISSING_CAS	BIT_ULL(24)
 /* For controller with a broken Port Disable implementation */
-#define XHCI_BROKEN_PORT_PED	(1 << 25)
-#define XHCI_LIMIT_ENDPOINT_INTERVAL_7	(1 << 26)
-#define XHCI_U2_DISABLE_WAKE	(1 << 27)
-#define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	(1 << 28)
-#define XHCI_SUSPEND_DELAY	(1 << 30)
+#define XHCI_BROKEN_PORT_PED	BIT_ULL(25)
+#define XHCI_LIMIT_ENDPOINT_INTERVAL_7	BIT_ULL(26)
+#define XHCI_U2_DISABLE_WAKE	BIT_ULL(27)
+#define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	BIT_ULL(28)
+#define XHCI_HW_LPM_DISABLE	BIT_ULL(29)
+#define XHCI_SUSPEND_DELAY	BIT_ULL(30)
+#define XHCI_INTEL_USB_ROLE_SW	BIT_ULL(31)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;


