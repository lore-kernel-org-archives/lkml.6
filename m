Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5863C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676132075D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfBFOqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:46:37 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43921 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbfBFOqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:46:37 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1grOT9-0001Qu-Sa; Wed, 06 Feb 2019 15:46:31 +0100
Message-ID: <1549464390.3338.8.camel@pengutronix.de>
Subject: Re: [PATCH] reset: Don't WARN if trying to get a used reset control
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Feb 2019 15:46:30 +0100
In-Reply-To: <20190206113849.GA21676@ulmo>
References: <20190125101554.5947-1-thierry.reding@gmail.com>
         <1548674808.6421.3.camel@pengutronix.de> <20190128145836.GA31317@ulmo>
         <1548849808.3939.7.camel@pengutronix.de> <20190201140025.GB12829@ulmo>
         <1549389941.3929.14.camel@pengutronix.de>
         <20190205221300.GA1372@mithrandir> <1549448885.3338.4.camel@pengutronix.de>
         <20190206113849.GA21676@ulmo>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On Wed, 2019-02-06 at 12:38 +0100, Thierry Reding wrote:
[...]
> I see, that's a very good point. So it sounds indeed like we'll need to
> add some sort of implicit acquire to request_exclusive() to make this
> work.

See below.

> However, that's going to make the API a bit awkward to use, because in
> order to release the implicit acquisition the driver would have to do a
> release() that is, from a driver's point of view, unbalanced.

That is true. We could make reset_control_acquire on an already acquired
control a no-op though, so this could look like:

reset_control_get_exclusive() // implicitly acquires, may fail
reset_control_acquire() // optional, just makes acquire explicit (no-op)
reset_control_assert/deassert()
reset_control_release()

or

reset_control_get_exclusive_released() // does not implicitly acquire
res
et_control_acquire() // necessary, may fail
reset_control_assert/deassert
()
reset_control_release()

> Also, if
> we implicitly acquire() in request_exclusive(), aren't we going to get
> into a situation where both driver A and driver B will try to acquire on
> request and one of them is going to fail?

That is true, at least one of the drivers must request the control as
initially released, otherwise probing may fail depending on whether the
other driver currently acquired the reset control.

> > Also, how to decide at driver B request_exclusive() time whether or not
> > to throw a warning? We the core doesn't know at this point whether
> > driver B will use acquire()/release().
> 
> My suggestion was not to throw a warning a request_exclusive() time, but
> at acquire() time.

I'd like to keep the warning in case of two drivers that never call
_acquire(). I assume this is error case that can easily happen by
writing a wrong phandle argument in the device tree.

[...]
> > > That's at least the way that it works on Tegra. Not sure if that is
> > > universally applicable, though it seems logical to me from a hardware
> > > point of view. It may not be required to keep the reset asserted while
> > > the power domain is turned off, but I'd be surprised if there was a
> > > requirement that it be deasserted while the power domain is off.
> > 
> > There is hardware that doesn't allow to control the level of the reset
> > line, providing only a self clearing bit that can be used to trigger a
> > reset pulse (via reset_control_reset()).
> 
> I don't think that really matters. The important part here is ownership.
> If the power domain owns the reset control upon turning off, no driver
> whose device is under that power domain should be handling the reset
> anyway. The device should only be able to take back control of the reset
> after the power domain has powered on again.

Ok, that makes sense.

> > > > > Hm... actually this means that power domains would have to request the
> > > > > reset controls and call reset_control_acquire() during probe. That way
> > > > > when the domain is powered on it will release the reset and free it up
> > > > > for the SOR driver to use.
> > > > 
> > > > If you can guarantee that the power domain is powered up and releases
> > > > the reset control before the SOR driver tries to request the reset line,
> > > > that would work.
> > > 
> > > Well, that's the part that the acquire/release protocol would enforce.
> > 
> > Only if both drivers use it. I'd prefer the API to provide consistent
> > behaviour even if one of the drivers doesn't use acquire/release.
> 
> I'm not sure how to solve that, unless we make the API asymmetric. So if
> an exclusive reset is implicitly acquired at request time, you need to
> have an unbalanced release() to release it for a second driver to use.

