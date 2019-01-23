Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56232C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258A821873
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548263474;
	bh=g1gXAVlBGM/G4ibTbWeBXLydQvBnQaFffBpMwLU5zU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cbs2HGMrIu063/NCUHJ1qagq0c60qd7kNSJRnEHMB07fZCBXYzw7ZjtFDBmbJVSpm
	 1ycOcD93gHGDLLEhc4ZUxvXvhdMeYy9tyIcnnTqSXKv0kJr7WJFaLii9BIeu4WDBhO
	 ON8hn49A+21npidB4AzftsB+qxKzicpUZaw7k08I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfAWRLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:11:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfAWRLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:11:12 -0500
Received: from localhost (lfbn-ncy-1-66-34.w83-194.abo.wanadoo.fr [83.194.157.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 738DD21855;
        Wed, 23 Jan 2019 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548263471;
        bh=g1gXAVlBGM/G4ibTbWeBXLydQvBnQaFffBpMwLU5zU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGOy2OVNa3m3Z/4nNST7V6atjR1JHC+3mdPlPYWMSktA4j9mc3+XfE9alA3U8cYPV
         X68RQrv0oTOdcjUaMxPwUCkZFAsu/G8o0ZjSaepU3HpaFdVLTu2JVBX7MMfZaW1Rjf
         EFJoPLd1Dt0tDUaRMIH7byNkw3FuKkjhojtNeGaY=
Date:   Wed, 23 Jan 2019 18:11:08 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] time/nohz: allow the boot CPU to be nohz_full
Message-ID: <20190123171106.GA17710@lenoir>
References: <20190114064745.27306-1-npiggin@gmail.com>
 <20190116175440.GB26169@lenoir>
 <1548231631.0hg3ugxhh4.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548231631.0hg3ugxhh4.astroid@bobo.none>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 06:25:26PM +1000, Nicholas Piggin wrote:
> Frederic Weisbecker's on January 17, 2019 3:54 am:
> > On Mon, Jan 14, 2019 at 04:47:45PM +1000, Nicholas Piggin wrote:
> >> We have a supercomputer site testing nohz_full to reduce jitter with
> >> good results, but they want CPU0 to be nohz_full. That happens to be
> >> the boot CPU, which is disallowed by the nohz_full code.
> >> 
> >> They have existing job scheduling code which wants this, I don't know
> >> too much detail beyond that, but I hope the kernel can be made to
> >> work with their config.
> >> 
> >> This patch has the boot CPU take over the jiffies update in the low
> >> res timer before SMP is brought up, after which the nohz CPU will take
> >> over.
> >> 
> >> It also modifies the housekeeping check code a bit to ensure at least
> >> one !nohz CPU is in the present map so it comes up at boot, rather
> >> than having the nohz code take the boot CPU out of the nohz mask.
> >> 
> >> This keeps jiffies incrementing on the nohz_full boot CPU before SMP
> >> init, but I'm not sure if this is covering all races and platform
> >> considerations. Sorry I don't know the timer code too well, I would
> >> appreciate any help.
> >> 
> >> Thanks,
> >> Nick
> > 
> > We used to allow that and that broke hibernation :)
> 
> Oh interesting to know thanks, I'll look up the old code.
> 
> > So, since we need to have at least one CPU alive to handle the
> > timekeeping updates on behalf of nohz CPUs, we forbid it to go idle
> > and offline, for simplicity. Now hibernation requires to disable
> > non-boot CPUs. So if the timekeeper is not the boot CPU, it's going to
> > refuse the hotplug operation and break hibernation.
> 
> Simplest would be just to make them mutually exclusive. I don't think 
> this customer needs hibernation.

That's something I can recommend out of tree. Of course upstream we can't break
a feature for a new one.

> 
> In the longer run, I wonder if it would be nice to allow CPUs to change 
> in and out of nohz-full mode at runtime, and the time keeper CPU to be 
> able to be migrated at runtime like it does for nohz idle. Maybe that's 
> over engineering things if there is no real demand for it though.

Indeed the plan is to be able to dynamically switch to/from nohz_full
on runtime, through cpuset for example. CPU 0 may stay the exception though.

Now, housekeepers (ie: CPUs that are not nohz_full) need to be many on machines
with big number of CPUs. With this kind of scenario in mind we could arrange for
allowing the migration of the timekeeping duty. But then again, that's an invasive
change. Like you just said, so far I haven't heard of real demand, you're the
first one :-)

