Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4C9C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DB3218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfAYOnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:43:21 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52347 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfAYOnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:43:20 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C5AC820748; Fri, 25 Jan 2019 15:43:17 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 716E6206A6;
        Fri, 25 Jan 2019 15:43:07 +0100 (CET)
Message-ID: <70a1887da5ca55adeeceb0d1758ec7cfe2d747bb.camel@bootlin.com>
Subject: Re: [PATCH v3 2/4] drm/vc4: Report underrun errors
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Date:   Fri, 25 Jan 2019 15:43:07 +0100
In-Reply-To: <87a7jrus68.fsf@anholt.net>
References: <20190108145056.2276-1-paul.kocialkowski@bootlin.com>
         <20190108145056.2276-3-paul.kocialkowski@bootlin.com>
         <87a7jrus68.fsf@anholt.net>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Wed, 2019-01-23 at 10:47 -0800, Eric Anholt wrote:
> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> 
> > From: Boris Brezillon <boris.brezillon@bootlin.com>
> > 
> > The DRM framework provides a generic way to report underrun errors.
> > Let's implement the necessary hooks to support it in the VC4 driver.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > ---
> > Changes in v3:
> > - Generic underrun report function has been dropped, adjust the
> >   code accordingly
> 
> Update commit message for DRM framework not providing a generic way any
> more?

Woops, sorry I missed that and left the commit inconsistent with the
changelog, indeed.

[...]

> > +void vc4_hvs_mask_underrun(struct drm_device *dev)
> > +{
> > +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> > +	u32 dispctrl = HVS_READ(SCALER_DISPCTRL);
> > +
> > +	dispctrl &= ~(SCALER_DISPCTRL_DSPEISLUR(0) |
> > +		      SCALER_DISPCTRL_DSPEISLUR(1) |
> > +		      SCALER_DISPCTRL_DSPEISLUR(2));
> > +
> > +	HVS_WRITE(SCALER_DISPCTRL, dispctrl);
> > +}
> > +
> > +void vc4_hvs_unmask_underrun(struct drm_device *dev)
> > +{
> > +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> > +	u32 dispctrl = HVS_READ(SCALER_DISPCTRL);
> > +
> > +	dispctrl |= SCALER_DISPCTRL_DSPEISLUR(0) |
> > +		    SCALER_DISPCTRL_DSPEISLUR(1) |
> > +		    SCALER_DISPCTRL_DSPEISLUR(2);
> > +
> > +	HVS_WRITE(SCALER_DISPSTAT,
> > +		  SCALER_DISPSTAT_EUFLOW(0) |
> > +		  SCALER_DISPSTAT_EUFLOW(1) |
> > +		  SCALER_DISPSTAT_EUFLOW(2));
> > +	HVS_WRITE(SCALER_DISPCTRL, dispctrl);
> > +}
> > +
> > +static void vc4_hvs_report_underrun(struct drm_device *dev)
> > +{
> > +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> > +
> > +	atomic_inc(&vc4->underrun);
> > +	DRM_DEV_ERROR(dev->dev, "HVS underrun\n");
> > +}
> > +
> > +static irqreturn_t vc4_hvs_irq_handler(int irq, void *data)
> > +{
> > +	struct drm_device *dev = data;
> > +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> > +	u32 status;
> > +
> > +	status = HVS_READ(SCALER_DISPSTAT);
> > +
> > +	if (status &
> > +	    (SCALER_DISPSTAT_EUFLOW(0) | SCALER_DISPSTAT_EUFLOW(1) |
> > +	     SCALER_DISPSTAT_EUFLOW(2))) {
> > +		vc4_hvs_mask_underrun(dev);
> > +		vc4_hvs_report_underrun(dev);
> > +	}
> > +
> > +	HVS_WRITE(SCALER_DISPSTAT, status);
> > +
> > +	return status ? IRQ_HANDLED : IRQ_NONE;
> > +}
> 
> So, if UFLOW is set then we incremented the counter and disabled the
> interrupt, otherwise we acked this specific interrupt and return?  Given
> that a short-line error (the other potential cause of EISLUR) would be
> likely to persist, we should probably either vc4_hvs_mask_underrun() in
> that case too, or only return IRQ_HANDLED for the case we actually
> handled.