Correct.

> But you also don't know which one of the drivers will get the implicit
> acquire, so the second driver to request the reset control is already
> going to fail to acquire() at request time. Or if we build in some smart
> mechanism to only acquire() for the first driver to request, we'll end
> up with a situation where neither driver knows whether they own the
> reset control or not.

That's why I suggested there should be a new method to explicitly get a
reset control without the implicit acquire step. That's more or less the
same as what you suggest below, just by a different name.

> To be honest, I have no idea if that could even work. It's like if you
> pass down a lock to two users but you don't tell them if it's locked or
> not. What are they supposed to do with that lock? None of them know who
> owns it, so the purpose of the lock is completely defeated.
> 
> The simplest alternative would be to introduce some sort of flag that
> would enable the acquire/release protocol. Drivers that want to share
> exclusive resets this way would then explicitly request using this flag
> and have to implement the acquire/release protocol if they do. All
> consumers will get a released reset control and have to call acquire()
> on it first to gain exclusive access to it.

^ This. I currently call this reset_control_get_exclusive_released.

> > > If your device shares a reset control with a power domain, this should
> > > work fine, provided that the device driver uses the reset only between
> > > (or during) ->runtime_resume() and ->runtime_suspend().
> > 
> > There should be a clear error path in case drivers don't use the reset
> > control only during suspend/resume as expected.
> 
> There are two things that I imagine could work. I think in general we
> should return an error (-EBUSY) if we call acquire() on a reset control
> that's already acquired.

Agreed.

> Something else that may make sense is to allow
> acquire() to block if the consumers wish to do that. This has the usual
> caveats in that it could block on consumer indefinitely if another
> consumer never releases the reset control.

I'd rather not open that can of worms.

> On the other hand, what's a consumer to do if they get -EBUSY? If they
> use this protocol, then surely they do so because they won't work
> without access to the reset control, so if they get -EBUSY, presumably
> there's no way forward for them.
> 
> Perhaps that means that such a condition is actually a bug and we should
> throw a big warning to make sure it gets addressed. Maybe this means the
> users of this protocol need to be extra cautious about sequencing, and
> that would be, in my opinion, a good argument in favour of adding an
> extra flag for this type of reset control.

I agree with all of this. In the case we are currently talking about
(driver/pm domain), reset_control_acquire() returning -EBUSY is a bug.

[...]
> Perhaps one alternative would be for all consumers to be modified with
> an explicit acquire() and release() pair before the new semantics take
> effect. But that seems a bit daunting:
> 
> 	$ git grep -n reset_control_get | wc -l
> 	381

Even if it was easy to change, I wouldn't want every driver to have to
deal with the acquire/release dance just because in some special cases
we have to be extra careful about who controls the reset line at what
time.

[...]
> I'm beginning to wonder if we're on a wild goose chase here. We've been
> focusing on exclusive resets here, but we're really talking about shared
> resets here. What we really want to do is share resets across multiple
> users and then allow one user to take exclusive control over the reset
> for a limited amount of time.

I suppose you could just use shared resets and patch the reset
controller driver to initially assert these resets. But that would again
make it work by accident.
If at any point you want to call reset_control_assert() and expect this
to have an effect, shared reset controls are not the right method.

> Would it be any easier to implement this on top of shared resets? Given
> the deassert count this would probably be difficult to do. Users of the
> shared reset could be at any point in their code execution when another
> user decides to acquire and assert/deassert.

Right. As soon as any shared reset control user has called deassert,
there is no sane way to explicitly assert the reset from another driver.
We'd have to build some kind of notification framework for reset
requests and then argue about whether to give other drivers veto power
or force them to store internal state and cease all operations.

> Hm... so I don't think the implicit acquire step during request would
> work because of the race conditions I mentioned above. The only other
> solution that I can think of is to have an explicit way to mark these
> resets as "exclusively shared" and require users of such resets to
> implement the acquire/release protocol.

