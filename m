Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE461C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794322229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437576AbfBNIkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:40:47 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52077 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387957AbfBNIkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:40:45 -0500
X-UUID: 93c143012157434eaa6c463bd9e52f6f-20190214
X-UUID: 93c143012157434eaa6c463bd9e52f6f-20190214
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 680764884; Thu, 14 Feb 2019 16:40:31 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs03n1.mediatek.inc
 (172.21.101.181) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 14 Feb
 2019 16:40:29 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Feb 2019 16:40:28 +0800
Message-ID: <1550133628.16070.32.camel@mhfsdcap03>
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
Date:   Thu, 14 Feb 2019 16:40:28 +0800
In-Reply-To: <CAPDyKFqncdVs-jB4_46ZhgZP3TGCaUWnOCoNmjfT-kAESY3csw@mail.gmail.com>
References: <1550048812-29068-1-git-send-email-chaotian.jing@mediatek.com>
         <CAPDyKFpNEhXT0dD_p85Ab2H_nHtr5r86BLcvkLVUsdwtYLUs4g@mail.gmail.com>
         <1550110458.16070.30.camel@mhfsdcap03>
         <CAPDyKFqncdVs-jB4_46ZhgZP3TGCaUWnOCoNmjfT-kAESY3csw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-14 at 09:14 +0100, Ulf Hansson wrote:
> On Thu, 14 Feb 2019 at 03:14, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> >
> > On Wed, 2019-02-13 at 13:08 +0100, Ulf Hansson wrote:
> > > On Wed, 13 Feb 2019 at 10:07, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> > > >
> > > > mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
> > > > Therefore, any commands sent to the card should use HS400 timing.
> > > > reduce clock frequency to 50Mhz but without host timming change
> > > > may cause CMD6 response CRC error. because host still running at
> > > > hs400 mode, and it's hard to find a suitable setting for all eMMC
> > > > cards when clock frequency reduced to 50Mhz but card & host still
> > > > in hs400 mode.
> > > > this patch refers to mmc_select_hs400(), make the reduce clock frequency
> > > > after card timing change.
> > > >
> > > > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > > > Fixes: ef3d232245ab ("mmc: mmc: Relax checking for switch errors after HS200 switch")
> > > > ---
> > > >  drivers/mmc/core/mmc.c | 29 +++++++++++++++++++++++------
> > > >  1 file changed, 23 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > > index 09c688f..00adc2d 100644
> > > > --- a/drivers/mmc/core/mmc.c
> > > > +++ b/drivers/mmc/core/mmc.c
> > > > @@ -1239,20 +1239,37 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> > > >         int err;
> > > >         u8 val;
> > > >
> > > > -       /* Reduce frequency to HS */
> > > > -       max_dtr = card->ext_csd.hs_max_dtr;
> > > > -       mmc_set_clock(host, max_dtr);
> > > > -
> > > >         /* Switch HS400 to HS DDR */
> > > >         val = EXT_CSD_TIMING_HS;
> > > >         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
> > > >                            val, card->ext_csd.generic_cmd6_time, 0,
> > > >                            true, false, true);
> > > > -       if (err)
> > > > -               goto out_err;
> > > > +       /*
> > > > +        * as we are on the way to do re-tune, so if the CMD6 got response CRC
> > > > +        * error, do not treat it as error.
> > > > +        */
> > > > +       if (err) {
> > > > +               if (err == -EILSEQ) {
> > > > +                       /*
> > > > +                        * card will busy after sending out response and host
> > > > +                        * driver may not wait busy de-assert when get
> > > > +                        * response CRC error. so just wait enough time to
> > > > +                        * ensure card leave busy state.
> > > > +                        */
> > > > +                       mmc_delay(card->ext_csd.generic_cmd6_time);
> > > > +                       pr_debug("%s: %s switch to HS got CRC error\n",
> > > > +                                mmc_hostname(host), __func__);
> > > > +               } else {
> > > > +                       goto out_err;
> > > > +               }
> > > > +       }
> > > >
> > > >         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> > > >
> > > > +       /* Reduce frequency to HS */
> > > > +       max_dtr = card->ext_csd.hs_max_dtr;
> > > > +       mmc_set_clock(host, max_dtr);
> > > > +
> > >
> > > What Adrian suggested was to not to move this part, but instead, only
> > > allow CRC errors from the CMD6 as above.
> > >
> > > I guess it didn't work for you?
> > >
> > It should work for me. another issue is CMD6 will be sent 3 times at max
> 
> Alright, let's give it a try then.
> 
> >  err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> 
> Yeah, that one have I thought about earlier as well.
> 
> >
> > if the first CMD6 got response CRC error, then Host driver must wait
> > busy signal de-assert before send the next CMD6.
> >
> > So that it really make sense to issue CMD6(R1B) for 3 times ? if host
> > driver did not handle the first CMD6 response CRC error and send second
> > CMD6 directly, then this CMD6 will get timeout due to card still in busy
> > state.
> 
> I fully agree with you, I don't think it makes sense to retry - not
> even for any CMD6, because of the busy signalling the card may raise
> afterwards.
> 
> Perhaps we should start with a simple oneliner patch, giving zero
> instead of MMC_CMD_RETRIES to mmc_wait_for_cmd() and see how that
> plays.
> 
> Then on top we can add the special error handling of the CRC errors,
> along the lines of what you suggest.
> 
> Does it make sense?
> 
Sure, I will upload a new patch to change the retry time from 3 to 0
along with this patch.
> [...]
> 
> Kind regards
> Uffe


