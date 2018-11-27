Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B94C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBE12147D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lilBqpoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBE12147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbeK1D4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:56:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731528AbeK1Dyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:54:32 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1292208E4;
        Tue, 27 Nov 2018 16:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543337761;
        bh=wXXHkEn11WdVGIHdRRmx/EiHg/RTSxIkIQJRBWW6Mws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lilBqpoPBA+WnFsDvt0yE//Hw8FaEBN8Q7VtmSYGpbSB1kv3IAPlYMPI3HNubvdSk
         ST2E5CIjhWQ7YuNOp++FFRT5Yp4iYk1wnaKiHVpIz9TVZKueFbcXA9jhtmnrk41n0O
         w9WV8fM37TjJgjiMm5MPEl20yE4FcmNRTg/Z3UOs=
Received: by mail-qk1-f177.google.com with SMTP id o125so15030361qkf.3;
        Tue, 27 Nov 2018 08:56:01 -0800 (PST)
X-Gm-Message-State: AA+aEWa44SMe3WAvRCK0kNSM14h9YBRnIha63OoqknQGK45EWJxIi0Du
        NncWVEWdJrLRnuuHXw1X238s0yaieMm8ANMX/A==
X-Google-Smtp-Source: AFSGD/U2fslTeNtnu5DPbVYapL9aOtkOtmpsXjIkX7hXMHSUQQzzaM2xhfxM+4zTJNCkabGVG0hfQYKidCUXcvw+1M0=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr30794624qkg.147.1543337760919;
 Tue, 27 Nov 2018 08:56:00 -0800 (PST)
MIME-Version: 1.0
References: <20181124140725.28593-1-tiny.windzz@gmail.com>
In-Reply-To: <20181124140725.28593-1-tiny.windzz@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 27 Nov 2018 10:55:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLqcA20HB=3bnwYD-g32h=mG=VR7sWiuVocW=5eKLcLzQ@mail.gmail.com>
Message-ID: <CAL_JsqLqcA20HB=3bnwYD-g32h=mG=VR7sWiuVocW=5eKLcLzQ@mail.gmail.com>
Subject: Re: [PATCH] memory: tegra: Convert to using %pOFn instead of device_node.name
To:     tiny.windzz@gmail.com
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 8:07 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/memory/tegra/mc.c           |  6 +++---
>  drivers/memory/tegra/tegra124-emc.c | 12 ++++++------
>  2 files changed, 9 insertions(+), 9 deletions(-)

Thanks, but I already sent a patch for this and all the others in
drivers/memory/ and have queued it since no one picked it up.

Rob
