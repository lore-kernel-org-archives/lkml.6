Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238DAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5CB208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ENrmkuWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5CB208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeLETgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:36:10 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46476 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeLETgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:36:10 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so19419040ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 11:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iOVsP8f6QrXA3nLba+qUPDC+s9JeWQ/Ir0drCJPEyD0=;
        b=ENrmkuWDY4XRI8bdj4eLTQpNjh4Tu5RYheZHgXqsotfiekDJSl7OdJAF/QlKoVY/NR
         E+y1R6NE6TyI5u8KC3X+ida3SLduJs35DHPhuI4fYbjPb95njmwd08NtST5+KcW4eiwK
         UZ3BAfg5WklO8lUr1Df/Q0p4PI3EwRExhmsu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iOVsP8f6QrXA3nLba+qUPDC+s9JeWQ/Ir0drCJPEyD0=;
        b=HsWZN8dDlIHfyIaHdqX3804KwXoEWAtozva2XaL0Ho2WaePwvmTfwWxhldgRRzWNGm
         2LvSgBeYlhyluGNiPq0zcGhCSKEikMNAXV+FzBDISzkoeZ3nH90K/pDLvr7L6Jh0/Yfi
         Fx0nghysjo09NkqA+/hct+sLQ3svEXySqx6npnSxymfiQU+hlPo/AyYbbsFR7IGELO36
         GGmWJQqKGfMdyLlcwXMQrqGpXeS6wNvVSh/EKsjucLIBFQEMWtkkZXLIP8NsLToQ/Wgv
         jwAm8gXoJMFQ1e059c/WChmITUSVVsTwdPm1o/4E3hrvGj8aRwBZx36xkJgrRIJX3pA2
         ZifA==
X-Gm-Message-State: AA+aEWbX1WDHmz7uGki/NLODivuKY+t6E/96u9daapgCNjxLLvI/5I0q
        NcCGcMW8gmyUTBr5JkmVt7bubaDhN9w=
X-Google-Smtp-Source: AFSGD/V0yDFvfYcLqr7qQIU2ia2hcU4DWnYTCdcpkcZ3Qekko0KhYWw76WG9bcxDe5GJ3gU+m6cK4w==
X-Received: by 2002:a2e:2b85:: with SMTP id r5-v6mr15994717ljr.91.1544038568132;
        Wed, 05 Dec 2018 11:36:08 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id i75sm3815477lfb.58.2018.12.05.11.36.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:36:07 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id u6-v6so19451682ljd.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 11:36:06 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr16039171ljh.59.1544038565910;
 Wed, 05 Dec 2018 11:36:05 -0800 (PST)
MIME-Version: 1.0
References: <20181205163624.1842-1-sean.j.christopherson@intel.com> <fcffaedd-5057-19ca-52fc-76d35cae7535@infradead.org>
In-Reply-To: <fcffaedd-5057-19ca-52fc-76d35cae7535@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Dec 2018 11:35:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=whaM9shZZCRaof4DgXPWLRkuRSoFRWhhjTs534XGbRL9g@mail.gmail.com>
Message-ID: <CAHk-=whaM9shZZCRaof4DgXPWLRkuRSoFRWhhjTs534XGbRL9g@mail.gmail.com>
Subject: Re: [PATCH] x86/fault: Print "SUPERVISOR" and "READ" when decoding
 #PF oops
To:     rdunlap@infradead.org
Cc:     sean.j.christopherson@intel.com, dave.hansen@linux.intel.com,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>, yu-cheng.yu@intel.com,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 11:27 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> BTW, what does PK mean?

"Protection Key"

               Linus
