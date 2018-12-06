Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B18EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D7620989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544128198;
	bh=LmAGwVz/4T2dpRord1Ge3gGKRUVfaOMYzQq4GUGfvmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Lks/3i8PfT7gqy4yANUEqgrPBxiZSoZKR+/LEVlvhC/D79eWG5fAW/q53KI6I5YOs
	 Er1yT8Xv0Qicb1mQ22VrfdsGRtqIHkVe+1uAj0fYr9NxKxeamJqBAcf9T4hANUDI62
	 Pv6SBcM9Se7l6K0yveL3mik+UtsgPpo8RI3otcns=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D7620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLFU34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:29:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbeLFU34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:29:56 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89930214E0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 20:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544128195;
        bh=LmAGwVz/4T2dpRord1Ge3gGKRUVfaOMYzQq4GUGfvmE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0WOic+7z9IJhcPcERxD8Yt0Mckw4OxxkNnUiwAFtN84fCfrjIcmPRdpWEGh+yPea+
         LniNgbxQxJirElQck1h6eu14gn+71QGMBClYTJ6tgxmhQcrbqrVSgTMUYiGyJbMApc
         /3vyg9CEVBxtkhGH11K+Ngifu5W2eoebdwy/5v0A=
Received: by mail-wm1-f42.google.com with SMTP id y1so2263877wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 12:29:55 -0800 (PST)
X-Gm-Message-State: AA+aEWbdN7tXEuRSMbmjPrTOZEmPiKwbEWJ8O1+MbNGa8qpnwHjUyayC
        /IumfA7FteKYmHi8m22w+ITk2tengG1u0b+vb1oC3g==
X-Google-Smtp-Source: AFSGD/UamjY5m+tsJA+o7VaZACazliGAEZ/3cuAn4z4uSAvMYPDo6vWjbGl0hQKSHc6Qr+HdjLGEOaiuYXVxOehaUfg=
X-Received: by 2002:a1c:864f:: with SMTP id i76mr16873672wmd.83.1544128194007;
 Thu, 06 Dec 2018 12:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20181206191231.192355-1-ndesaulniers@google.com>
In-Reply-To: <20181206191231.192355-1-ndesaulniers@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Dec 2018 12:29:42 -0800
X-Gmail-Original-Message-ID: <CALCETrUu5TuNQ9rxtpRng3=r4eaJQMs4PTNR6s=VFPKfW7eNBQ@mail.gmail.com>
Message-ID: <CALCETrUu5TuNQ9rxtpRng3=r4eaJQMs4PTNR6s=VFPKfW7eNBQ@mail.gmail.com>
Subject: Re: [PATCH] x86/vdso: drop implicit common-page-size linker flag
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Lutomirski <luto@kernel.org>, maskray@google.com,
        Andi Kleen <ak@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>, dima@golovin.in,
        morbo@google.com, ruiu@google.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 11:12 AM <ndesaulniers@google.com> wrote:
>
> These are implied by the target architecture and for x86_64 match the
> max-page-size. The default for non-NaCl x86_64 is 0x1000 (4096).
>
> In bfd the common page size is defined as 0x1000 (4096) for non-NaCl
> x86_64 targets:
>
> bfd/elf64-x86-64.c:
> 4998:#define ELF_COMMONPAGESIZE             0x1000
>
> For gold, the common page size is defined as 0x1000 (4096) for non-NaCl
> x86_64 targets:
>
> gold/x86_64.cc:
> 1413:  0x1000, // common_pagesize (overridable by -z common-page-size)
> 1442:  0x1000, // common_pagesize (overridable by -z common-page-size)
>
> (ELF_COMMONPAGESIZE also defaults to ELF_MAXPAGESIZE when not set
> explicitly for a target architecture in bfd/elfxx-target.h, but that's
> not relevant for x86_64).
>
> Because it's implied by the target architecture, it's of questionable
> use to implement in LLD.  This patch resolves one of the issues towards
> using LLD to link an x86_64 kernel.

Sure.

Acked-by: Andy Lutomirski <luto@kernel.org>
