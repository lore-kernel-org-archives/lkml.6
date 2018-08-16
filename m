Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102E8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE062147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE062147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbeHQAGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 20:06:48 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40228 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeHQAGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 20:06:48 -0400
Received: by mail-qk0-f194.google.com with SMTP id c126-v6so4838414qkd.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 14:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCzqaOw33JuxtAntixxBGE0Jl5tyGk91JSgKc/Ou5a4=;
        b=l7hub9BEcTy3AL5048YBDTpnl673/4cCsK++3Ss66b6LRgMUKA/xbUvb0Ul6Le0ptK
         RAxs4ebnXtrMUfREQnrE25i1DiX/CpYDygpMkSyesQY21KgnY4STw/Fz77fEt07lnkYK
         yNwR6cc7RRNz3a+uSv4m43/2V7BdtWRYAegN4kvuG3B+E/rmwc0F6KgRj7C90R4PFx0h
         qt3HAX/JujWnqOcbhdAZkYHcvPUnHEckeRuQR6Yeu8i7KasGQb+6v2D0hkI2M1phs/AX
         09jkCOwFm/lqG8acGrbsVLHhv7cjTeT9d0uU4UwQtK6OnnbzG0dbljyWDe4vKvSG84NA
         awyA==
X-Gm-Message-State: AOUpUlF5FOgteZtQYQNjvvhevhNQvJfm5nih/udyP+zK2pt5Xrppon+M
        KXugkO8UxwemBV0DYEubbGm0zZout1HLEnImogU=
X-Google-Smtp-Source: AA+uWPxrcJfUSVtVUlm6y7UmncZBwzzSkCv2aKHbKdYrPsga+KHYtF0/rWROWV/aoXyY9U5wBvmP2Mqc5eBkvG2XmNY=
X-Received: by 2002:a37:8786:: with SMTP id j128-v6mr28191166qkd.32.1534453567723;
 Thu, 16 Aug 2018 14:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <1534448679-13823-1-git-send-email-sunpeng.li@amd.com> <1534448679-13823-2-git-send-email-sunpeng.li@amd.com>
In-Reply-To: <1534448679-13823-2-git-send-email-sunpeng.li@amd.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Aug 2018 23:05:51 +0200
Message-ID: <CAK8P3a0Ds9OPqDqpBeY_cbQShTCO9Bkf4uRBtpAz4+8RP2Mwaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Don't build DCN1 when kcov is enabled
To:     sunpeng.li@amd.com
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        michel.daenzer@amd.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Jordan Lazare <Jordan.Lazare@amd.com>,
        Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 9:45 PM <sunpeng.li@amd.com> wrote:
>
> From: "Leo (Sunpeng) Li" <sunpeng.li@amd.com>
>
> DCN1 contains code that utilizes fp math. When
> CONFIG_KCOV_INSTRUMENT_ALL and CONFIG_KCOV_ENABLE_COMPARISONS are
> enabled, build errors are found. See this earlier patch for details:
>
> https://lists.freedesktop.org/archives/dri-devel/2018-August/186131.html
>
> As a short term solution, disable CONFIG_DRM_AMD_DC_DCN1_0 when
> KCOV_INSTRUMENT_ALL and KCOV_ENABLE_COMPARISONS are enabled. In
> addition, make it a fully derived config, taking into account
> CONFIG_X86.
>
> Signed-off-by: Leo (Sunpeng) Li <sunpeng.li@amd.com>

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
