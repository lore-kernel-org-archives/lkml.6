Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeCXHb5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 03:31:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45174 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750785AbeCXHbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 03:31:55 -0400
X-UUID: ffbc9ed43d244efb9cb3d60829757b7a-20180324
Message-ID: <1521876709.28226.34.camel@mtkswgap22>
Subject: Re: [PATCH v1 11/16] rtc: mediatek: move the declaration into a
 globally visible header file
From: Sean Wang <sean.wang@mediatek.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <eddie.huang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date: Sat, 24 Mar 2018 15:31:49 +0800
In-Reply-To: <20180323095740.GD3417@piout.net>
References: <cover.1521794176.git.sean.wang@mediatek.com>
         <53afbe8172fb1afd809ce9ba1afeda924b9ea705.1521794177.git.sean.wang@mediatek.com>
         <20180323095740.GD3417@piout.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23738.005
X-TM-AS-Result: No-15.357400-8.000000-10
X-TMASE-MatchedRID: HXSqh3WYKfsOwH4pD14DsPHkpkyUphL9+Vb3woyMZbue9toQ6h6LE5Ug
        SLx++MHyTnMpwMyn/2nN165pzTWohiY0eULsNBXl7spMO3HwKCBMkOX0UoduuX5h6y4KCSJct2r
        bRfUdmZ6IoQBwem+mJyZk/0dXUaXKqH7dGVt6/4nd+fuf9kcaptxWLypmYlZzZ5yuplze9pvD/y
        2uTT9Sb0tzMtMQMLlFYVXdy49z8o8zPB7mzXyiQ3uzDvI75j0spCyirVXz4MqbKItl61J/ycnjL
        TA/UDoASXhbxZVQ5H+OhzOa6g8KrZRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.357400-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23738.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-23 at 10:57 +0100, Alexandre Belloni wrote:
> On 23/03/2018 at 17:15:08 +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > This is in preparation for allowing other drivers can share the
> > declaration, so move the declaration into a globally visible header file.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  drivers/rtc/rtc-mt6397.c   | 53 +---------------------------------
> >  include/linux/rtc/mt6397.h | 72 ++++++++++++++++++++++++++++++++++++++++++++++
> 
> This should go in include/linux/mfd/

include/linux/mfd/mt6397 is present, so include/linux/mfd/mt6397/rtc.h
seems a nice place to keep these declarations for the pmic rtc.