I agree. Here is an (untested) patch to illustrate how I thought
handling 'acquired' state could work:

----------8<----------
From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] reset: add acquired/released state for exclusive reset
 controls

There are cases where a driver needs explicit control over a reset line
that is exclusively conneted to its device, but this control has to be
temporarily handed over to the power domain controller to handle reset
requirements during power transitions.
Allow multiple exclusive reset controls to be requested in 'released'
state for the same physical reset line, only one of which can be
acquired at the same time.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/core.c  | 79 ++++++++++++++++++++++++++++++------
 include/linux/reset.h | 93 +++++++++++++++++++++++++++++++++----------
 2 files changed, 140 insertions(+), 32 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 9582efb70025..c6a7a4474142 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -34,6 +34,7 @@ static LIST_HEAD(reset_lookup_list);
  * @id: ID of the reset controller in the reset
  *      controller device
  * @refcnt: Number of gets of this reset_control
+ * @acquired: Only one reset_control may be acquired for a given rcdev and id.
  * @shared: Is this a shared (1), or an exclusive (0) reset_control?
  * @deassert_cnt: Number of times this reset line has been deasserted
  * @triggered_count: Number of times this reset line has been reset. Currently
@@ -45,6 +46,7 @@ struct reset_control {
 	struct list_head list;
 	unsigned int id;
 	struct kref refcnt;
+	bool acquired;
 	bool shared;
 	bool array;
 	atomic_t deassert_count;
@@ -272,6 +274,9 @@ int reset_control_reset(struct reset_control *rstc)
 
 		if (atomic_inc_return(&rstc->triggered_count) != 1)
 			return 0;
+	} else {
+		if (!rstc->acquired)
+			return -EINVAL;
 	}
 
 	ret = rstc->rcdev->ops->reset(rstc->rcdev, rstc->id);
@@ -334,6 +339,9 @@ int reset_control_assert(struct reset_control *rstc)
 		 */
 		if (!rstc->rcdev->ops->assert)
 			return -ENOTSUPP;
+
+		if (!rstc->acquired)
+			return -EINVAL;
 	}
 
 	return rstc->rcdev->ops->assert(rstc->rcdev, rstc->id);
@@ -369,6 +377,9 @@ int reset_control_deassert(struct reset_control *rstc)
 
 		if (atomic_inc_return(&rstc->deassert_count) != 1)
 			return 0;
+	} else {
+		if (!rstc->acquired)
+			return -EINVAL;
 	}
 
 	/*
@@ -406,9 +417,38 @@ int reset_control_status(struct reset_control *rstc)
 }
 EXPORT_SYMBOL_GPL(reset_control_status);
 
+int reset_control_acquire(struct reset_control *rstc)
+{
+	struct reset_control *rc;
+
+	if (!rstc || rstc->acquired)
+		return 0;
+
+	mutex_lock(&reset_list_mutex);
+
+	list_for_each_entry(rc, &rstc->rcdev->reset_control_head, list) {
+		if (rstc != rc && rstc->id == rc->id) {
+			if (rc->acquired) {
+				mutex_unlock(&reset_list_mutex);
+				return -EBUSY;
+			}
+		}
+	}
+
+	mutex_unlock(&reset_list_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(reset_control_acquire);
+
+void reset_control_release(struct reset_control *rstc)
+{
+	rstc->acquired = false;
+}
+EXPORT_SYMBOL_GPL(reset_control_release);
+
 static struct reset_control *__reset_control_get_internal(
 				struct reset_controller_dev *rcdev,
-				unsigned int index, bool shared)
+				unsigned int index, bool shared, bool acquired)
 {
 	struct reset_control *rstc;
 
@@ -416,6 +456,14 @@ static struct reset_control *__reset_control_get_internal(
 
 	list_for_each_entry(rstc, &rcdev->reset_control_head, list) {
 		if (rstc->id == index) {
+			/*
+			 * Allow creating a secondary exclusive reset_control
+			 * that is initially not acquired for an already
+			 * controlled reset line.
+			 */
+			if (!rstc->shared && !shared && !acquired)
+				break;
+
 			if (WARN_ON(!rstc->shared || !shared))
 				return ERR_PTR(-EBUSY);
 
