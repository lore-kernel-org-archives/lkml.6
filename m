Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47889C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E182083B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549481003;
	bh=t4pXXUM8i1eMc+Ukhb5rLWTOVP8ef3Qps1Xp4FjUkcI=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=p0RZ0WCJasW09fIPtuzqCjxiDBIrBe41dbYYd1iP/BoKIIP82hNlQprXQvjmNnHji
	 U30i4fHlQIVfyhdnGkLS5dvk8n5f5xp7SjJ+9q/Qqv+2Tw2vxnfhgtb24S4rrEDMmt
	 6yW6p5jAFeNObAxNn5r1TNgkPXIKRLrNF1BOJ+bQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfBFTXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:23:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfBFTXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:23:20 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1FCB2083B;
        Wed,  6 Feb 2019 19:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549481000;
        bh=t4pXXUM8i1eMc+Ukhb5rLWTOVP8ef3Qps1Xp4FjUkcI=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=s8VsjekO8OdbCumOSMTaKarNsen3xOt12QTYT3u8RYQLjOgnejUWq2wxBJhAac6Ij
         PfpuKDEOSCbct/od+bGdKveWvBRgV3arMReqkFz2NatVbBzZFpUrUVmGFcbHD9ACId
         pVv2m3wIfwsP2K/UeKmZ+ybhQaMtSoiJdGYE8TIQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Yizhuo <yzhai003@ucr.edu>
In-Reply-To: <20190127051012.5928-1-yzhai003@ucr.edu>
User-Agent: alot/0.8
Subject: Re: [PATCH] clk: gemini: Variable "val" in function gemini_clk_probe() could be uninitialized
Message-ID: <154948099918.115909.13787183177670759883@swboyd.mtv.corp.google.com>
References: <20190127051012.5928-1-yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 06 Feb 2019 11:23:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yizhuo (2019-01-26 21:10:12)
> In function gemini_clk_probe(), local variable "val" could
> be uninitialized if function regmap_read() returns -EINVAL.
> However, it will be used as index in the later context, which
> could potentially be unsafe.

Ok. How did you find this? Any pointers?

>=20
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/clk/clk-gemini.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

There are other locations in this file where 'val' is used even if
regmap_read() fails. For example gemini_pci_recalc_rate() does this. Can
you fix all the callers in this file? Presumably nobody cares that this
API could fail in this driver because it's a thin wrapper around mmio
read that never fails. Maybe we could have a comment instead that this
is the case and then ignore this patch entirely.

