Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40606C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04239208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AoRnD3pC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04239208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbeLFUkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:40:05 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34288 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeLFUkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:40:05 -0500
Received: by mail-lf1-f68.google.com with SMTP id p6so1406800lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 12:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZAEYycWiumWKRAabgzjtBtryLX0wOeag1iCDMOhaII=;
        b=AoRnD3pCwbSngf8j1zH0Bxu2g2s+V3hPzVjaXBx41VOxXkHwZKudsgnVTZuiP2/6vg
         ZYydAkPAgIp/+Pf9Y8RuBkAa1uHDkCpcdo1cYCZI6PWYiJOGbFVTRhUyHGbUcuC/2y5b
         eLLNc0yBgq2koEJ32D4C8ch6XDTTKgCTkzjEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZAEYycWiumWKRAabgzjtBtryLX0wOeag1iCDMOhaII=;
        b=gAyqn5AAciIwIYOzEWzb1fklpB1QhHp6EE2NehJkQ1DICxLSLzr2dIS6aOCj/arJg7
         TMKGwvgdQ780ATwhg0QZG9wKgank8RRC/w7JXdyNoVTIhIiQHr7RcSr6oXECP5Xr0Wpe
         Sgj7zak3JR+ApfkBs+v2FlTh1dQLjxPjGBYxeDq/YxqPOmiPP1g39BHmQRGUU+P2bRin
         oU0UNj9tqTcewu/6is+icYMj1U4hWpF98RXCLB24cyxUex61/C+IPPCEMwu8DMrZ0uOR
         l+ZSEAx4w+4W63JOzLMAqkrUW09LNXkmA+B9+T5cnHqxGXA8JfhdnEIDikxeBHO3S2On
         Uj3Q==
X-Gm-Message-State: AA+aEWa5mkhdvrgQ5YHFXJTsGq4PpPKV3ASFqAhuKZ/XFO2ntaDRIUI5
        N9q1gtlQaCb4juSSxTqumNH+RlpjuOI=
X-Google-Smtp-Source: AFSGD/VZA1qx08AzWhsOuy/sDepsAUxNUjCrethRZKjVgRtvxu2HYlSCvXDhnOMiOHtsHQ3YjeNFvg==
X-Received: by 2002:a19:914b:: with SMTP id y11mr16776111lfj.98.1544128802936;
        Thu, 06 Dec 2018 12:40:02 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id b25-v6sm241731lji.94.2018.12.06.12.39.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 12:40:00 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id u18so1361260lff.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 12:39:59 -0800 (PST)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr18592223lfg.117.1544128799426;
 Thu, 06 Dec 2018 12:39:59 -0800 (PST)
MIME-Version: 1.0
References: <20181205163624.1842-1-sean.j.christopherson@intel.com>
 <20181206073409.GA64887@gmail.com> <CAHk-=wgrpUQyux2ZTJj8FUEdHcEoM0KUNrN3KCc+bBhi0fRhaQ@mail.gmail.com>
 <CALCETrUc7Y+WFkS1=ECXgtLoUXb3HPXsF+x+TCpiuuh3sXFjfA@mail.gmail.com>
 <CAHk-=wgOT0DW8a+VNgmrVybY1RJCajjJKskktzfNd1iJfhuV5Q@mail.gmail.com> <CALCETrWNGgYtFDQCBOH77dec3RctjsrMQaDuYaA4Ym5Zdo5SVQ@mail.gmail.com>
In-Reply-To: <CALCETrWNGgYtFDQCBOH77dec3RctjsrMQaDuYaA4Ym5Zdo5SVQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Dec 2018 12:39:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=whk_fsnxVMvF1T2fFCaP2WrvSybABrLQCWLJyCvHw6NKA@mail.gmail.com>
Message-ID: <CAHk-=whk_fsnxVMvF1T2fFCaP2WrvSybABrLQCWLJyCvHw6NKA@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/fault: Streamline the fault error_code decoder
 some more
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, sean.j.christopherson@intel.com,
        dave.hansen@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 12:28 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> "read" isn't an actual bit in the error code, so I thought it would be
> polite to make it look a little bit different.

If you care about the bits in the error code, then just look at the number.

And if you care about what the numbers mean, it doesn't matter how it's encoded.

I don't think you should mix up the two concepts.

> Sure.  Although it's extremely odd for us to OOPS from user mode, so
> maybe the OOPS code in general should print a big fat warning, and
> we'll just otherwise assume it was from kernel mode.

Yeah, the "from user mode" case is generally really something horribly
bad (reserved bits being set or us screwing up LDT's etc), so yeah,
maybe a better model is indeed to point that out explicitly, the same
way the "user/kernel doesn't match U/S bit" is pointed out.

              Linus