@@ -434,6 +482,7 @@ static struct reset_control *__reset_control_get_internal(
 	list_add(&rstc->list, &rcdev->reset_control_head);
 	rstc->id = index;
 	kref_init(&rstc->refcnt);
+	rstc->acquired = acquired;
 	rstc->shared = shared;
 
 	return rstc;
@@ -461,7 +510,7 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 
 struct reset_control *__of_reset_control_get(struct device_node *node,
 				     const char *id, int index, bool shared,
-				     bool optional)
+				     bool optional, bool acquired)
 {
 	struct reset_control *rstc;
 	struct reset_controller_dev *r, *rcdev;
@@ -514,7 +563,7 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
 	}
 
 	/* reset_list_mutex also protects the rcdev's reset_control list */
-	rstc = __reset_control_get_internal(rcdev, rstc_id, shared);
+	rstc = __reset_control_get_internal(rcdev, rstc_id, shared, acquired);
 
 out:
 	mutex_unlock(&reset_list_mutex);
@@ -544,7 +593,7 @@ __reset_controller_by_name(const char *name)
 
 static struct reset_control *
 __reset_control_get_from_lookup(struct device *dev, const char *con_id,
-				bool shared, bool optional)
+				bool shared, bool optional, bool acquired)
 {
 	const struct reset_control_lookup *lookup;
 	struct reset_controller_dev *rcdev;
@@ -574,7 +623,7 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 
 			rstc = __reset_control_get_internal(rcdev,
 							    lookup->index,
-							    shared);
+							    shared, acquired);
 			mutex_unlock(&reset_list_mutex);
 			break;
 		}
@@ -589,13 +638,18 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 }
 
 struct reset_control *__reset_control_get(struct device *dev, const char *id,
-					  int index, bool shared, bool optional)
+					  int index, bool shared, bool optional,
+					  bool acquired)
 {
+	if (WARN_ON(shared && acquired))
+		return ERR_PTR(-EINVAL);
+
 	if (dev->of_node)
 		return __of_reset_control_get(dev->of_node, id, index, shared,
-					      optional);
+					      optional, acquired);
 
-	return __reset_control_get_from_lookup(dev, id, shared, optional);
+	return __reset_control_get_from_lookup(dev, id, shared, optional,
+					       acquired);
 }
 EXPORT_SYMBOL_GPL(__reset_control_get);
 
