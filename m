Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2D3C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DB620989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548788214;
	bh=9r+oe5jna/Iw9Y6V0E+Qw2FY4aZyFK35kpgEU5vpYZs=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=yEy3PGokAqQXjMK4+XU2K/TMEk4gZPTV5GZXqUNFnHwFBnUgXqY5AYwOQv0lmbBVz
	 XKZP5WrmG06svoqtKfdLTPtNyCc616Z949mU71YY83MYdHmzCYhi4RnkwuTGECNq81
	 bO40GcY4mGZQ7/mdGhqlCg4m+t6j/m5h9funIEKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfA2S4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:56:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfA2S4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:56:51 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0280220844;
        Tue, 29 Jan 2019 18:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548788210;
        bh=9r+oe5jna/Iw9Y6V0E+Qw2FY4aZyFK35kpgEU5vpYZs=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=X/ShWqKosRwTc/CuGPLmfm+hE7IEPrT7D0rn8WCSMG5St247y5FmyXZxIEl0uNc1t
         DwxdTAVkEB2H3/NB7ovvwfLOqzSpA5Vlv4QlqOCwo3SnB9Kabn/MpoSigH9w2wEZaw
         04nOKRA3XFctQIojATAwnk6X3DSSJLxM4+dYaweI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 7/9] clk: Allow parents to be specified without string names
References: <20190129061021.94775-1-sboyd@kernel.org> <20190129061021.94775-8-sboyd@kernel.org> <2f88e7fb1788f68f7b97d9806d56f9271663bdfc.camel@baylibre.com>
User-Agent: alot/0.8
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <2f88e7fb1788f68f7b97d9806d56f9271663bdfc.camel@baylibre.com>
Message-ID: <154878820913.136743.9860407353339842831@swboyd.mtv.corp.google.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 29 Jan 2019 10:56:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-01-29 02:12:00)
> On Mon, 2019-01-28 at 22:10 -0800, Stephen Boyd wrote:
> >=20
> > Using either one of these new methods is entirely optional. Existing
> > drivers will continue to work, and they can migrate to this new approach
> > as they see fit. Eventually, we'll want to get rid of the 'parent_names'
> > array in struct clk_init_data and use one of these new methods instead.
>=20
> This may indeed allow to remove a lot of annoying code.
>=20
> However, does this remove the globally unique name string constraints ? A=
re we
> now allowed to have 2 instances of a driver registering a clock named "fo=
o" ?

Yes it would be allowed to have multiple clocks with the same name but
I'm not trying to solve that exact problem right now. The framework
already complains if that's happening, so drivers need to generate
unique names regardless of this series.

>=20
> If this is the case, I wonder:
> * How will it work with debugfs: clock names are used to create the
> directories in there, plus clk_summary will quickly get messy.

Agreed. We should probably prepend the device name to the front of the
clk now when creating in debugfs. I'll throw a patch for that into the
pile to get that problem out of the way.

I'm also beginning to think we should add a way to pass in the of_node
for a clk when it's registered.  Probably need to do that with the
initdata structure again. That way we can lookup a clk's parents with
the DT node if they don't call clk_register() with a device and also to
generate a better unique name for the clk for debug purposes.

> * How will it behave if 2 clock registers with "foo" and one clock regist=
er
> with the fallback parent "foo" ?

Sorry, I'm not following. The fallback is global so we'll be unable to
figure out which parent the clk is referring to. Maybe this is an
argument for keeping everything globally unique in the clk name space?

>=20
> >=20
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> > @@ -2365,8 +2432,11 @@ bool clk_has_parent(struct clk *clk, struct clk
> > *parent)
> >       if (core->parent =3D=3D parent_core)
> >               return true;
> > =20
> > -     return match_string(core->parent_names, core->num_parents,
> > -                         parent_core->name) >=3D 0;
> > +     for (i =3D 0; i < core->num_parents; i++)
> > +             if (!strcmp(core->parents[i].fallback, parent_core->name))
> > +                     return true;

This is also messy and not great BTW.

> > +
> > +     return false;
> >  }
> >  EXPORT_SYMBOL_GPL(clk_has_parent);
> > =20
> > @@ -2949,9 +3019,9 @@ static int possible_parents_show(struct seq_file =
*s,
> > void *data)
> >       int i;
> > =20
> >       for (i =3D 0; i < core->num_parents - 1; i++)
> > -             seq_printf(s, "%s ", core->parent_names[i]);
> > +             seq_printf(s, "%s ", core->parents[i].fallback);
> > =20
> > -     seq_printf(s, "%s\n", core->parent_names[i]);
> > +     seq_printf(s, "%s\n", core->parents[i].fallback);
>=20
> Wouldn't this show nothing if parent_data is used but fallback is not pro=
vided
> (like in your example when you provide the clk_hw pointer instead) or did=
 I
> miss something ?

