Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861CAC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5615820870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5615820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeLMCY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:24:26 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:8081 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726344AbeLMCYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:24:25 -0500
X-UUID: 1ca81a550d4744f9a545eadbf4d575d7-20181213
X-UUID: 1ca81a550d4744f9a545eadbf4d575d7-20181213
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1136412764; Thu, 13 Dec 2018 10:24:17 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 10:24:15 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 10:24:15 +0800
Message-ID: <1544667855.8755.7.camel@mhfsdcap03>
Subject: Re: [PATCH] iommu/io-pgtable-arm-v7s: Don't check PHYS_OFFSET if
 RAMDOMIZE_BASE is enabled
From:   Yong Wu <yong.wu@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <youlin.pei@mediatek.com>,
        "Nicolas Boichat" <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>, "CK Hu" <ck.hu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Stephen Boyd" <swboyd@chromium.org>
Date:   Thu, 13 Dec 2018 10:24:15 +0800
In-Reply-To: <50292758-47b1-1d08-5827-f7bdb3c33e1c@arm.com>
References: <1544619737-6313-1-git-send-email-yong.wu@mediatek.com>
         <50292758-47b1-1d08-5827-f7bdb3c33e1c@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-12 at 13:39 +0000, Robin Murphy wrote:
> On 12/12/2018 13:02, Yong Wu wrote:
> > If CONFIG_RANDOMIZE_BASE is enabled, the "memstart_addr" will be updated
> > randomly, then the PHYS_OFFSET may be random.
> 
> Oh, I hadn't ever realised that, good catch. However, since 29859aeb8a6e 
> I think we should probably just remove this check altogether.

Thanks the hint. It looks that I only need revert 82db33dc5e49.

> 
> > Fixes: 82db33dc5e49 ("iommu/io-pgtable-arm: Check for v7s-incapable
> > systems")
> 
> Note that this alone wouldn't be sufficient for stable prior to 4.18, 
> since CONFIG_RANDOMIZE_BASE would then allow the original crash to 
> happen again.

Yes. the problem always exist. Nicolas is fixing this. I will delete the
tag here.

> 
> Robin.
> 
> > Reported-by: CK Hu <ck.hu@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> > index 445c3bd..70941e6 100644
> > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > @@ -709,7 +709,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
> >   {
> >   	struct arm_v7s_io_pgtable *data;
> >   
> > -#ifdef PHYS_OFFSET
> > +#if defined(PHYS_OFFSET) && !defined(CONFIG_RANDOMIZE_BASE)
> >   	if (upper_32_bits(PHYS_OFFSET))
> >   		return NULL;
> >   #endif
> > 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


