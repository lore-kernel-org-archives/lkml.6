Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5D8C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4694C217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545098059;
	bh=TRzZJa3scjd8a8YvSr3vKiziF86H629YBaAXaLTDwJU=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=swzgxMqpcUY4qh7yCoUWMLgEbm8OdTPlqe5JJoW7jwB6gSU+d1ndF4Y2H2vRSaYX9
	 ayM/8y2hO8lDRKIY14Y60fXn5w8T/AsZ4mgnnTNCtOaDRFLF6cdMIPGWS6x47vmOhx
	 eKGhyXqXJylze4I39UsvSTjyWjvVpBbikIWJm2b0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbeLRByS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 20:54:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbeLRByR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 20:54:17 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 647ED214C6;
        Tue, 18 Dec 2018 01:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545098056;
        bh=TRzZJa3scjd8a8YvSr3vKiziF86H629YBaAXaLTDwJU=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=Gj4/ukEnnAGbpB+NL7mLxW9QrFl8cdKRzqqz/BscngMngpqK19eknSborLxRqbgiF
         DBmOEb+T67T2LtcvjXuVimhBK8JydL8Dg4GqHAHoKhPD/cJB9gFHaoIGvjbU19WHeQ
         Ndzrj71atadfmlMOkCQNY9gn7Bcdsh9A6WjBEyNM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <63f9b6f613cab0db91c8363635aa673a11f75fba.camel@baylibre.com>
Subject: Re: [PATCH] Revert "clk: fix __clk_init_parent() for single parent clocks"
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
References: <20181204163257.32085-1-jbrunet@baylibre.com> <154394675320.88331.12449582989130694425@swboyd.mtv.corp.google.com> <807f2924b67239f61c6d93de7f7b124f8a1f195a.camel@baylibre.com> <154399647605.88331.115722031910044874@swboyd.mtv.corp.google.com> <98e430d7a96fa6b4f0225e57820a4a677108a052.camel@baylibre.com> <154413410087.88331.10879623310968389005@swboyd.mtv.corp.google.com> <63f9b6f613cab0db91c8363635aa673a11f75fba.camel@baylibre.com>
Message-ID: <154509805561.19322.14057956205431846882@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 17 Dec 2018 17:54:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2018-12-07 02:03:19)
> On Thu, 2018-12-06 at 14:08 -0800, Stephen Boyd wrote:
> > Sorry this email is long.
>=20
> I tried reply the best I could to your use cases
>=20
> >=20
> > TL;DR is that I don't think we need to revert the patch as you suggest.
> > Instead, we should fix the driver to indicate NULL as the parent name of
> > the index it tells the framework about.
>=20
> The driver, can't indicate NULL, it just provides the index of the parent.
> What we are saying is not very far apart.
>=20
> Drivers implementing get_parent() must have way to tell the framework "I =
have
> no idea what I'm connected to ATM"
>=20
> Since get_parent() return a u8, the only way to signal a problem like thi=
s is
> to return an out of bound value, which the framework already safely under=
stand
> and maps to NULL, as you request

I'm saying that the clk with two parents but only one 'known' clk parent
should have a parent_names array of two strings, where the second
element is NULL.

	.parent_names =3D { "known_clk", NULL }
	.num_parents =3D 2,

And then the .get_parent op is OK to return '1' and then we know that
the clk isn't known to be anything, but it's otherwise a valid index for
the clk to be parented to. This is the orphan case. It's not the error
case, which would be some value returned from .get_parent() that's >=3D
num_parents.

I am not talking about the return value from get_parent() returning NULL
or the driver indicating that the parent is a NULL clk. I'm just saying
that the clk driver that wants to return an index that's outside the
bounds of the parent_names array needs to do the right thing and either
grow the parent_names array to say "it's unknown what's here, I've
indicated that with a NULL name", or it needs to return another value
outside of the array so the framework knows it's an error.

>=20
> This is done in the other patch I sent (... and now they are related ;) .=
..)
> by returning num_parents in the clk_mux code
>=20
> This is an important case, whatever the number of parent. I think it make=
s no
> sense that a clock with 2 known parents can return this error, a one with=
 only
> one known parent can't.


>=20
> This why I still think the change should be reverted.
>=20
> If you really insist on keeping it, there should at least be a warning wh=
en
> registering a clock with 'get_parent !=3D NULL' and 'num_parents =3D=3D 1=
', to let
> the user know that whatever is implemented there will be ignored ... inst=
ead
> of silently ignoring it. I think it would be a mistake, but at least there
> would be no suprise.

Maybe we should add the warning. At least it would be good to grep
around and try to find these cases and update them. The documentation on
the get_parent clk op says it's unnecessary right now when 0 or 1 parent
exists, so maybe that needs an update too.

