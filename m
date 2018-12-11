Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FDDC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAA920870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544548383;
	bh=GgCwKH/uEcw2pvZtG4f1Du5M6HKQEqDvBq9+YhBSbcM=;
	h=In-Reply-To:To:Subject:From:References:Cc:Date:List-ID:From;
	b=EgUbzMr9yKf9nN3tnFyufniutk+ZczpqZ1G6j5wTWxavhvKbnr3T0C10MuwbskpWw
	 3jJV5M7jkgFYl+vwDzrPxqBa8dFZTPkp0urfo8M2xvpVb4Tq3/OY050TEhxUf1K5Gv
	 ONuFNreg3mNCkrUXXA74I9urZDDmqKJ+d/m1/K5E=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAA920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeLKRNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:13:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbeLKRM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:12:58 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC43D2081B;
        Tue, 11 Dec 2018 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544548377;
        bh=GgCwKH/uEcw2pvZtG4f1Du5M6HKQEqDvBq9+YhBSbcM=;
        h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
        b=MZvA15MJTH99gywPOSHC/hjS+4mJ+eZA7uW6/dlINdlJjnJPBnn+f32XGOJ6OXTy/
         si7RCFaZ9WXqXiR6Rao2D9nj2UEIBGGZUdvZ0Oz/+dJl+LjCtnbrV6POeefceIVU5j
         X7GggpT5hGLyoh8knH0l2kmholIR493G6X2pKfzg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181204192440.12125-3-miquel.raynal@bootlin.com>
Message-ID: <154454837597.17204.11648795524314926025@swboyd.mtv.corp.google.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 2/4] clk: core: link consumer with clock driver
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <20181204192440.12125-1-miquel.raynal@bootlin.com> <20181204192440.12125-3-miquel.raynal@bootlin.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Date:   Tue, 11 Dec 2018 09:12:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I'm not reviewing the whole patch right now, just this one little
bit because I'm also working in the same area.

Quoting Miquel Raynal (2018-12-04 11:24:38)
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 60c51871b04b..721d6b55b2fa 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -781,6 +781,8 @@ void devm_clk_hw_unregister(struct device *dev, struc=
t clk_hw *hw);
>  const char *__clk_get_name(const struct clk *clk);
>  const char *clk_hw_get_name(const struct clk_hw *hw);
>  struct clk_hw *__clk_get_hw(struct clk *clk);
> +void clk_link_consumer(struct device *consumer, struct clk *clk);
> +void clk_unlink_consumer(struct clk *clk);

We shouldn't need to add these functions as far as I can tell. That's
because __clk_get() has become an internal API between clkdev.c and
clk.c that does nothing now on implementations that aren't the CCF. We
can even change this API to take a clk_hw pointer instead of a clk
pointer.

I'd rather see us plumb a struct device and clk_hw structure down into
__clk_get() and fold it all into __clk_create_clk, possibly even
renaming __clk_create_clk to clk_hw_create_clk(). That way we can get
the calling device and clk_hw pointer in one call in the clk framework,
along with the device name and connection name, and then generate the
struct clk right there. This can simplify some code and make it easier
to extend this to associate calling devices with the clk consumer
somehow.

Here's the diff. With this, you should be able to add and remove device
links in clk_hw_create_clk() when dev !=3D NULL.

----8<----

 drivers/clk/clk.c    | 57 +++++++++++++++++++++++-------------------------=
----
 drivers/clk/clk.h    | 12 +++++------
 drivers/clk/clkdev.c | 43 ++++++++++++++++++++-------------------
 3 files changed, 53 insertions(+), 59 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index af011974d4ec..684f9a4b7d65 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3202,10 +3202,11 @@ static int __clk_core_init(struct clk_core *core)
 	return ret;
 }
