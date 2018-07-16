Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FF7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0F72086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0F72086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeGPEBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:01:10 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:43774 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725731AbeGPEBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:01:10 -0400
X-UUID: 20b70eb3f52b4c9f8b91b7793b9c0053-20180716
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 290203197; Mon, 16 Jul 2018 11:35:39 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Mon, 16 Jul
 2018 11:35:37 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 16 Jul 2018 11:35:34 +0800
Message-ID: <1531712134.31406.1.camel@mhfsdcap03>
Subject: Re: [PATCH v3 0/4] PCI: mediatek: fixup find_port, enable_msi and
 add pm, module support
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>
CC:     <marc.zyngier@arm.com>, <bhelgaas@google.com>,
        <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>
Date:   Mon, 16 Jul 2018 11:35:34 +0800
In-Reply-To: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
References: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bjorn, Lorenzo,

could you kindly take a look at this serial?

thanks.

On Mon, 2018-07-02 at 15:57 +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> This patchset includes misc patchs:
> 
> The first patch fixup the mtk_pcie_find_port logical which will cause system
> could not touch the EP's configuration space which was connected to PCIe slot 1.
> 
> The second patch fixup the enable msi logical, the operation to enable msi
> should be after system clock is enabled. The function of mtk_pcie_startup_port_v2's
> define location is re-arranged to avoid mtk_pcie_enable_msi's forward declaration.
> And call mtk_pcie_enable_msi in mtk_pcie_startup_port_v2 since the clock was all
> enabled at that time.
> 
> The third patch was rebased and refactor of the v4 patch[1], changes are:
>  -Add PM support for MT7622.
>  -Using mtk_pcie_enable_port to re-establish the link when resumed.
>  -Rebase on the previous two patches.
> 
> The fourth patch add loadable kernel module support.
> 
> Some of those patches was already reviewed-by Ryder Lee <ryder.lee@mediatek.com>,
> so I just add the Reviewed-by tags in those patches.
> 
> [1] https://patchwork.kernel.org/patch/10479079
> 
> Change since v2:
>  - Fix the list_for_each_entry_safe parameter error.
>  - Add Ryder's Acked-by flag.
> 
> Change since v1:
>  - A bit of code refact of the first patch suggested by Andy Shevchenko, and
>    commit message updated.
>  - Using __maybe_unused.
>  - Remove the redundant list_empty check of the fourth patch.
> 
> Honghui Zhang (4):
>   PCI: mediatek: fixup mtk_pcie_find_port logical
>   PCI: mediatek: enable msi after clock enabled
>   PCI: mediatek: Add system pm support for MT2712 and MT7622
>   PCI: mediatek: Add loadable kernel module support
> 
>  drivers/pci/controller/Kconfig         |   2 +-
>  drivers/pci/controller/pcie-mediatek.c | 289 ++++++++++++++++++++++++---------
>  2 files changed, 213 insertions(+), 78 deletions(-)
> 