> >  2 files changed, 73 insertions(+), 52 deletions(-)
> >  create mode 100644 include/linux/rtc/mt6397.h
> > 
> > diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> > index d133d1f..015609d 100644
> > --- a/drivers/rtc/rtc-mt6397.c
> > +++ b/drivers/rtc/rtc-mt6397.c
> > @@ -19,63 +19,12 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/regmap.h>
> >  #include <linux/rtc.h>
> > -#include <linux/jiffies.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/io.h>
> >  #include <linux/mfd/mt6397/core.h>
> > -
> > -#define RTC_BBPU		0x0000
> > -#define RTC_BBPU_CBUSY		BIT(6)
> > -
> > -#define RTC_WRTGR		0x003c
> > -
> > -#define RTC_IRQ_STA		0x0002
> > -#define RTC_IRQ_STA_AL		BIT(0)
> > -#define RTC_IRQ_STA_LP		BIT(3)
> > -
> > -#define RTC_IRQ_EN		0x0004
> > -#define RTC_IRQ_EN_AL		BIT(0)
> > -#define RTC_IRQ_EN_ONESHOT	BIT(2)
> > -#define RTC_IRQ_EN_LP		BIT(3)
> > -#define RTC_IRQ_EN_ONESHOT_AL	(RTC_IRQ_EN_ONESHOT | RTC_IRQ_EN_AL)
> > -
> > -#define RTC_AL_MASK		0x0008
> > -#define RTC_AL_MASK_DOW		BIT(4)
> > -
> > -#define RTC_TC_SEC		0x000a
> > -/* Min, Hour, Dom... register offset to RTC_TC_SEC */
> > -#define RTC_OFFSET_SEC		0
> > -#define RTC_OFFSET_MIN		1
> > -#define RTC_OFFSET_HOUR		2
> > -#define RTC_OFFSET_DOM		3
> > -#define RTC_OFFSET_DOW		4
> > -#define RTC_OFFSET_MTH		5
> > -#define RTC_OFFSET_YEAR		6
> > -#define RTC_OFFSET_COUNT	7
> > -
> > -#define RTC_AL_SEC		0x0018
> > -
> > -#define RTC_PDN2		0x002e
> > -#define RTC_PDN2_PWRON_ALARM	BIT(4)
> > -
> > -#define RTC_MIN_YEAR		1968
> > -#define RTC_BASE_YEAR		1900
> > -#define RTC_NUM_YEARS		128
> > -#define RTC_MIN_YEAR_OFFSET	(RTC_MIN_YEAR - RTC_BASE_YEAR)
> > -
> > -#define MTK_RTC_POLL_DELAY_US	10
> > -#define MTK_RTC_POLL_TIMEOUT	(jiffies_to_usecs(HZ))
> > -
> > -struct mt6397_rtc {
> > -	struct device		*dev;
> > -	struct rtc_device	*rtc_dev;
> > -	struct mutex		lock;
> > -	struct regmap		*regmap;
> > -	int			irq;
> > -	u32			addr_base;
> > -};
> > +#include <linux/rtc/mt6397.h>
> >  
> >  static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
> >  {
> > diff --git a/include/linux/rtc/mt6397.h b/include/linux/rtc/mt6397.h
> > new file mode 100644
> > index 0000000..4b19f51
> > --- /dev/null
> > +++ b/include/linux/rtc/mt6397.h
> > @@ -0,0 +1,72 @@
> > +
> 
> Unnecessary empty line
> 

will remove the unnecessary empty line

> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2014-2018 MediaTek Inc.
> > + *
> > + * Author: Tianping.Fang <tianping.fang@mediatek.com>
> > + *	   Sean Wang <sean.wang@mediatek.com>
> > + */
> > +
> > +#ifndef _LINUX_RTC_MT6397_H_
> > +#define _LINUX_RTC_MT6397_H_
> > +
> > +#include <linux/jiffies.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +#include <linux/rtc.h>
> > +
> > +#define RTC_BBPU		0x0000
> > +#define RTC_BBPU_CBUSY		BIT(6)
> > +
> > +#define RTC_WRTGR		0x003c
> > +
> > +#define RTC_IRQ_STA		0x0002
> > +#define RTC_IRQ_STA_AL		BIT(0)
> > +#define RTC_IRQ_STA_LP		BIT(3)
> > +
> > +#define RTC_IRQ_EN		0x0004
> > +#define RTC_IRQ_EN_AL		BIT(0)
> > +#define RTC_IRQ_EN_ONESHOT	BIT(2)
> > +#define RTC_IRQ_EN_LP		BIT(3)
> > +#define RTC_IRQ_EN_ONESHOT_AL	(RTC_IRQ_EN_ONESHOT | RTC_IRQ_EN_AL)
> > +
> > +#define RTC_AL_MASK		0x0008
> > +#define RTC_AL_MASK_DOW		BIT(4)
> > +
> > +#define RTC_TC_SEC		0x000a
> > +/* Min, Hour, Dom... register offset to RTC_TC_SEC */
> > +#define RTC_OFFSET_SEC		0
> > +#define RTC_OFFSET_MIN		1
> > +#define RTC_OFFSET_HOUR		2
> > +#define RTC_OFFSET_DOM		3
> > +#define RTC_OFFSET_DOW		4
> > +#define RTC_OFFSET_MTH		5
> > +#define RTC_OFFSET_YEAR		6
> > +#define RTC_OFFSET_COUNT	7
> > +
> > +#define RTC_AL_SEC		0x0018
> > +
> > +#define RTC_PDN2		0x002e
> > +#define RTC_PDN2_PWRON_ALARM	BIT(4)
> > +
> > +#define RTC_MIN_YEAR		1968
> > +#define RTC_BASE_YEAR		1900
> > +#define RTC_NUM_YEARS		128
> > +#define RTC_MIN_YEAR_OFFSET	(RTC_MIN_YEAR - RTC_BASE_YEAR)
> > +
> > +#define MTK_RTC_POLL_DELAY_US	10
> > +#define MTK_RTC_POLL_TIMEOUT	(jiffies_to_usecs(HZ))
> > +
> > +struct mt6397_rtc {
> > +	struct device		*dev;
> > +	struct rtc_device	*rtc_dev;
> > +
> > +	/* protect registers accessing */
> > +	struct mutex		lock;
> > +	struct regmap		*regmap;
> > +	int			irq;
> > +	u32			addr_base;
> > +};
> > +
> > +#endif /* _LINUX_RTC_MT6397_H_ */
> > +
> > -- 
> > 2.7.4
> > 
> 
