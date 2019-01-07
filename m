Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FA7C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A2F2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546894592;
	bh=dvhf/8ktZNja+Dd7pfhSXqGIJZ2othMcMh326Q6CcQs=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=IOUB6M4j+/sfVkYsdNaNXYqQjBSF4SbEhqG9cup224hKkypOv44NfF4P3gzQMmGrn
	 PdAVaXnfJhGM8kwb79Glb335CM5EuY1NIjzAPGAaap37G54zl2nKyeVMd4egQc2hNh
	 /EzbMyU8UFMw6MJQ5lDP2qT8NqmvD9p8u1RY1CgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfAGU4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:56:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfAGU4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:56:31 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65D9E2087F;
        Mon,  7 Jan 2019 20:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546894590;
        bh=dvhf/8ktZNja+Dd7pfhSXqGIJZ2othMcMh326Q6CcQs=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=edwqp2HWsU/W1IZmP0hXEnSBBCxjscDaBdvevUomDokC2AXFYKiOUAJyK9iNelLJU
         jG3pqeifpvF4BOpY+nu4QGCCpfnmsZOWzS/e7bfbjr7XcnMjtiEREjQdNGIVjr0wbX
         FKM+I6sOLYxWvG61llhMvf9l9U5kotgb9oHIxdmQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/3] Mark clocks as critical for MT6797
Cc:     jasu@njomotys.info, sean.wang@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
To:     Kevin-CW Chen <kevin-cw.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        matthias.bgg@kernel.org, mturquette@baylibre.com
In-Reply-To: <8e8b9c0f-7647-daa4-504b-7b86bcd45a04@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20181116180901.17737-1-matthias.bgg@kernel.org> <154356044342.88331.13729809794593193239@swboyd.mtv.corp.google.com> <8e8b9c0f-7647-daa4-504b-7b86bcd45a04@gmail.com>
Message-ID: <154689458947.15366.14390825810412394676@swboyd.mtv.corp.google.com>
Date:   Mon, 07 Jan 2019 12:56:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Brugger (2018-11-30 01:04:02)
>=20
>=20
> On 30/11/2018 07:47, Stephen Boyd wrote:
> > Quoting matthias.bgg@kernel.org (2018-11-16 10:08:58)
> >> From: Matthias Brugger <mbrugger@suse.com>
> >>
> >> Jasper send this series some month ago. As there was no reaction from
> >> his side, I'll do a friendly take-over.
> >> I tested the patches on my Helios X20 boards and they fix the issue.
> >> I didn't add a Tested-by tag as I added my Signed-off-by.
> >>
> >> Changes since v1:
> >> - add a fixes tag.
> >>
> >> ---
> >>
> >> Currently, DRAM-related clocks and the axi_sel MUX are not marked with
> >> CLK_IS_CRITICAL for MT6797. This causes memory corruption when the
> >> system is booted without clk_ignore_unused.
> >>
> >> This patchset
> >>
> >> 1. Makes it possible to mark outputs of MUXes as critical by introduci=
ng
> >>    a new macro, MUX_FLAGS,
> >> 2. Makes it possible to mark gates as critical by adding flags to
> >>    mtk_gate, and
> >> 3. Marks axi_sel, ddrphycfg_sel, infra_dramc_f26m and infra_dramc_b_f2=
6m
> >>    as critical.
> >>
> >> The addition of flags to mtk_gate also exists in the patch series "Add
> >> basic and clock support for Mediatek MT8183 SoC" [1].  The type of
> >> flags is unsigned int in that series, but the real type is unsigned
> >> long, so my patch differs from that patch.
> >=20
> > Will anyone from Mediatek review this? Why aren't the people who signed
> > off on drivers/clk/mediatek/clk-mt6797.c included on this patch series?
> > They no longer work there?
> >=20
>=20
> My fault, I'll resend 3/3 with the comments you made. Added Kevin-CW now.=
..

I never saw anything on the list. Did I miss anything? I have the first
two patches in my local queue still but I never merged it to clk-next
because nobody replied or resent anything. Please resend the whole
series because I've lost track of what's going on now. Sorry.

