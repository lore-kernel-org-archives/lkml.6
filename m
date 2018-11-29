Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B114FC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78918213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FEf7tjAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78918213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeK3FaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:30:21 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35534 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeK3FaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:30:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id e26so2210091lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RehX+18LWL0rpiBehAMxevMufXG2TB3C+E51aYn8RXw=;
        b=FEf7tjASv06j2rkQ6juyTtFy00fktb5zyHfDjBD70h50ArVaUOitIMsWPe8FRxMdV3
         hgbdXxg0DlGrR7a0fJEP+zg8Mel1rU6fdV4aG1RAexeRF++ytKY7nEo5yr78lvTg0Bn0
         998CBlkHeo+DxaNck6m9tFwS2Urqcsr3lHiv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RehX+18LWL0rpiBehAMxevMufXG2TB3C+E51aYn8RXw=;
        b=mdRDUzTAIFLcg2JGXAx3nJZhGIvGYfBRfqdgqQC9HRpREY1i7flYQ/NcRRu+SAAY8P
         UHwf9LvsY1xLjnC+AfYCvtDYjGw9ODpAG6e2yVb40XchkiXfaZGDCOaxqv8TNvIuK69S
         1a+pEpUGBXcqJZEmn9eP0JkQhExzkU+ZJktAC4EuXLmTg57J4HmOcJvRqyYijjveZjS3
         GrsvNSdMC2yTXq97KHJ5a6IZnitC4ECaaHErWwoHWaTTJELwzdmu4sO2DyfAd0aHo4/G
         +sCTZJo5VEspenFaGXB9bfbSUBeBQdpyTCzSqKlhZdWYsPv8EnRPMdN4j5K8nRgDH1pG
         J0UQ==
X-Gm-Message-State: AA+aEWZS/9Fvaac9DDnRMpeKs/3P+KV368M4iL2uAbeOaci5njBbEYfv
        /vjfjI3HSelao+svvHFe/my7hC6yVFc=
X-Google-Smtp-Source: AFSGD/Ulqu33Io32lIb80C6T+VGQk/5hPfk6ebltEfaKImT5IFA1ZU7jI+lcgoP1IvQAFG5G9zYnDg==
X-Received: by 2002:a19:1a14:: with SMTP id a20mr1638713lfa.1.1543515842609;
        Thu, 29 Nov 2018 10:24:02 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id v11-v6sm390583ljc.57.2018.11.29.10.24.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 10:24:01 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id p6so2201617lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:24:01 -0800 (PST)
X-Received: by 2002:a19:7013:: with SMTP id h19mr1834550lfc.147.1543515840892;
 Thu, 29 Nov 2018 10:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126171036.chcbmb35ygpxziub@treble> <20181126175624.bruqfbkngbucpvxr@treble>
 <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble>
 <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
 <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net> <20181129121307.12393c57@gandalf.local.home>
 <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
 <20181129124404.2fe55dd0@gandalf.local.home> <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home>
In-Reply-To: <20181129125857.75c55b96@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Nov 2018 10:23:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
Message-ID: <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, mhiramat@kernel.org,
        jbaron@akamai.com, Jiri Kosina <jkosina@suse.cz>,
        David.Laight@aculab.com, bp@alien8.de, julia@ni.com,
        jeyu@kernel.org, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 9:59 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Do you realize that the cmpxchg used by the first attempts of the
> dynamic modification of code by ftrace was the source of the e1000e
> NVRAM corruption bug.

If you have a static call in IO memory, you have bigger problems than that.

What's your point?

Again - I will point out that the things you guys have tried to come
up with have been *WORSE*. Much worse.

               Linus