>=20
> Earlier, you mention having a special parent that would adopt the the orp=
han.
> Actually, it already exists, it is the framework itself. If, instead of
> returning 0, it returned a special value to let us know we reached the ro=
ot
> and there actually no signal, we would be easy to make sure the orphan (w=
ith
> no signal) are never accidently used.

I don't understand this part. We have orphan tracking code that knows
when a clk is no longer in an orphan chain (i.e. there is a signal
there).

>=20
> >=20
> > Quoting Jerome Brunet (2018-12-05 09:20:09)
> > > We have sometimes a few orphans in the amlogic clock tree, it does not
> > > seems
> > > to a problem.
>=20
> To the best of my knowledge, there will always be orphan in the tree. The=
 root
> clock (usually an xtal) being a special case of this.=20
>=20
> It seems to me that the problem is we can't differentiate between this sp=
ecial
> orphan and the rest because none will return an error when calling get_ra=
te()

The root clk isn't an orphan. It has num_parents =3D=3D 0 and is treated
specially as such.

>=20
> xtal will provide something to round_rate() while other clock which are
> supposed to be orphaned will defer to the framework which gives a 0 rate.
>=20
> I think this is your real issue with orphan in the framework. The framewo=
rk
> does not distinguish between a signal with rate =3D=3D 0 and an error (no=
 signal)

Ok. I'm not sure that rate is the entire problem, but I suppose it's one
problem.

> >=20
> > I suppose drivers aren't calling clk_set_rate() on the orphaned clks and
> > experiencing problems? There are problems around clk rates that could
> > happen if there aren't any proper parents of a mux.
> >=20
> > > I don't really understand the benefit of having a fake clock that wou=
ld
> > > adopt
> > > all the orphan ? You guess there is problem I'm not aware of ...
> >=20
> > I see three cases that can go wrong if we make orphan clks probe defer
> > clk_get():
> >=20
> >   1) NULL as the parent name for some parent index that the hardware
> >      indicates is the current parent of the clk when the clk is registe=
red.
>=20
> I don't think you can have NULL has a parent_name

Yes, it looks like Mike made that decision when introducing the CCF in
2012. I don't know why it is a problem though. Maybe kstrdup() on a NULL
string returns NULl and then errors can't be detected? Should be simple
enough to skip those ones when doing the deep copy though.

>=20
> >=20
> > In this case, we need to make clk_get() succeed and not return
> > -EPROBE_DEFER, so I think we need to make a special "unknown" clk in the
> > framework so that clks aren't orphaned when the hardware is indicating
> > the parent is something we don't (and won't) know anything about.
>=20
> I think DEFER is returned when clock is unknown, not when it is orphaned.

Yes it's only returned right now if the provider node hasn't registered
a provider function. We have wanted to extend that further so that clks
can't be acquired until the clk is properly rooted in the clk tree
instead of being orphaned. It may not matter on amlogic but it matters
on other platforms.

>=20
> >=20
> >   2) get_parent/set_parent on a clk with num_parents =3D=3D 1
> >=20
> > This seems to be how ao_cts_cec is implemented. This hides the fact that
> > get_parent may return some number above the number of parents
>=20
> The index returned will be either 0, to indicate the only known parent, or
> num_parents (1) to indicate an invalid parent to framework. This is the t=
opic
> of the other patch I sent you
>=20
> You must have way for a driver to tell you that it is not connected to
> anything it knows. That's a very basic error case and this is not specifi=
c to
> num_parents =3D=3D 1.=20
>=20
> With any number of num_parent, there is still a possibility that a driver=
 ends
> up in configuration where it cannot tell what it is his parent. (invalid
> combination, reserved values, crappy doc ...)
>=20
> This is why is important to call get_parent() (if available) even when
> num_parent =3D=3D 1. The driver might tell if it is connected as expected=
 - or not

Ok. Thanks for the explanation. What should the framework do when the
parent is not known? Mark the clk as not an orphan but parent it to
NULL? That might work here.

