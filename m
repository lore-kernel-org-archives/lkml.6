Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E732C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91562177A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91562177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeHVBgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:36:47 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:49352 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeHVBgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:36:47 -0400
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 07646D3D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 22:14:47 +0000 (UTC)
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 573E5B1;
        Tue, 21 Aug 2018 22:14:46 +0000 (UTC)
Received: from linux-tqvx.americas.hpqcorp.net (linux-tqvx.americas.hpqcorp.net [10.34.51.15])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id C591637;
        Tue, 21 Aug 2018 22:14:45 +0000 (UTC)
Date:   Tue, 21 Aug 2018 17:14:43 -0500
From:   Andrew Banman <abanman@hpe.com>
To:     Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     abanman@hpe.com, justin.ernst@hpe.com, rja@hpe.com,
        frank.ramsay@hpe.com, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [RFC] IPMI state machine regression
Message-ID: <20180821221443.hhgcnzw6xttaih3i@linux-tqvx.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear IPMI supporters,

We observe a window in IPMI BT's opportunistic get capabilities request,
wherein GET_DEVICE_GUID and GET_DEVICE_ID requests may start while the BT state
machine is in WR_CONSUME. Following this, the 0xD5 error code is forced in
bt_start_transaction, IPMI fails to initialize, and the interface is torn down.
There is no mechanism to retry bringing up the interface in open() /dev/ipmi.
This leaves IPMI hosed until you reload modules. Looks to happen after we call
schedule().

The problem is intermittent, but we observe ~50% fail rate on 4.18
kernels on our UV4 systems.

Here's the relevant snippet (the action starts at 120.367379):