@@ -636,7 +690,7 @@ static void devm_reset_control_release(struct device *dev, void *res)
 
 struct reset_control *__devm_reset_control_get(struct device *dev,
 				     const char *id, int index, bool shared,
-				     bool optional)
+				     bool optional, bool acquired)
 {
 	struct reset_control **ptr, *rstc;
 
@@ -645,7 +699,7 @@ struct reset_control *__devm_reset_control_get(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	rstc = __reset_control_get(dev, id, index, shared, optional);
+	rstc = __reset_control_get(dev, id, index, shared, optional, acquired);
 	if (!IS_ERR(rstc)) {
 		*ptr = rstc;
 		devres_add(dev, ptr);
@@ -672,7 +726,7 @@ int __device_reset(struct device *dev, bool optional)
 	struct reset_control *rstc;
 	int ret;
 
-	rstc = __reset_control_get(dev, NULL, 0, 0, optional);
+	rstc = __reset_control_get(dev, NULL, 0, 0, optional, true);
 	if (IS_ERR(rstc))
 		return PTR_ERR(rstc);
 
@@ -736,7 +790,8 @@ of_reset_control_array_get(struct device_node *np, bool shared, bool optional)
 		return ERR_PTR(-ENOMEM);
 
 	for (i = 0; i < num; i++) {
-		rstc = __of_reset_control_get(np, NULL, i, shared, optional);
+		rstc = __of_reset_control_get(np, NULL, i, shared, optional,
+					      true);
 		if (IS_ERR(rstc))
 			goto err_rst;
 		resets->rstc[i] = rstc;
diff --git a/include/linux/reset.h b/include/linux/reset.h
index c1901b61ca30..ea9a8a1ce4b1 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -14,18 +14,20 @@ int reset_control_reset(struct reset_control *rstc);
 int reset_control_assert(struct reset_control *rstc);
 int reset_control_deassert(struct reset_control *rstc);
 int reset_control_status(struct reset_control *rstc);
+int reset_control_acquire(struct reset_control *rstc);
+void reset_control_release(struct reset_control *rstc);
 
 struct reset_control *__of_reset_control_get(struct device_node *node,
 				     const char *id, int index, bool shared,
-				     bool optional);
+				     bool optional, bool acquired);
 struct reset_control *__reset_control_get(struct device *dev, const char *id,
 					  int index, bool shared,
-					  bool optional);
+					  bool optional, bool acquired);
 void reset_control_put(struct reset_control *rstc);
 int __device_reset(struct device *dev, bool optional);
 struct reset_control *__devm_reset_control_get(struct device *dev,
 				     const char *id, int index, bool shared,
-				     bool optional);
+				     bool optional, bool acquired);
 
 struct reset_control *devm_reset_control_array_get(struct device *dev,
 						   bool shared, bool optional);
@@ -56,6 +58,15 @@ static inline int reset_control_status(struct reset_control *rstc)
 	return 0;
 }
 
+static inline int reset_control_acquire(struct reset_control *rstc)
+{
+	return 0;
+}
+
+static inline void reset_control_release(struct reset_control *rstc)
+{
+}
+
 static inline void reset_control_put(struct reset_control *rstc)
 {
 }
