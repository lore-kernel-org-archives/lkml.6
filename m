Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758683AbeD0QyN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:54:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40750 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758550AbeD0QyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:54:11 -0400
X-Google-Smtp-Source: AB8JxZqY/AD8bC8kNEiT+09IBBPbD/OEVLvulKWrzN2ZuTp66f0Cyisk0AaPlVtuBoY3nMrGrQSzWg==
Date: Fri, 27 Apr 2018 09:54:09 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v6 06/10] drivers: qcom: rpmh-rsc: allow invalidation of
 sleep/wake TCS
Message-ID: <20180427165409.GH243180@google.com>
References: <20180419221635.17849-1-ilina@codeaurora.org>
 <20180419221635.17849-7-ilina@codeaurora.org>
 <20180425221123.GD243180@google.com>
 <20180427164421.GB6380@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180427164421.GB6380@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 10:44:21AM -0600, Lina Iyer wrote:
> On Wed, Apr 25 2018 at 16:11 -0600, Matthias Kaehlcke wrote:
> > On Thu, Apr 19, 2018 at 04:16:31PM -0600, Lina Iyer wrote:
> > > Allow sleep and wake commands to be cleared from the respective TCSes,
> > > so that they can be re-populated.
> > > 
> > > Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> > > ---
> > > 
> > > Changes in v6:
> > > 	- remove unnecessary locks around __tcs_invalidate
> > > 	- rename function to tcs_invaldiate
> > > 
> > > Changes in v4:
> > > 	- refactored the rphm_rsc_invalidate()
> > > ---
> > >  drivers/soc/qcom/rpmh-rsc.c | 45 +++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 45 insertions(+)
> > > 
> > > diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> > > index d169f7da5422..170d4a10275d 100644
> > > --- a/drivers/soc/qcom/rpmh-rsc.c
> > > +++ b/drivers/soc/qcom/rpmh-rsc.c
> > > @@ -101,6 +101,51 @@ static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
> > >  	return &drv->tcs[type];
> > >  }
> > > 
> > > +static int tcs_invalidate(struct rsc_drv *drv, int type)
> > > +{
> > > +	int m;
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
> > > +		bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
> > 
> > Shouldn't this only clear the slots corresponding to 'm'?
> > 
> > If resetting the entire bitmap is really intended it could be done
> > once after the loop, though the bitmap might be left in an
> > inconsistent state if a TCS is still in use.
> The TCS will not be in use, the check tcs_is_free() will ensure that. I
> will move the bitmap_zero() outside the for().

Sure, but it could occur that one or more TCSes are disabled, then
tcs_is_free() returns false for the next TCS and the function returns
without having updated tcs->slots for the TCSes that have been
disabled.
