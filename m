Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD4EC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB8C2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfAYJzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:55:12 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42758 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfAYJzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:55:11 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5258220714; Fri, 25 Jan 2019 10:55:09 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id F31AD20714;
        Fri, 25 Jan 2019 10:55:08 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH net-next v2 0/2] mv88e6xxx DSA suspend to RAM support
Date:   Fri, 25 Jan 2019 10:55:05 +0100
Message-Id: <20190125095507.29334-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a first attempt of bringing S2RAM support to the DSA switch, it
has been reported that a part of the configuration was lost during the
cycle. This second version adds a first patch that saves the rules in
a per-chip list when they are applied, so that in the second patch we
bring S2RAM support by also re-applying these rules.

Bridging is set up on the EspressoBin with the below commands (thanks
to Andrew):

        ip link set eth0 up
        ip link add name br0 type bridge
        ip link set br0 up
        ip link set lan0 up
        ip link set lan0 master br0
        ip link set lan1 up
        ip link set lan1 master br0

Static forwarding entries are added:

        bridge fdb add 00:42:42:42:42:42 dev lan0
        bridge fdb add 00:24:24:24:24:24 dev lan1

Dumping the switch entries gives:

        # bridge fdb show
	33:33:00:00:00:01 dev eth0 self permanent
        01:00:5e:00:00:01 dev eth0 self permanent
        33:33:ff:06:e2:95 dev eth0 self permanent
        dc:0b:34:87:7f:27 dev lan0 br0
        d4:81:d7:4f:a1:0d dev lan0 br0
        f0:ad:4e:06:e2:95 dev lan0 vlan 1 br0 permanent
        f0:ad:4e:06:e2:95 dev lan0 br0 permanent
        00:42:42:42:42:42 dev lan0 self static
        d4:81:d7:4f:a1:0d dev lan0 self
        dc:0b:34:87:7f:27 dev lan0 self
        00:0a:35:00:01:22 dev lan1 br0
        00:0a:35:00:01:22 dev lan1 self
        00:24:24:24:24:24 dev lan1 self static
        33:33:00:00:00:01 dev br0 self permanent
        01:00:5e:00:00:01 dev br0 self permanent
        33:33:ff:00:2a:68 dev br0 self permanent

After a S2RAM cycle, the bridge and the static entries have been restored.


        mv88e6085 d0032004.mdio-mii:01 lan0: configuring for phy/ link mode
        mv88e6085 d0032004.mdio-mii:01 lan1: configuring for phy/ link mode
        mv88e6085 d0032004.mdio-mii:01 lan1: Link is Up - 1Gbps/Full - flow control rx/tx
        mv88e6085 d0032004.mdio-mii:01 lan0: Link is Up - 1Gbps/Full - flow control rx/tx

        # bridge fdb show
        33:33:00:00:00:01 dev eth0 self permanent
        01:00:5e:00:00:01 dev eth0 self permanent
        33:33:ff:06:e2:95 dev eth0 self permanent
        9c:93:4e:26:e4:54 dev lan0 br0
        d4:81:d7:45:de:60 dev lan0 br0
        dc:0b:34:87:7f:27 dev lan0 br0
        d4:81:d7:4f:a1:0d dev lan0 br0
        f0:ad:4e:06:e2:95 dev lan0 vlan 1 br0 permanent
        f0:ad:4e:06:e2:95 dev lan0 br0 permanent
        00:42:42:42:42:42 dev lan0 self static
        d4:81:d7:4f:a1:0d dev lan0 self
        00:0a:35:00:01:22 dev lan1 br0
        00:0a:35:00:01:22 dev lan1 self
        00:24:24:24:24:24 dev lan1 self static
        33:33:00:00:00:01 dev br0 self permanent
        01:00:5e:00:00:01 dev br0 self permanent
        33:33:ff:00:2a:68 dev br0 self permanent

An iperf test running over the whole cycle gives:

         1.00-2.00   sec  81.7 MBytes   685 Mbits/sec
         2.00-3.00   sec  81.8 MBytes   687 Mbits/sec
         3.00-4.00   sec  81.8 MBytes   685 Mbits/sec
         4.00-5.00   sec  81.7 MBytes   686 Mbits/sec
         5.00-6.00   sec  81.5 MBytes   683 Mbits/sec
         6.00-7.00   sec  81.6 MBytes   685 Mbits/sec
         7.00-8.00   sec  81.5 MBytes   684 Mbits/sec
         8.00-9.00   sec  81.7 MBytes   685 Mbits/sec
         9.00-10.00  sec  81.5 MBytes   684 Mbits/sec
        10.00-11.00  sec  81.6 MBytes   684 Mbits/sec
        11.00-12.00  sec  81.5 MBytes   683 Mbits/sec

        macb e000b000.ethernet eth0: link down

	12.00-13.00  sec  19.5 MBytes   164 Mbits/sec
        13.00-14.00  sec  0.00 Bytes  0.00 bits/sec
        14.00-15.00  sec  0.00 Bytes  0.00 bits/sec
        15.00-16.00  sec  0.00 Bytes  0.00 bits/sec
        16.00-17.00  sec  0.00 Bytes  0.00 bits/sec
        17.00-18.00  sec  0.00 Bytes  0.00 bits/sec
        18.00-19.00  sec  0.00 Bytes  0.00 bits/sec
        19.00-20.00  sec  0.00 Bytes  0.00 bits/sec
        20.00-21.00  sec  0.00 Bytes  0.00 bits/sec
        21.00-22.00  sec  0.00 Bytes  0.00 bits/sec
        22.00-23.00  sec  0.00 Bytes  0.00 bits/sec

        macb e000b000.ethernet eth0: link up (1000/Full)

        23.00-24.00  sec  0.00 Bytes  0.00 bits/sec
        24.00-25.00  sec  0.00 Bytes  0.00 bits/sec
        25.00-26.00  sec  18.6 MBytes   156 Mbits/sec
        26.00-27.00  sec  81.5 MBytes   684 Mbits/sec
        27.00-28.00  sec  81.6 MBytes   684 Mbits/sec
        28.00-29.00  sec  81.5 MBytes   684 Mbits/sec
        29.00-30.00  sec  81.5 MBytes   683 Mbits/sec
        30.00-31.00  sec  81.6 MBytes   685 Mbits/sec
        31.00-32.00  sec  81.6 MBytes   684 Mbits/sec
        32.00-33.00  sec  81.4 MBytes   683 Mbits/sec
        33.00-34.00  sec  81.4 MBytes   683 Mbits/sec
        33.00-34.00  sec  81.4 MBytes   683 Mbits/sec

I hope everything has been restored correctly, please let me know if
you spot anything else that is missing.


Thanks,
Miquèl


Miquel Raynal (2):
  net: dsa: mv88e6xxx: Save switch rules
  net: dsa: mv88e6xxx: Add suspend to RAM support

 drivers/net/dsa/mv88e6xxx/chip.c | 359 ++++++++++++++++++++++++++++---
 drivers/net/dsa/mv88e6xxx/chip.h |  33 +++
 2 files changed, 357 insertions(+), 35 deletions(-)

-- 
2.19.1

