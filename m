Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A82C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5002082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544134104;
	bh=ExD9TSSNAfv7uoKuEqR4Nc7idb8HztWEiCRbDzmkgeY=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=RB27G+KA8AN3MoPeJMZGZr1uTZD5lsiLs4H0KuWXa8Z2GukXX5EfytNIjumcBWcPR
	 8dALPLfPGWG7CIkxHzAyG8RIvMrp+fFDoTdTNkwS2R1q4bprIjgUSRf1B7Ug5Qs6EQ
	 L8C+k0hpY823WO3Ra9PstGgRFsja5VqNGDCLllCc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5002082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbeLFWIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:08:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLFWIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:08:23 -0500
Received: from localhost (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CF9C2082B;
        Thu,  6 Dec 2018 22:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544134101;
        bh=ExD9TSSNAfv7uoKuEqR4Nc7idb8HztWEiCRbDzmkgeY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=IRKWy8u3d/rNg6Xiusm+8Wqe9FKdvIsHhuBn4Aip918882I2c20N4TDtqgGfWV+rB
         YtbKuX73SE+FvWDn4qD8cglIr9N9zUred5CV4oHq3BuDvTc+m3lo/22LgqFM1mPzH2
         vY9PgV1ig6JAtiYxeUieQ/3SSlGyOeXJYpi9I7p8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <98e430d7a96fa6b4f0225e57820a4a677108a052.camel@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20181204163257.32085-1-jbrunet@baylibre.com>
 <154394675320.88331.12449582989130694425@swboyd.mtv.corp.google.com>
 <807f2924b67239f61c6d93de7f7b124f8a1f195a.camel@baylibre.com>
 <154399647605.88331.115722031910044874@swboyd.mtv.corp.google.com>
 <98e430d7a96fa6b4f0225e57820a4a677108a052.camel@baylibre.com>
Message-ID: <154413410087.88331.10879623310968389005@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] Revert "clk: fix __clk_init_parent() for single parent clocks"
Date:   Thu, 06 Dec 2018 14:08:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry this email is long.

TL;DR is that I don't think we need to revert the patch as you suggest.
Instead, we should fix the driver to indicate NULL as the parent name of
the index it tells the framework about.

Quoting Jerome Brunet (2018-12-05 09:20:09)
> On Tue, 2018-12-04 at 23:54 -0800, Stephen Boyd wrote:
> > =

> > Ok. Thanks for the explanation. What do you do to fix this problem in
> > the 'ao_cts_cec' clk implementation?
> =

> IMO, there is nothing to fix, the implementation is correct. =

> =

> >  Sounds like you just rely on
> > clk_set_rate() to fix this all up for you when the consumer changes the
> > rate?
> =

> To setup the rate as the customer expect, yes.

Ok.

> =

> > =

> > If we have something that is default parented to something we're not
> > telling the framework about for some reason then one solution would be
> > to have some init code reparent the clk in hardware before registering
> > it with the framework. Basically "fix up" the clk tree in hardware to be
> > consistent with what software can reason about. =

> =

> Should we really ? Something the framework does not know about is not
> necessarily something wrong.
> =

> It would best if we could model the tree completly, but most of the time,=
 we
> just approximate it the best we can.
> =

> The framework just knows how to setup rates, it has no idea what rate nee=
ds to
> be set or when - And I think it is best if does not make any assumption a=
bout
> that.
> =

> Pushing it a bit, this unknown parent might important to the boot sequenc=
e.
> How would you know when it is safe to change the setting ?
> What would change it to ? It Seems obvious when there is only one known
> parent, but what if there two ? which one do you pick ? Is it really the =
role
> of CCF to make this kind of choice ? =


Agreed. We can't mandate this requirement because of what you say. There
are pitfalls such as not always knowing if it's safe to change the clk
tree before clks are registered.

> =

> > =

> > This also reminds me of some audio clks I've seen before where the
> > default parent is some external pin and it can be reparented to an
> > internal clk with clk_set_rate/parent. In that case, I think we forced
> > the parent over to the internal clk before registering so that it would
> > always get parented properly in the framework. Right now, this is going
> > to cause problems for plans to probe defer clk_get() on orphan clks.
> =

> clk_get() on orphaned clock should probably return an error if it is not =
the
> case already ? or 0 maybe ?

