Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73F6C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AA121104
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AA121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeKTUvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:51:53 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:9752 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726250AbeKTUvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:51:53 -0500
X-UUID: f617e93033b3491781c07a1ff9cd1b68-20181120
X-UUID: f617e93033b3491781c07a1ff9cd1b68-20181120
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1875717253; Tue, 20 Nov 2018 18:23:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 20 Nov 2018 18:23:23 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 20 Nov 2018 18:23:23 +0800
Message-ID: <1542709403.13494.0.camel@mtksdaap41>
Subject: Re: [PATCH v5 05/12] drm: mediatek: Omit warning on probe defers
From:   CK Hu <ck.hu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <matthias.bgg@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <ulrich.hecht+renesas@gmail.com>,
        <laurent.pinchart@ideasonboard.com>, <sean.wang@mediatek.com>,
        <sean.wang@kernel.org>, <rdunlap@infradead.org>, <wens@csie.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Matthias Brugger <mbrugger@suse.com>
Date:   Tue, 20 Nov 2018 18:23:23 +0800
In-Reply-To: <9a445746-b07d-73e1-68c9-10eb9d5bf771@gmail.com>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
         <20181116125449.23581-6-matthias.bgg@kernel.org>
         <1542605939.32082.12.camel@mtksdaap41>
         <0a02edf9-78da-dde9-4b69-38c4719b711b@gmail.com>
         <1542686700.9073.15.camel@mtksdaap41>
         <9a445746-b07d-73e1-68c9-10eb9d5bf771@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

On Tue, 2018-11-20 at 11:19 +0100, Matthias Brugger wrote:
> 
> On 20/11/2018 05:05, CK Hu wrote:
> > Hi, Matthias:
> > 
> > On Mon, 2018-11-19 at 10:26 +0100, Matthias Brugger wrote:
> >>
> >> On 19/11/2018 06:38, CK Hu wrote:
> >>> Hi, Matthias:
> >>>
> >>> On Fri, 2018-11-16 at 13:54 +0100, matthias.bgg@kernel.org wrote:
> >>>> From: Matthias Brugger <mbrugger@suse.com>
> >>>>
> >>>> It can happen that the mmsys clock drivers aren't probed before the
> >>>> platform driver gets invoked. The platform driver used to print a warning
> >>>> that the driver failed to get the clocks. Omit this error on
> >>>> the defered probe path.
> >>>
> >>> This patch looks good to me, but you have not modified the sub driver in
> >>> HDMI path. We could let HDMI path print the warning and someone send
> >>> another patch later, or you modify for HDMI path in this patch.
> >>
> >> Sure, I'll add this in v6. After inspecting the code, I think we will need to
> >> also check for not initialized clocks in mtk_mdp_comp_init, as the driver for
> >> now does not even check if the clocks are present. What do you think?
> > 
> > Yes, we do really need to consider mdp driver because mmsys clock
> > include mdp clock. You remind me that mmsys control 4 major function:
> > drm routing, drm clock, mdp routing, and mdp clock. Your design let the
> > mmsys device as drm device (control drm routing) and create a sub device
> > as clock device (control drm clock, mdp clock). If one day mdp device
> > (may need control drm routing) need to control the register of mdp
> > routing, would mdp device be a sub device? Or we need not to consider
> > this because it need not to access mmsys register now?
> > 
> 
> I think we should for now concentrate to fix the clock probing issue. If in the
> future we will need to access drm routing from the mdp device, we can have a
> look into this.
> 
> Sounds good?

Sounds good to me.

Regards,
CK

> Regards,
> Matthias


