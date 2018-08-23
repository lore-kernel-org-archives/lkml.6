Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3C4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC02208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC02208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeHWUXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:23:11 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:29412 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeHWUXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:23:11 -0400
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 5EE398E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:52:35 +0000 (UTC)
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id A3B2466;
        Thu, 23 Aug 2018 16:52:34 +0000 (UTC)
Received: from linux-tqvx.americas.hpqcorp.net (linux-tqvx.americas.hpqcorp.net [10.34.51.15])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 18BCD4C;
        Thu, 23 Aug 2018 16:52:34 +0000 (UTC)
Date:   Thu, 23 Aug 2018 11:52:31 -0500
From:   Andrew Banman <abanman@hpe.com>
To:     minyard@acm.org
Cc:     Andrew Banman <abanman@hpe.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        justin.ernst@hpe.com, rja@hpe.com, frank.ramsay@hpe.com,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] IPMI state machine regression
Message-ID: <20180823165231.2v3oq2nifbudy6ub@linux-tqvx.americas.hpqcorp.net>
References: <20180821221443.hhgcnzw6xttaih3i@linux-tqvx.americas.hpqcorp.net>
 <a72a169e-ce1b-500c-7910-b400c7842033@acm.org>
 <20180822162352.q7qc2udqabbqxdya@linux-tqvx>
 <a3b0e765-24e5-781b-218d-abcb16030e99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3b0e765-24e5-781b-218d-abcb16030e99@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 11:22:58AM -0500, Corey Minyard wrote:
> On 08/22/2018 11:23 AM, Andrew Banman wrote:
> > On Wed, Aug 22, 2018 at 11:14:52AM -0500, Corey Minyard wrote:
> > > On 08/21/2018 05:14 PM, Andrew Banman wrote:
> > > > Dear IPMI supporters,
> > > > 
> > > > We observe a window in IPMI BT's opportunistic get capabilities request,
> > > > wherein GET_DEVICE_GUID and GET_DEVICE_ID requests may start while the BT state
> > > > machine is in WR_CONSUME. Following this, the 0xD5 error code is forced in
> > > > bt_start_transaction, IPMI fails to initialize, and the interface is torn down.
> > > > There is no mechanism to retry bringing up the interface in open() /dev/ipmi.
> > > > This leaves IPMI hosed until you reload modules. Looks to happen after we call
> > > > schedule().
> > > When was the latest kernel where this worked properly?  Also, what hardware
> > > is this?
> > This is UV4.
> > 
> > First known bad commit, but I am not sure if the timing issue predates
> > it:
> > 
> > commit aa9c9ab2443e3b9562c6c7cfc245a9e43b557d14
> > Author: Jeremy Kerr <jk@ozlabs.org>
> > Date:   Fri Aug 25 15:47:24 2017 +0800
> > 
> >      ipmi: allow dynamic BMC version information
> > 
> > Hits less frequently with older kernels so I didn't see it until
> > recently when it became more frequent.
> 
> Ok, that's for the crash, which makes sense.  But that's an easy problem to
> fix.
> I would like a "Tested-by" on that, if you get to test it, though I was able
> to
> simulate various failures there to test it out.

Testing it today. We'll respond to the patch you sent out. Thanks for
fixing that!

> 
> So reading between the lines ("more frequent") I'm guessing that this still
> happened with older kernels, but is becoming annoying with newer kernels.
> I would guess recent changes causes it to happen more often due to changes
> in the way the upper layer interacts with the lower layers, you will have
> more
> messages at startup, and the timing is somewhat different.
> 
> The BT code itself hasn't changed much in over 10 years.  Nothing that
> looks like it would cause an issue like this.  So I would guess this is an
> issue that has been around for a while.

That's what I suspect as well.

> 
> I don't have any real hardware with a BT interface, just the one in qemu,
> but I've never seen it there.
> 
> It actually looks like the state machine is working ok.  But the BMC is
> responding to a "Get Device ID" command with:
> 
>    Recv::  1c 08 d5

That completion code is spoofed in after bt_start_transaction when bt->state
is in WR_CONSUME. This is pretty visible from the message trace, but here
is another with an explicit debug printk (below).

