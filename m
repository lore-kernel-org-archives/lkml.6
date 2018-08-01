Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E0EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D3A208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D3A208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeHATl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:41:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49926 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405960AbeHATIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:40 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 27D3510BB;
        Wed,  1 Aug 2018 17:03:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 194/336] i40e: free the skb after clearing the bitlock
Date:   Wed,  1 Aug 2018 18:48:49 +0200
Message-Id: <20180801165036.519999218@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit c79756cb5f084736b138da9319a02f7c72644548 ]

In commit bbc4e7d273b5 ("i40e: fix race condition with PTP_TX_IN_PROGRESS
bits") we modified the code which handles Tx timestamps so that we would
clear the progress bit as soon as possible.

A later commit 0bc0706b46cd ("i40e: check for Tx timestamp timeouts during
watchdog") introduced similar code for detecting and handling cleanup of
a blocked Tx timestamp. This code did not use the same pattern for cleaning
up the skb.

Update this code to wait to free the skb until after the bit lock is
free, by first setting the ptp_tx_skb to NULL and clearing the lock.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -338,6 +338,8 @@ void i40e_ptp_rx_hang(struct i40e_pf *pf
  **/
 void i40e_ptp_tx_hang(struct i40e_pf *pf)
 {
+	struct sk_buff *skb;
+
 	if (!(pf->flags & I40E_FLAG_PTP) || !pf->ptp_tx)
 		return;
 
@@ -350,9 +352,12 @@ void i40e_ptp_tx_hang(struct i40e_pf *pf
 	 * within a second it is reasonable to assume that we never will.
 	 */
 	if (time_is_before_jiffies(pf->ptp_tx_start + HZ)) {
-		dev_kfree_skb_any(pf->ptp_tx_skb);
+		skb = pf->ptp_tx_skb;
 		pf->ptp_tx_skb = NULL;
 		clear_bit_unlock(__I40E_PTP_TX_IN_PROGRESS, pf->state);
+
+		/* Free the skb after we clear the bitlock */
+		dev_kfree_skb_any(skb);
 		pf->tx_hwtstamp_timeouts++;
 	}
 }


