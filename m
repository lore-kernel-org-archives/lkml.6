Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6633AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA0120839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA0120839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeHaOJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:09:56 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:48913 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727715AbeHaOJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:09:56 -0400
X-UUID: 8d55a4e0bba347489017c9214e9446df-20180831
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1805492628; Fri, 31 Aug 2018 18:03:09 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Fri, 31 Aug
 2018 18:03:07 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 31 Aug 2018 18:03:07 +0800
Message-ID: <1535709787.32173.33.camel@mhfsdcap03>
Subject: Re: [PATCH v3] usb: core: phy: fix return value checking about
 devm_of_phy_get_by_index()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 31 Aug 2018 18:03:07 +0800
In-Reply-To: <20180831094154.GL28861@localhost>
References: <626cea85395e3a1f002ef0a241bb508d770a33c0.1535536218.git.chunfeng.yun@mediatek.com>
         <20180831094154.GL28861@localhost>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 11:41 +0200, Johan Hovold wrote:
> On Thu, Aug 30, 2018 at 09:16:40AM +0800, Chunfeng Yun wrote:
> > Use IS_ERR() instead of IS_ERR_OR_NULL() because devm_of_phy_get_by_index()
> > never return NULL value;
> > But still need ignore the error of -ENODEV, for more information, please
> > refer to:
> > [0] https://lkml.org/lkml/2018/4/19/88
> > [1] https://patchwork.kernel.org/patch/10160181/
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > V3: abandon the ternary operator suggested by Johan
> > 
> > V2: keep the -ENODEV check
> 
> Perhaps the patch Subject is a little misleading as this is more of a
> clean up than a fix (as there's no bug here).
> 
> But apart from that this looks good to me.
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>
Sent a new version, thanks
> 
> > ---
> >  drivers/usb/core/phy.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> > index 9879767..38b2c77 100644
> > --- a/drivers/usb/core/phy.c
> > +++ b/drivers/usb/core/phy.c
> > @@ -23,10 +23,11 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
> >  				   struct list_head *list)
> >  {
> >  	struct usb_phy_roothub *roothub_entry;
> > -	struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> > +	struct phy *phy;
> >  
> > -	if (IS_ERR_OR_NULL(phy)) {
> > -		if (!phy || PTR_ERR(phy) == -ENODEV)
> > +	phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> > +	if (IS_ERR(phy)) {
> > +		if (PTR_ERR(phy) == -ENODEV)
> >  			return 0;
> >  		else
> >  			return PTR_ERR(phy);
> 
> Thanks,
> Johan


