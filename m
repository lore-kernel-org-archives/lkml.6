Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AAAC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA482073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbfACRWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:22:23 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:46354 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730229AbfACRWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:22:23 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x03HJUQi009761;
        Thu, 3 Jan 2019 11:22:19 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2pp67unx05-1;
        Thu, 03 Jan 2019 11:22:18 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 5E413611C8AC;
        Thu,  3 Jan 2019 11:22:18 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 3 Jan 2019
 17:22:17 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id x03HMHjB006264; Thu,
 3 Jan 2019 17:22:17 GMT
Date:   Thu, 3 Jan 2019 17:22:17 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
Subject: Re: [PATCH] regmap: irq: Make IRQ type support optional
Message-ID: <20190103172217.GP16508@imbe.wolfsonmicro.main>
References: <20181228112358.5914-1-ckeepax@opensource.cirrus.com>
 <20181228115548.GM16508@imbe.wolfsonmicro.main>
 <042F8805D2046347BB8420BEAE397A4066F2EFFE@WILL-MAIL001.REu.RohmEu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <042F8805D2046347BB8420BEAE397A4066F2EFFE@WILL-MAIL001.REu.RohmEu.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901030153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 12:16:17PM +0000, Vaittinen, Matti wrote:
> Hello Charles,
> 
> Sending this mail form outlook web interface - so I won't inline any code :/
> 
> From: Charles Keepax [ckeepax@opensource.cirrus.com]
> Sent: Friday, December 28, 2018 1:55 PM
> 
> > On Fri, Dec 28, 2018 at 11:23:58AM +0000, Charles Keepax wrote:
> > > Currently only gpio-max77620 is using the type support in regmap IRQ,
> > > but the implementation causes the irq_set_type operation to fail on all
> > > other regmap IRQ chips. Avoid these regressions by skipping the type
> > > handling on any chips that don't define a set of supported types.
> > >
> > > Fixes: 1c2928e3e321 ("regmap: regmap-irq/gpio-max77620: add level-irq support")
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > ---
> > >  drivers/base/regmap/regmap-irq.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
> > > index 1bd1145ad8b5e..8c674f1ad0fc8 100644
> > > --- a/drivers/base/regmap/regmap-irq.c
> > > +++ b/drivers/base/regmap/regmap-irq.c
> > > @@ -257,6 +257,9 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
> > >       int reg;
> > >       const struct regmap_irq_type *t = &irq_data->type;
> > >
> > > +     if (!t->types_supported)
> > > +             return 0;
> > > +
> > >       if ((t->types_supported & type) != type)
> > >               return -ENOTSUPP;
> > >
> 
> I got the bug-report from Geert and sent this patch yesterday:
> https://lore.kernel.org/lkml/20181227084443.GA23991@localhost.localdomain/
> 
> Looking at these two options, I wonder if we shuld return
> -ENOTSUPP if we do support type setting, but for example
> only for edge, not level active IRQs - and if LEVEL_LOW or
> LEVEL_HIGH is requested? Well, I have no strong opinion and
> both of these should fix the regressions - sorry for the hassle!
> 
> I still wonder whether we should do as I suggested and only
> set the irq_set_type callback for chips which have non zero
> type_registers? I suggested that here:
> https://lore.kernel.org/lkml/20181228080533.GC2461@localhost.localdomain/
> 

Yeah that does look like probably the best solution.

Thanks,
Charles
