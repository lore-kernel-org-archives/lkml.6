Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46899C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF14B214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MpHEcJTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF14B214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJJRkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:40:25 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:46292 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeJJRkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WdzpGAe1GfXOVXBpxadD7R70TRb1Ea3ietdzXlqfnck=; b=MpHEcJTUO9f1S9DhclxWQ/vhJ
        i8wktpHPal4rD/NbEmIBbKWBdbEf8dQizLrvEFkt6rk9rqYQaLYo6h9GFQAkZ9I6HM14CmKqebrMf
        5PuqhN9Lv+F6nRKJMgAXXyXmdnarPp/NiXbKRhgJuPWPqn/7fY3IPqk1bet8uFGUFoZ7A=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:39988)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gABZk-00068F-M6; Wed, 10 Oct 2018 11:18:44 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gABZi-0000XQ-0i; Wed, 10 Oct 2018 11:18:42 +0100
Date:   Wed, 10 Oct 2018 11:18:40 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        b.zolnierkie@samsung.com, linux-kernel@vger.kernel.org,
        Lukasz Luba <l.luba@partner.samsung.com>, mingo@redhat.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Doc: lockdep: add information about performance impact
Message-ID: <20181010101840.GM30658@n2100.armlinux.org.uk>
References: <CGME20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056@eucas1p2.samsung.com>
 <20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056~b_ujkjRd31303013030eucas1p2C@eucas1p2.samsung.com>
 <20181009154359.GB5728@hirez.programming.kicks-ass.net>
 <20181009155818.GD9259@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009155818.GD9259@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 04:58:18PM +0100, Will Deacon wrote:
> On Tue, Oct 09, 2018 at 05:43:59PM +0200, Peter Zijlstra wrote:
> > On Tue, Oct 09, 2018 at 05:39:27PM +0200, Lukasz Luba wrote:
> > > This patch add some warning related to performance drop.
> > > It should be mentioned that this is not for free
> > > and the platfrom resources (cache, bus interconnect, etc.)
> > > will be used more frequently.
> > 
> > To me this reads a bit like: water is wet.
> > 
> > Is this really needed?
> 
> I don't think so -- this is a debug option under "kernel hacking". Surely
> the perf hit comes with the territory.

Indeed it does - since adding debug code means additional instructions,
more cache pressure and, therefore, slower execution.

I've already said to people... turn on all debug options for development,
and when you move to performance evaluation and optimisation for the
production version, evaluate and turn off debug options.

Unfortunately, turning off PROVE_LOCKING in the defconfigs is going
to have a negative impact on the automated build/boot testing that
systems like kernelci.org do for us - these are primarily based
around the defconfigs, which means we're going to end up building
with PROVE_LOCKING disabled.  This means kernelci.org will be less
likely to catch locking issues.

Forcing PROVE_LOCKING on also doesn't make sense - there may be (rare)
bugs, eg race conditions, uncovered by having that disabled.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