Yes, it will show nothing. Maybe we need to generate the debug name
somehow? That code sounds quite awful because we're going in reverse to
the device through a DT node pointer. Or add an indicator in the output
if the parent is a global name vs. a local name or a clk debugfs name?

   "global_name(g)"
   "local_name(l)"
   "debug_name"

Or if we can't figure anything out then perhaps just ignoring this
problem for now is fine. It is debugfs after all.

>=20
> > =20
> >       return 0;
> >  }
> > @@ -3360,6 +3424,74 @@ struct clk *clk_hw_create_clk(struct device *dev,
> > struct clk_hw *hw,
> >       return clk;
> >  }
> > =20
> > +static int clk_core_populate_parent_map(struct clk_core *core)
> > +{
> > +     const struct clk_init_data *init =3D core->hw->init;
> > +     u8 num_parents =3D init->num_parents;
> > +     const char * const *parent_names =3D init->parent_names;
> > +     struct clk_hw **parent_hws =3D init->parent_hws;
> > +     const struct clk_parent_data *parent_data =3D init->parent_data;
> > +     int i, ret =3D 0;
> > +     struct clk_parent_map *parents, *parent;
> > +
> > +     if (!num_parents)
> > +             return 0;
> > +
> > +     /*
> > +      * Avoid unnecessary string look-ups of clk_core's possible paren=
ts by
> > +      * having a cache of names/clk_hw pointers to clk_core pointers.
> > +      */
> > +     parents =3D kcalloc(num_parents, sizeof(*parents), GFP_KERNEL);
> > +     core->parents =3D parents;
> > +     if (!parents)
> > +             return -ENOMEM;
> > +
> > +     /* Copy everything over because it might be __initdata */
> > +     for (i =3D 0, parent =3D parents; i < num_parents; i++, parent++)=
 {
> > +             if (parent_names) {
> > +                     /* throw a WARN if any entries are NULL */
> > +                     WARN(!parent_names[i],
> > +                             "%s: invalid NULL in %s's .parent_names\n=
",
> > +                             __func__, core->name);
> > +                     parent->fallback =3D kstrdup_const(parent_names[i=
],
> > +                                                      GFP_KERNEL);
> > +                     if (!parent->fallback) {
> > +                             ret =3D -ENOMEM;
> > +                             while (--i >=3D 0)
> > +                                     kfree_const(parents[i].fallback);
> > +                     }
> > +             } else if (parent_data) {
> > +                     parent->hw =3D parent_data[i].hw;
> > +                     parent->name =3D parent_data[i].name;
> > +                     parent->fallback =3D parent_data[i].fallback;
>=20
> I'm a bit confused by the comment at the top of the loop. Strings in
> parent_data are not copied over like we used to do with parent_names.
>=20
> Is it allowed to have parent_data in __initdata ? It could be error prone=
 if
> parent_names and parent_data behaved differently on this.

Good catch, thanks. Will fix.

>=20
> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > index 8b84dee942bf..f513f4074a93 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -264,6 +264,18 @@ struct clk_ops {
> >       void            (*debug_init)(struct clk_hw *hw, struct dentry
> > *dentry);
> >  };
> > =20
> > +/**
> > + * struct clk_parent_data - clk parent information
> > + * @hw: parent clk_hw pointer (used for clk providers with internal cl=
ks)
> > + * @name: parent name local to provider registering clk
> > + * @fallback: globally unique parent name (used as a fallback)
> > + */
> > +struct clk_parent_data {
> > +     struct clk_hw   *hw;
> > +     const char      *name;
> > +     const char      *fallback;
>=20
> If I understand correctly, .name and .fallback will be ignored if hw is
> provided ? Maybe this should be documented somehow ?

Sure. I'll add some documentation to the long portion of the kernel-doc
here describing priority order.

>=20
> > +};
> > +
> >  /**
> >   * struct clk_init_data - holds init data that's common to all clocks =
and
> > is
> >   * shared between the clock provider and the common clock framework.
> > @@ -277,7 +289,10 @@ struct clk_ops {
> >  struct clk_init_data {
> >       const char              *name;
> >       const struct clk_ops    *ops;
> > -     const char              * const *parent_names;
> > +     /* Only one of the following three should be assigned */
> > +     const char              * const *parent_names; /* If NULL (and
> > num_parents !=3D 0) look at parent_data and parent_hws */
> > +     const struct clk_parent_data    *parent_data;
> > +     struct clk_hw           **parent_hws;
>=20
> Isn't parent_hws redundant with parent_data ? you may pass the clk_hw poi=
nter
> with both, right ?

Yeah it's redundant, but I thought that drivers may not want to waste
the extra space for pointers if they had all the pointers in hand for
the parents they care about, or if they had a single parent and just
wanted to point to that directly.

Another thought is to have a union on these three pointers and then a
flag indicating which method is used:

	union {
		const char              * const *parent_names;
		const struct clk_parent_data    *parent_data;
		struct clk_hw           **parent_hws;
	};

	#define CLK_PARENTS_POINTERS		BIT(3)
	#define CLK_PARENTS_DATA		BIT(8)

