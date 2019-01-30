Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E47C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFC8218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548883818;
	bh=qw1hvxr/BiWWag2oXsyZ/XX5yBpJZkhqZgKVzhoHO90=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=nnuVT3JngF1jCl9sgAku87WA/h1xPSA2Xzt5Ih6eVj/YkGwd7JqOnSURbdQZuoRTA
	 3RbmPX2IkfSPJrJavvq3+bh2tdLiKKEk1YrKXd9+RAlqdn2a/lb3cZBPRvRJoB+VgN
	 4ytw0uJ+oP13RUpWmAjsIYakXffJa5BygoBJ8EXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388122AbfA3VaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:30:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfA3VaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:30:16 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2C792184D;
        Wed, 30 Jan 2019 21:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548883814;
        bh=qw1hvxr/BiWWag2oXsyZ/XX5yBpJZkhqZgKVzhoHO90=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=hsKIL2Zksheg4JpcvUmHWhjDsstP9htXQHrQEQ4cK+79/QEaIVa8b+2e5hBu+qyB+
         Rcq6gC/Agc16CUquMfC9I/tijeglyQ8oSoSBqda/CQm6wvVAHl/bXUr9A+E/zSjBfC
         aObp/Rz42KeJIfK5MuNM+84zPGYKnPZgxfo6k/Lo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/9] clk: Introduce get_parent_hw clk op
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154888381385.169292.12776041058756822056@swboyd.mtv.corp.google.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
References: <20190129061021.94775-1-sboyd@kernel.org> <20190129061021.94775-3-sboyd@kernel.org> <e303573aefeaf6a7e3a4b1d820e801354ff900b4.camel@baylibre.com> <154879654428.136743.10048771201181501034@swboyd.mtv.corp.google.com> <ff76dcdb4ceb3209619e5348ed7b575a8ae9df8d.camel@baylibre.com>
User-Agent: alot/0.8
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <ff76dcdb4ceb3209619e5348ed7b575a8ae9df8d.camel@baylibre.com>
Date:   Wed, 30 Jan 2019 13:30:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-01-30 01:53:41)
>=20
> It is the value we find in the register after the bootloader. Since we ha=
ve no
> idea what it is, we must assume it is invalid.

Ok, so my understanding is correct.

>=20
> The problem was that there only one known parent for this particular cloc=
k,
> and the CCF quirk (call get_parent() only if num_parent =3D=3D 1) is maki=
ng things
> difficult for us.
>=20
> We found a work around to this. We declare a non existing parent, which m=
ake
> num_parent =3D=3D 2 and force CCF to call get_parent(), and later on set_=
parent()
> ... It works but it sucks.

Yes that is bad.

>
> Sure, good idea.
>=20
> If clk_hw_get_parent_by_index() may return an error, it because get_paren=
t()
> could provide an invalid index.
>=20
> Which brings us back to the original point, if it is possible for get_par=
ent()
> to return invalid index, which means out of bounds, it shall be called ev=
en if
> num_parent =3D=3D 1.
>=20
> To be coherent, either:
> 1) the return value of get_parent() *MUST* be valid, it is fine to not ca=
ll it
> if num_parent =3D=3D 1 because we already know the only possible result.
>=20
> 2) the return value of get_parent *MAY* be invalid, then it should be cal=
led
> regarless of num_parent.
>=20
> IMO, (2) is the only valid option because any existing muxes could alread=
y be
> returning invalid indexes. I know we do on Amlogic (with various muxes, e=
ven
> with num_parent >=3D 1) and I'm sure we are not the only ones. Plus a dri=
ver
> needs to have a mean to tell CCF that things are not as expected.

Right. Having drivers specify more clks than the kernel knows about or
having the return value of get_parent() be out of range is non-obvious.
I'd rather see any drivers that want to express errors during the parent
initialization phase return an error pointer through the get_parent_hw
clk op instead.

Put another way, if you have any edge case like this you should migrate
to this new clk op and stop using .get_parent and playing tricks with
.num_parents and return values from .get_parent.

>=20
> >=20
> > so I took
> > the route of adding another callback with semantics that we can define
> > now because there aren't any users. The difference between the two is
> > made intentionally.
>=20
> I still think that the drivers relying on this quirk (only 1 AFAIK) are b=
roken
> and should be fixed, rather that keeping the quirk for everyone else.=20

Agreed. Use the new API?

>=20
> With this quirk, CCF is making an assumption that might be wrong.
>=20
> The quirk is very easy put in the get_parent() callback of the said drive=
r, or
> even better, don't provide the callback if it should not be called.
>=20
> I understand the need for a cautious approach. It seems I'm only one with=
 that
> issue right now and since I have a work around, there is no rush. But we =
must
> have plan to make it right.
>=20
> To be clear, I'm not against your new API but I don't think it should be a
> reason to keep a broken behavior the framework.
>=20

So do you think you can use this new clk_op and ignore the problems with
the .get_parent clk op? Putting effort into fixing the .get_parent
design isn't very useful from my perspective. There's more than just the
problem that we don't call it when .num_parents is 1. There's the
inability to return errors without doing weird things to return an index
out of range and there isn't any way for us to really know if the clk is
an orphan or not. If we can migrate all drivers to use the new clk op
then we can fix these problems too, and deprecate and eventually remove
the broken by design .get_parent clk op API.

BTW, I included this patch in this series because I'm wondering if it
would be useful for there to be a 'parent cookie' pointer that we pass
between the framework and providers instead using a raw index.

	struct clk_parent {
		struct clk_hw *hw;
	};

Then drivers could embed these structs into their parent_data structure
and the framework could pass pointers to these structures in struct
clk_rate_request. That may make it easier for drivers to attach extra
data to the parent for a particular clk when changing parents or rates.
For example, if the index of the parent is not a linear monotonic range
of [0, num_parents) then we could let them throw the index into either a
wrapper structure or a void *data field.

	struct my_clk_parent {
		struct clk_parent parent;
		u32 mask;
		u8 select_bit;
	};

Or
	struct my_clk_parent_data {
		u32 mask;
		u8 select_bit;
	};

	struct clk_parent {
		struct clk_hw *hw;
		void *data;
	};

And have data point to struct my_clk_parent. There's code in various clk
drivers that maps between the framework's view of the parent index and
the providers view, i.e. the hardware index. If we already have the
parent_map structure, maybe we should let that live in the provider
driver near the hardware and then just pass a pointer to it so drivers
can do container_of() or ->data accesses to get any driver data they
associate with that parent index.

If we did something like this, it may reduce code further and let us get
rid of the u8 index in the clk framework entirely. But we may want to
have the .get_parent_hw op return a pointer to a struct clk_parent
instead of a struct clk_hw now to make this easier to implement in the
future. Or this could all be overkill and only help a few drivers skip a
mapping step.

