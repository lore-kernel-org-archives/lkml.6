Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A24C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7180B2070C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfAHDFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:05:12 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:30987 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727145AbfAHDFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:05:12 -0500
X-UUID: 50a7ace050f14fb9947e4246a2243e1b-20190108
X-UUID: 50a7ace050f14fb9947e4246a2243e1b-20190108
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2117629010; Tue, 08 Jan 2019 11:05:05 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 8 Jan 2019 11:05:04 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 8 Jan 2019 11:05:04 +0800
Message-ID: <1546916704.4994.3.camel@mtkswgap22>
Subject: Re: [PATCH v2 0/3] Mark clocks as critical for MT6797
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Kevin-CW Chen <kevin-cw.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <matthias.bgg@kernel.org>, <mturquette@baylibre.com>,
        Matthias Brugger <mbrugger@suse.com>, <sean.wang@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <jasu@njomotys.info>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 8 Jan 2019 11:05:04 +0800
In-Reply-To: <154689458947.15366.14390825810412394676@swboyd.mtv.corp.google.com>
References: <20181116180901.17737-1-matthias.bgg@kernel.org>
         <154356044342.88331.13729809794593193239@swboyd.mtv.corp.google.com>
         <8e8b9c0f-7647-daa4-504b-7b86bcd45a04@gmail.com>
         <154689458947.15366.14390825810412394676@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: EEC90C1E2BC24CAD9F1D04DCAE853DD2CC27D9F55A8D1640A3E6C066578E56382000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen/Matthias

On Mon, 2019-01-07 at 12:56 -0800, Stephen Boyd wrote:
> Quoting Matthias Brugger (2018-11-30 01:04:02)
> > 
> > 
> > On 30/11/2018 07:47, Stephen Boyd wrote:
> > > Quoting matthias.bgg@kernel.org (2018-11-16 10:08:58)
> > >> From: Matthias Brugger <mbrugger@suse.com>
> > >>
> > >> Jasper send this series some month ago. As there was no reaction from
> > >> his side, I'll do a friendly take-over.
> > >> I tested the patches on my Helios X20 boards and they fix the issue.
> > >> I didn't add a Tested-by tag as I added my Signed-off-by.
> > >>
> > >> Changes since v1:
> > >> - add a fixes tag.
> > >>
> > >> ---
> > >>
> > >> Currently, DRAM-related clocks and the axi_sel MUX are not marked with
> > >> CLK_IS_CRITICAL for MT6797. This causes memory corruption when the
> > >> system is booted without clk_ignore_unused.
> > >>
> > >> This patchset
> > >>
> > >> 1. Makes it possible to mark outputs of MUXes as critical by introducing
> > >>    a new macro, MUX_FLAGS,
> > >> 2. Makes it possible to mark gates as critical by adding flags to
> > >>    mtk_gate, and
> > >> 3. Marks axi_sel, ddrphycfg_sel, infra_dramc_f26m and infra_dramc_b_f26m
> > >>    as critical.
> > >>
> > >> The addition of flags to mtk_gate also exists in the patch series "Add
> > >> basic and clock support for Mediatek MT8183 SoC" [1].  The type of
> > >> flags is unsigned int in that series, but the real type is unsigned
> > >> long, so my patch differs from that patch.
> > > 
> > > Will anyone from Mediatek review this? Why aren't the people who signed
> > > off on drivers/clk/mediatek/clk-mt6797.c included on this patch series?
> > > They no longer work there?
> > > 
> > 
> > My fault, I'll resend 3/3 with the comments you made. Added Kevin-CW now...
> 
> I never saw anything on the list. Did I miss anything? I have the first
> two patches in my local queue still but I never merged it to clk-next
> because nobody replied or resent anything. Please resend the whole
> series because I've lost track of what's going on now. Sorry.
> 
> 

sorry for late response. Kelvin-CW and I are responsible for 6797
clk.You have my Ack:
Acked-by: Mars Cheng <mars.cheng@mediatek.com>

Thanks.
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


