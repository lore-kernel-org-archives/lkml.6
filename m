Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379BEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B672075B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mVf9JcYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B672075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbeKTFQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:16:16 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43836 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbeKTFQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:16:16 -0500
Received: by mail-lf1-f67.google.com with SMTP id u18so22083301lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 10:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p5nvnt9YOHjU8DKdM7lIvB2Bnl0P4nCiWCSifm5Rmto=;
        b=mVf9JcYI3xt7GYhNRw1JpIKOo6IaIwSzBgRnke4+bGaq6OQcKBvgQGISjTyg2XocJE
         O3a3ZdKU42hrC0sq2IZYGjrf8geyAGMbfi3bzJTQEGYSpIJ7sd/7PNyeAPQvJNG5a5wP
         ons6kWZm8BN78nhJUqu63ASYfzWcpWm2dOFo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p5nvnt9YOHjU8DKdM7lIvB2Bnl0P4nCiWCSifm5Rmto=;
        b=rybjWOMxtOjM2fV0G9L9i15Ulf4Uxb55XsFquqjATmgnXMX2pakrK0AwX6R1TUWyOe
         c5SnFe8t58wH+kriv+6y+xr3jSYPiwxC3YJ9wHvZ1zdDU3cGzQkBcyC/jCHdorwJ2ppF
         RtPkWTcZFeXzhkgrJgtAOXNSWjzv9CzWo94aBfk8QPugeGNZPDeXew3GvNd3PqC/YJN4
         qldP1aHFujcO0pzz30AewehKR66mjLS6e4D/l67LFaEymimNyVPrF+15HU3Dt9HkCJsk
         SLUs7orgel/EDaHR4mqx/FSAloMAnaMhmE7PACQkucKHcUVtLp8rk20FK02ig5p+4zeS
         XPFQ==
X-Gm-Message-State: AGRZ1gI+oWCPiJVmdvyuhXHugP8jlIaa6f7O26kmDySU2EoP+STg6LFk
        hdXgQaj7VMnnXeljRKptIXw/JQ+1WAs=
X-Google-Smtp-Source: AJdET5fdXo1JJqwvOmsmZW8xKkunxsgtF9tzKipeq+JPrsIoINlLbtPxoB448AldArZmtGxOjq2Htg==
X-Received: by 2002:a19:f89:: with SMTP id 9mr11083973lfp.10.1542653483297;
        Mon, 19 Nov 2018 10:51:23 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id l21-v6sm5755352ljj.48.2018.11.19.10.51.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 10:51:21 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id k19-v6so27047661lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 10:51:20 -0800 (PST)
X-Received: by 2002:a2e:12c1:: with SMTP id 62-v6mr13587692ljs.74.1542653480334;
 Mon, 19 Nov 2018 10:51:20 -0800 (PST)
MIME-Version: 1.0
References: <1542005537-19154-1-git-send-email-vbadigan@codeaurora.org> <1542005537-19154-3-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1542005537-19154-3-git-send-email-vbadigan@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 19 Nov 2018 10:50:43 -0800
X-Gmail-Original-Message-ID: <CAE=gft7EFFEawCe02KOkB9T_fMPBfQTXEk-cddEQdDnVOQ+Yyg@mail.gmail.com>
Message-ID: <CAE=gft7EFFEawCe02KOkB9T_fMPBfQTXEk-cddEQdDnVOQ+Yyg@mail.gmail.com>
Subject: Re: [PATCH V5 2/2] mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically
To:     vbadigan@codeaurora.org
Cc:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, Doug Anderson <dianders@google.com>,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayali <sayalil@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 10:53 PM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> On few SDHCI-MSM controllers, the host controller's clock tuning
> circuit may go out of sync if controller clocks are gated which
> eventually will result in data CRC, command CRC/timeout errors.
> To overcome this h/w limitation, the DLL needs to be re-initialized
> and restored with its old settings once clocks are ungated.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
