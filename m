Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AED9C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B4B2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P/TCebjH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TUzP/gYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbfARWEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:04:24 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35860 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbfARWEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:04:23 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A597A60851; Fri, 18 Jan 2019 22:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547849062;
        bh=BOgPAZwW8IKRhRcPizoEbMnDotDEOB+or5QwhH4AQhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/TCebjHEhMnrOD0Tmo2fhScPNLmYxTxz5+AIrI5Z8nWasaDXiL5jJIv7piUXU+JA
         IjNln3eCiQiFbOgYhwn36nVBT0Ws2IMzSLH0Ngu3aCGS3cV0okbfjWZg8PtpkWFu1o
         Pj4/D1+f2IQxe1510FxCgasoN/w9AMRDRIP2RGIQ=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AAB226053B;
        Fri, 18 Jan 2019 22:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547849061;
        bh=BOgPAZwW8IKRhRcPizoEbMnDotDEOB+or5QwhH4AQhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TUzP/gYj16/g5/ygA8K1PVDdjDRMdgTaWcgxXKAJvvez6TiLa6qC2XlQMa+3qivlG
         WxnqgqKbkK39Q4gyuwDudVDWAFWCBTLl0kogR/Ueq6MHQ/H7Ts20i4YNohaPG4ao8U
         6GFgoWTilXFFNidagV8H9xqZUezJRnnACIA+cLOc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AAB226053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Fri, 18 Jan 2019 15:04:17 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Evan Green <evgreen@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Gross <andy.gross@linaro.org>,
        Colin Ian King <colin.king@canonical.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Freedreno] [PATCH v6] drm/msm/a6xx: Add support for an
 interconnect path
Message-ID: <20190118220417.GE4140@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Doug Anderson <dianders@chromium.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Evan Green <evgreen@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>, David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Andy Gross <andy.gross@linaro.org>,
        Colin Ian King <colin.king@canonical.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1547843058-27933-1-git-send-email-jcrouse@codeaurora.org>
 <CAD=FV=XBBk31zqgJMqcTeNLoEWxLzow=LxQ=2geJAaf6Cpui_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=XBBk31zqgJMqcTeNLoEWxLzow=LxQ=2geJAaf6Cpui_Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 01:52:20PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jan 18, 2019 at 12:24 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > Try to get the interconnect path for the GPU and vote for the maximum
> > bandwidth to support all frequencies. This is needed for performance.
> > Later we will want to scale the bandwidth based on the frequency to
> > also optimize for power but that will require some device tree
> > infrastructure that does not yet exist.
> >
> > v6: use icc_set_bw() instead of icc_set()
> > v5: Remove hardcoded interconnect name and just use the default
> > v4: Don't use a port string at all to skip the need for names in the DT
> > v3: Use macros and change port string per Georgi Djakov
> >
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >
> >  drivers/gpu/drm/msm/Kconfig             |  1 +
> >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
> >  drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
> >  4 files changed, 33 insertions(+)
> 
> Presumably this should go in together with the bindings:
> 
> - https://patchwork.kernel.org/patch/10739233/
> - https://lkml.kernel.org/r/20181220173026.3857-3-jcrouse@codeaurora.org
> 
> ...since bindings and code usually go in the same tree together.
> 
> 
> As per discussion in v3 AKA v5
> <https://patchwork.kernel.org/patch/10739231/>, we're trying to figure
> out where to land this.  ;-)
 
I'm just a simple caveman driver developer. I'll let the adults figure
out where to put what. LMK if you need a rebase on a different tree.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