Maybe I'm totally reading this wrong, but I think that err gets passed 
on to the upper layer:

	start_transaction: return 0xD5 -> return_hosed_msg -> deliver_recv_msg
		-> ipmi_smi_msg_received


[  120.367379] BT: IDLE [ ] TO=5000000 - 0
[  120.367384] BT: CAP_BEGIN [ ] TO=5000000 - 0
[  120.376634] **Timer: 1534434704.376633453
[  120.376646] BT: XACTION [ ] TO=5000000 - 92000
[  120.376683] BT: WR_BYTES [ ] TO=4908000 - 0
[  120.376995] BT: WR_CONSUME [ H2B ] TO=4908000 - 0
[  120.377025] Send:  18 08
[  120.377027] **Enqueue: 1534434704.377028726
[  120.377028] **Start2: 1534434704.377029859
# Added DBG # [  120.377028] bt_start_transaction returned IPMI_NOT_IN_MY_STATE_ERR 0xd5
# Added DBG # [  120.377030]  18
# Added DBG # [  120.377030]  08
# Added DBG # [  120.377030]
[  120.377061] BT: WR_CONSUME [ ] TO=4908000 - 0
[  120.377137] BT: RD_WAIT [ ] TO=4908000 - 0
[  120.377140] Recv::  1c 08 d5
[  120.377156] Send:  18 01
[  120.377161] **Enqueue: 1534434704.377161047
[  120.377164] **Start2: 1534434704.377164751
# Added DBG # [  120.377165] bt_start_transaction returned IPMI_NOT_IN_MY_STATE_ERR 0xd5
# Added DBG # [  120.377166]  18
# Added DBG # [  120.377167]  01
# Added DBG # [  120.377168]
[  120.377226] BT: RD_WAIT [ ] TO=4908000 - 0
[  120.377237] Recv::  1c 01 d5
[  120.377242] ipmi_si IPI0001:00: IPMI message handler: device id demangle failed: -22
[  120.377252] ipmi_si IPI0001:00: Unable to get the device id: -5
[  120.377252] ipmi_si IPI0001:00: Unable to register device: error -5


diff --git a/drivers/char/ipmi/ipmi_bt_sm.c b/drivers/char/ipmi/ipmi_bt_sm.c
index d99d744..1be4de9 100644
--- a/drivers/char/ipmi/ipmi_bt_sm.c
+++ b/drivers/char/ipmi/ipmi_bt_sm.c
@@ -24,7 +24,7 @@
  * value
  */

-static int bt_debug = 4; /* 0 == BT_DEBUG_OFF */
+static int bt_debug = 2; /* 0 == BT_DEBUG_OFF */

 module_param(bt_debug, int, 0644);
 MODULE_PARM_DESC(bt_debug, "debug bitmask, 1=enable, 2=messages, 4=states");
@@ -217,8 +217,14 @@ static int bt_start_transaction(struct si_sm_data *bt,
        if (bt->state == BT_STATE_LONG_BUSY)
                return IPMI_NODE_BUSY_ERR;

-   if (bt->state != BT_STATE_IDLE)
+ if (bt->state != BT_STATE_IDLE) {
+         pr_crit("bt->state = %d : bt_start_transaction returned "
+                 "IPMI_NOT_IN_MY_STATE_ERR 0xd5\n", bt->state);
+         for (i = 0; i < size; i ++)
+                 printk(" %02x", data[i]);
+         printk("\n");
                return IPMI_NOT_IN_MY_STATE_ERR;
+ }

        if (bt_debug & BT_DEBUG_MSG) {
                printk(KERN_WARNING "BT: +++++++++++++++++ New command\n");

> 
> 
> That's an error response with D5, which is "Cannot execute command.
> Command, or request parameter(s), not supported in present state."
> That's an error response from your BMC.  That particular command
> shouldn't ever respond with that error, so I think the bug here is
> with your BMC.

My BMC engineers and I cannot reproduce the problem running ipmi commands
direct from the BMC.

> 
> -corey
> 
> 

Thank you,

Andrew
