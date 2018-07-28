Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE45C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 10:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B40A20862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 10:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhLbgQSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B40A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbeG1Ljr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 07:39:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45503 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbeG1Ljq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 07:39:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id j143-v6so5124972lfj.12;
        Sat, 28 Jul 2018 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vd8jWosoxlzrilW5j1C5mrPIKeenluDpN4wB4nkorKw=;
        b=qhLbgQSHk5IKijXrqDPsp+UPJT30nhuGaYerGyFBOKh5BxU9IUqIkO5AXH9/TtCRks
         xuoTKFhc97duKOQstsnaKcY5TJt1W78YEonyAmbYveU2H9yUjOVfxtFkIAVRGGLZY01N
         C3z3ibew81eAWnVFNWX+w/uRBBbZdKgUnddGhLJVq6+l1dtFZrwXxtZ+DHqwoyP22e78
         cd/dC0Q1YT06gxbSEPr/bVv2DJr14iiSF9YiInGTbbdrMgN0y+SxWAHgT0GAjZhjeQ7e
         g8/hNbMaKDEw1IuQ2KU5vJHApU1C1BRlVrBvs0w3GGHbiLnERNR1+5ND9dVyQabCtm7L
         D7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vd8jWosoxlzrilW5j1C5mrPIKeenluDpN4wB4nkorKw=;
        b=HIon/aFc22+r/dtH7Km106HMaJL8QdsYTxtcczQx7oB0EteDOgkMmt+2YbvCQOMOVz
         8N5/ardlF4lrR8WUOXdqxA6oc8dVIMytiZaBWFXixTGLRUre3sPt7H79bHEx7GeL/gC2
         XqYLEacRtUgOdm0A25c6U0DvmrF+9IR87wLxfWmhRufDgYB/lpzfipAklPgFuM3OUFTF
         zdBnHbVtchI9jl29gPohbktfFw84o2zJNe79rUvocrGWZRHX3FFAy9HHit1NiVkqhhP1
         7B2AEdZZDxemevkOKH712xMd12TnzJ7s13zheKZ4Mfty3hL+kViP9y0oVyPhyygUAHKz
         zFOw==
X-Gm-Message-State: AOUpUlHVV/al/q+Qtso5xw7x8gU/9ZSVJtdYtD8tN9bRhujxDdFJxart
        TgYnxDzpwy+bzob5ONyn+7Y=
X-Google-Smtp-Source: AAOMgpc/b2Ul1DADtHDnxZgWJ3Feh8MF2bpI0AAj3U3AINsqKfNqJblL0ZqK00dj+1fCcLS0j7MeHw==
X-Received: by 2002:a19:b519:: with SMTP id e25-v6mr5866178lff.119.1532772827296;
        Sat, 28 Jul 2018 03:13:47 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v136-v6sm844984lfa.10.2018.07.28.03.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 03:13:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        ulf.hansson@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, marcel.ziswiler@toradex.com,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra-owner@vger.kernel.org
Subject: Re: [PATCH 3/3] mmc: tegra: prevent ACMD23 on Tegra 3
Date:   Sat, 28 Jul 2018 13:13:42 +0300
Message-ID: <7096174.4n8ysn5QrL@dimapc>
In-Reply-To: <CAMdYzYpawoCQ_08aJr0XUNxY8C=K95gkgMbZNetcw1vrmDgpig@mail.gmail.com>
References: <20180712073904.4705-1-stefan@agner.ch> <4098188.Bd2NGYzoJE@dimapc> <CAMdYzYpawoCQ_08aJr0XUNxY8C=K95gkgMbZNetcw1vrmDgpig@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 27 July 2018 23:19:53 MSK Peter Geis wrote:
> Kingston KE4CN3K6A.
> Though I am pretty sure I've figured out the instability.
> Brought it in to work and hooked it to a scope.
> Couldn't find clock, but cmd and all eight bits are running at 1.2 volts.
> Repeated the results with the bootloader, the original kernel, and my
> mainline.
> Also noticed that even on the slowest slew rate there is significant
> ringing and overshoot of .15 volts.

Okay, but eMMC is working fine with the original kernel, isn't it?


