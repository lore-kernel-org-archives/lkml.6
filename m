Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932372AbeBVM6a (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:58:30 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:39584 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753719AbeBVM63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:58:29 -0500
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "Vineet Gupta" <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 1/3] ARC: mcip: halt GFRC together with ARC cores
Thread-Topic: [PATCH 1/3] ARC: mcip: halt GFRC together with ARC cores
Thread-Index: AQHTqvgMORbrZZk760yisL1Avwo/taOvP0EAgAA1WACAAN5YAA==
Date: Thu, 22 Feb 2018 12:58:25 +0000
Message-ID: <1519304304.2982.21.camel@synopsys.com>
References: <20180221094027.12674-1-Eugeniy.Paltsev@synopsys.com>
         <a4a20519-e8b0-3522-0528-6de2595635ed@synopsys.com>
         <8c86b9f9-a4b7-1217-7cf3-1d8891292679@synopsys.com>
In-Reply-To: <8c86b9f9-a4b7-1217-7cf3-1d8891292679@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.43]
Content-Type: text/plain; charset="utf-8"
Content-ID: <368A055D7FF0F042B653A64601EEC3CB@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1MCwa1a017574

Hi Vineet,

On Wed, 2018-02-21 at 15:42 -0800, Vineet Gupta wrote:
> On 02/21/2018 12:31 PM, Vineet Gupta wrote:
> > Hi Eugeniy,
> > 
> > > Starting from ARC HS v3.0
> > 
> >  From the STAR fix, it seem this was fixed in HS 2.1c, so you should be able to 
> > test it on HSDK, which was my next question: where and how did you test this and 
> > verify that it works as we think it does. I tried the patch on HSDK and I still 
> > see the rcu_preempt self-detected stall error splat when running hackbench and 
> > pausing the target with Metaware debugger. Perhaps we need to write a small test 
> > case to check what's going on. Also try that on AXS103 release which is definitely 
> > HS 3.0 !
> 
> So I tried this on both.
>   - HSDK   (HS 2.1c): Doesn't work
>   - AXS103 (HS 3.0) : Works

I checked the HS_3.00a and HS_2.1c documentation - GFRC HALT commands/settings exist
only in HS_3.00a.

> 
> Fortunately we can read (yet another BCR: GFRC_BUILD) and infer whether this is 
> supported or not. So add that check in mcip_update_gfrc_halt_mask()

Ok, I'll add GFRC_BUILD read.

> > > it's possible to tie GFRC to state of up-to 4
> > > ARC cores with help of GFRC's CORE register where we set a mask for
> > > cores which state we need to rely on.
> 
> On second thoughts, do we really have to do this per cpu. Just write 0xf once just 
> as Alexey did in first iteration.

And we will face with same problems like with MCIP debug.
Remember what happens when we launch kernel on one CPU on board which has several CPUs.

> In theory this could be called concurrently by multiple cpus and mcip doesn't 
> guarantee any internal serialization/buffering. Granted, current use
case is fine 
> as mcip_setup_per_cpu --> plat_smp_ops.init_per_cpu is serialized by master core, 
> we could run into issue when say cpu hot plug etc
works. So better to wrap this 
> inside the spinlock which we already have.

Yep, I was also thinking about adding the spinlock here...
I'll add it in next patch version.

> -Vineet
-- 
 Eugeniy Paltsev
