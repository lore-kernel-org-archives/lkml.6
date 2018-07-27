Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A96C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE9320894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE9320894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbeG0LXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:23:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34238 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbeG0LXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:23:03 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 42075BB6;
        Fri, 27 Jul 2018 10:01:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Ball <ball@umich.edu>,
        Jarod Wilson <jarod@redhat.com>,
        Mahesh Bandewar <maheshb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 08/48] bonding: set default miimon value for non-arp modes if not set
Date:   Fri, 27 Jul 2018 11:59:53 +0200
Message-Id: <20180727095919.370874429@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727095918.503549522@linuxfoundation.org>
References: <20180727095918.503549522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jarod Wilson <jarod@redhat.com>

[ Upstream commit c1f897ce186a529a494441642125479d38727a3d ]

For some time now, if you load the bonding driver and configure bond
parameters via sysfs using minimal config options, such as specifying
nothing but the mode, relying on defaults for everything else, modes
that cannot use arp monitoring (802.3ad, balance-tlb, balance-alb) all
wind up with both arp_interval=0 (as it should be) and miimon=0, which
means the miimon monitor thread never actually runs. This is particularly
problematic for 802.3ad.

For example, from an LNST recipe I've set up:

$ modprobe bonding max_bonds=0"
$ echo "+t_bond0" > /sys/class/net/bonding_masters"
$ ip link set t_bond0 down"
$ echo "802.3ad" > /sys/class/net/t_bond0/bonding/mode"
$ ip link set ens1f1 down"
$ echo "+ens1f1" > /sys/class/net/t_bond0/bonding/slaves"
$ ip link set ens1f0 down"
$ echo "+ens1f0" > /sys/class/net/t_bond0/bonding/slaves"
$ ethtool -i t_bond0"
$ ip link set ens1f1 up"
$ ip link set ens1f0 up"
$ ip link set t_bond0 up"
$ ip addr add 192.168.9.1/24 dev t_bond0"
$ ip addr add 2002::1/64 dev t_bond0"

This bond comes up okay, but things look slightly suspect in
/proc/net/bonding/t_bond0 output:

$ grep -i mii /proc/net/bonding/t_bond0
MII Status: up
MII Polling Interval (ms): 0
MII Status: up
MII Status: up

Now, pull a cable on one of the ports in the bond, then reconnect it, and
you'll see:

Slave Interface: ens1f0
MII Status: down
Speed: 1000 Mbps
Duplex: full

I believe this became a major issue as of commit 4d2c0cda0744, which for
802.3ad bonds, sets slave->link = BOND_LINK_DOWN, with a comment about
relying on link monitoring via miimon to set it correctly, but since the
miimon work queue never runs, the link just stays marked down.

If we simply tweak bond_option_mode_set() slightly, we can check for the
non-arp modes having no miimon value set, and insert BOND_DEFAULT_MIIMON,
which gets things back in full working order. This problem exists as far
back as 4.14, and might be worth fixing in all stable trees since, though
the work-around is to simply specify an miimon value yourself.

Reported-by: Bob Ball <ball@umich.edu>
Signed-off-by: Jarod Wilson <jarod@redhat.com>
Acked-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_options.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -743,15 +743,20 @@ const struct bond_option *bond_opt_get(u
 static int bond_option_mode_set(struct bonding *bond,
 				const struct bond_opt_value *newval)
 {
-	if (!bond_mode_uses_arp(newval->value) && bond->params.arp_interval) {
-		netdev_dbg(bond->dev, "%s mode is incompatible with arp monitoring, start mii monitoring\n",
-			   newval->string);
-		/* disable arp monitoring */
-		bond->params.arp_interval = 0;
-		/* set miimon to default value */
-		bond->params.miimon = BOND_DEFAULT_MIIMON;
-		netdev_dbg(bond->dev, "Setting MII monitoring interval to %d\n",
-			   bond->params.miimon);
+	if (!bond_mode_uses_arp(newval->value)) {
+		if (bond->params.arp_interval) {
+			netdev_dbg(bond->dev, "%s mode is incompatible with arp monitoring, start mii monitoring\n",
+				   newval->string);
+			/* disable arp monitoring */
+			bond->params.arp_interval = 0;
+		}
+
+		if (!bond->params.miimon) {
+			/* set miimon to default value */
+			bond->params.miimon = BOND_DEFAULT_MIIMON;
+			netdev_dbg(bond->dev, "Setting MII monitoring interval to %d\n",
+				   bond->params.miimon);
+		}
 	}
 
 	if (newval->value == BOND_MODE_ALB)


