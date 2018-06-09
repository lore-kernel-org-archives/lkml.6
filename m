Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GjvkJtoOHFsDQQAAmS7hNA
	; Sat, 09 Jun 2018 17:31:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8CA4E608C1; Sat,  9 Jun 2018 17:31:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CFA13601D2;
	Sat,  9 Jun 2018 17:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CFA13601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=netousek.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeFIRbD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 13:31:03 -0400
Received: from bb9b.bb9.wien.funkfeuer.at ([78.41.112.192]:50600 "EHLO
        mail.eMediaMonitor.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753268AbeFIRbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 13:31:02 -0400
X-Greylist: delayed 923 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Jun 2018 13:31:02 EDT
Received: by mail.eMediaMonitor.net (8.14.9/8.14.9) with ESMTP id w59HFbJb020180; Sat, 9 Jun 2018 17:15:37 GMT
From: Thomas Netousek <thomas@netousek.com>
Subject: [BUG] igb: reconnecting of cable not always detected
To: linux-kernel@vger.kernel.org
Message-ID: <6521c024-457e-cc77-0335-c0300269fc4f@netousek.com>
Date: Sat, 9 Jun 2018 19:15:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a similar problem.
If I disconnect and reconnect the ethernet cable on a Intel Ethernet
card then the device does not come up again.

For me this problem happens on the first pull of the LAN cable all the time.

It is reproducible on Supermicro X8, X9 and X10 dual CPU mainboards with
onboard networking providing two PHY interfaces using Intel 82576 and
I350 chips.
It is not reproducible on a Supermicro X10SLL single mainboard with
onboard I210 chip providing one PHY for eth0 (tested) and one
I217-LM powered by the e1000e driver (not connected, not tested).

It is reproducible using kernel 4.9.107 and 4.17.0.
It is not reproducible using  kernels 4.1.48, 4.4.136.
So it might be related to the changes in the igb versions from 5.3.0-k
(good) to 5.4.0-k (bad).

After pulling and re-plugging the cable, with the bad driver I get:

# ip -d link show eth0
2: eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state
DOWN mode DEFAULT group default qlen 1000
    link/ether 0c:c4:7a:69:9d:3e brd ff:ff:ff:ff:ff:ff promiscuity 0
numtxqueues 8 numrxqueues 8 gso_max_size 65536 gso_max_segs 65535

# ethtool -i eth0    
Cannot get driver information: No such device

The last lines in the dmesg output are:

[   13.127730] igb 0000:01:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps
Full Duplex, Flow Control: RX/TX
[   13.747735] igb 0000:01:00.1 eth1: igb: eth1 NIC Link is Up 1000 Mbps
Full Duplex, Flow Control: RX/TX
[  147.760943] igb 0000:01:00.0 eth0: igb: eth0 NIC Link is Down
[  608.211864] igb 0000:01:00.0 eth0: PCIe link lost, device now detached

Please note that the "PCIe link lost" message arrives 8 minutes after
re-plugging the LAN cable.

I hope that information helps pinning down this bug and fixing it.

Kind regards
Thomas