>=20
> > and then
> > has that quietly make the parent of the clk NULL during registration so
> > that it's orphaned. Then we rely on set_rate() or set_parent() being
> > called to fix the parent chain at a later time.
> >=20
> > That is complicated and non-obvious. I'd rather that we specify NULL as
> > a parent in the parent_names array if we're going to return that index
> > to the framework and then have the framework go to case #1. This makes
> > it easier for the framework to assume that [0, num_parents) is the valid
> > range of indices returned from the get_parent() op and a number outside
> > that range is an error, clearing the way for errors to be returned from
> > get_parent() if it somehow fails.
>=20
> The fix I sent is quite simple.
>=20
> The above would require that:
> 1) the framework accept NULL in the list of parent (which it forbids ATM
> AFAIK)
> 2) Have all drivers account for this a create this fake parent
>=20
> This seems to be putting more work on the drivers with no real gain for t=
he
> framework, none that I can see at least.
>=20
> >=20
> >   3) A string as the parent name for some parent index that the hardware
> >      indicates is the current parent of the clk when the clk is registe=
red,
> >      but that parent clk may never be registered with the framework.
> >=20
> > I imagine this can happen with an external gpio clk that feeds some SoC
> > internal clk. That gpio could be supplied by some clk signal that the
> > board designer decides to send there, and it could also just "magically
> > appear" by applying some DT overlay. Due to our use of global strings
> > for parent linking, we don't have a good way to figure out that nothing
> > is connected to some clock input signal, making this quite a nightmare
> > to figure out a runtime!
> >=20
> > One solution is to replace the parent name with NULL and ignore the
> > runtime update case. This will work and bring us back to case #1. The
> > problem is that if it is connected to something like a GPIO and it
> > defaults to that pin instead of some internal clk we're stuck with an
> > "orphan" clk that we can't clk_get(). I suppose the driver could read DT
> > and see if this pin is not connected and then mark this input parent
> > name as NULL. We can punt on solving the DT overlay problem until later,
> > because we would need some way to dynamically resolve a new parent of a
> > clk and update the tree when the DT node is modified to use a new GPIO.
>=20
> I don't understand what is the problem here.
> In Amlogic we have a lot of this cases, with optional input clocks of the=
 axg-
> audio clock controller. Many muxes have parent names of clock that don't
> exists.
>=20
> CCF will return a 0 rate for these inputs.
> It works well as it is, but as said above, I think it would be better if =
we
> could distinguish between a signal with 0 rate and no signal at all (erro=
r)
>=20

Ok. It sounds like we want similar things but I'm worried about the
orphan probe defer logic getting messed up.

How about we tri-state the get_parent() return value? So now [0,
num_parents) means a valid parent is known, num_parents means "I don't
know what it is but it must be something valid", and [num_parents + 1,
255] means some error occurred. Sounds obfuscated to me still.

Alternatively, we could make a get_parent_hw() op that returns a pointer
to a clk_hw structure of the parent clk. Then drivers can be converted
to use this new clk_op instead of get_parent and we can have it return
an error pointer when some error happens, NULL when the parent is not
known to the software but is otherwise valid, and the parent pointer
when the parent is findable. It would still be tri-stated then, but at
least it wouldn't be some odd u8 numberspace that it all has to fit
into. This patch starts to do that. What do you think? Clk providers
would need to implement a clk_ops that mostly does
clk_hw_get_parent_by_index(), or they could stash the parent_hw pointer
in their structure, or index into it based on some global numberspace in
their driver.

-----8<----
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index af011974d4ec..5fe3c41e0b7b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2242,14 +2242,84 @@ struct clk *clk_get_parent(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_get_parent);
=20
-static struct clk_core *__clk_init_parent(struct clk_core *core)
+static struct clk_core *
+__clk_init_parent(struct clk_core *core, bool update_orphan)
 {
 	u8 index =3D 0;
+	struct clk_hw *parent_hw =3D NULL;
=20
-	if (core->num_parents > 1 && core->ops->get_parent)
-		index =3D core->ops->get_parent(core->hw);
+	if (core->ops->get_parent_hw) {
+		parent_hw =3D core->ops->get_parent_hw(core->hw);
+		/*
+		 * The provider driver doesn't know what the parent is,
+		 * but it's at least something valid, so it's not an
+		 * orphan, just a clk with some unknown parent.
+		 */
+		if (!parent_hw && update_orphan)
+			core->orphan =3D false;
+	} else {
+		if (core->num_parents > 1 && core->ops->get_parent)
+			index =3D core->ops->get_parent(core->hw);
+
+		parent_hw =3D clk_hw_get_parent_by_index(core->hw, index);
+	}
+
+	if (IS_ERR(parent_hw)) {
+		/* Parent clk provider hasn't probed yet, orphan it */
+		if (PTR_ERR(parent_hw) =3D=3D -EPROBE_DEFER) {
+			if (update_orphan)
+				core->orphan =3D true;
+
+			return NULL;
+		}
+
+		return ERR_CAST(parent_hw);
+	}
+
+	if (!parent_hw)
+		return NULL;
+
+	return parent_hw->core;
+}
+
+static int clk_init_parent(struct clk_core *core)
+{
+	core->parent =3D __clk_init_parent(core, true);
+	if (IS_ERR(core->parent))
+		return PTR_ERR(core->parent);
+
+	/*
+	 * Populate core->parent if parent has already been clk_core_init'd. If
+	 * parent has not yet been clk_core_init'd then place clk in the orphan
+	 * list.  If clk doesn't have any parents then place it in the root
+	 * clk list.
+	 *
+	 * Every time a new clk is clk_init'd then we walk the list of orphan
+	 * clocks and re-parent any that are children of the clock currently
+	 * being clk_init'd.
+	 */
+	if (core->parent) {
+		hlist_add_head(&core->child_node,
+				&core->parent->children);
+		core->orphan =3D core->parent->orphan;
+	} else if (!core->num_parents) {
+		hlist_add_head(&core->child_node, &clk_root_list);
+		core->orphan =3D false;
+	} else {
+		hlist_add_head(&core->child_node, &clk_orphan_list);
+	}
+
+	return 0;
+}
=20
-	return clk_core_get_parent_by_index(core, index);
+static struct clk_core *clk_find_parent(struct clk_core *core)
+{
+	return __clk_init_parent(core, false);
+}
+
+static bool clk_has_parent_op(const struct clk_ops *ops)
+{
+	return ops->get_parent || ops->get_parent_hw;
 }
