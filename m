Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7BDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DB120989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DB120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeLEWZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:25:33 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:58947 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeLEWZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:25:33 -0500
X-Greylist: delayed 86471 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Dec 2018 17:25:32 EST
X-Originating-IP: 134.134.139.75
Received: from localhost (jfdmzpr06-ext.jf.intel.com [134.134.139.75])
        (Authenticated sender: josh@joshtriplett.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 7327220003;
        Wed,  5 Dec 2018 22:25:26 +0000 (UTC)
Date:   Wed, 5 Dec 2018 14:25:24 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:core/rcu] rcutorture: Make initrd/init execute in userspace
Message-ID: <20181205222523.GA14609@localhost>
References: <tip-229ab0cb5be3bfbac5947df7240f6905470ca413@git.kernel.org>
 <20181204222412.GA6874@localhost>
 <20181204230423.GP4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204230423.GP4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 03:04:23PM -0800, Paul E. McKenney wrote:
> On Tue, Dec 04, 2018 at 02:24:13PM -0800, Josh Triplett wrote:
> > On Tue, Dec 04, 2018 at 02:09:42PM -0800, tip-bot for Paul E. McKenney wrote:
> > > --- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> > > +++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> > > @@ -39,9 +39,22 @@ mkdir $T
> > >  
> > >  cat > $T/init << '__EOF___'
> > >  #!/bin/sh
> > > +# Run in userspace a few milliseconds every second.  This helps to
> > > +# exercise the NO_HZ_FULL portions of RCU.
> > >  while :
> > >  do
> > > -	sleep 1000000
> > > +	q=
> > > +	for i in \
> > > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> > > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> > > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> > > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> > > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> > > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a
> > 
> > Ow. If there's no better way to do this, please do at least comment how many 'a's
> > this is. (And why 186, exactly?)
> 
> Yeah, that is admittedly a bit strange.  The reason for 186 occurrences of
> "a" to one-time calibration, measuring a few millisecond's worth of delay.
> 
> > Please also consider calibrating the delay loop as you do in the C code.
> 
> Good point.  And a quick web search finds me "date '+%s%N'", which gives
> me nanoseconds since the epoch.  I probably don't want to do a 2038 to
> myself (after all, I might still be alive then), so I should probably try
> to make something work with "date '+%N'".  Or use something like this:
> 
> 	$ date '+%4N'; date '+%4N';date '+%4N'; date '+%4N'
> 	6660
> 	6685
> 	6697
> 	6710
> 
> Ah, but that means I need to add the "date" command to my initrd, doesn't
> it?  And calculation requires either bash or the "test" command.  And it
> would be quite good to restrict this to what can be done with Bourne shell
> built-in commands, since a big point of this is to maintain a small-sized
> initrd.  :-/

Sure, and I'm not suggesting adding commands to the initrd, hence my
mention of "If there's no better way".

> So how about the following patch, which attempts to explain the situation?

That would help, but please also consider consolidating with something
like a10="a a a a a a a a a a" to make it more readable (and perhaps
rounding up to 200 for simplicity).

- Josh
