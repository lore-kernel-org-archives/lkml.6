Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8CBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81D42086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l637roip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81D42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbeKTGR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:17:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbeKTGRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:17:25 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5085220831
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 19:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542657136;
        bh=YxP4BKo4PjD6PZZwn6g5wblNOazSfdvH7axyG+0UbAw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l637roiptSM/8kO+A6m7orRNSWxMwf4fCYKJGXew3Wjh1YseIXsJtn0J82MbU/bjA
         gEFmsByNGbbOk/RdjDCKoBsYFPDvDDJPVV6WG438zdA50vep83YN93by8hb7aUyugP
         Zc47DtwCM+/TI9DTvb4SzGEC7eIRmwVoM8bma40k=
Received: by mail-wm1-f52.google.com with SMTP id c126so173987wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:52:16 -0800 (PST)
X-Gm-Message-State: AA+aEWbgm5OdZCmzgXNiLMMiMrdZZjYlXsO4b3eAhI8ZN73bHJ0tCrSe
        Ql1YOv9HgryWyNSD7LPpU5NWSuLi5WM6iNM31zSBPg==
X-Google-Smtp-Source: AJdET5fwsZzd5m4nQQ6UesPgeMlFOvKX6Ynr82EJW67sqYGUjirrAhIzF2e/4yFAdX5zEQQWVI9IhD0BpFQo0aU/qnQ=
X-Received: by 2002:a1c:110b:: with SMTP id 11mr5521748wmr.83.1542657134867;
 Mon, 19 Nov 2018 11:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20181119184556.11479-1-bp@alien8.de>
In-Reply-To: <20181119184556.11479-1-bp@alien8.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 19 Nov 2018 11:52:02 -0800
X-Gmail-Original-Message-ID: <CALCETrV34q-BP2w8A1s82-a8Hg062=RYzk+SCOa31W7ftsznPA@mail.gmail.com>
Message-ID: <CALCETrV34q-BP2w8A1s82-a8Hg062=RYzk+SCOa31W7ftsznPA@mail.gmail.com>
Subject: Re: [PATCH] x86/TSC: Use RDTSCP
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Stultz <john.stultz@linaro.org>,
        Tom Lendacky <Thomas.Lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 10:46 AM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> Currently, the kernel uses
>
>   [LM]FENCE; RDTSC
>
> in the timekeeping code, to guarantee monotonicity of time where the
> *FENCE is selected based on vendor.
>
> Replace that sequence with RDTSCP which is faster or on-par and gives
> the same guarantees.
>
> A microbenchmark on Intel shows that the change is on-par.
>
> On AMD, the change is either on-par with the current LFENCE-prefixed
> RDTSC and some are slightly better with RDTSCP.
>
> The comparison is done with the LFENCE-prefixed RDTSC (and not with the
> MFENCE-prefixed one, as one would normally expect) because all modern
> AMD families make LFENCE serializing and thus avoid the heavy MFENCE by
> effectively enabling X86_FEATURE_LFENCE_RDTSC.
>

I thought I benchmarked this on Intel at some point and found the
LFENCE;RDTSC variant to be slightly faster.  But I believe you, so:

Acked-by: Andy Lutomirski <luto@kernel.org>
