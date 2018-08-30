Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC44C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B962120666
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B962120666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeH3FLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:11:49 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:59091 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725758AbeH3FLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:11:48 -0400
X-UUID: 0e8012c5956c490cbedcd30423c0eaac-20180830
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1920903367; Thu, 30 Aug 2018 09:12:05 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Thu, 30 Aug
 2018 09:12:03 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 30 Aug 2018 09:12:03 +0800
Message-ID: <1535591523.32173.32.camel@mhfsdcap03>
Subject: Re: [PATCH v2] usb: core: phy: fix return value checking about
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
Date:   Thu, 30 Aug 2018 09:12:03 +0800
In-Reply-To: <20180829083050.GG28861@localhost>
References: <8263a8d0f87d595dd35efa5432d294d9f7b38719.1535507412.git.chunfeng.yun@mediatek.com>
         <20180829083050.GG28861@localhost>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-29 at 10:30 +0200, Johan Hovold wrote:
> On Wed, Aug 29, 2018 at 10:10:48AM +0800, Chunfeng Yun wrote:
> > Use IS_ERR() instead of IS_ERR_OR_NULL() because devm_of_phy_get_by_index()
> > never return NULL value;
> > But still need ignore the error of -ENODEV, for more information, please
> > refer to:
> > [0] https://lkml.org/lkml/2018/4/19/88
> > [1] https://patchwork.kernel.org/patch/10160181/
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > V2: keep the -ENODEV check
> > ---
> >  drivers/usb/core/phy.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> > index 9879767..e3cc743 100644
> > --- a/drivers/usb/core/phy.c
> > +++ b/drivers/usb/core/phy.c
> > @@ -23,14 +23,11 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
> >  				   struct list_head *list)
> >  {
> >  	struct usb_phy_roothub *roothub_entry;
> > -	struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> > +	struct phy *phy;
> >  
> > -	if (IS_ERR_OR_NULL(phy)) {
> > -		if (!phy || PTR_ERR(phy) == -ENODEV)
> > -			return 0;
> > -		else
> > -			return PTR_ERR(phy);
> > -	}
> > +	phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> > +	if (IS_ERR(phy))
> > +		return (PTR_ERR(phy) == -ENODEV) ? 0 : PTR_ERR(phy);
> 
> I prefer not to use the terse ternary operator in general, and
> especially so in this case where we are doing something unexpected (i.e.
> we want to highlight that the -ENODEV case is special).
> 
> So please keep the current construct, and just replace IS_ERR_OR_NULL
> and drop the !phy test.
> 
> I think separating the declaration and (non-trivial) initialisation of
> phy here is a good thing that can remain in the patch, even if it's
> arguable separate change.
> 
Ok, thanks
> >  
> >  	roothub_entry = devm_kzalloc(dev, sizeof(*roothub_entry), GFP_KERNEL);
> >  	if (!roothub_entry)
> 
> Thanks,
> Johan


