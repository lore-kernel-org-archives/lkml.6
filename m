Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681E6C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D027206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqTu5v9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D027206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeLEHyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:54:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbeLEHyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:54:38 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB206206B7;
        Wed,  5 Dec 2018 07:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543996476;
        bh=aL4ODeTQah4DODeBi3GL64gIEpcnP7yaNfbfCumh1i8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=OqTu5v9Lm5CoEHE8TaiTKjAbqblVYt07EXrxQldgEPh+fwZcsUcCb2zei4/sp+buO
         sXOKNhU/cQp7DsQ7w2bVkcdRsESDvlrcItX6drVn85IljucDhTD3tTjJDYA/XNcJZu
         oDB2xbb1j+MZYy1mwKbpDPa8sp215M8nuEdGMBkg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <807f2924b67239f61c6d93de7f7b124f8a1f195a.camel@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20181204163257.32085-1-jbrunet@baylibre.com>
 <154394675320.88331.12449582989130694425@swboyd.mtv.corp.google.com>
 <807f2924b67239f61c6d93de7f7b124f8a1f195a.camel@baylibre.com>
Message-ID: <154399647605.88331.115722031910044874@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] Revert "clk: fix __clk_init_parent() for single parent clocks"
Date:   Tue, 04 Dec 2018 23:54:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2018-12-04 11:51:17)
> On Tue, 2018-12-04 at 10:05 -0800, Stephen Boyd wrote:
> > Quoting Jerome Brunet (2018-12-04 08:32:57)
> > > This reverts commit 2430a94d1e719b7b4af2a65b781a4c036eb22e64.
> > > =

> > > From the original commit message:
> > >   It turned out a problem because there are some single-parent clocks
> > >   that implement .get_parent() callback and return non-zero index.
> > >   The SOCFPGA clock is the case; the commit broke the SOCFPGA boards.
> > > =

> > > It is wrong for a clock to return an index >=3D num_parents. CCF chec=
ks
> > > for this condition in clk_core_get_parent_by_index(). This function s=
ets
> > > the parent to NULL if index is incoherent, which seems like the only
> > > sane choice.
> > > =

> > > commit 2430a94d1e71 ("clk: fix __clk_init_parent() for single parent
> > > clocks")
> > > appears to be a work around installed in the core framework for a pro=
blem
> > > that is platform specific, and should probably be fixed in the platfo=
rm
> > > code.
> > =

> > Ouch. I see that I even pointed that out in 2016 but never got a reply
> > or a fix patch[1].
> > =

> > > Further more, it introduces a problem in a corner case of the mux clo=
ck.
> > > Take mux with multiple parents, but only one is known, the rest being
> > > undocumented. The register reset has one of unknown parent set.
> > > =

> > > Before commit 2430a94d1e71 ("clk: fix __clk_init_parent() for single
> > > parent clocks"):
> > >  * get_parent() is called, register is read and give an unknown index.
> > >    -> the mux is orphaned.
> > >  * a call to set_rate() will reparent the mux to the only known paren=
t.
> > > =

> > > With commit 2430a94d1e71 ("clk: fix __clk_init_parent() for single pa=
rent
> > > clocks"):
> > >  * the register is never read.
> > >  * parent is wrongly assumed to be the only known one.
> > >    As a consequence, all the calculation deriving from the mux will be
> > >    wrong
> > >  * Since we believe the only know parent to be set, set_parent() won't
> > >    ever be called and the register won't be set with the correct valu=
e.
> > =

> > Isn't this the broken bad case all over again? Why register a clk as a
> > mux and then only say it has one parent?
> =

> I understand it is a bit odd but as I explained it is a corner case.
> =

> We are really trying to drive a mux here, applying a values will change t=
he
> clock signal we get. Documentation being what it is, we only know one the
> parent. The other parent could anything or maybe not connected at all, who
> know. That is not the important part actually
> =

> If such mux was already set to the known entry by default, it would be OK=
 to
> ignore it. But if it is not, then we CCF to realise that and change the
> setting accordingly.
> =

> This the case of the 'ao_cts_cec' clock in the following patch:
> https://lore.kernel.org/patchwork/patch/1021028/
> =

> by default the value in the register is 0, but the only one that makes se=
nse
> for us is 1.

Ok. Thanks for the explanation. What do you do to fix this problem in
the 'ao_cts_cec' clk implementation? Sounds like you just rely on
clk_set_rate() to fix this all up for you when the consumer changes the
rate?

If we have something that is default parented to something we're not
telling the framework about for some reason then one solution would be
to have some init code reparent the clk in hardware before registering
it with the framework. Basically "fix up" the clk tree in hardware to be
consistent with what software can reason about. =


This also reminds me of some audio clks I've seen before where the
default parent is some external pin and it can be reparented to an
internal clk with clk_set_rate/parent. In that case, I think we forced
the parent over to the internal clk before registering so that it would
always get parented properly in the framework. Right now, this is going
to cause problems for plans to probe defer clk_get() on orphan clks.

Maybe this could work better if we allowed
'assigned-clock-parents/rates' to reparent clks regardless of orphan
status and/or had some flag that could be set on clks to indicate that
we're OK if clk_get() is called on it when it's an orphan because this
isn't a problem?

Or we can make the defer on orphan code only defer if the clk has a
single parent and it's an orphan and return the clk if there is at least
one parent of the clk that has been registered and isn't marked as an
orphan. That would need to be recursively applied, so I guess we would
update our orphan marking code to indicate that clk_get() on the clk
should probe defer or not instead of indicating the clk's orphan status.
Doing this would also side-step the problem Rockchip was having where
certain parents never appeared but the clk was parented to it in
hardware, essentially blocking the clk from ever being touched by
consumers.

On the other hand, not having the clk there causes us to do a global
search of the clk name space each time we look for parents by the
"unknown" index, which in the Rockchip case was quite often because the
clk was changing between two other parents with a third one that never
got registered. So it may be better to just register an "unknown" clk as
a root clk with a rate of 0 that you can then hook everything up to that
is hardware reset to this unknown input. That way nothing is orphaned
and everyone is happy. We could do this for the audio case I talked
about earlier too so when the external pin is left unconnected we could
register some 'unconnected' clk and parent the audio clk to it.

> =

> > =

> > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > > ---
> > =

> > Is this related to the other patch you sent? Can you send series for
> > related patches please?
> > =

> > [1] https://lkml.kernel.org/r/20160209181833.GA24167@codeaurora.org
> =

> Actually I was intially doing a series, and stopped when my cover letter
> started with "those are two unrelated patches ..." ;)
> =

> I found these things while debugging the same thing but there is no deps
> between them.
> =


Ok.