=20
 static void clk_core_reparent(struct clk_core *core,
@@ -3045,14 +3115,14 @@ static int __clk_core_init(struct clk_core *core)
 		goto out;
 	}
=20
-	if (core->ops->set_parent && !core->ops->get_parent) {
+	if (core->ops->set_parent && !clk_has_parent_op(core->ops)) {
 		pr_err("%s: %s must implement .get_parent & .set_parent\n",
 		       __func__, core->name);
 		ret =3D -EINVAL;
 		goto out;
 	}
=20
-	if (core->num_parents > 1 && !core->ops->get_parent) {
+	if (core->num_parents > 1 && !clk_has_parent_op(core->ops)) {
 		pr_err("%s: %s must implement .get_parent as it has multi parents\n",
 		       __func__, core->name);
 		ret =3D -EINVAL;
@@ -3073,29 +3143,9 @@ static int __clk_core_init(struct clk_core *core)
 				"%s: invalid NULL in %s's .parent_names\n",
 				__func__, core->name);
=20
-	core->parent =3D __clk_init_parent(core);
-
-	/*
-	 * Populate core->parent if parent has already been clk_core_init'd. If
-	 * parent has not yet been clk_core_init'd then place clk in the orphan
-	 * list.  If clk doesn't have any parents then place it in the root
-	 * clk list.
-	 *
-	 * Every time a new clk is clk_init'd then we walk the list of orphan
-	 * clocks and re-parent any that are children of the clock currently
-	 * being clk_init'd.
-	 */
-	if (core->parent) {
-		hlist_add_head(&core->child_node,
-				&core->parent->children);
-		core->orphan =3D core->parent->orphan;
-	} else if (!core->num_parents) {
-		hlist_add_head(&core->child_node, &clk_root_list);
-		core->orphan =3D false;
-	} else {
-		hlist_add_head(&core->child_node, &clk_orphan_list);
-		core->orphan =3D true;
-	}
+	ret =3D clk_init_parent(core);
+	if (ret)
+		goto out;
=20
 	/*
 	 * optional platform-specific magic
@@ -3173,7 +3223,14 @@ static int __clk_core_init(struct clk_core *core)
 	 * parent.
 	 */
 	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
-		struct clk_core *parent =3D __clk_init_parent(orphan);
+		struct clk_core *parent =3D clk_find_parent(orphan);
+
+		/*
+		 * Error parent should have been caught before and returned
+		 * as an error during registration.
+		 */
+		if (WARN_ON_ONCE(IS_ERR(parent)))
+			continue;
=20
 		/*
 		 * We need to use __clk_set_parent_before() and _after() to
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 60c51871b04b..8b84dee942bf 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -155,6 +155,14 @@ struct clk_duty {
  *		multiple parents.  It is optional (and unnecessary) for clocks
  *		with 0 or 1 parents.
  *
+ * @get_parent_hw: Queries the hardware to determine the parent of a clock=
.  The
+ *		return value is a clk_hw pointer corresponding to
+ *		the parent clock. In short, this function translates the parent
+ *		value read from hardware into a pointer to the clk_hw for that clk.
+ *		Currently only called when the clock is initialized by
+ *		__clk_init.  This callback is mandatory for clocks with
+ *		multiple parents.  It is optional for clocks with 0 or 1 parents.
+ *
  * @set_rate:	Change the rate of this clock. The requested rate is specifi=
ed
  *		by the second argument, which should typically be the return
  *		of .round_rate call.  The third argument gives the parent rate
@@ -238,6 +246,7 @@ struct clk_ops {
 					  struct clk_rate_request *req);
 	int		(*set_parent)(struct clk_hw *hw, u8 index);
 	u8		(*get_parent)(struct clk_hw *hw);
+	struct clk_hw * (*get_parent_hw)(struct clk_hw *hw);
 	int		(*set_rate)(struct clk_hw *hw, unsigned long rate,
 				    unsigned long parent_rate);
 	int		(*set_rate_and_parent)(struct clk_hw *hw,


