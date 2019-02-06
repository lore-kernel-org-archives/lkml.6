Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F3AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C52020821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfBFSMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:12:08 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59755 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFSMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:12:08 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1grRg5-0006Vf-50; Wed, 06 Feb 2019 19:12:05 +0100
Message-ID: <1549476724.3338.10.camel@pengutronix.de>
Subject: Re: [PATCH] reset: Don't WARN if trying to get a used reset control
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Feb 2019 19:12:04 +0100
In-Reply-To: <20190206160023.GA23805@ulmo>
References: <20190125101554.5947-1-thierry.reding@gmail.com>
         <1548674808.6421.3.camel@pengutronix.de> <20190128145836.GA31317@ulmo>
         <1548849808.3939.7.camel@pengutronix.de> <20190201140025.GB12829@ulmo>
         <1549389941.3929.14.camel@pengutronix.de>
         <20190205221300.GA1372@mithrandir> <1549448885.3338.4.camel@pengutronix.de>
         <20190206113849.GA21676@ulmo> <1549464390.3338.8.camel@pengutronix.de>
         <20190206160023.GA23805@ulmo>
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

On Wed, 2019-02-06 at 17:00 +0100, Thierry Reding wrote:
[...]
> > reset_control_get_exclusive() // implicitly acquires, may fail
> > reset_control_acquire() // optional, just makes acquire explicit (no-op)
> > reset_control_assert/deassert()
> > reset_control_release()
> 
> I don't think we can do that. Otherwise, how do we make sure the acquire
> from a second driver isn't a no-op as well?

If each driver gets their own struct reset_control, the 'acquired'
property can be a boolean. If it is already set to true, _acquire() can
just return.

[...]
> > That is true, at least one of the drivers must request the control as
> > initially released, otherwise probing may fail depending on whether the
> > other driver currently acquired the reset control.
> 
> Yeah. I think that this would really only be a temporary situation.
> Eventually drivers that deal with temporarily exclusive resets should
> transition to the acquire/release protocol in all consumer drivers.
> 
> But yeah, the implicit acquire would make sure that existing code
> continues to work and the assumptions of the API hold true.

Right. I don't expect the mixed in-between state, where one driver still
requests a reset with the implicit acquire, to be guaranteed to work. It
does have to lead to sane error conditions though.

[...]
> > @@ -272,6 +274,9 @@ int reset_control_reset(struct reset_control *rstc)
> >  
> >  		if (atomic_inc_return(&rstc->triggered_count) != 1)
> >  			return 0;
> > +	} else {
> > +		if (!rstc->acquired)
> > +			return -EINVAL;
> 
> Perhaps something like -EPERM would be more appropriate here? -EINVAL
> could be confusing because we already return that under a number of
> other conditions.

Yes, thank you. Technically rstc is a valid argument. It just is in an
unprivileged state. I think EPERM would be perfectly appropriate here.

> > @@ -406,9 +417,38 @@ int reset_control_status(struct reset_control *rstc)
> >  }
> >  EXPORT_SYMBOL_GPL(reset_control_status);
> >  
> > +int reset_control_acquire(struct reset_control *rstc)
> > +{
> > +	struct reset_control *rc;
> > +
> > +	if (!rstc || rstc->acquired)
> > +		return 0;
> > +
> > +	mutex_lock(&reset_list_mutex);
> > +
> > +	list_for_each_entry(rc, &rstc->rcdev->reset_control_head, list) {
> > +		if (rstc != rc && rstc->id == rc->id) {
> > +			if (rc->acquired) {
> > +				mutex_unlock(&reset_list_mutex);
> > +				return -EBUSY;
> > +			}
> > +		}
> > +	}
> > +
> > +	mutex_unlock(&reset_list_mutex);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(reset_control_acquire);
> 
> Okay, so I see that you're trying to make sure a shared reset ID isn't
> acquired for any of the users. I think the idea of having different
> struct reset_control objects pointing at the same ID is pretty elegant,

Two users can't share the same struct reset_control, as the 'acquired'
state must be (allowed to be) different between the two of them.

> though I wonder if the loop here may not be a bit much overhead if the
> system has a large number of reset controls.

I suppose we could use a bitfield on the rcdev and atomic bitops to
speed this up if necessary. _acquire() does have to be protected against
new reset controls appearing on the rcdev list due to a
reset_control_get_exclusive running in parallel.

[...]
> > @@ -416,6 +456,14 @@ static struct reset_control *__reset_control_get_internal(
> >  
> >  	list_for_each_entry(rstc, &rcdev->reset_control_head, list) {
> >  		if (rstc->id == index) {
> > +			/*
> > +			 * Allow creating a secondary exclusive reset_control
> > +			 * that is initially not acquired for an already
> > +			 * controlled reset line.
> > +			 */
> > +			if (!rstc->shared && !shared && !acquired)
> > +				break;
> > +
> 
> Instead of allowing this to fall through and create a second reset
> control pointing at the same ID, wouldn't it be possible to just take a
> reference to the original reset control that has the same ID?

That works fine for shared reset controls because all rstc handles are
functionally identical. But for the temporarily exclusive reset
controls, whichever is in the 'acquired' state has to be different from
the others.

> That way we operate on the same reset control, but we wouldn't need to
> iterate over all existing reset controls in order to determine whether
> we can acquire or not.

How could we decide in reset_control_assert whether the provided rstc is
allowed to change the reset line if both rstc handles point to the same
struct reset_control?

> >  			if (WARN_ON(!rstc->shared || !shared))
> >  				return ERR_PTR(-EBUSY);
> 
> With the above I think we could just extend this list of conditions with
> 
> 	|| acquired
> 
> and things should work the same. Or perhaps I'm missing something.
>
> Other than that this really looks like a very nice solution.

Well, apart from the API function names...
devm_reset_control_get_optional_exclusive_released(dev, "id");
would be a mouthful.

regards
Philipp
