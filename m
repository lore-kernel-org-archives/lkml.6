Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C341CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 01:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAF220672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 01:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DAF220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439286AbeKWMNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 07:13:38 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:53259 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733028AbeKWMNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 07:13:38 -0500
X-UUID: 5af2764ce1754de1b782693054180be0-20181123
X-UUID: 5af2764ce1754de1b782693054180be0-20181123
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 980203538; Fri, 23 Nov 2018 09:31:21 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 23 Nov
 2018 09:31:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 23 Nov 2018 09:31:18 +0800
Message-ID: <1542936676.24219.66.camel@mhfsdcap03>
Subject: Re: [v5, PATCH 2/2] dt-binding: mediatek-dwmac: add binding
 document for MediaTek MT2712 DWMAC
From:   biao huang <biao.huang@mediatek.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <honghui.zhang@mediatek.com>, <yt.shen@mediatek.com>,
        <liguo.zhang@mediatek.com>, <mark.rutland@arm.com>,
        <nelson.chang@mediatek.com>, <matthias.bgg@gmail.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <joabreu@synopsys.com>
Date:   Fri, 23 Nov 2018 09:31:16 +0800
In-Reply-To: <20181122151932.GD15403@lunn.ch>
References: <1542882521-18874-1-git-send-email-biao.huang@mediatek.com>
         <1542882521-18874-3-git-send-email-biao.huang@mediatek.com>
         <20181122151932.GD15403@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andrew,

	Thanks for you remind.

	Sincerely, I respect any comment from any reviewer. If I didn't reply
for any comment, really sorry for that.

	As to this "tx-delay" issue, the following reply in v3 maybe ignored.
	https://lkml.org/lkml/2018/11/19/158

	"the delay time in mediatek dwmac design is not so accurate,
	the current mt2712 and the following ICs will not use the
	same delay design, but will use stages to indicate different
	delay time.
	so maybe "mediatek.tx-delay" represent the delay stage is a
	good choice"

	And to make it clearer here.

	In mt2712, there are two delay macro circuit: named fine-tune and
coarse-tune.
	a. fine-tune, 170+/-50ps per stage, total 32 stages
	b. coarse-tune, 0.55+/-0.2ns per stage, total 32 stages
	If we only consider mt2712, delay in fine-tune select a integer
multiple of 170ps, delay in coarse-tune select a integer multiple of
550ps, for stage 0~31, the delay in fine-tune will not have the same
value with that in coarse-tune.
	OK, It seems the property "fine-tune" can be eliminated .

	But the following ic will not have the same accuracy as mt2712,
and maybe will not have two delay macro circuit to be selected.
	1. assume two delay macro circuit in the following ic,
	fine-tune, 100ps per stage, coarse-tune, 0.55ns per stage,
	if we want delay 2.2ns, fine-tune will get a 22, and coarse-tune get a
4. We can't distinguish which delay macro we are choosing.
	2. assume only one delay macro circuit is used, a similar case as 1
will also increase the complexity of driver.
	Then, we need define more flag property to know which delay macro we
are handling.

	The common things for all delay macro circuit in MediaTek mac design is
the stages, not the accuracy. so if we maintain stage info in "mediatek,
tx-delay", we only need care which stage we should choose.
And for each IC, we will recommend a best stage as a candidate.

	Above is my personal opinion, may be my understanding is wrong,
welcome for further discussion.

	Thanks a lot.

On Thu, 2018-11-22 at 16:19 +0100, Andrew Lunn wrote:
> On Thu, Nov 22, 2018 at 06:28:41PM +0800, Biao Huang wrote:
> > The commit adds the device tree binding documentation for the MediaTek DWMAC
> > found on MediaTek MT2712.
> > 
> > Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> 
> > +Optional properties:
> > +- mediatek,tx-delay: TX clock delay macro value. Range is 0~31. Default is 0.
> > +	It should be defined for rgmii/rgmii-rxid/mii interface.
> > +- mediatek,rx-delay: RX clock delay macro value. Range is 0~31. Default is 0.
> > +	It should be defined for rgmii/rgmii-txid/mii/rmii interface.
> 
> You have received the same feedback at least twice now, from two
> different maintainers, that the delay should be specified in pS, and
> the driver should figure out what values to place into registers.
> 
> You should not ignore feedback like that. If you don't understand the
> feedback, please ask us to explain it. If you don't agree with the
> feedback, you need to argue why you think it is wrong, or why what you
> are doing is better, etc.
> 
> We are here to help, but just ignoring us won't get you anywhere.
> 
> For the moment:
> 
> NACK
> 
> 	Andrew


