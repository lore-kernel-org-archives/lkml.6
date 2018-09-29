Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D749C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FB120838
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FB120838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeI2JG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 05:06:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:14391 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727351AbeI2JG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 05:06:27 -0400
X-UUID: 81804df54d3d4760a6a30d2013de228d-20180929
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 939508365; Sat, 29 Sep 2018 10:39:44 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs08n2.mediatek.inc
 (172.21.101.56) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 29 Sep
 2018 10:39:42 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 29 Sep 2018 10:39:42 +0800
Message-ID: <1538188782.3674.3.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] mmc: mediatek: add bus_clk control
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Sat, 29 Sep 2018 10:39:42 +0800
In-Reply-To: <1538155736.30348.85.camel@mtkswgap22>
References: <1538134855-11198-1-git-send-email-chaotian.jing@mediatek.com>
         <1538134855-11198-3-git-send-email-chaotian.jing@mediatek.com>
         <1538155736.30348.85.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5DEBC6360705079189BE26649977CC817332A1FF0480DC940F89CA98083F59C92000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-09-29 at 01:28 +0800, Sean Wang wrote:
> Hi,
> 
> On Fri, 2018-09-28 at 19:40 +0800, Chaotian Jing wrote:
> > when gate MSDC0_HCLK, access register will hang, even the MSDC driver
> > will never accessing register after HCLK was gated, but for safety, need
> > gate the bus_clk(which used to access register) too.
> > 
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > ---
> >  drivers/mmc/host/mtk-sd.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index 0484138..1c1c967 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -387,6 +387,7 @@ struct msdc_host {
> >  
> >  	struct clk *src_clk;	/* msdc source clock */
> >  	struct clk *h_clk;      /* msdc h_clk */
> > +	struct clk *bus_clk;	/* bus clock which used to access register */
> >  	struct clk *src_clk_cg; /* msdc source clock control gate */
> >  	u32 mclk;		/* mmc subsystem clock frequency */
> >  	u32 src_clk_freq;	/* source clock frequency */
> > @@ -660,12 +661,14 @@ static void msdc_gate_clock(struct msdc_host *host)
> >  {
> >  	clk_disable_unprepare(host->src_clk_cg);
> >  	clk_disable_unprepare(host->src_clk);
> > +	clk_disable_unprepare(host->bus_clk);
> >  	clk_disable_unprepare(host->h_clk);
> >  }
> >  
> >  static void msdc_ungate_clock(struct msdc_host *host)
> >  {
> >  	clk_prepare_enable(host->h_clk);
> > +	clk_prepare_enable(host->bus_clk);
> >  	clk_prepare_enable(host->src_clk);
> >  	clk_prepare_enable(host->src_clk_cg);
> >  	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
> > @@ -1900,6 +1903,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
> >  		goto host_free;
> >  	}
> >  
> > +	host->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
> > +	if (IS_ERR(host->bus_clk))
> > +		host->bus_clk = NULL;
> 
> The implementation would cause all SoCs to treat the bus_clk as the optional.
> It seems you should add a flag to see what SoC requires the bus_clk to successfully access the related registers.

>  Yes, but is no harm to other SoCs, just like the handle of "source_cg"
> >  	/*source clock control gate is optional clock*/
> >  	host->src_clk_cg = devm_clk_get(&pdev->dev, "source_cg");
> >  	if (IS_ERR(host->src_clk_cg))
> 
> 


