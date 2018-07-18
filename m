Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B2DECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366592075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366592075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbeGRT3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:29:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728038AbeGRT3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:29:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4CFA1401CC41;
        Wed, 18 Jul 2018 18:49:52 +0000 (UTC)
Received: from hp-dl360pgen8-07.khw.lab.eng.bos.redhat.com (hp-dl360pgen8-07.khw.lab.eng.bos.redhat.com [10.16.184.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B51B52026D69;
        Wed, 18 Jul 2018 18:49:51 +0000 (UTC)
From:   Jarod Wilson <jarod@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarod Wilson <jarod@redhat.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Mahesh Bandewar <maheshb@google.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH net] bonding: set default miimon value for non-arp modes if not set
Date:   Wed, 18 Jul 2018 14:49:36 -0400
Message-Id: <20180718184936.16037-1-jarod@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 18 Jul 2018 18:49:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 18 Jul 2018 18:49:52 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jarod@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
CC: Jay Vosburgh <j.vosburgh@gmail.com>
CC: Veaceslav Falico <vfalico@gmail.com>
CC: Andy Gospodarek <andy@greyhouse.net>
CC: Mahesh Bandewar <maheshb@google.com>
CC: David S. Miller <davem@davemloft.net>
CC: netdev@vger.kernel.org
CC: stable@vger.kernel.org
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 drivers/net/bonding/bond_options.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 98663c50ded0..4d5d01cb8141 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -743,15 +743,20 @@ const struct bond_option *bond_opt_get(unsigned int option)
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
-- 
2.16.1

