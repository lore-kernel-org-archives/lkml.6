Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41744C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040E3214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qph5wQHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040E3214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbeKVFTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:19:33 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35585 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbeKVFTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:19:33 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so4763643lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 10:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47NppObr9IGpPjPeEDcz3xxdwv/xVA/TuPO1Qq4gymA=;
        b=Qph5wQHirxhXFM2wcpXAyVhob4ramuE4YuFC+d0rJG9z4LZ7dJqXc6PAT5FWe6L2Sr
         RRaZNHg5LzKtlX2xLmM4r//K7zjqDCHopOm2ZSyOrrvn81y2OsUF0J858nWAOpV4i1h6
         8RcYgKWOiNlHsof02aFu+QS9FICi36FDOn2Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47NppObr9IGpPjPeEDcz3xxdwv/xVA/TuPO1Qq4gymA=;
        b=JXOkw11RZ2MWHS754o6mtRSI1T6ZS6UkZQQnJdnywqi7oNBWHCKHQ2ZweJKNNeydhv
         Uq+9Rud33UX6mvakJb4CTyL+DHs8xxG/4FM8MbUgM4iDOQAvfcbJY4aYK9Fs9mqV0VBn
         W+jqUI57/7+wpLhYBjJmDv+lN7GSnA7dwb6Jnk2dRGwvqy92ivbesjOsuFadS7/BKHFt
         6xI9lq5XrcP/sfButM8r622XtosHJLjHRA+6CK9fLgekSnC+roQSmEh6eUIQGmXlF1Wf
         iD3a/SHB3TkCmcg829SKN1m7sGG2ujoRK07DHun5XlcN7cOWSNsLSLZIXYuK/N2UCB6m
         LBrw==
X-Gm-Message-State: AGRZ1gLaPGTmS6vTsbyjq3em1WPAT+5xx3r9xk0fTHPldgXVMQMfc+P4
        eHLq3pf7sTVUIQAqbDYTv69nn72Sfcw=
X-Google-Smtp-Source: AJdET5fVHng08tg7Y9cMKDp9tG/gTmIiHes/iihrvpdTLlRVaZxl/MSGR8fbEXl2a7tAfevYmvKD6A==
X-Received: by 2002:a19:5f1e:: with SMTP id t30mr4395185lfb.76.1542825841915;
        Wed, 21 Nov 2018 10:44:01 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id q8-v6sm5441571lji.69.2018.11.21.10.43.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 10:43:59 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id f23so4725893lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 10:43:59 -0800 (PST)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr4717669lfg.117.1542825838485;
 Wed, 21 Nov 2018 10:43:58 -0800 (PST)
MIME-Version: 1.0
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <1c22125bb5d22c2dcd686d0d3b390f115894f746.camel@redhat.com>
 <CAHk-=wgnjB+=o0771=J_YkQzabU5aadh6pN3x9Vk4HPs3MHL3g@mail.gmail.com>
 <658cdb28-e3e5-c0af-368f-c26daf9986ac@kernel.dk> <9E7DFB44-8A2A-48CF-972E-6CB5122CCA20@amacapital.net>
In-Reply-To: <9E7DFB44-8A2A-48CF-972E-6CB5122CCA20@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Nov 2018 10:43:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wia47WugL2b02gMx49AfpUmm5jp3tBoUL5dF2YomSGN2A@mail.gmail.com>
Message-ID: <CAHk-=wia47WugL2b02gMx49AfpUmm5jp3tBoUL5dF2YomSGN2A@mail.gmail.com>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jens Axboe <axboe@kernel.dk>, dave.hansen@intel.com,
        pabeni@redhat.com, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, dvlasenk@redhat.com,
        brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:26 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> Can we maybe use this as an excuse to ask for some reasonable instructions to access user memory?

I did that long ago. It's why we have CLAC/STAC today. I was told that
what I actually asked for (get an instruction to access user space - I
suggested using a segment override prefix) was not viable.

                 Linus
