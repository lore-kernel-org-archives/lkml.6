Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6496FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1E820660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfANG5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 01:57:40 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:29528 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726067AbfANG5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 01:57:40 -0500
X-UUID: f7039342ff9e44c0935e6fc2e4188c5a-20190114
X-UUID: f7039342ff9e44c0935e6fc2e4188c5a-20190114
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 470450526; Mon, 14 Jan 2019 14:57:30 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 14 Jan
 2019 14:57:28 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 14 Jan 2019 14:57:28 +0800
Message-ID: <1547449048.24830.15.camel@mhfsdcap03>
Subject: Re: [PATCH v5 12/20] memory: mtk-smi: Add gals support
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <youlin.pei@mediatek.com>,
        "Nicolas Boichat" <drinkcat@chromium.org>
Date:   Mon, 14 Jan 2019 14:57:28 +0800
In-Reply-To: <1546314952-15990-13-git-send-email-yong.wu@mediatek.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
         <1546314952-15990-13-git-send-email-yong.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

   Gentle ping about this and the other mtk-smi part in this patchset.

   The memory part don't have its specific maintainer, normally we need
SoC maintain's help. Thus, For this file(memory/mtk-smi.c), your review
is needed before Joerg accept it.

    Appreciate in advance.

On Tue, 2019-01-01 at 11:55 +0800, Yong Wu wrote:
> In some SoCs like mt8183, SMI add GALS(Global Async Local Sync) module
> which can help synchronize for the modules in different clock frequency.
> It can be seen as a "asynchronous fifo". This is a example diagram:
> 
>             M4U
>              |
>          ----------
>          |        |
>      gals0-rx   gals1-rx
>          |        |
>          |        |
>      gals0-tx   gals1-tx
>          |        |
>         ------------
>          SMI Common
>         ------------
>              |
>   +-----+--------+-----+- ...
>   |     |        |     |
>   |  gals-rx  gals-rx  |
>   |     |        |     |
>   |     |        |     |
>   |  gals-tx  gals-tx  |
>   |     |        |     |
> larb1 larb2   larb3  larb4
> 
> GALS only help transfer the command/data while it doesn't have the
> configuring register, thus it has the special "smi" clock and doesn't
> have the "apb" clock. From the diagram above, we add "gals0" and
> "gals1" clocks for smi-common and add a "gals" clock for smi-larb.
> 
> This patch adds gals clock supporting in the SMI. Note that some larbs
> may still don't have the "gals" clock like larb1 and larb4 above.
> 
> This is also a preparing patch for mt8183 which has GALS.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
[...]
  



