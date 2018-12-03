Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC8CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2D02081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2D02081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbeLCIlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:41:05 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:6499 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725872AbeLCIlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:41:04 -0500
X-UUID: da55362b01fa484f8601ad5104561662-20181203
X-UUID: da55362b01fa484f8601ad5104561662-20181203
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1700383168; Mon, 03 Dec 2018 16:40:53 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 3 Dec
 2018 16:40:51 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Dec 2018 16:40:51 +0800
Message-ID: <1543826451.23023.35.camel@mhfsdcap03>
Subject: Re: [PATCH v3 13/15] memory: mtk-smi: Get rid of need_larbid
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>, <youlin.pei@mediatek.com>,
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>, <arnd@arndb.de>,
        <srv_heupstream@mediatek.com>, Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        <yingjoe.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>, <YT.shen@mediatek.com>
Date:   Mon, 3 Dec 2018 16:40:51 +0800
In-Reply-To: <21767ceb-1db5-045f-06ac-29c57f1a74a5@gmail.com>
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
         <1542422142-30688-14-git-send-email-yong.wu@mediatek.com>
         <21767ceb-1db5-045f-06ac-29c57f1a74a5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-03 at 00:04 +0100, Matthias Brugger wrote:
> 
> On 17/11/2018 03:35, Yong Wu wrote:
> > The "mediatek,larb-id" has already been parsed in MTK IOMMU driver.
> > It's no need to parse it again in SMI driver. Only clean some codes.
> > This patch is fit for all the current mt2701, mt2712, mt7623, mt8173
> > and mt8183.
> 
> I'm trying to understand why we need the mediatek,larb-id at all. From what I
> understand as long as the mediatek larbs described in the iommu are ordered
> (larb0, larb1, larb2, etc) we actually get the same value as defined by
> mediatek,larb-id. At least this holds for all present implementations.
> 
> On the other hand I don't see where the mtk_iommu_v1 driver actually parses the
> larb-id, can you please help to understand:
> 
> 1) why we need the larb-id at all

Actually only mt2712 which have 2 M4U HW need "mediatek,larb-id".

This is larbs in the m4u0/1 dtsi node of mt2712:
m4u0 { mediatek,larbs = <&larb0 &larb1 &larb2 &larb3 &larb6>;}
m4u1 { mediatek,larbs = <&larb4 &larb5 &larb7>;}

the id don't increase one by one, M4U have to get the larbid with the
help of "mediatek,larb-id".

(The m4u/smi dtsi patch of mt2712 will be send with some other modules,
maybe in this week.)


> 2) how this will work if we do not parse the larb-id for v1 iommu at all

As you said above and I also have wrote that the larbid "must sort
according to the local arbiter index" in the "mediatek,larbs"
description of dt-binding. All the M4U except mt2712 could ignore
"mediatek,larb-id". the v1 iommu also should be ok.

I'm not sure whether we should change [1], if only reserving mt2712
there, we also should change the dtsi file of mt2701 and mt7623.or keep
it as is.

[1]
https://elixir.bootlin.com/linux/v4.20-rc1/source/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt#L20

> 
> Thanks a lot,
> Matthias
> 
> > 

[snip]


