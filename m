Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33D8C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39C920878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FXuyOYZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39C920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeLFXeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:34:24 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39635 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLFXeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:34:24 -0500
Received: by mail-ua1-f65.google.com with SMTP id k10so792393ual.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 15:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MS88ko9gb54lDREVjPnuISfIKtgGb7ByGl5IyXo1bCs=;
        b=FXuyOYZepGKM08hC+NI0MSwL5fg17JhPCefcg/72Lil+g78VeXh55vFkWOCqOEDPai
         t32LbkzJv5wNzy2bllOtMxWAUCUN5ngYVJ7evKr94OAVo+yRSk+BOydXNeoTcSDEhQh1
         jCwT8ltzPl5AcbJ7TYpa/wXfMe/4UQyiE3S7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MS88ko9gb54lDREVjPnuISfIKtgGb7ByGl5IyXo1bCs=;
        b=T8OngVRp7prlv0aqQxWe/dsiE6Fp7o9coLnLsNmkvNBG8U7IT00i2peCX7hcWl5OiZ
         dWEi1pKCDUj03fzwYDvaepr+0HrW3oluTu4qkHqEDg3qTPHxA+DRKXSqlCIsgFUZuVwq
         vysnQhLRRWrEAvj/CuMYrUu6MJpb5vzKFtrxJFTv00W3T0WET9LOe7/G5V8M8DvSEl35
         hgXjADp8I9u4aF6aEi+8yhqwxyPnhQ7FGINDkvNoto7VAMAE9chnQth6PJxLz6K+D8te
         OxdyMLlXBI3tpvzbKrlmisPh913s60Qb1TJ4Zhw+JQoSKTBkKwDXs+gCZRv5bFBwZL3a
         D80Q==
X-Gm-Message-State: AA+aEWZO75hOVJibOH7Frbax1dgljdojsgFqmxioH7wfBSRIBeY7E3AJ
        tSeyhUeVnD0KM5vC+TUmYTfziaOmF98=
X-Google-Smtp-Source: AFSGD/WIJFRRzJ/Xz2EZ4FQ+2ctFCUP5b3zgPa3PE5743jyHRzxNjJR/CzxIk2t2V8oliM5fY72W9w==
X-Received: by 2002:ab0:526:: with SMTP id 35mr14069123uax.25.1544139262768;
        Thu, 06 Dec 2018 15:34:22 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id k199sm589172vka.6.2018.12.06.15.34.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 15:34:22 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id h18so1413743vsj.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 15:34:21 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr13716418vsj.144.1544139261385;
 Thu, 06 Dec 2018 15:34:21 -0800 (PST)
MIME-Version: 1.0
References: <20181206184522.118062-1-evgreen@chromium.org> <20181206184522.118062-2-evgreen@chromium.org>
In-Reply-To: <20181206184522.118062-2-evgreen@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Dec 2018 15:34:07 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XWpLcevH72bchsKauqRpH3FSSKooQ7r6uoEgjN=4k_PQ@mail.gmail.com>
Message-ID: <CAD=FV=XWpLcevH72bchsKauqRpH3FSSKooQ7r6uoEgjN=4k_PQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: sdhci-msm: Clarify register requirements
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Dec 6, 2018 at 10:45 AM Evan Green <evgreen@chromium.org> wrote:
>
> In sdhci-msm-v5 and beyond, the MCI registers are removed, so there is only
> one register region required.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
> Changes in v2: None
>
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You probably should have skipped this patch from v2.  Ulf already
landed it.  It can be found at:

https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=next&id=68fe87ac8a9309bbdc960cbd774725e44ea98b58

-Doug
