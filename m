Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AA4C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3CB20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544128111;
	bh=IoUKOy1q34wAiXtGh1607hggiBb3BUSj7Oefzabqh2o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DQbNK2y+iAEDcTbSrZzvaGwn/DKU8jnmGwNf/9QPClaUfAQDdceGMcXMjrG4DJeLm
	 wEmE9IUC31kB0N9dpspX8cGJK2fRK0Ugf4v8GfJOm/u8UDyukDvIkQLw7pKJFWSdAx
	 DizxRSMLlGUbggZ1n/0bB3TT8xbO+jNYjc7a2BYQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3CB20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbeLFU2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:28:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbeLFU2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:28:30 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18ABC21479
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 20:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544128109;
        bh=IoUKOy1q34wAiXtGh1607hggiBb3BUSj7Oefzabqh2o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M6m45aiJMEOFlWzQdciOkfeuzp/ukrQEK7qaymQNFroJov7+LSLlKq4tdqRUpj3T9
         9GIALbCK0MDHzhJ4vxTz9MEc7+ClGdRdEx2p+Bx8c1M52iChrYqAAyl+jwwVaZKl1u
         TDvsmujrsJTvWE0XTCw560a1Q1eZcJpZg5S1H+fY=
Received: by mail-wm1-f47.google.com with SMTP id y185so14905550wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 12:28:29 -0800 (PST)
X-Gm-Message-State: AA+aEWaEKepo2aNd4nWRybpipcjQifv/DayKiKOzFJ6nDxN6hLklkaSc
        sJv1o8nAqzTkgeAErpWqpAQb7VEZmWuBeaWFATsvKA==
X-Google-Smtp-Source: AFSGD/Vxsa5ctJw9/c+VEmkc6JXtvUoCKFTs7Y6lfo2FWUWRwfYOBDokwduCdGUTCzePJ1SGM0BB1G58pAe1DvEjRXo=
X-Received: by 2002:a1c:aa0f:: with SMTP id t15mr10027437wme.108.1544128107541;
 Thu, 06 Dec 2018 12:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20181205163624.1842-1-sean.j.christopherson@intel.com>
 <20181206073409.GA64887@gmail.com> <CAHk-=wgrpUQyux2ZTJj8FUEdHcEoM0KUNrN3KCc+bBhi0fRhaQ@mail.gmail.com>
 <CALCETrUc7Y+WFkS1=ECXgtLoUXb3HPXsF+x+TCpiuuh3sXFjfA@mail.gmail.com> <CAHk-=wgOT0DW8a+VNgmrVybY1RJCajjJKskktzfNd1iJfhuV5Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgOT0DW8a+VNgmrVybY1RJCajjJKskktzfNd1iJfhuV5Q@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Dec 2018 12:28:16 -0800
X-Gmail-Original-Message-ID: <CALCETrWNGgYtFDQCBOH77dec3RctjsrMQaDuYaA4Ym5Zdo5SVQ@mail.gmail.com>
Message-ID: <CALCETrWNGgYtFDQCBOH77dec3RctjsrMQaDuYaA4Ym5Zdo5SVQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/fault: Streamline the fault error_code decoder
 some more
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 12:24 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Dec 6, 2018 at 11:07 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > How do you like the attached patch?
>
> I agree with whoever thought it's odd that "read" is in lower case
> when everything else is in upper case.

"read" isn't an actual bit in the error code, so I thought it would be
polite to make it look a little bit different.  That's not a big deal,
though.

>
> And honestly, I'd just siggest making the err_text simply have the
> real user/kernel difference in it too, using something like
>
>         pr_alert("#PF error: 0x%04lx%s from %s mode\n", error_code, err_txt,
>                 user_mode(regs) ? "user" : "kernel" );
>
> The "oh, PF_USER and user_mode differs, so let's point that out
> explicitly" thing is a good thing regardless.

Sure.  Although it's extremely odd for us to OOPS from user mode, so
maybe the OOPS code in general should print a big fat warning, and
we'll just otherwise assume it was from kernel mode.  (In your tree
right now, we print the wrong value for CS for OOPSes from user mode,
which is extra confusing.  That's fixed in -tip.)

--Andy
