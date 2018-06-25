Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B75C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B250F254D8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B250F254D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeFYGm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 02:42:29 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:59995 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751094AbeFYGm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 02:42:27 -0400
X-UUID: 7633760f091a4a9cb37b0bcb902794e0-20180625
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1459433964; Mon, 25 Jun 2018 14:37:03 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Mon, 25 Jun
 2018 14:37:02 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 25 Jun 2018 14:37:01 +0800
Message-ID: <1529908621.32173.27.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] usb: core: phy: fix return value checking about
 devm_of_phy_get_by_index()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <johan@kernel.org>, <gregkh@linuxfoundation.org>,
        <felipe.balbi@linux.intel.com>, <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 25 Jun 2018 14:37:01 +0800
In-Reply-To: <CAFBinCBS+fpfx6jaaqD=kqFuMF6ko8GikbV1ZVwgbDh-Sn8T8w@mail.gmail.com>
References: <4c338a129ab14ab41949da5e3c21aed0d77dff8d.1529647619.git.chunfeng.yun@mediatek.com>
         <644d00edd2932c1a0d0a1bf368dd25427d1d9f64.1529647619.git.chunfeng.yun@mediatek.com>
         <CAFBinCBS+fpfx6jaaqD=kqFuMF6ko8GikbV1ZVwgbDh-Sn8T8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-06-24 at 20:00 +0200, Martin Blumenstingl wrote:
> Hello Chunfeng,
> 
> thank you for the patch!
> 
> On Fri, Jun 22, 2018 at 8:33 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> >
> > 1. use IS_ERR() but not IS_ERR_OR_NULL() because devm_of_phy_get_by_index()
> >     never return NULL value;
> ACK - good catch!
> 
> > 2. devm_of_phy_get_by_index() should not fail for a valid index
> I have learned that the PHY framework can return -ENODEV if the PHY is:
> 1. supposed to be handled by the legacy USB PHY framework
> 2. the PHY node is disabled in devicetree
A little confused, we can avoid this error by not using a disabled or
"usb-nop-xceiv" phy in host node.

If ignore error of -ENODEV, we will also skip an error case which we
don't want it happen. 

> 
> see [0] for the code in the PHY framework and [1] for the discussion
> with Johan (who informed me of case #1, I added him on this mail)
> 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  drivers/usb/core/phy.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> > index 9879767..0f972e1 100644
> > --- a/drivers/usb/core/phy.c
> > +++ b/drivers/usb/core/phy.c
> > @@ -23,14 +23,11 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
> >                                    struct list_head *list)
> >  {
> >         struct usb_phy_roothub *roothub_entry;
> > -       struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> > +       struct phy *phy;
> >
> > -       if (IS_ERR_OR_NULL(phy)) {
> > -               if (!phy || PTR_ERR(phy) == -ENODEV)
> > -                       return 0;
> > -               else
> > -                       return PTR_ERR(phy);
> > -       }
> > +       phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> > +       if (IS_ERR(phy))
> > +               return PTR_ERR(phy);
> @Johan can you please review this as well? maybe we need to keep the
> -ENODEV check
> 
> 
> Regards
> Martin
> 
> 
> [0] https://elixir.bootlin.com/linux/v4.18-rc2/source/drivers/phy/phy-core.c#L421
> [1] https://lkml.org/lkml/2018/4/19/88


