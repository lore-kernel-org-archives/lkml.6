Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4867DC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0B227CCD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0B227CCD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933939AbeF2Jrn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:47:43 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49418 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753471AbeF2Jrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:47:39 -0400
X-UUID: 9a9ae6b1f4834a9eabb3e1b78ce32924-20180629
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 350955493; Fri, 29 Jun 2018 17:47:33 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Fri, 29 Jun
 2018 17:47:31 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 29 Jun 2018 17:47:26 +0800
Message-ID: <1530265646.6245.6.camel@mtkswgap22>
Subject: Re: [PATCH v4 6/7] Bluetooth: mediatek: Add protocol support for
 MediaTek serial devices
From:   Sean Wang <sean.wang@mediatek.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        "Johan Hedberg" <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 29 Jun 2018 17:47:26 +0800
In-Reply-To: <20180628051941.GF629@localhost>
References: <cover.1530004712.git.sean.wang@mediatek.com>
         <48215a1276c36af7ad581c3d83759fe9f55e3c4b.1530004712.git.sean.wang@mediatek.com>
         <CAHp75VehTeyyzR4bPKK3hFDTVqZnhdNy5vcBFJCSH_Zrx+QrKA@mail.gmail.com>
         <CAHp75VedHLw52J_ymh3iYf2w=r8d+Kqg=fJZmBGnaCrEbNEPdQ@mail.gmail.com>
         <1530155173.29697.48.camel@mtkswgap22> <20180628051941.GF629@localhost>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-28 at 07:19 +0200, Johan Hovold wrote:
> On Thu, Jun 28, 2018 at 11:06:13AM +0800, Sean Wang wrote:
> > On Wed, 2018-06-27 at 20:04 +0300, Andy Shevchenko wrote:
> > > On Wed, Jun 27, 2018 at 7:59 PM, Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Wed, Jun 27, 2018 at 8:43 AM,  <sean.wang@mediatek.com> wrote:
> > > >> From: Sean Wang <sean.wang@mediatek.com>
> 
> > > >> +#include <net/bluetooth/bluetooth.h>
> > > >> +#include <net/bluetooth/hci_core.h>
> > > 
> > > >> +       /* Enable the power domain and clock the device requires. */
> > > >> +       pm_runtime_enable(dev);
> > > >> +       err = pm_runtime_get_sync(dev);
> > > >> +       if (err < 0)
> > > >> +               goto err_pm2;
> 
> > > >> +err_pm1:
> > > >> +       pm_runtime_put_sync(dev);
> > > >> +err_pm2:
> > > >> +       pm_runtime_disable(dev);
> 
> Please name error labels after what they do, not using numbers (see
> CodingStyle). Here you could use err_disable_rpm instead of err_pm2, for
> example.
> 
> Also, if you really want to undo pm_runtime_get_sync() failing above,
> you still need a pm_runtime_put_noidle() to balance the usage count.
> 

I'll give a reasonable naming for these labels and add a
pm_runtime_put_noidle() in the path undoing failing
pm_runtime_get_sync().

> > > >> +struct mtk_stp_hdr {
> > > >> +       __u8 prefix;
> > > >> +       __u8 dlen1:4;
> > > >> +       __u8 type:4;
> > > 
> > > >> +       __u8 dlen2:8;
> > > >> +       __u8 cs;
> > > >> +} __packed;
> 
> Perhaps too much context have been lost here, but unless you're sharing
> this struct with user space, you should be using u8 (without __) above
> (and elsewhere).
> 

These struct don't be shard with user space so I will turn __u8 into u8.

Thanks so much for all suggestions. 

> Johan


