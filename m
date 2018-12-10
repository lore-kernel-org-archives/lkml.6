Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8ABC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD382081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD382081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbeLJVwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:52:33 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34514 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJVwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:52:33 -0500
Received: from p4fea4820.dip0.t-ipconnect.de ([79.234.72.32] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gWTTU-00059B-Kw; Mon, 10 Dec 2018 22:52:24 +0100
Date:   Mon, 10 Dec 2018 22:52:24 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Xen-devel List <xen-devel@lists.xen.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Beulich <JBeulich@suse.com>,
        Brian Woods <brian.woods@amd.com>,
        SuraveeSuthikulpanit <suravee.suthikulpanit@amd.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijeshkumar.singh@amd.com>
Subject: Re: AMD EPYC Topology problems
In-Reply-To: <20181209125648.GA15262@zn.tnic>
Message-ID: <alpine.DEB.2.21.1812102245360.1667@nanos.tec.linutronix.de>
References: <7369db0c-4917-0807-eef4-cba5e5ae0d4e@citrix.com> <20181203111359.GA31670@zn.tnic> <9e392fcd-4829-afe4-6f36-73d5cf03ee7c@citrix.com> <20181209125648.GA15262@zn.tnic>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2018, Borislav Petkov wrote:

> On Mon, Dec 03, 2018 at 11:23:49AM +0000, Andrew Cooper wrote:
> > Right, but the documentation also states that where it says package, it
> > means "Node" in AMD's terminology, and the information in CPUID is per
> > socket, not per node.
> > 
> > My point is that the numbers ending up in cpuinfo_x86 don't match the
> > semantics described by the documentation.
> 
> Ok, I think I know where the issue stems from:
> 
> 	definition of "package" in the AMD docs != definition of "package" in Documentation/x86/topology.txt
> 
> AMD's is "Processor: A package containing one or more Nodes." whereas
> ours is:
> 
>   "Packages contain a number of cores plus shared resources, e.g. DRAM
>    controller, shared caches etc."
> 
> and physical sockets we don't care about because they're not relevant to
> sw.

Right. Physical sockets are not interesting at all.

> Yeah, lemme discuss this with tglx to refresh what we were thinking then. :)

What Intel calls package is called Node on AMD. Yes, it's a mess, but we
can't do much about it and as lots of existing code already used 'package'
for both Intel and AMD, there was no point to invent yet another name for
it. Maybe we should have...

Thanks,

	tglx
