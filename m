Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEBFC43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9742073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbfACRUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:20:21 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:46204 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730243AbfACRUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:20:21 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x03HJEvP009739;
        Thu, 3 Jan 2019 11:20:10 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2pp67unwwh-1;
        Thu, 03 Jan 2019 11:20:10 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 488BE611C8AF;
        Thu,  3 Jan 2019 11:24:14 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 3 Jan 2019
 17:20:09 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id x03HK8PI032642; Thu,
 3 Jan 2019 17:20:08 GMT
Date:   Thu, 3 Jan 2019 17:20:08 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
CC:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        <mazziesaccount@gmail.com>, <heikki.haikola@fi.rohmeurope.com>,
        <mikko.mutanen@fi.rohmeurope.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3] regmap: regmap-irq/gpio-max77620: add level-irq
 support
Message-ID: <20190103172008.GO16508@imbe.wolfsonmicro.main>
References: <20181218115931.GA21253@localhost.localdomain>
 <CAMuHMdUbXeuemACL+GGx0HFjn2oKUb2UbDUKJedzCrm8JDfNaA@mail.gmail.com>
 <20181227073531.GA2461@localhost.localdomain>
 <20181227075648.GB2461@localhost.localdomain>
 <20181228080533.GC2461@localhost.localdomain>
 <20181231191127.GL1846@sirena.org.uk>
 <20190102074251.GA8865@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190102074251.GA8865@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901030153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 09:42:51AM +0200, Matti Vaittinen wrote:
> On Mon, Dec 31, 2018 at 07:11:27PM +0000, Mark Brown wrote:
> > On Fri, Dec 28, 2018 at 10:05:33AM +0200, Matti Vaittinen wrote:
> > 
> > > Last night - just when I was about to get some sleep - it stroke me. I
> > > think the correct thing to do would be leaving the irq_set_type to NULL
> > > for those IRQ chips which do not support type setting. If we do that,
> > > then the irq core will take care of situations where user requests type
> > > setting but the chip does not support it. Which means the regmap-irq
> > > would be no different from any other irq chip where type setting is not
> > > supported.
> > 
> > Yes, this is the best fix - let the framework handle things properly.
> > We'll need a second set of operations and to select which to use based
> > on having type information but that's fine.
> > 
> > > So at the cost of removing "const" from regmap_irq_chip we could do:
> > 
> > ...
> > 
> > > Mark, Geert, what do you think? (And maybe same for the .irq_set_wake -
> > > but I did omit this as I have never looked at the wake functionality
> > > before).
> > 
> > We need a separate struct as otherwise if there's multiple devices with
> > regmap irq_chip implementations then they'll collide with each other
> 
> Right. I must admit I didn't notice this! I was about to make a nasty
> error there...
> 

Looking at the code I think it just copies the struct anyway,
basically using it as a template so I think this should be fine.

> > you're probably right that we need to do the same thing for the wake
> > configuration.  I'll still look at applying your patch as a temporary
> > fix though.
> 
> Thanks Mark. I try to cook a patch with copying of struct irq_chip still
> at this week but I wont rush it (I have some other topics under work) as
> the regression should be fixed by the other patch.
> 

Just to check that is this patch here:

https://lore.kernel.org/lkml/20181227084443.GA23991@localhost.localdomain/

Just want to check what will be applied so I know it will fix the
regression I am seeing as well.

Thanks,
Charles