[  118.316764] IPMI System Interface driver.
[  118.354246] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
[  118.354249] ipmi_si: SMBIOS: mem 0xce4 regsize 1 spacing 1 irq 6
[  118.354251] ipmi_si: Adding SMBIOS-specified bt state machine
[  118.354311] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
[  118.381164] ipmi_si IPI0001:00: [io  0x0ce4-0x0ce6] regsize 1 spacing 1 irq 6
[  118.381167] ipmi_si: Adding ACPI-specified bt state machine
[  118.382811] ipmi_si: Trying SMBIOS-specified bt state machine at mem address 0xce4, slave address 0x20, irq 6
[  118.382815] ipmi_si dmi-ipmi-si.0: Could not set up I/O space
[  118.382816] ipmi_si: Trying ACPI-specified bt state machine at i/o address 0xce4, slave address 0x0, irq 6
[  118.382911] IPMI BT: flag reset [ ]
[  118.383008] BT: XACTION [ ] TO=5000000 - 0
[  118.383059] BT: WR_BYTES [ ] TO=5000000 - 0
[  118.383272] BT: WR_CONSUME [ H2B ] TO=5000000 - 0
[  118.388034] BT: WR_CONSUME [ ] TO=5000000 - 4000
[  118.388059] BT: RD_WAIT [ ] TO=4996000 - 0
[  118.396017] BT: RD_WAIT [ ] TO=4996000 - 4000
[  118.492015] BT: RD_WAIT [ ] TO=4992000 - 4000
[  118.520073] BT: RD_WAIT [ ] TO=4988000 - 4000
[  118.528079] BT: RD_WAIT [ ] TO=4984000 - 4000
[  118.540049] BT: RD_WAIT [ ] TO=4980000 - 4000
[  118.548011] BT: RD_WAIT [ ] TO=4976000 - 4000
[  118.564033] BT: RD_WAIT [ ] TO=4972000 - 4000
[  118.572109] BT: RD_WAIT [ ] TO=4968000 - 4000
[  118.580013] BT: RD_WAIT [ ] TO=4964000 - 4000
[  118.588017] BT: RD_WAIT [ ] TO=4960000 - 4000
[  118.608014] BT: RD_WAIT [ ] TO=4956000 - 4000
[  118.628058] BT: RD_WAIT [ ] TO=4952000 - 4000
[  118.636053] BT: RD_WAIT [ ] TO=4948000 - 4000
[  118.648016] BT: RD_WAIT [ ] TO=4944000 - 4000
[  118.672028] BT: RD_WAIT [ ] TO=4940000 - 4000
[  118.684056] BT: RD_WAIT [ ] TO=4936000 - 4000
[  118.696021] BT: RD_WAIT [ ] TO=4932000 - 4000
[  118.708015] BT: RD_WAIT [ ] TO=4928000 - 4000
[  118.720018] BT: RD_WAIT [ ] TO=4924000 - 4000
[  118.732063] BT: RD_WAIT [ ] TO=4920000 - 4000
[  118.744021] BT: RD_WAIT [ ] TO=4916000 - 4000
[  118.752089] BT: RD_WAIT [ ] TO=4912000 - 4000
[  118.764011] BT: RD_WAIT [ ] TO=4908000 - 4000
[  118.784009] BT: RD_WAIT [ ] TO=4904000 - 4000
[  118.808011] BT: RD_WAIT [ ] TO=4900000 - 4000
[  118.832010] BT: RD_WAIT [ ] TO=4896000 - 4000
[  118.844011] BT: RD_WAIT [ ] TO=4892000 - 4000
[  118.860036] BT: RD_WAIT [ ] TO=4888000 - 4000
[  118.868102] BT: RD_WAIT [ ] TO=4884000 - 4000
[  118.876012] BT: RD_WAIT [ ] TO=4880000 - 4000
[  118.904011] BT: RD_WAIT [ ] TO=4876000 - 4000
[  118.924013] BT: RD_WAIT [ ] TO=4872000 - 4000
[  118.948016] BT: RD_WAIT [ ] TO=4868000 - 4000
[  118.984043] BT: RD_WAIT [ ] TO=4864000 - 4000
[  118.992059] BT: RD_WAIT [ ] TO=4860000 - 4000
[  118.995422]  for 2000000
[  118.995650]
[  119.000026] BT: RD_WAIT [ ] TO=4856000 - 4000
[  119.012018] BT: RD_WAIT [ ] TO=4852000 - 4000
[  119.032010] BT: RD_WAIT [ ] TO=4848000 - 4000
[  119.048013] BT: RD_WAIT [ ] TO=4844000 - 4000
[  119.060013] BT: RD_WAIT [ ] TO=4840000 - 4000
[  119.080014] BT: RD_WAIT [ ] TO=4836000 - 4000
[  119.096021] BT: RD_WAIT [ ] TO=4832000 - 4000
[  119.120009] BT: RD_WAIT [ ] TO=4828000 - 4000
[  119.128017] BT: RD_WAIT [ ] TO=4824000 - 4000
[  119.136011] BT: RD_WAIT [ ] TO=4820000 - 4000
[  119.144013] BT: RD_WAIT [ ] TO=4816000 - 4000
[  119.164008] BT: RD_WAIT [ ] TO=4812000 - 4000
[  119.184010] BT: RD_WAIT [ ] TO=4808000 - 4000
[  119.204015] BT: RD_WAIT [ ] TO=4804000 - 4000
[  119.264034] BT: RD_WAIT [ ] TO=4800000 - 4000
[  119.272013] BT: RD_WAIT [ ] TO=4796000 - 4000
[  119.288013] BT: RD_WAIT [ ] TO=4792000 - 4000
[  119.308011] BT: RD_WAIT [ ] TO=4788000 - 4000
[  119.324011] BT: RD_WAIT [ ] TO=4784000 - 4000
[  119.344010] BT: RD_WAIT [ ] TO=4780000 - 4000
[  119.364027] BT: RD_WAIT [ ] TO=4776000 - 4000
[  119.376011] BT: RD_WAIT [ ] TO=4772000 - 4000
[  119.396010] BT: RD_WAIT [ ] TO=4768000 - 4000
[  119.408013] BT: RD_WAIT [ ] TO=4764000 - 4000
[  119.424012] BT: RD_WAIT [ B2H ] TO=4760000 - 4000
[  119.434845] BT: CLEAR_B2H [ H_BUSY ] TO=4756000 - 0
[  119.592204] BT: RD_BYTES [ H_BUSY ] TO=4756000 - 0
[  119.650481] BT: XACTION [ ] TO=5000000 - 0
[  119.676062] BT: WR_BYTES [ ] TO=5000000 - 0
[  119.734596] BT: WR_CONSUME [ H2B ] TO=5000000 - 0
[  119.740019] BT: WR_CONSUME [ ] TO=5000000 - 4000
[  119.740036] BT: RD_WAIT [ ] TO=4996000 - 0
[  119.748032] BT: RD_WAIT [ B2H ] TO=4996000 - 4000
[  119.748101] BT: CLEAR_B2H [ H_BUSY ] TO=4992000 - 0
[  119.748124] BT: RD_BYTES [ H_BUSY ] TO=4992000 - 0
[  119.748348] BT: XACTION [ ] TO=5000000 - 0
[  119.748382] BT: WR_BYTES [ ] TO=5000000 - 0
[  119.748537] BT: WR_CONSUME [ H2B ] TO=5000000 - 0
[  119.760013] BT: WR_CONSUME [ B2H ] TO=5000000 - 4000
[  119.806271] BT: RD_WAIT [ B2H ] TO=4996000 - 0
[  119.806282] BT: CLEAR_B2H [ H_BUSY ] TO=4996000 - 0
[  119.816909] BT: RD_BYTES [ H_BUSY ] TO=4996000 - 0
[  119.816944] BT: XACTION [ ] TO=5000000 - 0
[  119.827061] BT: WR_BYTES [ ] TO=5000000 - 0
[  119.827088] BT: WR_CONSUME [ H2B ] TO=5000000 - 0
[  119.852024] BT: WR_CONSUME [ B2H ] TO=5000000 - 4000
[  119.875752] BT: RD_WAIT [ B2H ] TO=4996000 - 0
[  119.895099] BT: CLEAR_B2H [ H_BUSY ] TO=4996000 - 0
[  119.991768] BT: RD_BYTES [ H_BUSY ] TO=4996000 - 0
[  119.991805] BT: XACTION [ ] TO=5000000 - 0
[  120.004993] BT: WR_BYTES [ ] TO=5000000 - 0
[  120.027171] BT: WR_CONSUME [ H2B ] TO=5000000 - 0
[  120.048024] BT: WR_CONSUME [ ] TO=5000000 - 4000
[  120.072949] BT: RD_WAIT [ B2H ] TO=4996000 - 0
[  120.085892] BT: CLEAR_B2H [ H_BUSY ] TO=4996000 - 0
[  120.097374] BT: RD_BYTES [ H_BUSY ] TO=4996000 - 0
[  120.097406] BT: XACTION [ ] TO=5000000 - 0
[  120.125568] BT: WR_BYTES [ ] TO=5000000 - 0
[  120.141827] BT: WR_CONSUME [ H2B ] TO=5000000 - 0
[  120.264026] BT: WR_CONSUME [ B2H ] TO=5000000 - 4000
[  120.287267] BT: RD_WAIT [ B2H ] TO=4996000 - 0
[  120.287276] BT: CLEAR_B2H [ H_BUSY ] TO=4996000 - 0
[  120.287280] BT: RD_BYTES [ H_BUSY ] TO=4996000 - 0
[  120.287429] ipmi_si IPI0001:00: Using irq 6
[  120.287447] **Interrupt: 1534434704.287445059
[  120.287457] BT: XACTION [ ] TO=5000000 - 0
[  120.287466] BT: WR_BYTES [ ] TO=5000000 - 0
[  120.287500] BT: WR_CONSUME [ H2B ] TO=5000000 - 0
[  120.297445] **Interrupt: 1534434704.297445691
[  120.332534] BT: WR_CONSUME [ B2H ] TO=5000000 - 0
[  120.332538] BT: RD_WAIT [ B2H ] TO=5000000 - 0
[  120.342956] BT: CLEAR_B2H [ H_BUSY ] TO=5000000 - 0
[  120.342969] BT: RD_BYTES [ H_BUSY ] TO=5000000 - 0
[  120.343244] **Done: 1534434704.343244675
[  120.367379] BT: IDLE [ ] TO=5000000 - 0
[  120.367384] BT: CAP_BEGIN [ ] TO=5000000 - 0
[  120.376634] **Timer: 1534434704.376633453
[  120.376646] BT: XACTION [ ] TO=5000000 - 92000
[  120.376683] BT: WR_BYTES [ ] TO=4908000 - 0
[  120.376995] BT: WR_CONSUME [ H2B ] TO=4908000 - 0
[  120.377025] Send:  18 08
[  120.377027] **Enqueue: 1534434704.377028726
[  120.377028] **Start2: 1534434704.377029859
[  120.377061] BT: WR_CONSUME [ ] TO=4908000 - 0
[  120.377137] BT: RD_WAIT [ ] TO=4908000 - 0
[  120.377140] Recv::  1c 08 d5
[  120.377156] Send:  18 01
[  120.377161] **Enqueue: 1534434704.377161047
[  120.377164] **Start2: 1534434704.377164751
[  120.377226] BT: RD_WAIT [ ] TO=4908000 - 0
[  120.377237] Recv::  1c 01 d5
[  120.377242] ipmi_si IPI0001:00: IPMI message handler: device id demangle failed: -22
[  120.377252] ipmi_si IPI0001:00: Unable to get the device id: -5
[  120.377252] ipmi_si IPI0001:00: Unable to register device: error -5
[  120.569865] IPMI SSIF Interface driver

Also FYI,

Bad cleanup code causes a null pointer and adds a race condition; this
is addressed by "[PATCH] Remove redundant cleanup in ipmi_register_smi"
from Justin Ernst <justin.ernst@hpe.com>, which I paste here:

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 51832b8a2c62..3b0b50c4f064 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -3395,12 +3395,12 @@ int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
 
  out:
 	if (rv) {
-		ipmi_bmc_unregister(intf);
-		list_del_rcu(&intf->link);
+		/*
+		 * ipmi_unregister_smi must be called to clean up after
+		 * failure. We unlock the mutex to allow ipmi_unregister_smi
+		 * to lock it and perform cleanup.
+		 */
 		mutex_unlock(&ipmi_interfaces_mutex);
-		synchronize_srcu(&ipmi_interfaces_srcu);
-		cleanup_srcu_struct(&intf->users_srcu);
-		kref_put(&intf->refcount, intf_free);
 	} else {
 		/*
 		 * Keep memory order straight for RCU readers.  Make
--