=20
-struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
-			     const char *con_id)
+struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
+			      const char *dev_id, const char *con_id)
 {
 	struct clk *clk;
+	struct clk_core *core;
=20
 	/* This is to allow this function to be chained to others */
 	if (IS_ERR_OR_NULL(hw))
@@ -3215,15 +3216,23 @@ struct clk *__clk_create_clk(struct clk_hw *hw, con=
st char *dev_id,
 	if (!clk)
 		return ERR_PTR(-ENOMEM);
=20
-	clk->core =3D hw->core;
+	core =3D hw->core;
+	clk->core =3D core;
 	clk->dev_id =3D dev_id;
 	clk->con_id =3D kstrdup_const(con_id, GFP_KERNEL);
 	clk->max_rate =3D ULONG_MAX;
=20
 	clk_prepare_lock();
-	hlist_add_head(&clk->clks_node, &hw->core->clks);
+	hlist_add_head(&clk->clks_node, &core->clks);
 	clk_prepare_unlock();
=20
+	if (!try_module_get(core->owner)) {
+		kfree(clk);
+		return ERR_PTR(-ENOENT);
+	}
+
+	kref_get(&core->ref);
+
 	return clk;
 }
=20
@@ -3313,7 +3322,11 @@ struct clk *clk_register(struct device *dev, struct =
clk_hw *hw)
=20
 	INIT_HLIST_HEAD(&core->clks);
=20
-	hw->clk =3D __clk_create_clk(hw, NULL, NULL);
+	/*
+	 * Pass NULL here for device because we eventually plan
+	 * to get rid of this clk created here
+	 */
+	hw->clk =3D clk_hw_create_clk(NULL, hw, NULL, NULL);
 	if (IS_ERR(hw->clk)) {
 		ret =3D PTR_ERR(hw->clk);
 		goto fail_parents;
@@ -3594,18 +3607,6 @@ EXPORT_SYMBOL_GPL(devm_clk_hw_unregister);
 /*
  * clkdev helpers
  */
-int __clk_get(struct clk *clk)
-{
-	struct clk_core *core =3D !clk ? NULL : clk->core;
-
-	if (core) {
-		if (!try_module_get(core->owner))
-			return 0;
-
-		kref_get(&core->ref);
-	}
-	return 1;
-}
=20
 /* keep in sync with __clk_free_clk */
 void __clk_put(struct clk *clk)
@@ -3976,12 +3977,12 @@ __of_clk_get_hw_from_provider(struct of_clk_provide=
r *provider,
 	return __clk_get_hw(clk);
 }
=20
-struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
+struct clk *__of_clk_get_from_provider(struct device *dev,
+				       struct of_phandle_args *clkspec,
 				       const char *dev_id, const char *con_id)
 {
 	struct of_clk_provider *provider;
-	struct clk *clk =3D ERR_PTR(-EPROBE_DEFER);
-	struct clk_hw *hw;
+	struct clk_hw *hw =3D ERR_PTR(-EPROBE_DEFER);
=20
 	if (!clkspec)
 		return ERR_PTR(-EINVAL);
@@ -3991,21 +3992,13 @@ struct clk *__of_clk_get_from_provider(struct of_ph=
andle_args *clkspec,
 	list_for_each_entry(provider, &of_clk_providers, link) {
 		if (provider->node =3D=3D clkspec->np) {
 			hw =3D __of_clk_get_hw_from_provider(provider, clkspec);
-			clk =3D __clk_create_clk(hw, dev_id, con_id);
-		}
-
-		if (!IS_ERR(clk)) {
-			if (!__clk_get(clk)) {
-				__clk_free_clk(clk);
-				clk =3D ERR_PTR(-ENOENT);
-			}
-
-			break;
+			if (!IS_ERR(hw))
+				break;
 		}
 	}
 	mutex_unlock(&of_clk_mutex);
=20
-	return clk;
+	return clk_hw_create_clk(dev, hw, dev_id, con_id);
 }
=20
 /**
@@ -4018,7 +4011,7 @@ struct clk *__of_clk_get_from_provider(struct of_phan=
dle_args *clkspec,
  */
 struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
 {
-	return __of_clk_get_from_provider(clkspec, NULL, __func__);
+	return __of_clk_get_from_provider(NULL, clkspec, NULL, __func__);
 }
 EXPORT_SYMBOL_GPL(of_clk_get_from_provider);
=20
diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index 70c0ba6336c1..a0d4aa0fcfcd 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -12,20 +12,21 @@
 struct clk_hw;
=20
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
-struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
+struct clk *__of_clk_get_from_provider(struct device *dev,
+				       struct of_phandle_args *clkspec,
 				       const char *dev_id, const char *con_id);
 #endif
=20
 #ifdef CONFIG_COMMON_CLK
-struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
-			     const char *con_id);
+struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
+			      const char *dev_id, const char *con_id);
 void __clk_free_clk(struct clk *clk);
-int __clk_get(struct clk *clk);
 void __clk_put(struct clk *clk);
 #else
 /* All these casts to avoid ifdefs in clkdev... */
 static inline struct clk *
-__clk_create_clk(struct clk_hw *hw, const char *dev_id, const char *con_id)
+clk_hw_create_clk(struct device *dev, struct clk_hw *hw, const char *dev_i=
d,
+		  const char *con_id)
 {
 	return (struct clk *)hw;
 }
@@ -34,7 +35,6 @@ static struct clk_hw *__clk_get_hw(struct clk *clk)
 {
 	return (struct clk_hw *)clk;
 }
-static inline int __clk_get(struct clk *clk) { return 1; }
 static inline void __clk_put(struct clk *clk) { }
=20
 #endif
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9ab3db8b3988..08cf01c168fb 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -28,8 +28,9 @@ static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
=20
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
-static struct clk *__of_clk_get(struct device_node *np, int index,
-			       const char *dev_id, const char *con_id)
+static struct clk *__of_clk_get(struct device *dev, struct device_node *np,
+				int index, const char *dev_id,
+				const char *con_id)
 {
 	struct of_phandle_args clkspec;
 	struct clk *clk;
@@ -40,7 +41,7 @@ static struct clk *__of_clk_get(struct device_node *np, i=
nt index,
 	if (rc)
 		return ERR_PTR(rc);
=20
-	clk =3D __of_clk_get_from_provider(&clkspec, dev_id, con_id);
+	clk =3D __of_clk_get_from_provider(dev, &clkspec, dev_id, con_id);
 	of_node_put(clkspec.np);
=20
 	return clk;
@@ -48,13 +49,13 @@ static struct clk *__of_clk_get(struct device_node *np,=
 int index,
=20
 struct clk *of_clk_get(struct device_node *np, int index)
 {
-	return __of_clk_get(np, index, np->full_name, NULL);
+	return __of_clk_get(NULL, np, index, np->full_name, NULL);
 }
 EXPORT_SYMBOL(of_clk_get);
=20
-static struct clk *__of_clk_get_by_name(struct device_node *np,
-					const char *dev_id,
-					const char *name)
+static struct clk *__of_clk_get_by_name(struct device *dev,
+					struct device_node *np,
+					const char *dev_id, const char *name)
 {
 	struct clk *clk =3D ERR_PTR(-ENOENT);
=20
@@ -69,7 +70,7 @@ static struct clk *__of_clk_get_by_name(struct device_nod=
e *np,
 		 */
 		if (name)
 			index =3D of_property_match_string(np, "clock-names", name);
-		clk =3D __of_clk_get(np, index, dev_id, name);
+		clk =3D __of_clk_get(dev, np, index, dev_id, name);
 		if (!IS_ERR(clk)) {
 			break;
 		} else if (name && index >=3D 0) {
@@ -106,13 +107,14 @@ struct clk *of_clk_get_by_name(struct device_node *np=
, const char *name)
 	if (!np)
 		return ERR_PTR(-ENOENT);
=20
-	return __of_clk_get_by_name(np, np->full_name, name);
+	return __of_clk_get_by_name(NULL, np, np->full_name, name);
 }
 EXPORT_SYMBOL(of_clk_get_by_name);
=20
 #else /* defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK) */
=20
-static struct clk *__of_clk_get_by_name(struct device_node *np,
+static struct clk *__of_clk_get_by_name(struct device *dev,
+					struct device_node *np,
 					const char *dev_id,
 					const char *name)
 {
@@ -163,7 +165,8 @@ static struct clk_lookup *clk_find(const char *dev_id, =
const char *con_id)
 	return cl;
 }
=20
-struct clk *clk_get_sys(const char *dev_id, const char *con_id)
+static struct clk *__clk_get_sys(struct device *dev, const char *dev_id,
+				 const char *con_id)
 {
 	struct clk_lookup *cl;
 	struct clk *clk =3D NULL;
@@ -174,21 +177,19 @@ struct clk *clk_get_sys(const char *dev_id, const cha=
r *con_id)
 	if (!cl)
 		goto out;
=20
-	clk =3D __clk_create_clk(cl->clk_hw, dev_id, con_id);
+	clk =3D clk_hw_create_clk(dev, cl->clk_hw, dev_id, con_id);
 	if (IS_ERR(clk))
-		goto out;
-
-	if (!__clk_get(clk)) {
-		__clk_free_clk(clk);
 		cl =3D NULL;
-		goto out;
-	}
-
 out:
 	mutex_unlock(&clocks_mutex);
=20
 	return cl ? clk : ERR_PTR(-ENOENT);
 }
+
+struct clk *clk_get_sys(const char *dev_id, const char *con_id)
+{
+	return __clk_get_sys(NULL, dev_id, con_id);
+}
 EXPORT_SYMBOL(clk_get_sys);
=20
 struct clk *clk_get(struct device *dev, const char *con_id)
@@ -197,12 +198,12 @@ struct clk *clk_get(struct device *dev, const char *c=
on_id)
 	struct clk *clk;
=20
 	if (dev && dev->of_node) {
-		clk =3D __of_clk_get_by_name(dev->of_node, dev_id, con_id);
+		clk =3D __of_clk_get_by_name(dev, dev->of_node, dev_id, con_id);
 		if (!IS_ERR(clk) || PTR_ERR(clk) =3D=3D -EPROBE_DEFER)
 			return clk;
 	}
=20
-	return clk_get_sys(dev_id, con_id);
+	return __clk_get_sys(dev, dev_id, con_id);
 }
 EXPORT_SYMBOL(clk_get);
=20
