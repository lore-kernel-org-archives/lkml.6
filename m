Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6980C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C49218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387798AbeLVD5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 22:57:18 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:46287 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728705AbeLVD5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 22:57:18 -0500
X-UUID: 2d2635b84153470c99e8e05dbddebae5-20181222
X-UUID: 2d2635b84153470c99e8e05dbddebae5-20181222
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 420443479; Sat, 22 Dec 2018 11:57:13 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs03n2.mediatek.inc
 (172.21.101.182) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 22 Dec
 2018 11:57:10 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 22 Dec 2018 11:57:09 +0800
Message-ID: <1545451029.29587.88.camel@mhfsdcap03>
Subject: Re: [PATCH v4 03/18] memory: mtk-smi: Use a general config_port
 interface
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>
Date:   Sat, 22 Dec 2018 11:57:09 +0800
In-Reply-To: <aa91ceb7-673b-7022-d718-f9f61d4b2f23@gmail.com>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
         <1544258371-4600-4-git-send-email-yong.wu@mediatek.com>
         <aa91ceb7-673b-7022-d718-f9f61d4b2f23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: AB02C084B20EE4BCA50763E1D82E09562B22C2F6AEDB29FB3F7D7D8289E858D62000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-21 at 18:47 +0100, Matthias Brugger wrote:
> 
> On 08/12/2018 09:39, Yong Wu wrote:
> > The config_port of mt2712 and mt8183 are the same. Use a general
> > config_port interface instead.
> > 
> > In addition, in mt2712, larb8 and larb9 are the bdpsys larbs which
> > are not the normal larb, their register space are different from the
> > normal one. thus, we can not call the general config_port. In mt8183,
> > IPU0/1 and CCU connect with smi-common directly, they also are not
> > the normal larb. Hence, we add a "larb_special_mask" for these special
> > larbs.
> > 
> > This is also a preparing patch for adding mt8183 SMI support.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/memory/mtk-smi.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index 8f2d152..3b9ad0e 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -53,6 +53,7 @@ struct mtk_smi_larb_gen {
> >  	bool need_larbid;
> >  	int port_in_larb[MTK_LARB_NR_MAX + 1];
> >  	void (*config_port)(struct device *);
> > +	unsigned int larb_special_mask; /* The special larbs mask. */
> 
> I'm not really happy with the name larb_special_mask but I can't think of
> anything else. The comment is not needed as it just rewords the name of the
> variable.

Thanks this comment. then I reword more detail instead this common
"special", How about "larb_to_common_directly_mask"?

> 
> Other then that (or even without changing anything):
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Thanks.

> 
> >  };
> >  
> >  struct mtk_smi {
> > @@ -176,17 +177,13 @@ void mtk_smi_larb_put(struct device *larbdev)
> >  	return -ENODEV;
> >  }
> >  
> > -static void mtk_smi_larb_config_port_mt2712(struct device *dev)
> > +static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
> >  {
> >  	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> >  	u32 reg;
> >  	int i;
> >  
> > -	/*
> > -	 * larb 8/9 is the bdpsys larb, the iommu_en is enabled defaultly.
> > -	 * Don't need to set it again.
> > -	 */
> > -	if (larb->larbid == 8 || larb->larbid == 9)
> > +	if (BIT(larb->larbid) & larb->larb_gen->larb_special_mask)
> >  		return;
> >  
> >  	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
> > @@ -261,7 +258,8 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
> >  
> >  static const struct mtk_smi_larb_gen mtk_smi_larb_mt2712 = {
> >  	.need_larbid = true,
> > -	.config_port = mtk_smi_larb_config_port_mt2712,
> > +	.config_port       = mtk_smi_larb_config_port_gen2_general,
> > +	.larb_special_mask = BIT(8) | BIT(9),          /* bdpsys */
> >  };
> >  
> >  static const struct of_device_id mtk_smi_larb_of_ids[] = {
> > 