I see, there is definitely an inconsistency here. I don't think we
should be disabling the interrupt if we get a short line indication,
just in case the interrupt gets triggered later for a legitimate
underrun (before the next commit).

So I think we should just totally ignore the short line status bit for
the IRQ return (although it certainly doesn't hurt to clear it as
well). What do you think?

> > +
> >  static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
> >  {
> >  	struct platform_device *pdev = to_platform_device(dev);
> > @@ -236,15 +305,33 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
> >  	dispctrl = HVS_READ(SCALER_DISPCTRL);
> >  
> >  	dispctrl |= SCALER_DISPCTRL_ENABLE;
> > +	dispctrl |= SCALER_DISPCTRL_DSPEISLUR(0) | SCALER_DISPCTRL_DISPEIRQ(0) |
> > +		    SCALER_DISPCTRL_DSPEISLUR(1) | SCALER_DISPCTRL_DISPEIRQ(1) |
> > +		    SCALER_DISPCTRL_DSPEISLUR(2) | SCALER_DISPCTRL_DISPEIRQ(2);
> >  
> >  	/* Set DSP3 (PV1) to use HVS channel 2, which would otherwise
> >  	 * be unused.
> >  	 */
> >  	dispctrl &= ~SCALER_DISPCTRL_DSP3_MUX_MASK;
> > +	dispctrl &= ~(SCALER_DISPCTRL_DMAEIRQ |
> > +		      SCALER_DISPCTRL_SLVWREIRQ |
> > +		      SCALER_DISPCTRL_SLVRDEIRQ |
> > +		      SCALER_DISPCTRL_DSPEIEOF(0) |
> > +		      SCALER_DISPCTRL_DSPEIEOF(1) |
> > +		      SCALER_DISPCTRL_DSPEIEOF(2) |
> > +		      SCALER_DISPCTRL_DSPEIEOLN(0) |
> > +		      SCALER_DISPCTRL_DSPEIEOLN(1) |
> > +		      SCALER_DISPCTRL_DSPEIEOLN(2) |
> > +		      SCALER_DISPCTRL_SCLEIRQ);
> >  	dispctrl |= VC4_SET_FIELD(2, SCALER_DISPCTRL_DSP3_MUX);
> 
> future work: At some point, we should stop inheriting old dispctrl setup
> and just initialize it on our own (so we get priority flags even if the
> firmware didn't set them up for us)

Sounds good, I'm taking a note of that for crafting a patch in that
direction.

> > diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
> > index 2d66a2b57a91..a28e801aeae2 100644
> > --- a/drivers/gpu/drm/vc4/vc4_kms.c
> > +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> > @@ -139,6 +139,8 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
> >  	struct drm_device *dev = state->dev;
> >  	struct vc4_dev *vc4 = to_vc4_dev(dev);
> >  
> > +	vc4_hvs_mask_underrun(dev);
> > +
> >  	drm_atomic_helper_wait_for_fences(dev, state, false);
> >  
> >  	drm_atomic_helper_wait_for_dependencies(state);
> > @@ -157,6 +159,8 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
> >  
> >  	vc4_hvs_sync_dlist(dev);
> >  
> > +	vc4_hvs_unmask_underrun(dev);
> > +
> >  	drm_atomic_helper_wait_for_flip_done(dev, state);
> >  
> >  	drm_atomic_helper_cleanup_planes(dev, state);
> > diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
> > index 50c653309aec..7e2692e9a83e 100644
> > --- a/drivers/gpu/drm/vc4/vc4_regs.h
> > +++ b/drivers/gpu/drm/vc4/vc4_regs.h
> > @@ -217,8 +217,6 @@
> >  #define SCALER_DISPCTRL                         0x00000000
> >  /* Global register for clock gating the HVS */
> >  # define SCALER_DISPCTRL_ENABLE			BIT(31)
> > -# define SCALER_DISPCTRL_DSP2EISLUR		BIT(15)
> > -# define SCALER_DISPCTRL_DSP1EISLUR		BIT(14)
> >  # define SCALER_DISPCTRL_DSP3_MUX_MASK		VC4_MASK(19, 18)
> >  # define SCALER_DISPCTRL_DSP3_MUX_SHIFT		18
> >  
> > @@ -226,45 +224,25 @@
> >   * SCALER_DISPSTAT_IRQDISP0.  Note that short frame contributions are
> >   * always enabled.
> >   */
> > -# define SCALER_DISPCTRL_DSP0EISLUR		BIT(13)
> > -# define SCALER_DISPCTRL_DSP2EIEOLN		BIT(12)
> > -# define SCALER_DISPCTRL_DSP2EIEOF		BIT(11)
> > -# define SCALER_DISPCTRL_DSP1EIEOLN		BIT(10)
> > -# define SCALER_DISPCTRL_DSP1EIEOF		BIT(9)
> > +# define SCALER_DISPCTRL_DSPEISLUR(x)		BIT(13 + (x))
> >  /* Enables Display 0 end-of-line-N contribution to
> >   * SCALER_DISPSTAT_IRQDISP0
> >   */
> > -# define SCALER_DISPCTRL_DSP0EIEOLN		BIT(8)
> > +# define SCALER_DISPCTRL_DSPEIEOLN(x)		BIT(8 + ((x) * 2))
> >  /* Enables Display 0 EOF contribution to SCALER_DISPSTAT_IRQDISP0 */
> > -# define SCALER_DISPCTRL_DSP0EIEOF		BIT(7)
> > +# define SCALER_DISPCTRL_DSPEIEOF(x)		BIT(7 + ((x) * 2))
> >  
> >  # define SCALER_DISPCTRL_SLVRDEIRQ		BIT(6)
> >  # define SCALER_DISPCTRL_SLVWREIRQ		BIT(5)
> >  # define SCALER_DISPCTRL_DMAEIRQ		BIT(4)
> > -# define SCALER_DISPCTRL_DISP2EIRQ		BIT(3)
> > -# define SCALER_DISPCTRL_DISP1EIRQ		BIT(2)
> >  /* Enables interrupt generation on the enabled EOF/EOLN/EISLUR
> >   * bits and short frames..
> >   */
> > -# define SCALER_DISPCTRL_DISP0EIRQ		BIT(1)
> > +# define SCALER_DISPCTRL_DISPEIRQ(x)		BIT(1 + (x))
> >  /* Enables interrupt generation on scaler profiler interrupt. */
> >  # define SCALER_DISPCTRL_SCLEIRQ		BIT(0)
> >  
> >  #define SCALER_DISPSTAT                         0x00000004
> > -# define SCALER_DISPSTAT_COBLOW2		BIT(29)
> > -# define SCALER_DISPSTAT_EOLN2			BIT(28)
> > -# define SCALER_DISPSTAT_ESFRAME2		BIT(27)
> > -# define SCALER_DISPSTAT_ESLINE2		BIT(26)
> > -# define SCALER_DISPSTAT_EUFLOW2		BIT(25)
> > -# define SCALER_DISPSTAT_EOF2			BIT(24)
> > -
> > -# define SCALER_DISPSTAT_COBLOW1		BIT(21)
> > -# define SCALER_DISPSTAT_EOLN1			BIT(20)
> > -# define SCALER_DISPSTAT_ESFRAME1		BIT(19)
> > -# define SCALER_DISPSTAT_ESLINE1		BIT(18)
> > -# define SCALER_DISPSTAT_EUFLOW1		BIT(17)
> > -# define SCALER_DISPSTAT_EOF1			BIT(16)
> > -
> >  # define SCALER_DISPSTAT_RESP_MASK		VC4_MASK(15, 14)
> >  # define SCALER_DISPSTAT_RESP_SHIFT		14
> >  # define SCALER_DISPSTAT_RESP_OKAY		0
> > @@ -272,23 +250,23 @@
> >  # define SCALER_DISPSTAT_RESP_SLVERR		2
> >  # define SCALER_DISPSTAT_RESP_DECERR		3
> >  
> > -# define SCALER_DISPSTAT_COBLOW0		BIT(13)
> > +# define SCALER_DISPSTAT_COBLOW(x)		BIT(5 + (((x) + 1) * 8))
> 
> These are weird to me -- why are we doing 5 + (x + 1) * 8, instead of 13
> + x * 8?  The bottom 8 bits don't seem to be related to the 3 sets in
> the top 24.

The reasoning behind it is to think in terms of "bit offset within the
byte for display x" + "number of bytes to the byte for display x" which
I feel comes somewhat naturally when reading the datasheet (the bits
for each display start byte-aligned).

But without the overall structure in mind, I agree it's a bit
disturbing and it's a more complex expression than what you suggested
either way, so I'll use your suggestion in the next revision.

Cheers and thanks for the review,

Paul

> >  /* Set when the DISPEOLN line is done compositing. */
> > -# define SCALER_DISPSTAT_EOLN0			BIT(12)
> > +# define SCALER_DISPSTAT_EOLN(x)		BIT(4 + (((x) + 1) * 8))
> >  /* Set when VSTART is seen but there are still pixels in the current
> >   * output line.
> >   */
> > -# define SCALER_DISPSTAT_ESFRAME0		BIT(11)
> > +# define SCALER_DISPSTAT_ESFRAME(x)		BIT(3 + (((x) + 1) * 8))
> >  /* Set when HSTART is seen but there are still pixels in the current
> >   * output line.
> >   */
> > -# define SCALER_DISPSTAT_ESLINE0		BIT(10)
> > +# define SCALER_DISPSTAT_ESLINE(x)		BIT(2 + (((x) + 1) * 8))
> >  /* Set when the the downstream tries to read from the display FIFO
> >   * while it's empty.
> >   */
> > -# define SCALER_DISPSTAT_EUFLOW0		BIT(9)
> > +# define SCALER_DISPSTAT_EUFLOW(x)		BIT(1 + (((x) + 1) * 8))
> >  /* Set when the display mode changes from RUN to EOF */
> > -# define SCALER_DISPSTAT_EOF0			BIT(8)
> > +# define SCALER_DISPSTAT_EOF(x)			BIT(((x) + 1) * 8)
> >  
> >  /* Set on AXI invalid DMA ID error. */
> >  # define SCALER_DISPSTAT_DMA_ERROR		BIT(7)
> > @@ -300,12 +278,10 @@
> >   * SCALER_DISPSTAT_RESP_ERROR is not SCALER_DISPSTAT_RESP_OKAY.
> >   */
> >  # define SCALER_DISPSTAT_IRQDMA			BIT(4)
> > -# define SCALER_DISPSTAT_IRQDISP2		BIT(3)
> > -# define SCALER_DISPSTAT_IRQDISP1		BIT(2)
> >  /* Set when any of the EOF/EOLN/ESFRAME/ESLINE bits are set and their
> >   * corresponding interrupt bit is enabled in DISPCTRL.
> >   */
> > -# define SCALER_DISPSTAT_IRQDISP0		BIT(1)
> > +# define SCALER_DISPSTAT_IRQDISP(x)		BIT(1 + (x))
> >  /* On read, the profiler interrupt.  On write, clear *all* interrupt bits. */
> >  # define SCALER_DISPSTAT_IRQSCL			BIT(0)
> >  
> > -- 
> > 2.20.1
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

