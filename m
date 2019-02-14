Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617F0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36781222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391722AbfBNCOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:14:32 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:10875 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728365AbfBNCOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:14:32 -0500
X-UUID: a0816b68e78749179379deea4823c140-20190214
X-UUID: a0816b68e78749179379deea4823c140-20190214
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 14699297; Thu, 14 Feb 2019 10:14:21 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs03n1.mediatek.inc
 (172.21.101.181) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 14 Feb
 2019 10:14:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Feb 2019 10:14:18 +0800
Message-ID: <1550110458.16070.30.camel@mhfsdcap03>
Subject: Re: [PATCH v1] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        "Kyle Roeschley" <kyle.roeschley@ni.com>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Date:   Thu, 14 Feb 2019 10:14:18 +0800
In-Reply-To: <CAPDyKFpNEhXT0dD_p85Ab2H_nHtr5r86BLcvkLVUsdwtYLUs4g@mail.gmail.com>
References: <1550048812-29068-1-git-send-email-chaotian.jing@mediatek.com>
         <CAPDyKFpNEhXT0dD_p85Ab2H_nHtr5r86BLcvkLVUsdwtYLUs4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-02-13 at 13:08 +0100, Ulf Hansson wrote:
> On Wed, 13 Feb 2019 at 10:07, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> >
> > mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
> > Therefore, any commands sent to the card should use HS400 timing.
> > reduce clock frequency to 50Mhz but without host timming change
> > may cause CMD6 response CRC error. because host still running at
> > hs400 mode, and it's hard to find a suitable setting for all eMMC
> > cards when clock frequency reduced to 50Mhz but card & host still
> > in hs400 mode.
> > this patch refers to mmc_select_hs400(), make the reduce clock frequency
> > after card timing change.
> >
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > Fixes: ef3d232245ab ("mmc: mmc: Relax checking for switch errors after HS200 switch")
> > ---
> >  drivers/mmc/core/mmc.c | 29 +++++++++++++++++++++++------
> >  1 file changed, 23 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 09c688f..00adc2d 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -1239,20 +1239,37 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> >         int err;
> >         u8 val;
> >
> > -       /* Reduce frequency to HS */
> > -       max_dtr = card->ext_csd.hs_max_dtr;
> > -       mmc_set_clock(host, max_dtr);
> > -
> >         /* Switch HS400 to HS DDR */
> >         val = EXT_CSD_TIMING_HS;
> >         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
> >                            val, card->ext_csd.generic_cmd6_time, 0,
> >                            true, false, true);
> > -       if (err)
> > -               goto out_err;
> > +       /*
> > +        * as we are on the way to do re-tune, so if the CMD6 got response CRC
> > +        * error, do not treat it as error.
> > +        */
> > +       if (err) {
> > +               if (err == -EILSEQ) {
> > +                       /*
> > +                        * card will busy after sending out response and host
> > +                        * driver may not wait busy de-assert when get
> > +                        * response CRC error. so just wait enough time to
> > +                        * ensure card leave busy state.
> > +                        */
> > +                       mmc_delay(card->ext_csd.generic_cmd6_time);
> > +                       pr_debug("%s: %s switch to HS got CRC error\n",
> > +                                mmc_hostname(host), __func__);
> > +               } else {
> > +                       goto out_err;
> > +               }
> > +       }
> >
> >         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> >
> > +       /* Reduce frequency to HS */
> > +       max_dtr = card->ext_csd.hs_max_dtr;
> > +       mmc_set_clock(host, max_dtr);
> > +
> 
> What Adrian suggested was to not to move this part, but instead, only
> allow CRC errors from the CMD6 as above.
> 
> I guess it didn't work for you?
> 
It should work for me. another issue is CMD6 will be sent 3 times at max
 err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);

if the first CMD6 got response CRC error, then Host driver must wait
busy signal de-assert before send the next CMD6.

So that it really make sense to issue CMD6(R1B) for 3 times ? if host
driver did not handle the first CMD6 response CRC error and send second
CMD6 directly, then this CMD6 will get timeout due to card still in busy
state.
> >         err = mmc_switch_status(card);
> >         if (err)
> >                 goto out_err;
> > --
> > 1.8.1.1.dirty
> >
> 
> Kind regards
> Uffe