I'd prefer that it return EPROBE_DEFER if the clk is an orphan, except
that it causes problems for this case where muxes move away from
something unknown to something known.

> =

> > =

> > Maybe this could work better if we allowed
> > 'assigned-clock-parents/rates' to reparent clks regardless of orphan
> > status and/or had some flag that could be set on clks to indicate that
> > we're OK if clk_get() is called on it when it's an orphan because this
> > isn't a problem?
> =

> Not sure I understand your point here.

There is a problem with assigned-clock DT properties and orphan clks and
making orphan clks defer driver probes.

> =

> > =

> > Or we can make the defer on orphan code only defer if the clk has a
> > single parent and it's an orphan and return the clk if there is at least
> > one parent of the clk that has been registered and isn't marked as an
> > orphan. That would need to be recursively applied, so I guess we would
> > update our orphan marking code to indicate that clk_get() on the clk
> > should probe defer or not instead of indicating the clk's orphan status.
> > Doing this would also side-step the problem Rockchip was having where
> > certain parents never appeared but the clk was parented to it in
> > hardware, essentially blocking the clk from ever being touched by
> > consumers.
> =

> ... and now you lost me completly :)

Hmm alright.

> =

> > =

> > On the other hand, not having the clk there causes us to do a global
> > search of the clk name space each time we look for parents by the
> > "unknown" index, which in the Rockchip case was quite often because the
> > clk was changing between two other parents with a third one that never
> > got registered. So it may be better to just register an "unknown" clk as
> > a root clk with a rate of 0 that you can then hook everything up to that
> > is hardware reset to this unknown input. That way nothing is orphaned
> > and everyone is happy. We could do this for the audio case I talked
> > about earlier too so when the external pin is left unconnected we could
> > register some 'unconnected' clk and parent the audio clk to it.
> =

> We have sometimes a few orphans in the amlogic clock tree, it does not se=
ems
> to a problem.

I suppose drivers aren't calling clk_set_rate() on the orphaned clks and
experiencing problems? There are problems around clk rates that could
happen if there aren't any proper parents of a mux.

> =

> I don't really understand the benefit of having a fake clock that would a=
dopt
> all the orphan ? You guess there is problem I'm not aware of ...

I see three cases that can go wrong if we make orphan clks probe defer
clk_get():

  1) NULL as the parent name for some parent index that the hardware
     indicates is the current parent of the clk when the clk is registered.

In this case, we need to make clk_get() succeed and not return
-EPROBE_DEFER, so I think we need to make a special "unknown" clk in the
framework so that clks aren't orphaned when the hardware is indicating
the parent is something we don't (and won't) know anything about.

  2) get_parent/set_parent on a clk with num_parents =3D=3D 1

This seems to be how ao_cts_cec is implemented. This hides the fact that
get_parent may return some number above the number of parents and then
has that quietly make the parent of the clk NULL during registration so
that it's orphaned. Then we rely on set_rate() or set_parent() being
called to fix the parent chain at a later time.

That is complicated and non-obvious. I'd rather that we specify NULL as
a parent in the parent_names array if we're going to return that index
to the framework and then have the framework go to case #1. This makes
it easier for the framework to assume that [0, num_parents) is the valid
range of indices returned from the get_parent() op and a number outside
that range is an error, clearing the way for errors to be returned from
get_parent() if it somehow fails.

  3) A string as the parent name for some parent index that the hardware
     indicates is the current parent of the clk when the clk is registered,
     but that parent clk may never be registered with the framework.

I imagine this can happen with an external gpio clk that feeds some SoC
internal clk. That gpio could be supplied by some clk signal that the
board designer decides to send there, and it could also just "magically
appear" by applying some DT overlay. Due to our use of global strings
for parent linking, we don't have a good way to figure out that nothing
is connected to some clock input signal, making this quite a nightmare
to figure out a runtime!

One solution is to replace the parent name with NULL and ignore the
runtime update case. This will work and bring us back to case #1. The
problem is that if it is connected to something like a GPIO and it
defaults to that pin instead of some internal clk we're stuck with an
"orphan" clk that we can't clk_get(). I suppose the driver could read DT
and see if this pin is not connected and then mark this input parent
name as NULL. We can punt on solving the DT overlay problem until later,
because we would need some way to dynamically resolve a new parent of a
clk and update the tree when the DT node is modified to use a new GPIO.

