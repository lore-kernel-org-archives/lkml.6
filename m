Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DADC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D199420811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D199420811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeLMJOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:14:04 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:42795 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727095AbeLMJOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:14:04 -0500
X-UUID: c80aa5f96e3445abb442e1da0c70cc33-20181213
X-UUID: c80aa5f96e3445abb442e1da0c70cc33-20181213
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1045786807; Thu, 13 Dec 2018 17:14:01 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 17:13:50 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 17:13:50 +0800
Message-ID: <1544692429.11699.31.camel@mhfsdcap03>
Subject: Re: [PATCH 2/5] i2c: mediatek: remove useless code and replace
 definitions
From:   Qii Wang <qii.wang@mediatek.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <ryder.lee@mediatek.com>
Date:   Thu, 13 Dec 2018 17:13:49 +0800
In-Reply-To: <20181211202058.cd4wyz4so66iqspt@ninjato>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
         <1543843974-4054-3-git-send-email-qii.wang@mediatek.com>
         <20181211202058.cd4wyz4so66iqspt@ninjato>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-11 at 21:20 +0100, Wolfram Sang wrote:
> On Mon, Dec 03, 2018 at 09:32:51PM +0800, qii.wang@mediatek.com wrote:
> > From: qii wang <qii.wang@mediatek.com>
> > 
> > Completion_done is useless when we don't use its return value,
> > so we remove it. Different speeds have been defined by macros,
> > so we use macros definitions.
> 
> Those are two seperate patches, or?
> 

These two changes are relatively small, but it seems better to be
divided into two seperate patches.

> > 
> > Signed-off-by: qii wang <qii.wang@mediatek.com>
> > ---
> >  drivers/i2c/busses/i2c-mt65xx.c |    6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> > index a74ef76..660de1e 100644
> > --- a/drivers/i2c/busses/i2c-mt65xx.c
> > +++ b/drivers/i2c/busses/i2c-mt65xx.c
> > @@ -456,7 +456,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
> >  
> >  	control_reg = readw(i2c->base + OFFSET_CONTROL) &
> >  			~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
> > -	if ((i2c->speed_hz > 400000) || (left_num >= 1))
> > +	if ((i2c->speed_hz > MAX_FS_MODE_SPEED) || (left_num >= 1))
> >  		control_reg |= I2C_CONTROL_RS;
> >  
> >  	if (i2c->op == I2C_MASTER_WRRD)
> > @@ -465,7 +465,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
> >  	writew(control_reg, i2c->base + OFFSET_CONTROL);
> >  
> >  	/* set start condition */
> > -	if (i2c->speed_hz <= 100000)
> > +	if (i2c->speed_hz <= I2C_DEFAULT_SPEED)
> >  		writew(I2C_ST_START_CON, i2c->base + OFFSET_EXT_CONF);
> >  	else
> >  		writew(I2C_FS_START_CON, i2c->base + OFFSET_EXT_CONF);
> > @@ -642,8 +642,6 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
> >  		return -ETIMEDOUT;
> >  	}
> >  
> > -	completion_done(&i2c->msg_complete);
> > -
> >  	if (i2c->irq_stat & (I2C_HS_NACKERR | I2C_ACKERR)) {
> >  		dev_dbg(i2c->dev, "addr: %x, transfer ACK error\n", msgs->addr);
> >  		mtk_i2c_init_hw(i2c);
> > -- 
> > 1.7.9.5
> > 


