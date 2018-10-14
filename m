Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E16C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B4520876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B4520876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbeJNX1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:27:24 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37188 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728141AbeJNX1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:27:23 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM0-0004co-JA; Sun, 14 Oct 2018 16:30:52 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLT-0000NE-JA; Sun, 14 Oct 2018 16:30:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Michael Ellerman" <mpe@ellerman.id.au>,
        "Russell Currey" <ruscur@russell.cc>,
        "Pridhiviraj Paidipeddi" <ppaidipe@linux.vnet.ibm.com>,
        "Michael Neuling" <mikey@neuling.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.349606110@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 172/366] powerpc/eeh: Fix enabling bridge MMIO windows
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Neuling <mikey@neuling.org>

commit 13a83eac373c49c0a081cbcd137e79210fe78acd upstream.

On boot we save the configuration space of PCIe bridges. We do this so
when we get an EEH event and everything gets reset that we can restore
them.

Unfortunately we save this state before we've enabled the MMIO space
on the bridges. Hence if we have to reset the bridge when we come back
MMIO is not enabled and we end up taking an PE freeze when the driver
starts accessing again.

This patch forces the memory/MMIO and bus mastering on when restoring
bridges on EEH. Ideally we'd do this correctly by saving the
configuration space writes later, but that will have to come later in
a larger EEH rewrite. For now we have this simple fix.

The original bug can be triggered on a boston machine by doing:
  echo 0x8000000000000000 > /sys/kernel/debug/powerpc/PCI0001/err_injct_outbound
On boston, this PHB has a PCIe switch on it.  Without this patch,
you'll see two EEH events, 1 expected and 1 the failure we are fixing
here. The second EEH event causes the anything under the PHB to
disappear (i.e. the i40e eth).

With this patch, only 1 EEH event occurs and devices properly recover.

Fixes: 652defed4875 ("powerpc/eeh: Check PCIe link after reset")
Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/kernel/eeh_pe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -723,7 +723,8 @@ static void eeh_restore_bridge_bars(stru
 	eeh_ops->write_config(dn, 15*4, 4, edev->config_space[15]);
 
 	/* PCI Command: 0x4 */
-	eeh_ops->write_config(dn, PCI_COMMAND, 4, edev->config_space[1]);
+	eeh_ops->write_config(dn, PCI_COMMAND, 4, edev->config_space[1] |
+			      PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
 
 	/* Check the PCIe link is ready */
 	eeh_bridge_check_link(edev, dn);

