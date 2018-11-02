Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FB9C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336852081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336852081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeKBVjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:39:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeKBVjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:39:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4C733082129;
        Fri,  2 Nov 2018 12:32:01 +0000 (UTC)
Received: from localhost (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC98D1054FD5;
        Fri,  2 Nov 2018 12:31:59 +0000 (UTC)
Date:   Fri, 2 Nov 2018 13:31:58 +0100
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Christopher Hall <christopher.s.hall@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com,
        Gavin Hindman <gavin.hindman@intel.com>,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: TSC to Mono-raw Drift
Message-ID: <20181102123158.GN19434@localhost>
References: <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de>
 <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com>
 <alpine.DEB.2.21.1810192244150.1651@nanos.tec.linutronix.de>
 <CALAqxLUpKU73kzBh6mxgoCX4nEueuE42REcXw6F6DYYk4Hry6Q@mail.gmail.com>
 <CALAqxLUKOYYm=bzn4owZC_UgWTqrVPiz2TSnLFm1RNak3tm8-g@mail.gmail.com>
 <alpine.DEB.2.21.1811011841060.1642@nanos.tec.linutronix.de>
 <CALAqxLV7SGRx_jKyM_RmzBGmnqAtDRXQLcH4Yjj+HKCY1O9sOQ@mail.gmail.com>
 <alpine.DEB.2.21.1811011859590.1642@nanos.tec.linutronix.de>
 <20181102112006.GM19434@localhost>
 <alpine.DEB.2.21.1811021225010.1895@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811021225010.1895@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 02 Nov 2018 12:32:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 12:25:56PM +0100, Thomas Gleixner wrote:
> On Fri, 2 Nov 2018, Miroslav Lichvar wrote:
> > clocksource -> MONOTONIC_RAW -> MONOTONIC/REALTIME
> > 
> > or 
> > 
> > clocksource -> ? -> MONOTONIC_RAW
> >                  -> MONOTONIC/REALTIME
> 
> That's what we have now. At least I don't see how the raw thing is coupled
> in NTP.

Oh, right.

So, for the first approach when the raw clock is stepped, the same
step needs to be applied to the mono clock. That means the mono clock
will have two large independent corrections applied to it, which will
make it less stable, e.g. steps of up to 8 ns at 100 Hz instead of 4
ns. Otherwise they would drift from each other when not synchronized
by NTP/PTP.

In the second approach, the corrections of the two clocks are
independent, but the NTP tick length needs to be adjusted before the
multiplier is calculated to match the frequency of the raw clock. If
the correction was applied later, I suspect it would require a +2 mult
adjustment or larger steps as in the first approach.

That tick adjustment generally won't be perfectly accurate, so an
extra small correction would be needed to keep the clocks in sync over
long intervals. This could be a +1 adjustment of the NTP tick length,
or it could be a small forward step. I'm not sure what would be easier
to implement.

Does that make sense?

-- 
Miroslav Lichvar
