Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF766C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E8B2089F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E8B2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeKOMW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 07:22:28 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:63199 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbeKOMW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 07:22:28 -0500
X-UUID: 18d2ffdbec494684a6da295c3f24ece5-20181115
X-UUID: 18d2ffdbec494684a6da295c3f24ece5-20181115
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 138560396; Thu, 15 Nov 2018 10:16:24 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 15 Nov 2018 10:16:16 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 15 Nov 2018 10:16:16 +0800
Message-ID: <1542248176.30611.4.camel@mtkswgap22>
Subject: Re: [resend PATCH 1/3] pwm: mediatek: drop flag 'has_clks'
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     John Crispin <john@phrozen.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-pwm@vger.kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 15 Nov 2018 10:16:16 +0800
In-Reply-To: <2fc9dbac-4919-4ceb-49ac-67ddd7f203b5@phrozen.org>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
         <20181114124752.GI2620@ulmo>
         <2fc9dbac-4919-4ceb-49ac-67ddd7f203b5@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 81364D0BD973C495A397C616D90E803CBAEBF535F8DFF9CCC6EA8C1EF360420C2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-14 at 14:27 +0100, John Crispin wrote:
> On 14/11/2018 13:47, Thierry Reding wrote:
> > On Tue, Nov 13, 2018 at 10:08:22AM +0800, Ryder Lee wrote:
> >> The flag 'has_clks' and related checks are superfluous as the CCF
> >> subsystem does this for you.
> > Both of these mechanisms aren't equivalent. While CCF can deal with
> > optional clocks, what the has_clks flag actually means is that the
> > device doesn't need a clock (or doesn't have a clock input) on the
> > devices where it is cleared.
> >
> > So I'd actually be in favor of keeping the has_clks property because it
> > serves as an additional sanity check. For example if you run this driver
> > on an SoC that "has clocks" but if you don't list them in DT, then after
> > this patch the driver will happily continue without clocks, even though
> > it may break completely without those clocks. I've seen SoCs respond to
> > disabled clocks for a hardware block in different ways, in many cases an
> > access to any of the registers will completely hang the CPU. In other
> > cases it may just crash in some other way or give you some sort of
> > machine exception. None of those are good, and make the tiny bit of
> > additional code required to support the has_clks flag very attractive.
> >
> > But that's just my opinion. If you prefer to throw away that safety
> > barrier, be my guest. But if you do, please move this functionality into
> > the clock framework first and then make the driver use it.
> >
> > Thierry
> 
> Hi,
> 
> sorry for my late response. I added the flag for the legacy MIPS 
> silicon. These SoCs only have a single clock register with a few on/off 
> bits. there is no complex clocktree or scaling. Hence COMMON_CLK is not 
> supported by those SoCs. I fully agree with Thierry, that the flag makes 
> this explicit and the intent was indeed to make sure that on silicon 
> where clocks are required, that they really are listed in OF. This is 
> indeed an extra sanity check and hiding it in an implicit check inside 
> CCF does not feel right.
> 
>      John
> 

Thanks for the detailed information:)  I will drop this patch in v1.

Ryder

