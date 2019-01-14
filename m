Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9A0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB4320651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="yWfdocym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfANN3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:29:37 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:46861 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbfANN3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:29:37 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id 8D88421747;
        Mon, 14 Jan 2019 16:29:33 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id JxqI17tisr-TXRu19oa;
        Mon, 14 Jan 2019 16:29:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1547472573; bh=al6g5gqxBiHQ2kuARC6LcE3oO3x9nXYk4BzV7QhwKvc=;
        h=Subject:From:To:Cc:Date:Message-ID;
        b=yWfdocymMNEZ0tpxyHXXVtg0WaZ5zdYSNTcgAHgA2pG+sijTuhc9CaxrUAd2LJORz
         KqZFP16tm1Lv3D64SAhvIGeeEgvuJp5FXCq59+FWaCs14Lgs0+oOB+IYpMfBHtnac6
         zoVrCKyEQWmHwXIYLPqACv8EjI8N43MrQGnXbl/I=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:ddac:7ad6:150c:c9b3])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id xhEqFlmGfv-TXhiGHsP;
        Mon, 14 Jan 2019 16:29:33 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] e1000e: fix cyclic resets at link up with active tx
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Date:   Mon, 14 Jan 2019 16:29:30 +0300
Message-ID: <154747257030.250168.12931902291381446144.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing series of e1000e resets (sometimes endless) at system boot
if something generates tx traffic at this time. In my case this is
netconsole who sends message "e1000e 0000:02:00.0: Some CPU C-states
have been disabled in order to enable jumbo frames" from e1000e itself.
As result e1000_watchdog_task sees used tx buffer while carrier is off
and start this reset cycle again.

[   17.794359] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   17.794714] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   22.936455] e1000e 0000:02:00.0 eth1: changing MTU from 1500 to 9000
[   23.033336] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   26.102364] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   27.174495] 8021q: 802.1Q VLAN Support v1.8
[   27.174513] 8021q: adding VLAN 0 to HW filter on device eth1
[   30.671724] cgroup: cgroup: disabling cgroup2 socket matching due to net_prio or net_cls activation
[   30.898564] netpoll: netconsole: local port 6666
[   30.898566] netpoll: netconsole: local IPv6 address 2a02:6b8:0:80b:beae:c5ff:fe28:23f8
[   30.898567] netpoll: netconsole: interface 'eth1'
[   30.898568] netpoll: netconsole: remote port 6666
[   30.898568] netpoll: netconsole: remote IPv6 address 2a02:6b8:b000:605c:e61d:2dff:fe03:3790
[   30.898569] netpoll: netconsole: remote ethernet address b0:a8:6e:f4:ff:c0
[   30.917747] console [netcon0] enabled
[   30.917749] netconsole: network logging started
[   31.453353] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.185730] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.321840] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.465822] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.597423] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.745417] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.877356] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   35.005441] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   35.157376] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   35.289362] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   35.417441] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   37.790342] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None

This patch flushes tx buffers only once when carrier is off
rather than at each watchdog iteration.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/net/ethernet/intel/e1000e/netdev.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 189f231075c2..d10083beec83 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5309,8 +5309,13 @@ static void e1000_watchdog_task(struct work_struct *work)
 			/* 8000ES2LAN requires a Rx packet buffer work-around
 			 * on link down event; reset the controller to flush
 			 * the Rx packet buffer.
+			 *
+			 * If the link is lost the controller stops DMA, but
+			 * if there is queued Tx work it cannot be done.  So
+			 * reset the controller to flush the Tx packet buffers.
 			 */
-			if (adapter->flags & FLAG_RX_NEEDS_RESTART)
+			if ((adapter->flags & FLAG_RX_NEEDS_RESTART) ||
+			    e1000_desc_unused(tx_ring) + 1 < tx_ring->count)
 				adapter->flags |= FLAG_RESTART_NOW;
 			else
 				pm_schedule_suspend(netdev->dev.parent,
@@ -5333,14 +5338,6 @@ static void e1000_watchdog_task(struct work_struct *work)
 	adapter->gotc_old = adapter->stats.gotc;
 	spin_unlock(&adapter->stats64_lock);
 
-	/* If the link is lost the controller stops DMA, but
-	 * if there is queued Tx work it cannot be done.  So
-	 * reset the controller to flush the Tx packet buffers.
-	 */
-	if (!netif_carrier_ok(netdev) &&
-	    (e1000_desc_unused(tx_ring) + 1 < tx_ring->count))
-		adapter->flags |= FLAG_RESTART_NOW;
-
 	/* If reset is necessary, do it outside of interrupt context. */
 	if (adapter->flags & FLAG_RESTART_NOW) {
 		schedule_work(&adapter->reset_task);

