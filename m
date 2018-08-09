Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BCCC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E94F21CF7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E94F21CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbeHILh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:37:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43178 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727371AbeHILh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:37:28 -0400
X-UUID: cf8ff1d5ed8242559352abdb832aaf96-20180809
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1545081374; Thu, 09 Aug 2018 17:13:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 9 Aug 2018 17:13:20 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 9 Aug 2018 17:13:20 +0800
Message-ID: <1533806000.3347.6.camel@mtksdaap41>
Subject: Re: [PATCH v2 2/3] i2c: Add helper to ease DMA handling
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Jun Gao <jun.gao@mediatek.com>, <devicetree@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 9 Aug 2018 17:13:20 +0800
In-Reply-To: <20180808205752.llowh4bvu2wkuhga@ninjato>
References: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
         <1530955795-17714-3-git-send-email-jun.gao@mediatek.com>
         <20180808205752.llowh4bvu2wkuhga@ninjato>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-08 at 22:57 +0200, Wolfram Sang wrote:
> On Sat, Jul 07, 2018 at 05:29:54PM +0800, Jun Gao wrote:
> > From: Jun Gao <jun.gao@mediatek.com>
> > 
> > This function is needed by i2c_get_dma_safe_msg_buf() potentially.
> > It is used to free DMA safe buffer when DMA operation fails.
> > 
> > Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> 
> Right, we need something like this. This leaks in the sh_mobile driver,
> too :(
> 
> I am still thinking if there is a nice way to put this functionality
> into i2c_release_dma_safe_msg_buf() itself somehow...

Wolfram,

I have second thought on these API now. Recently, we have saw similar
issue for spi device driver.

I believe the reason for these api is because some arch changed to can
not do DMA on stack recently. Maybe we should have dma_mapping to bounce
buffer like it bounce un-dma-able address for those arch? or we should
have a common driver API for this, not just for i2c?

Joe.C


