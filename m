Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1803C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E1B2170A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E1B2170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbeHCJZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:25:31 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:19943 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727618AbeHCJZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:25:31 -0400
X-UUID: 2bca46ecebeb46879409772701a836a5-20180803
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1646128690; Fri, 03 Aug 2018 15:30:14 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 3 Aug 2018 15:30:12 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 3 Aug 2018 15:30:12 +0800
Message-ID: <1533281412.31144.23.camel@mtksdaap41>
Subject: Re: [PATCH v1 06/15] drm/mediatek: add memory mode for RDMA
From:   CK Hu <ck.hu@mediatek.com>
To:     Stu Hsieh <stu.hsieh@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Fri, 3 Aug 2018 15:30:12 +0800
In-Reply-To: <1533209786.11190.60.camel@mtksdccf07>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
         <1532420235-22268-7-git-send-email-stu.hsieh@mediatek.com>
         <1532486454.9280.12.camel@mtksdaap41>
         <1533209786.11190.60.camel@mtksdccf07>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stu:

On Thu, 2018-08-02 at 19:36 +0800, Stu Hsieh wrote:
> Hi, CK:
> 
> On Wed, 2018-07-25 at 10:40 +0800, CK Hu wrote:
> > Hi, Stu:
> > 
> > On Tue, 2018-07-24 at 16:17 +0800, Stu Hsieh wrote:
> > > This patch add memory mode for RDMA
> > > 
> > > If use RDMA to read data from memory, it should set memory mode to RDMA
> > > 
> > > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 16 +++++++++++++++-
> > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > > 
> > 
> > [...]
> > 
> > >  static inline struct mtk_disp_rdma *comp_to_rdma(struct mtk_ddp_comp *comp)
> > > @@ -111,7 +116,8 @@ static void mtk_rdma_start(struct mtk_ddp_comp *comp)
> > >  
> > >  static void mtk_rdma_stop(struct mtk_ddp_comp *comp)
> > >  {
> > > -	rdma_update_bits(comp, DISP_REG_RDMA_GLOBAL_CON, RDMA_ENGINE_EN, 0);
> > > +	writel(RDMA_SOFT_RESET, comp->regs + DISP_REG_RDMA_GLOBAL_CON);
> > > +	writel(0, comp->regs + DISP_REG_RDMA_GLOBAL_CON);
> > 
> > Without reset, what happen to dram mode? Why direct link mode need not
> > this reset?
> > 
> 
> There is nothing to happen, I would remove it.
> 
> > >  }
> > >  
> > >  static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
> > > @@ -121,10 +127,18 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
> > >  	unsigned int threshold;
> > >  	unsigned int reg;
> > >  	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
> > > +	bool *rdma_memory_mode = comp->comp_mode;
> > >  
> > >  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xfff, width);
> > >  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_1, 0xfffff, height);
> > >  
> > > +	if (*rdma_memory_mode == true) {
> > > +		rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xff0000,
> > > +				 MATRIX_INT_MTX_SEL_DEFAULT);
> > > +		rdma_update_bits(comp, DISP_REG_RDMA_GLOBAL_CON,
> > > +				 RDMA_MODE_MEMORY, RDMA_MODE_MEMORY);
> > > +	}
> > > +
> > 
> > I would like this to be a kind of 'layer' config. In some SoC, one layer
> > of OVL could switch to direct link input or dram input. So I think it's
> > better to move this setting into some layer interface.
> > 
> > Regards,
> > CK
> > 
> 
> If move it to layer_config, RDMA would not trigger interrupt.
> In the future, when cmdq patch upstream and accepted, this part can move
> to layer_config. 

I don't know why interrupt would be influenced by moving this to layer
config? In mtk_crtc_ddp_hw_init(), call mtk_ddp_comp_config() first and
then call mtk_ddp_comp_layer_config() later. It's in almost the same
place.

Regards,
CK

> 
> Regard,
> Stu
> 
> > >  	/*
> > >  	 * Enable FIFO underflow since DSI and DPI can't be blocked.
> > >  	 * Keep the FIFO pseudo size reset default of 8 KiB. Set the
> > 
> > 
> 
> 


