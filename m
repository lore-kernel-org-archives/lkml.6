Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABDEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA962081B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfBLIUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:20:23 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:28710 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727509AbfBLIUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:20:22 -0500
X-UUID: 3407cdf92e8d4a4dab858e746932f055-20190212
X-UUID: 3407cdf92e8d4a4dab858e746932f055-20190212
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 557104309; Tue, 12 Feb 2019 16:20:14 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Feb 2019 16:20:13 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Feb 2019 16:20:13 +0800
Message-ID: <1549959613.22716.6.camel@mtksdccf07>
Subject: Re: [PATCH 1/7] thermal: mediatek: fix register index error
From:   Michael Kao <michael.kao@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     =Zhang Rui <rui.zhang@intel.com>,
        =Eduardo Valentin <edubezval@gmail.com>,
        =Daniel Lezcano <daniel.lezcano@linaro.org>,
        "=Rob Herring" <robh+dt@kernel.org>,
        =Mark Rutland <mark.rutland@arm.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date:   Tue, 12 Feb 2019 16:20:13 +0800
In-Reply-To: <6496b13f-57e4-af86-bb59-91a4705d91b0@gmail.com>
References: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
         <1549006693-11659-2-git-send-email-michael.kao@mediatek.com>
         <6496b13f-57e4-af86-bb59-91a4705d91b0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-04 at 18:24 +0100, Matthias Brugger wrote:
> 
> On 01/02/2019 08:38, michael.kao@mediatek.com wrote:
> > From: Michael Kao <michael.kao@mediatek.com>
> > 
> > The index of msr and adcpnp should match the sensor
> > which belongs to the selected bank in the for loop.
> > 
> 
> If I get that right, this fixes
> b7cf0053738c ("thermal: Add Mediatek thermal driver for mt2701.")
> 
> So please add a fixes tag to the commit.

It is true that the patch is fix b7cf0053738c.
I will add 
Fixes: b7cf0053738c ("thermal: Add Mediatek thermal driver for mt2701.")
to the commit message of next version.

> Thanks,
> Matthias
> 
> > Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> > ---
> >  drivers/thermal/mtk_thermal.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> > index 0691f26..f646436 100644
> > --- a/drivers/thermal/mtk_thermal.c
> > +++ b/drivers/thermal/mtk_thermal.c
> > @@ -431,7 +431,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
> >  	u32 raw;
> >  
> >  	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
> > -		raw = readl(mt->thermal_base + conf->msr[i]);
> > +		raw = readl(mt->thermal_base +
> > +			    conf->msr[conf->bank_data[bank->id].sensors[i]]);
> >  
> >  		temp = raw_to_mcelsius(mt,
> >  				       conf->bank_data[bank->id].sensors[i],
> > @@ -568,7 +569,8 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
> >  
> >  	for (i = 0; i < conf->bank_data[num].num_sensors; i++)
> >  		writel(conf->sensor_mux_values[conf->bank_data[num].sensors[i]],
> > -		       mt->thermal_base + conf->adcpnp[i]);
> > +		       mt->thermal_base +
> > +		       conf->adcpnp[conf->bank_data[num].sensors[i]]);
> >  
> >  	writel((1 << conf->bank_data[num].num_sensors) - 1,
> >  	       mt->thermal_base + TEMP_MONCTL0);
> > 


