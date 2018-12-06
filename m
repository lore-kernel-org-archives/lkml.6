Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3D4C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B366214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B366214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbeLFA1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:27:48 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:46445 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeLFA1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:27:48 -0500
X-Originating-IP: 134.134.139.73
Received: from localhost (jfdmzpr04-ext.jf.intel.com [134.134.139.73])
        (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 2807DC0002;
        Thu,  6 Dec 2018 00:27:42 +0000 (UTC)
Date:   Wed, 5 Dec 2018 16:27:38 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:core/rcu] rcutorture: Make initrd/init execute in userspace
Message-ID: <20181206002738.GA23990@localhost>
References: <tip-229ab0cb5be3bfbac5947df7240f6905470ca413@git.kernel.org>
 <20181204222412.GA6874@localhost>
 <20181204230423.GP4170@linux.ibm.com>
 <20181205222523.GA14609@localhost>
 <20181206000809.GX4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206000809.GX4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:08:09PM -0800, Paul E. McKenney wrote:
> On Wed, Dec 05, 2018 at 02:25:24PM -0800, Josh Triplett wrote:
> > On Tue, Dec 04, 2018 at 03:04:23PM -0800, Paul E. McKenney wrote:
> > > On Tue, Dec 04, 2018 at 02:24:13PM -0800, Josh Triplett wrote:
> > > > On Tue, Dec 04, 2018 at 02:09:42PM -0800, tip-bot for Paul E. McKenney wrote:
> > > > > --- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> > > > > +++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> > > > > @@ -39,9 +39,22 @@ mkdir $T
> > > > >  
> > > > >  cat > $T/init << '__EOF___'
> > > > >  #!/bin/sh
> > > > > +# Run in userspace a few milliseconds every second.  This helps to
> > > > > +# exercise the NO_HZ_FULL portions of RCU.
> > > > >  while :
> > > > >  do
> > > > > -	sleep 1000000
> > > > > +	q=
> > > > > +	for i in \
> > > > > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> > > > > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> > > > > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> > > > > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> > > > > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> > > > > +		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a
> > > > 
> > > > Ow. If there's no better way to do this, please do at least comment how many 'a's
> > > > this is. (And why 186, exactly?)
> > > 
> > > Yeah, that is admittedly a bit strange.  The reason for 186 occurrences of
> > > "a" to one-time calibration, measuring a few millisecond's worth of delay.
> > > 
> > > > Please also consider calibrating the delay loop as you do in the C code.
> > > 
> > > Good point.  And a quick web search finds me "date '+%s%N'", which gives
> > > me nanoseconds since the epoch.  I probably don't want to do a 2038 to
> > > myself (after all, I might still be alive then), so I should probably try
> > > to make something work with "date '+%N'".  Or use something like this:
> > > 
> > > 	$ date '+%4N'; date '+%4N';date '+%4N'; date '+%4N'
> > > 	6660
> > > 	6685
> > > 	6697
> > > 	6710
> > > 
> > > Ah, but that means I need to add the "date" command to my initrd, doesn't
> > > it?  And calculation requires either bash or the "test" command.  And it
> > > would be quite good to restrict this to what can be done with Bourne shell
> > > built-in commands, since a big point of this is to maintain a small-sized
> > > initrd.  :-/
> > 
> > Sure, and I'm not suggesting adding commands to the initrd, hence my
> > mention of "If there's no better way".
> > 
> > > So how about the following patch, which attempts to explain the situation?
> > 
> > That would help, but please also consider consolidating with something
> > like a10="a a a a a a a a a a" to make it more readable (and perhaps
> > rounding up to 200 for simplicity).
> 
> How about powers of four and one factor of three for 192, as shown below?

Perfect, thanks. That's much better.

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 4f8f751961b536f77c8f82394963e8e2d26efd84
> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> Date:   Tue Dec 4 14:59:12 2018 -0800
> 
>     torture: Explain and simplify odd "for" loop in mkinitrd.sh
>     
>     Why a Bourne-shell "for" loop?  And why 192 instances of "a"?  This commit
>     adds a shell comment to present the answer to these mysteries.  It also
>     uses a series of factor-of-four Bourne-shell assignments to make it
>     easy to see how many instances there are, replacing the earlier wall of
>     'a' characters.
>     
>     Reported-by: Josh Triplett <josh@joshtriplett.org>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> index da298394daa2..ff69190604ea 100755
> --- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> +++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> @@ -40,17 +40,24 @@ mkdir $T
>  cat > $T/init << '__EOF___'
>  #!/bin/sh
>  # Run in userspace a few milliseconds every second.  This helps to
> -# exercise the NO_HZ_FULL portions of RCU.
> +# exercise the NO_HZ_FULL portions of RCU.  The 192 instances of "a" was
> +# empirically shown to give a nice multi-millisecond burst of user-mode
> +# execution on a 2GHz CPU, as desired.  Modern CPUs will vary from a
> +# couple of milliseconds up to perhaps 100 milliseconds, which is an
> +# acceptable range.
> +#
> +# Why not calibrate an exact delay?  Because within this initrd, we
> +# are restricted to Bourne-shell builtins, which as far as I know do not
> +# provide any means of obtaining a fine-grained timestamp.
> +
> +a4="a a a a"
> +a16="$a4 $a4 $a4 $a4"
> +a64="$a8 $a8 $a8 $a8"
> +a192="$a64 $a64 $a64"
>  while :
>  do
>  	q=
> -	for i in \
> -		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> -		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> -		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> -		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> -		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> -		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a
> +	for i in $a192
>  	do
>  		q="$q $i"
>  	done
> 
