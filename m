Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E55EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CB2218FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbeL2Csw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 21:48:52 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:15131 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727815AbeL2Csv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 21:48:51 -0500
X-UUID: 82db1c0ec9f14e29a3abd3678ac361f7-20181229
X-UUID: 82db1c0ec9f14e29a3abd3678ac361f7-20181229
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1276222270; Sat, 29 Dec 2018 10:48:42 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 29 Dec
 2018 10:48:40 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 29 Dec 2018 10:48:40 +0800
Message-ID: <1546051720.32173.139.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: devio: update max count of DPs per interval for
 ISOC
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Sat, 29 Dec 2018 10:48:40 +0800
In-Reply-To: <20181228105148.GA22073@kroah.com>
References: <1545992864-9530-1-git-send-email-chunfeng.yun@mediatek.com>
         <20181228105148.GA22073@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, 2018-12-28 at 11:51 +0100, Greg Kroah-Hartman wrote:
> On Fri, Dec 28, 2018 at 06:27:44PM +0800, Chunfeng Yun wrote:
> > The host shall be able to accept and send up to 96 DPs for
> > devices operating at Gen 2 speed.
> 
> Why?  What is this keeping from working properly today?

The failure happened when I tried to send up to 96DPs per an interval
for SSP ISOC transations by libusb, this is used to verify SSP ISOC
function of USB3 GEN2 controller. Maybe for normal scenarios they
needn't transfer greater than 48 DPs in an ISOC interval.
(refer usb3.1r1.0 section 8.12.6 Isochronous Transactions)
> 
> I need a much better changelog text here in order to be able to accept
> this patch.
I'll make the change in next version
> 
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  drivers/usb/core/devio.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> > index a75bc0b8a50f..82c16210e34c 100644
> > --- a/drivers/usb/core/devio.c
> > +++ b/drivers/usb/core/devio.c
> > @@ -1564,12 +1564,10 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
> >  		}
> >  		for (totlen = u = 0; u < number_of_packets; u++) {
> >  			/*
> > -			 * arbitrary limit need for USB 3.0
> > -			 * bMaxBurst (0~15 allowed, 1~16 packets)
> > -			 * bmAttributes (bit 1:0, mult 0~2, 1~3 packets)
> > -			 * sizemax: 1024 * 16 * 3 = 49152
> > +			 * arbitrary limit need for USB 3.1 Gen2
> > +			 * sizemax: 96 DPs at SSP, 96 * 1024 = 98304
> >  			 */
> > -			if (isopkt[u].length > 49152) {
> > +			if (isopkt[u].length > 98304) {
> 
> Are we going to have to keep bumping this up as speeds get faster and
> faster?
Or remove the check of data length? I'm not sure which way is better

> 
> thanks,
> 
> greg k-h


