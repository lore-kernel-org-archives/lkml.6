Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B17C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DC720879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfAJIue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:50:34 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:56657 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727372AbfAJIue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:50:34 -0500
X-UUID: 70060d12bb194ef7b0aeb2f78d44d92e-20190110
X-UUID: 70060d12bb194ef7b0aeb2f78d44d92e-20190110
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1420587663; Thu, 10 Jan 2019 16:50:28 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs03n2.mediatek.inc
 (172.21.101.182) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Jan
 2019 16:50:26 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 10 Jan 2019 16:50:25 +0800
Message-ID: <1547110225.3831.24.camel@mhfsdcap03>
Subject: Re: [PATCH v9 1/2] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
From:   Long Cheng <long.cheng@mediatek.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Nicolas Boichat <drinkcat@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        "YT Shen" <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>
Date:   Thu, 10 Jan 2019 16:50:25 +0800
In-Reply-To: <d60c25c2-efe4-9294-dc7e-98f0333bff76@infradead.org>
References: <1546395178-8880-1-git-send-email-long.cheng@mediatek.com>
         <1546395178-8880-2-git-send-email-long.cheng@mediatek.com>
         <CANMq1KB=yuEJxUdi8M9deDhAv24WZ-4h+26cFq7AzBi8uyd88Q@mail.gmail.com>
         <d60c25c2-efe4-9294-dc7e-98f0333bff76@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: C0E1301CD85C79D6C4D6D9D004E32AB58BE59366EFE59482B05044DE530829012000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-02 at 18:03 -0800, Randy Dunlap wrote:
> Hi,
> 
> While you are making changes, here are a few more:
> 

hi

OK, thanks for your comments.

> 
> On 1/2/19 5:39 PM, Nicolas Boichat wrote:
> > diff --git a/drivers/dma/mediatek/Kconfig b/drivers/dma/mediatek/Kconfig
> > index 27bac0b..1a523c87 100644
> > --- a/drivers/dma/mediatek/Kconfig
> > +++ b/drivers/dma/mediatek/Kconfig
> > @@ -1,4 +1,15 @@
> > 
> > +config DMA_MTK_UART
> > +       tristate "MediaTek SoCs APDMA support for UART"
> > +       depends on OF && SERIAL_8250_MT6577
> > +       select DMA_ENGINE
> > +       select DMA_VIRTUAL_CHANNELS
> > +       help
> > +         Support for the UART DMA engine found on MediaTek MTK SoCs.
> > +         when SERIAL_8250_MT6577 is enabled, and if you want to use DMA,
> 
> 	    When
> 
> > +         you can enable the config. the DMA engine can only be used
> 
> 	                               The
> 
> > +         with MediaTek SoCs.
> > +
> 

above, i will modify.

> Also, use tabs to indent instead of spaces.
> The lines (tristate, depends, select, and help) should be indented with one tab.
> The help text lines should be indented with one tab + 2 spaces.
> 

in my patch, i already do this. So don't need modify.

> >  config MTK_HSDMA
> >         tristate "MediaTek High-Speed DMA controller support"
> >         depends on ARCH_MEDIATEK || COMPILE_TEST
> 
> 
> thanks,


