Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D186C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EDF20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfBABi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 20:38:28 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:30554 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726425AbfBABi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 20:38:28 -0500
X-UUID: 7bf840b21c78462d82058e3f38702b8b-20190201
X-UUID: 7bf840b21c78462d82058e3f38702b8b-20190201
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1066291908; Fri, 01 Feb 2019 09:38:17 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs03n2.mediatek.inc
 (172.21.101.182) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 09:38:13 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 09:38:12 +0800
Message-ID: <1548985091.10251.26.camel@mhfsdcap03>
Subject: Re: [PATCH] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
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
        srv_heupstream <srv_heupstream@mediatek.com>
Date:   Fri, 1 Feb 2019 09:38:11 +0800
In-Reply-To: <CAPDyKFruCCs_un1oR-gd1P=ZGryyHwKuY0SkvLO2=Jm1bGV6sQ@mail.gmail.com>
References: <1548921212-5219-1-git-send-email-chaotian.jing@mediatek.com>
         <CAPDyKFruCCs_un1oR-gd1P=ZGryyHwKuY0SkvLO2=Jm1bGV6sQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: B537CDA27EF59E3B1B84E492B269AE1FB2207C44900CE4F37535641C42AF7ECF2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-31 at 16:58 +0100, Ulf Hansson wrote:
> On Thu, 31 Jan 2019 at 08:53, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> >
> > mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
> > Therefore, any commands sent to the card should use HS400 timing.
> > It is incorrect to reduce frequency to 50Mhz before sending the switch
> > command, in this case, only reduce clock frequency to 50Mhz but without
> > host timming change, host is still in hs400 mode but clock changed from
> > 200Mhz to 50Mhz, which makes the tuning result unsuitable and cause
> > the switch command gets response CRC error.
> 
> According the eMMC spec there is no violation by decreasing the clock
> frequency like this. We can use whatever value <=200MHz.
> 
> However, perhaps in practice this becomes an issue, due to the tuning
> for HS400 has been done on the "current" frequency.
> 
> As as start, I think you need to clarify this in the changelog.
> 
Yes, reduce clock frequency to 50Mhz is no Spec violation, but it may
cause __mmc_switch() gets response CRC error, decreasing the clock but
without HOST mode change, on the host side, host driver do not know
what's operation the core layer want to do and can only set current bus
clock to 50Mhz, without tuning parameter change, it has a chance lead to
response CRC error. even lower clock frequency, but with the wrong
tuning parameter setting(the setting is of hs400 tuning @200Mhz).
> >
> > this patch refers to mmc_select_hs400(), make the reduce clock frequency
> > after card timing change.
> >
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > ---
> >  drivers/mmc/core/mmc.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index da892a5..21b811e 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -1239,10 +1239,6 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> >         int err;
> >         u8 val;
> >
> > -       /* Reduce frequency to HS */
> > -       max_dtr = card->ext_csd.hs_max_dtr;
> > -       mmc_set_clock(host, max_dtr);
> > -
> 
> As far as I can tell, the reason to why we change the clock frequency
> *before* the call to __mmc_switch() below, is probably to try to be on
> the safe side and conform to the spec.
> 
Agree, it Must be more safe with lower clock frequency, but the
precondition is to make the host side recognize current timing is not
HS400 mode. it has no method to find a safe setting to ensure no
response CRC error when reduce clock from 200Mhz to 50Mhz.
> However, I think you have a point, as the call to __mmc_switch(),
> passes the "send_status" parameter as false, no other command than the
> CMD6 is sent to the card.
> 
yes, the send status command was sent only after __mmc_switch() done.
> >         /* Switch HS400 to HS DDR */
> >         val = EXT_CSD_TIMING_HS;
> >         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
> > @@ -1253,6 +1249,10 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> >
> >         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> >
> > +       /* Reduce frequency to HS */
> > +       max_dtr = card->ext_csd.hs_max_dtr;
> > +       mmc_set_clock(host, max_dtr);
> > +
> 
> Perhaps it's even more correct to change the clock frequency before
> the call to mmc_set_timing(host, MMC_TIMING_MMC_DDR52). Otherwise you
> will be using the DDR52 timing in the controller, but with a too high
> frequency.
> 
for Our host, it has no impact to change the clock before or after
change timing, as the mmc_set_timing() is only for host side, not
related to MMC card side and no commands sent do card before the
timing/clock change completed.
> >         err = mmc_switch_status(card);
> >         if (err)
> >                 goto out_err;
> > --
> > 1.8.1.1.dirty
> >
> 
> Finally, it sounds like you are trying to fix a real problem, can you
> please provide some more information what is happening when the
> problem occurs at your side?
> 
Yes, I got a problem with new kernel version. with
commit:57da0c042f4af52614f4bd1a148155a299ae5cd8, this commit makes
re-tuning every time when access RPMB partition.

in fact, our host tuning result of hs400 is very stable and almost never
get response CRC error with clock frequency at 200Mhz. but cannot ensure
this tuning result also suitable when running at HS400 mode @50Mhz. as I
mentioned before, the host side does not know the reason of reduce clock
frequency to 50Mhz at HS400 mode, so what's the host side can do is only
reduce the bus clock to 50Mhz, even it can just only set the tuning
setting to default when clock frequency lower than 50Mhz, but both card
& host side are still at HS400 mode, still cannot ensure this setting is
suitable.

> Kind regards
> Uffe


