Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8DDC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DF32148D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W8Guo2Fn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DF32148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeJQHgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:36:22 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34542 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbeJQHgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:36:21 -0400
Received: by mail-ua1-f66.google.com with SMTP id k4so4076547uao.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFcRdt04RpB+VehUbvDFJ90UxlQzQWDTHC1WwHYUXxs=;
        b=W8Guo2Fnm3TkODJs+14L3dsR3F+pRAxaxqOkJIpMQ58Dc+gxFvEt4eY0yLr+XEbMmo
         Uz2IbQ5Su+VzM8V9UcuSncwJNLbI59aliE34PMeyGsCtszlPBHUmfWtB5zeVWKdpgtRk
         4Jh55IzzqBg7tkl7eyWAqpPyHqVgXwNMuB0VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFcRdt04RpB+VehUbvDFJ90UxlQzQWDTHC1WwHYUXxs=;
        b=uJ25jVvQX95zSu5gg7Vy085GdD/fAnIPvFxvjmYaiFQguAOqqfkjLFpAUTSHl2kVn6
         Tji9QxwkQ1mdL5Ac1CE5yXoli3JmLytdLLqHLQHQax6kvBGltSj8/oFUg/3l8VAVTl1d
         BfuL8YsznrwAFRY22IsF4TPjPKc4dFYJWrOjNWuQnrl20x5EsiNan6O3wW9P5WoUI3E0
         RpjKca1eI9BTzSz8LTTOjblgScTUEpLOTVBLOf5C1KLsR4gW5SSnqBN8DMPlNjfgz21w
         U4FzkZb1JP0vC9/lcAahlCxmyPfjTHEny7EXEVIXiexVgaCpv7n68cDDndEEsoyWfr7b
         d8Yw==
X-Gm-Message-State: ABuFfoiTuuNPLb+pBgfEfv+csLYz16dDMIi5b+fUTOFd6FXglVPCzfLg
        RWI6hy05gDg4LZsnOoXq1V4AyP6KECE=
X-Google-Smtp-Source: ACcGV62VYGWoRRghqiqG42kZh71lxD3x86Dpk1hnDQmsJnzPvTDcJmUxFh77jjm3KmqNbhu/UqdCHQ==
X-Received: by 2002:ab0:20af:: with SMTP id y15mr10477075ual.110.1539733414088;
        Tue, 16 Oct 2018 16:43:34 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1sm1279904vsd.30.2018.10.16.16.43.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 16:43:32 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id c10so4072036uao.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:43:32 -0700 (PDT)
X-Received: by 2002:ab0:7291:: with SMTP id w17mr10587021uao.115.1539733412269;
 Tue, 16 Oct 2018 16:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181013005504.46399-1-briannorris@chromium.org>
In-Reply-To: <20181013005504.46399-1-briannorris@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 16 Oct 2018 16:43:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UmvnsueUbDTa-vSp5Ay+8Zo0YORW8T7u1AwreUbZA4+Q@mail.gmail.com>
Message-ID: <CAD=FV=UmvnsueUbDTa-vSp5Ay+8Zo0YORW8T7u1AwreUbZA4+Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] ath10k: snoc: remove 'wcn3990' from generic resource handling
To:     Brian Norris <briannorris@chromium.org>
Cc:     kvalo@qca.qualcomm.com, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 12, 2018 at 5:55 PM Brian Norris <briannorris@chromium.org> wrote:
>
> ath10k_wcn3990_clk_info and ath10k_wcn3990_vreg_info are not
> WCN3990-specific structures. They hold generic data. So don't name them
> with wcn3990 specifics.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/net/wireless/ath/ath10k/snoc.c | 34 +++++++++++++-------------
>  drivers/net/wireless/ath/ath10k/snoc.h |  8 +++---
>  2 files changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index 8d3d9bca410f..c6254db17dab 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -46,14 +46,14 @@ static char *const ce_name[] = {
>         "WLAN_CE_11",
>  };
>
> -static struct ath10k_wcn3990_vreg_info vreg_cfg[] = {
> +static struct ath10k_vreg_info vreg_cfg[] = {

Ironically, you could sorta make the argument that this should be:

static struct ath10k_vreg_info wcn3990_vreg_cfg

AKA the "wcn3990" shouldn't be in the name of the structure (since all
snoc devices can have the concept of an array of regulators) but
wcn3990 could be in the name of the variable since it's possible that
different snoc devices could have different arrays.  However I'm OK w/
waiting to do that part until we actually see a different snoc device
with a different array.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
