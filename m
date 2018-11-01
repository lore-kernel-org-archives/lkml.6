Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F4BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B66620820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ka3MZW/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B66620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeKBCPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:15:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32987 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKBCPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:15:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id z21-v6so18727251ljz.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1bw2yW+h0eGS/RMnaF4u47fsjJQb66zNNoQ/6mxicf8=;
        b=ka3MZW/Fk0SsAl3l/4I9AbcRSXgjR+VGFDmpEcFZ7ZjY4NCGVQxLVIJKsNkvgxfP7m
         ct5CKM8HSf6mshwf+6eQy4mwJhZweqr+yg5CpwSFlVoL/isTObIe07y981ei1P0fJ9+A
         G3yJ0tSI6Tyw7/H5TQsngo4A/2EKSwOq0VwQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1bw2yW+h0eGS/RMnaF4u47fsjJQb66zNNoQ/6mxicf8=;
        b=l1PyaITThEpw/CatRF6lotspNNhud2j9X6eprzCQVVTT6i4AGLg4zpre5iqmN6dKKb
         ctarDiudEzFoNmWrrOdkOa1/VRLy9w/InMPLIw7coZY+k6MPt1bUWNL+CEGwujl66O5+
         Y671ZMjMhMbzcy7OuEandpivJ4fSAuWbygk+kiTned1OB1tJ+nMlmRAkos1Uw1V8Hfc9
         UKpidfOwk5Jf6pMcYcHVKvRHXqKpJH0CO60RkHQTJYfaebXPiK+mcLaDp4MBOtma7PFW
         ArFymWQmpo21bGXVmuHuZWyI4nmKqxoBt1JUaVLGW5DLSI2iPVF6EWHYE36/kZbExHgr
         x/qw==
X-Gm-Message-State: AGRZ1gKdg4H3LM2KpFdw7RR/RdBVctZlMMUJTihxgDwKMuDN7IgZxXt3
        eZCKt8pfQiPbab3oguzYUC29EdTQeac=
X-Google-Smtp-Source: AJdET5ec141XMAepNdgeEtz/R2H66JWVr/BbhBRbSSm1syzPyRsfxK73AP21GIB43CnqwKvoKdY9Yw==
X-Received: by 2002:a2e:6c0c:: with SMTP id h12-v6mr5385430ljc.112.1541092283955;
        Thu, 01 Nov 2018 10:11:23 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id n3-v6sm4773594lfe.8.2018.11.01.10.11.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 10:11:22 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id x85-v6so14511834ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 10:11:21 -0700 (PDT)
X-Received: by 2002:a2e:12c1:: with SMTP id 62-v6mr5955225ljs.74.1541092280983;
 Thu, 01 Nov 2018 10:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <1541073999-11752-1-git-send-email-vbadigan@codeaurora.org> <1541073999-11752-3-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1541073999-11752-3-git-send-email-vbadigan@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 1 Nov 2018 10:10:44 -0700
X-Gmail-Original-Message-ID: <CAE=gft6FiC5mkCDkzdhrOuj2qAfwmPxDJNbekca+EVg5yhLYgg@mail.gmail.com>
Message-ID: <CAE=gft6FiC5mkCDkzdhrOuj2qAfwmPxDJNbekca+EVg5yhLYgg@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically
To:     vbadigan@codeaurora.org
Cc:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, Doug Anderson <dianders@google.com>,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayali <sayalil@codeaurora.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 5:08 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> On few SDHCI-MSM controllers, the host controller's clock tuning
> circuit may go out of sync if controller clocks are gated which
> eventually will result in data CRC, command CRC/timeout errors.
> To overcome this h/w limitation, the DLL needs to be re-initialized
> and restored with its old settings once clocks are ungated.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 59 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c

Reviewed-by: Evan Green <evgreen@chromium.org>
