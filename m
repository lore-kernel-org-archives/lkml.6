Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B225C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB161218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbeLVD6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 22:58:13 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:25528 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728705AbeLVD6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 22:58:13 -0500
X-UUID: 759698c5dc7e4985bab8cdde5e727758-20181222
X-UUID: 759698c5dc7e4985bab8cdde5e727758-20181222
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 784888556; Sat, 22 Dec 2018 11:58:06 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 22 Dec
 2018 11:58:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 22 Dec 2018 11:58:03 +0800
Message-ID: <1545451083.29587.91.camel@mhfsdcap03>
Subject: Re: [PATCH v4 10/18] iommu/mediatek: Add mt8183 IOMMU support
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
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Date:   Sat, 22 Dec 2018 11:58:03 +0800
In-Reply-To: <07f6276d-e7b5-ef82-9c38-1fa0af0cd9f3@gmail.com>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
         <1544258371-4600-11-git-send-email-yong.wu@mediatek.com>
         <07f6276d-e7b5-ef82-9c38-1fa0af0cd9f3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-21 at 19:31 +0100, Matthias Brugger wrote:
> 
> On 08/12/2018 09:39, Yong Wu wrote:
> > The M4U IP blocks in mt8183 is MediaTek's generation2 M4U which use
> > the ARM Short-descriptor like mt8173, and most of the HW registers
> > are the same.
> > 
> > Here list main differences between mt8183 and mt8173/mt2712:
> > 1) mt8183 has only one M4U HW like mt8173 while mt2712 has two.
> > 2) mt8183 don't have the "bclk" clock, it use the EMI clock instead.
> > 3) mt8183 can support the dram over 4GB, but it doesn't call this "4GB
> > mode".
> > 4) mt8183 pgtable base register(0x0) extend bit[1:0] which represent
> > the bit[33:32] in the physical address of the pgtable base, But the
> > standard ttbr0[1] means the S bit which is enabled defaultly, Hence,
> > we add a mask.
> > 5) mt8183 HW has a GALS modules, SMI should enable "has_gals" support.
> > 6) the larb-id in smi-common is remapped. M4U should enable
> > larbid_remapped support.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
[...]
> > +static const struct mtk_iommu_plat_data mt8183_data = {
> > +	.m4u_plat            = M4U_MT8183,
> > +	.larbid_remap_enable = true,
> > +	.larbid_remapped     = {0, 4, 5, 6, 7, 2, 3, 1},
> 
> Aren't we reinventing the wheel here?
> Why can't we use larb-id to get the correct id insteaf of providing another data
> structure for the remapping?

Sorry, The remapping id is arbitrary, there is no rule to get it from
the larb-id.

From Nicolas's comment, I plan to delete "larbid_remap_enable" and only
use "larbid_remap". The other SoCs use the linear mapping here.

In addition, I have to apologize that here will may be improved for
mt2712. There are 2 smi-common(smi-common0 and smi-common1) in mt2712,
actually the remapping relationship for smi-common1 is also different.
If it is really needed, I plan to change it from "larbid_remap" to
"larbid_remap[2]" which 0 is for smi-common0 and 1 is for smi-common1.
Of course, it doesn't affect the iommu functions and only prints the
error log when IOMMU translation fault.

> 
> Regards,
> Matthias

[...]


