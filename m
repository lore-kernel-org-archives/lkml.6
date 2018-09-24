Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55A1ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB9921486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB9921486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733010AbeIXS1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:27:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57024 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbeIXS1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:27:39 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 17E9F108B;
        Mon, 24 Sep 2018 12:25:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Poirier <bpoirier@suse.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.14 167/173] e1000e: Remove Other from EIAC
Date:   Mon, 24 Sep 2018 13:53:21 +0200
Message-Id: <20180924113127.289044233@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
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

From: Benjamin Poirier <bpoirier@suse.com>

commit 745d0bd3af99ccc8c5f5822f808cd133eadad6ac upstream.

It was reported that emulated e1000e devices in vmware esxi 6.5 Build
7526125 do not link up after commit 4aea7a5c5e94 ("e1000e: Avoid receiver
overrun interrupt bursts", v4.15-rc1). Some tracing shows that after
e1000e_trigger_lsc() is called, ICR reads out as 0x0 in e1000_msix_other()
on emulated e1000e devices. In comparison, on real e1000e 82574 hardware,
icr=0x80000004 (_INT_ASSERTED | _LSC) in the same situation.

Some experimentation showed that this flaw in vmware e1000e emulation can
be worked around by not setting Other in EIAC. This is how it was before
16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt", v4.5-rc1).

Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/intel/e1000e/netdev.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1914,6 +1914,8 @@ static irqreturn_t e1000_msix_other(int
 	bool enable = true;
 
 	icr = er32(ICR);
+	ew32(ICR, E1000_ICR_OTHER);
+
 	if (icr & E1000_ICR_RXO) {
 		ew32(ICR, E1000_ICR_RXO);
 		enable = false;
@@ -2036,7 +2038,6 @@ static void e1000_configure_msix(struct
 		       hw->hw_addr + E1000_EITR_82574(vector));
 	else
 		writel(1, hw->hw_addr + E1000_EITR_82574(vector));
-	adapter->eiac_mask |= E1000_IMS_OTHER;
 
 	/* Cause Tx interrupts on every write back */
 	ivar |= BIT(31);
@@ -2261,7 +2262,7 @@ static void e1000_irq_enable(struct e100
 
 	if (adapter->msix_entries) {
 		ew32(EIAC_82574, adapter->eiac_mask & E1000_EIAC_MASK_82574);
-		ew32(IMS, adapter->eiac_mask | E1000_IMS_LSC);
+		ew32(IMS, adapter->eiac_mask | E1000_IMS_OTHER | E1000_IMS_LSC);
 	} else if (hw->mac.type >= e1000_pch_lpt) {
 		ew32(IMS, IMS_ENABLE_MASK | E1000_IMS_ECCER);
 	} else {


