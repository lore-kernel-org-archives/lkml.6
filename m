Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1F9ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835602146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835602146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbeIREiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:38:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49968 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbeIREiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:38:15 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C25EF707;
        Mon, 17 Sep 2018 23:08:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.18 009/158] mac80211: dont update the PM state of a peer upon a multicast frame
Date:   Tue, 18 Sep 2018 00:40:39 +0200
Message-Id: <20180917211711.047132526@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit 20932750d9c78d307e4f2f18f9c6a32b82b1e0e8 upstream.

I changed the way mac80211 updates the PM state of the peer.
I forgot that we could also have multicast frames from the
peer and that those frame should of course not change the
PM state of the peer: A peer goes to power save when it
needs to scan, but it won't send the broadcast Probe Request
with the PM bit set.

This made us mark the peer as awake when it wasn't and then
Intel's firmware would fail to transmit because the peer is
asleep according to its database. The driver warned about
this and it looked like this:

 WARNING: CPU: 0 PID: 184 at /usr/src/linux-4.16.14/drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1369 iwl_mvm_rx_tx_cmd+0x53b/0x860
 CPU: 0 PID: 184 Comm: irq/124-iwlwifi Not tainted 4.16.14 #1
 RIP: 0010:iwl_mvm_rx_tx_cmd+0x53b/0x860
 Call Trace:
  iwl_pcie_rx_handle+0x220/0x880
  iwl_pcie_irq_handler+0x6c9/0xa20
  ? irq_forced_thread_fn+0x60/0x60
  ? irq_thread_dtor+0x90/0x90

The relevant code that spits the WARNING is:

        case TX_STATUS_FAIL_DEST_PS:
                /* the FW should have stopped the queue and not
                 * return this status
                 */
                WARN_ON(1);
                info->flags |= IEEE80211_TX_STAT_TX_FILTERED;

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=199967.

Fixes: 9fef65443388 ("mac80211: always update the PM state of a peer on MGMT / DATA frames")
Cc: <stable@vger.kernel.org>   #4.16+
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/rx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1612,6 +1612,7 @@ ieee80211_rx_h_sta_process(struct ieee80
 	 */
 	if (!ieee80211_hw_check(&sta->local->hw, AP_LINK_PS) &&
 	    !ieee80211_has_morefrags(hdr->frame_control) &&
+	    !is_multicast_ether_addr(hdr->addr1) &&
 	    (ieee80211_is_mgmt(hdr->frame_control) ||
 	     ieee80211_is_data(hdr->frame_control)) &&
 	    !(status->rx_flags & IEEE80211_RX_DEFERRED_RELEASE) &&