@@ -68,21 +79,23 @@ static inline int __device_reset(struct device *dev, bool optional)
 static inline struct reset_control *__of_reset_control_get(
 					struct device_node *node,
 					const char *id, int index, bool shared,
-					bool optional)
+					bool optional, bool acquired)
 {
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
 
 static inline struct reset_control *__reset_control_get(
 					struct device *dev, const char *id,
-					int index, bool shared, bool optional)
+					int index, bool shared, bool optional,
+					bool acquired)
 {
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
 
 static inline struct reset_control *__devm_reset_control_get(
 					struct device *dev, const char *id,
-					int index, bool shared, bool optional)
+					int index, bool shared, bool optional,
+					bool acquired)
 {
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
@@ -134,7 +147,28 @@ static inline int device_reset_optional(struct device *dev)
 static inline struct reset_control *
 __must_check reset_control_get_exclusive(struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, false, false);
+	return __reset_control_get(dev, id, 0, false, false, true);
+}
+
+/**
+ * reset_control_get_exclusive_released - Lookup and obtain a temoprarily
+ *                                        exclusive reference to a reset
+ *                                        controller.
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Returns a struct reset_control or IS_ERR() condition containing errno.
+ * reset-controls returned by this function must be acquired via
+ * reset_control_acquire() before they can be used and should be released
+ * via reset_control_release() afterwards.
+ *
+ * Use of id names is optional.
+ */
+static inline struct reset_control *
+__must_check reset_control_get_exclusive_released(struct device *dev,
+						  const char *id)
+{
+	return __reset_control_get(dev, id, 0, false, false, false);
 }
 
 /**
@@ -162,19 +196,19 @@ __must_check reset_control_get_exclusive(struct device *dev, const char *id)
 static inline struct reset_control *reset_control_get_shared(
 					struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, true, false);
+	return __reset_control_get(dev, id, 0, true, false, false);
 }
 
 static inline struct reset_control *reset_control_get_optional_exclusive(
 					struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, false, true);
+	return __reset_control_get(dev, id, 0, false, true, true);
 }
 
 static inline struct reset_control *reset_control_get_optional_shared(
 					struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, true, true);
+	return __reset_control_get(dev, id, 0, true, true, false);
 }
 
 /**
@@ -190,7 +224,7 @@ static inline struct reset_control *reset_control_get_optional_shared(
 static inline struct reset_control *of_reset_control_get_exclusive(
 				struct device_node *node, const char *id)
 {
-	return __of_reset_control_get(node, id, 0, false, false);
+	return __of_reset_control_get(node, id, 0, false, false, true);
 }
 
 /**
@@ -215,7 +249,7 @@ static inline struct reset_control *of_reset_control_get_exclusive(
 static inline struct reset_control *of_reset_control_get_shared(
 				struct device_node *node, const char *id)
 {
-	return __of_reset_control_get(node, id, 0, true, false);
+	return __of_reset_control_get(node, id, 0, true, false, false);
 }
 
 /**
@@ -232,7 +266,7 @@ static inline struct reset_control *of_reset_control_get_shared(
 static inline struct reset_control *of_reset_control_get_exclusive_by_index(
 					struct device_node *node, int index)
 {
-	return __of_reset_control_get(node, NULL, index, false, false);
+	return __of_reset_control_get(node, NULL, index, false, false, true);
 }
 
 /**
@@ -260,7 +294,7 @@ static inline struct reset_control *of_reset_control_get_exclusive_by_index(
 static inline struct reset_control *of_reset_control_get_shared_by_index(
 					struct device_node *node, int index)
 {
-	return __of_reset_control_get(node, NULL, index, true, false);
+	return __of_reset_control_get(node, NULL, index, true, false, false);
 }
 
 /**
@@ -279,7 +313,26 @@ static inline struct reset_control *
 __must_check devm_reset_control_get_exclusive(struct device *dev,
 					      const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, false, false);
+	return __devm_reset_control_get(dev, id, 0, false, false, true);
+}
+
+/**
+ * devm_reset_control_get_exclusive_released - resource managed
+ *                                             reset_control_get_exclusive_released()
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Managed reset_control_get_exclusive_released(). For reset controllers
+ * returned from this function, reset_control_put() is called automatically on
+ * driver detach.
+ *
+ * See reset_control_get_exclusive_released() for more information.
+ */
+static inline struct reset_control *
+__must_check devm_reset_control_get_exclusive_released(struct device *dev,
+						       const char *id)
+{
+	return __devm_reset_control_get(dev, id, 0, false, false, false);
 }
 
 /**
@@ -294,19 +347,19 @@ __must_check devm_reset_control_get_exclusive(struct device *dev,
 static inline struct reset_control *devm_reset_control_get_shared(
 					struct device *dev, const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, true, false);
+	return __devm_reset_control_get(dev, id, 0, true, false, false);
 }
 
 static inline struct reset_control *devm_reset_control_get_optional_exclusive(
 					struct device *dev, const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, false, true);
+	return __devm_reset_control_get(dev, id, 0, false, true, true);
 }
 
 static inline struct reset_control *devm_reset_control_get_optional_shared(
 					struct device *dev, const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, true, true);
+	return __devm_reset_control_get(dev, id, 0, true, true, false);
 }
 
 /**
@@ -324,7 +377,7 @@ static inline struct reset_control *devm_reset_control_get_optional_shared(
 static inline struct reset_control *
 devm_reset_control_get_exclusive_by_index(struct device *dev, int index)
 {
-	return __devm_reset_control_get(dev, NULL, index, false, false);
+	return __devm_reset_control_get(dev, NULL, index, false, false, true);
 }
 
 /**
@@ -340,7 +393,7 @@ devm_reset_control_get_exclusive_by_index(struct device *dev, int index)
 static inline struct reset_control *
 devm_reset_control_get_shared_by_index(struct device *dev, int index)
 {
-	return __devm_reset_control_get(dev, NULL, index, true, false);
+	return __devm_reset_control_get(dev, NULL, index, true, false, false);
 }
 
 /*
-- 
2.20.1
---------->8----------

regards
Philipp
