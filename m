Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755584AbeEHRZv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:25:51 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33878 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755288AbeEHRZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:25:49 -0400
X-Google-Smtp-Source: AB8JxZqvgp2thTayAo/0+flCj9peQklhrDB0jbwHDBpSrrPQOScmclG2aDir3r7CCF/IDeNqq1tqVQ==
Date: Tue, 8 May 2018 10:25:47 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: ilina@codeaurora.org
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v7 06/10] drivers: qcom: rpmh-rsc: allow invalidation of
 sleep/wake TCS
Message-ID: <20180508172547.GG19594@google.com>
References: <20180502193749.31004-1-ilina@codeaurora.org>
 <20180502193749.31004-7-ilina@codeaurora.org>
 <20180503220651.GB19594@google.com>
 <65db1bdd4cf9337337b41745179eb84b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65db1bdd4cf9337337b41745179eb84b@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lina,

On Tue, May 08, 2018 at 10:14:33AM -0600, ilina@codeaurora.org wrote:
> On 2018-05-03 16:06, Matthias Kaehlcke wrote:
> Hi Matthias,
> 
> > Hi Lina,
> > 
> > On Wed, May 02, 2018 at 01:37:45PM -0600, Lina Iyer wrote:
> > > Allow sleep and wake commands to be cleared from the respective TCSes,
> > > so that they can be re-populated.
> > > 
> > > Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> > > ---
> > > 
> > > Changes in v7:
> > > 	- Move bitmap_zero() outside the loop
> > > 
> > > Changes in v6:
> > > 	- remove unnecessary locks around __tcs_invalidate
> > > 	- rename function to tcs_invaldiate
> > > 
> > > Changes in v4:
> > > 	- refactored the rphm_rsc_invalidate()
> > > ---
> > >  drivers/soc/qcom/rpmh-rsc.c | 45
> > > +++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 45 insertions(+)
> > > 
> > > diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> > > index 4e2144a14c31..42aedf2d80fe 100644
> > > --- a/drivers/soc/qcom/rpmh-rsc.c
> > > +++ b/drivers/soc/qcom/rpmh-rsc.c
> > > @@ -104,6 +104,51 @@ static struct tcs_group *get_tcs_of_type(struct
> > > rsc_drv *drv, int type)
> > >  	return &drv->tcs[type];
> > >  }
> > > 
> > > +static int tcs_invalidate(struct rsc_drv *drv, int type)
> > > +{
> > > +	int m;
> > 
> > nit: use tcs_id?
> > 
> It's an iterator. Hence didn't change this.
> 
> > > +	struct tcs_group *tcs;
> > > +
> > > +	tcs = get_tcs_of_type(drv, type);
> > > +	if (IS_ERR(tcs))
> > > +		return PTR_ERR(tcs);
> > > +
> > > +	spin_lock(&tcs->lock);
> > > +	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
> > > +		spin_unlock(&tcs->lock);
> > > +		return 0;
> > > +	}
> > > +
> > > +	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
> > > +		if (!tcs_is_free(drv, m)) {
> > > +			spin_unlock(&tcs->lock);
> > > +			return -EAGAIN;
> > > +		}
> > > +		write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, m, 0);
> > > +	}
> > > +	bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
> > 
> > You didn't reply to (or address) my comment on v6:
> > 
> > It could occur that one or more TCSes are disabled, then tcs_is_free()
> > returns false for the next TCS and the function returns without having
> > updated tcs->slots for the TCSes that have been disabled.
> How do you mean TCS are disabled? I think I asked that question in my mail.
> Sorry, if I forgot to ask.
> 
> TCSes are either available for sending requests or they are busy sending
> requests. They cannot be disabled if they are present.
> Individual commands, however are enabled or disabled based on whether they
> have active requests or not.

Sorry for conflating terminologies, I don't have a firm grasp on that
yet, what I meant is a TCS being busy sending requests.

> What we are trying to do here is to cleanup the TCSes of their existing
> requests. Generally, sleep and wake TCSes are not used to send active state
> requests, they are sent through AMC/Active TCS. So they will be free.
> However, in the case of the Display RSC, there is no explicit TCS available
> for sending active state requests. So we overload the wake TCS to send the
> active state requests. Even in that case, TCS would have finished and should
> be free when this function is called. The tcs_is_free() check is addition to
> make sure the requirement is not violated.

If you are sure that tcs_is_free(tcs) basically should never return
false when tcs_invalidate() is called I won't insist. If it is a
requirement violation should the code path include a WARN?
