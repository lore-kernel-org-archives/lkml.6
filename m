Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A8AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D631920821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D631920821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeLJMgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:36:19 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:8571 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726475AbeLJMgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:36:19 -0500
X-UUID: f4a494469f034bea8d765f5be211ffc5-20181210
X-UUID: f4a494469f034bea8d765f5be211ffc5-20181210
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <nick.fan@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 82825730; Mon, 10 Dec 2018 20:36:13 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Dec 2018 20:36:12 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Dec 2018 20:36:12 +0800
Message-ID: <1544445372.3502.42.camel@mtksdaap41>
Subject: Re: [PATCH] opp: Add API for getting voltage from supplies
From:   Nick Fan <nick.fan@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <tfiga@chromium.org>,
        <Chiawen.Lee@mediatek.com>, <erin.lo@mediatek.com>
Date:   Mon, 10 Dec 2018 20:36:12 +0800
In-Reply-To: <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
References: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
         <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-04 at 13:51 +0530, Viresh Kumar wrote:
> On 04-12-18, 14:59, Nick Fan wrote:
> > Add API to get voltage for multiple supplies from opp table
> 
> And who needs to use this new API ? It would be better to add the user in the
> same series to make sure this really gets used.

This new API would be required when handling multiple regulators.
You can check the example 4 in
Documentation/devicetree/bindings/opp/opp.txt for multiple regulators.

When we specify multiple regulator voltages in device tree, we are not
able to access the secondary supply voltages.
Because the dev_pm_opp_get_voltage only returns the first supply
voltages, this new API is required to get the specific supply.

> 
> > Signed-off-by: Nick Fan <Nick.Fan@mediatek.com>
> > ---
> >  drivers/opp/core.c     | 28 ++++++++++++++++++++++++++++
> >  include/linux/pm_opp.h |  3 +++
> >  2 files changed, 31 insertions(+)
> > 
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 2c2df4e..ee73546 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -113,6 +113,34 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
> >  
> >  /**
> > + * dev_pm_opp_get_voltage_supply() - Gets the voltage corresponding to an opp
> > + * with index
> > + * @opp:        opp for which voltage has to be returned for
> > + * @index:      index to specify the returned supplies
> > + *
> > + * Return: voltage in micro volt corresponding to the opp with index, else
> > + * return 0
> > + *
> > + * This is useful for devices with multiple power supplies.
> > + */
> > +unsigned long dev_pm_opp_get_voltage_supply(struct dev_pm_opp *opp,
> > +					    unsigned int index)
> 
> How will the users of this API get the index ?

For the users who only use one supply, they can use
dev_pm_opp_get_voltage to get the voltage data from an opp.
But if the users who use more than one supply, they will need this API
to get their voltage data from OPP.
The users should know about the supply count while creating opp table by
using dev_pm_opp_set_regulators function.
By using this API, the users can get the voltages by using index to
specify which supplies they want.

The following is a simple example to get multiple regulators by this
API.
for (i = 0; i < regulator_num; i++)
	target_volt[i] = dev_pm_opp_get_voltage_supply(opp, i);
> 
> > +{
> > +	if (IS_ERR_OR_NULL(opp)) {
> > +		pr_err("%s: Invalid parameters\n", __func__);
> > +		return 0;
> > +	}
> > +
> > +	if (index >= opp->opp_table->regulator_count) {
> > +		pr_err("%s: Invalid supply index: %u\n", __func__, index);
> > +		return 0;
> > +	}
> > +
> > +	return opp->supplies[index].u_volt;
> 
Nick Fan

