Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2CCC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E502081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v2vnuLT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E502081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbeLDSFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:05:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbeLDSFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:05:54 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D93412081C;
        Tue,  4 Dec 2018 18:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543946754;
        bh=PQiKGFsJSbL6IEbVPDQ3kwiBnxFpeVrgeLrDOF+efH4=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=v2vnuLT5uX9+CIdaG8hAV7DBlRbca4WUw2P0yAOmfKj9QydhuwSBacT4xXPk59jkr
         CtMsOJyRRC11f5p3l86pBLbiGkKtrDhyWENrOMQQwDvZFWbBs0+cS7ovqMV1A7PLCz
         AQ9nxY3FUPKx9eEl77NJBPIpEjhtIy7QTjLIzwoY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181204163257.32085-1-jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20181204163257.32085-1-jbrunet@baylibre.com>
Message-ID: <154394675320.88331.12449582989130694425@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] Revert "clk: fix __clk_init_parent() for single parent clocks"
Date:   Tue, 04 Dec 2018 10:05:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2018-12-04 08:32:57)
> This reverts commit 2430a94d1e719b7b4af2a65b781a4c036eb22e64.
> =

> From the original commit message:
>   It turned out a problem because there are some single-parent clocks
>   that implement .get_parent() callback and return non-zero index.
>   The SOCFPGA clock is the case; the commit broke the SOCFPGA boards.
> =

> It is wrong for a clock to return an index >=3D num_parents. CCF checks
> for this condition in clk_core_get_parent_by_index(). This function sets
> the parent to NULL if index is incoherent, which seems like the only
> sane choice.
> =

> commit 2430a94d1e71 ("clk: fix __clk_init_parent() for single parent cloc=
ks")
> appears to be a work around installed in the core framework for a problem
> that is platform specific, and should probably be fixed in the platform c=
ode.

Ouch. I see that I even pointed that out in 2016 but never got a reply
or a fix patch[1].

> =

> Further more, it introduces a problem in a corner case of the mux clock.
> Take mux with multiple parents, but only one is known, the rest being
> undocumented. The register reset has one of unknown parent set.
> =

> Before commit 2430a94d1e71 ("clk: fix __clk_init_parent() for single pare=
nt clocks"):
>  * get_parent() is called, register is read and give an unknown index.
>    -> the mux is orphaned.
>  * a call to set_rate() will reparent the mux to the only known parent.
> =

> With commit 2430a94d1e71 ("clk: fix __clk_init_parent() for single parent=
 clocks"):
>  * the register is never read.
>  * parent is wrongly assumed to be the only known one.
>    As a consequence, all the calculation deriving from the mux will be
>    wrong
>  * Since we believe the only know parent to be set, set_parent() won't
>    ever be called and the register won't be set with the correct value.

Isn't this the broken bad case all over again? Why register a clk as a
mux and then only say it has one parent?

> =

> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Is this related to the other patch you sent? Can you send series for
related patches please?

[1] https://lkml.kernel.org/r/20160209181833.GA24167@codeaurora.org
