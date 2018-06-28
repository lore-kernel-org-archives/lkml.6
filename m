Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6C8C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0352713A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0352713A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934934AbeF1JHF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:07:05 -0400
Received: from muru.com ([72.249.23.125]:49200 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932883AbeF1JG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:06:59 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 15166810E;
        Thu, 28 Jun 2018 09:09:48 +0000 (UTC)
Date:   Thu, 28 Jun 2018 02:06:55 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: v4.18-rc1 on droid 4: very bad CPU performance
Message-ID: <20180628090655.GL112168@atomide.com>
References: <20180621121542.GA4836@amd>
 <20180622072005.GF112168@atomide.com>
 <20180622074936.GG112168@atomide.com>
 <20180627205834.GB29478@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627205834.GB29478@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180627 21:01]:
> On Fri 2018-06-22 00:49:36, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [180622 07:22]:
> > > * Pavel Machek <pavel@ucw.cz> [180621 12:18]:
> > > > Hi!
> > > > 
> > > > V4.18 is slower than it should be.
> > > > 
> > > > user@devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 -
> > > > | wc -c
> > > > 10044291
> > > > 52.73user 2.40system 61.53 (1m1.534s) elapsed 89.60%CPU
> > > > user@devuan:~$ uname -a
> > > > Linux devuan 4.18.0-rc1-87964-gfa19934-dirty #743 SMP Sun Jun 17
> > > > 19:26:37 CEST 2018 armv7l GNU/Linux
> > > > 
> > > > That bzip should take 12 seconds, not minute.
> > > > 
> > > > Any ideas? Do you see it, too?
> > > 
> > > I've noticed firefox is super slow.. Git bisect time?
> > 
> > Hmm not happening for me at least on duovero and droid4,
> > I'm getting about 20s for v4.17 and v4.18-rc1.
> 
> Okay, so I know what was wrong with my config. I had l2cache disabled
> -- and this solved it:
> 
> +CONFIG_OUTER_CACHE=y
> +CONFIG_OUTER_CACHE_SYNC=y
> +CONFIG_CACHE_L2X0=y
> +CONFIG_PL310_ERRATA_588369=y
> +CONFIG_PL310_ERRATA_727915=y

We have these in omap2plus_defconfig.

> +CONFIG_PL310_ERRATA_753970=y
> +CONFIG_PL310_ERRATA_769419=y

These two should not be needed from what I recall. Have not
checked against processor revisions or errata though. But
I verified that my duovero time stays at 21 seconds also
with these enabled. It seems to run at 600MHz so it's slower
compared to droid4.

> Now I'm at 12 seconds.
> 
> user@devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 - | wc -c
> 10043993
> 11.41user 0.44system 11.63 (0m11.637s) elapsed 101.97%CPU
> user@devuan:~$ uname -a
> Linux devuan 4.18.0-rc2-88315-g3452793-dirty #756 SMP Wed Jun 27 22:16:59 CEST 2018 armv7l GNU/Linux
> user@devuan:~$
> 
> I was about to add "facepalm" emoji here, as disabling l2 cache is
> major mistake. OTOH if you also see 20 seconds, then either there is
> another problem, or you need to enable l2 cache, too (and I don't have
> to feel too bad for misconfiguring it).

OK. I checked and duovero runs only at 600MHz. I can only
get down to 19 seconds with omap2plus_defconfig if I disable
CONFIG_CPU_FREQ so the max speed is maintained from bootloader.
Otherwise it runs at most at 1GHz, I think any higher speeds
need smartreflex and voltage scaling working which we don't
have in the mainline kernel. Not sure what happens with higher
speeds with mainline kernel or if they are unsafe in the long
run.

Anyways, care to post your .config somewhere so I can see what
the numbers are for me with it?

Regards,

Tony


