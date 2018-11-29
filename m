Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97960C07E85
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6E72146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DCJhLAfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6E72146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbeK3Elk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:41:40 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37839 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730493AbeK3Elk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:41:40 -0500
Received: by mail-lf1-f66.google.com with SMTP id p17so2089791lfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zM/Y8YvqQfxkSbSA6sCwfJQA/HUxoZfpiH46OJ7iBZ0=;
        b=DCJhLAfWD8phDj9xqXvhpZcEe2ydGJdSX6OY+G+Vy5/TNFMA1mTqaohEP6RMR06SUa
         5WYPDDD7yEA6HlCW96ERZzIGSRoTMcncuIpRMUYAN0+HsfrFxpib7hJbO62JGDJcXhXL
         TmX9JrTiHVLvZPB3tIm3loayYxFtywOcDR1/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zM/Y8YvqQfxkSbSA6sCwfJQA/HUxoZfpiH46OJ7iBZ0=;
        b=VQFpCc2mlWhez5AtNWQe751W+ResK7tzSeQk5jCzKd44WB7VlmycYH9Pmk2fbJ55OW
         kVPlYli6OV6F7RSMorwr4M/kTzngnxhwcofpZjf8rIeAOnUu5vlMsSSkWgNOEJz+zV9i
         0p/hTGHD49G+O8/lNw98zWXUmtZuU7nWUZMK0UakjVwoT1dGMhZFtDveShaHgjxplrxA
         0qqFCUFKQqgBckt0yGd7Ul6sjTcruCW1GGkWlaTBLe0Ud4CzvHf5rx/sADbhygcwvMoe
         8QqPn8Hg4TVRiNJbmYhIKFKTK1L+HWqhhwBTJgDqVz2aK1SAoPhQRtEPtKTnqje/dXiy
         /o2Q==
X-Gm-Message-State: AA+aEWbnRAW80O/XRiCFqwApbbZ3w7lnUR3M9T1Tc5yRophDAgaNGg6s
        OLLv9WbppRFScSUFFwYTwNrogki34Ig=
X-Google-Smtp-Source: AFSGD/XLcYyThhNlTTtfcdpKZNri7bw0cAWN+YlGj0AU8BIznmB03gU5HTum/guztA8MNchvJdoTcQ==
X-Received: by 2002:a19:2752:: with SMTP id n79mr1705631lfn.11.1543512929759;
        Thu, 29 Nov 2018 09:35:29 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id e82sm409455lfg.34.2018.11.29.09.35.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:35:28 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id l15-v6so2487795lja.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:35:27 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr1886754ljk.80.1543512927326;
 Thu, 29 Nov 2018 09:35:27 -0800 (PST)
MIME-Version: 1.0
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126171036.chcbmb35ygpxziub@treble> <20181126175624.bruqfbkngbucpvxr@treble>
 <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble>
 <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
 <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net> <20181129121307.12393c57@gandalf.local.home>
In-Reply-To: <20181129121307.12393c57@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Nov 2018 09:35:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
Message-ID: <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
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

On Thu, Nov 29, 2018 at 9:13 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> No, we really do need to sync after we change the second part of the
> command with the int3 on it. Unless there's another way to guarantee
> that the full instruction gets seen when we replace the int3 with the
> finished command.

Making sure the call instruction is aligned with the I$ fetch boundary
should do that.

It's not in the SDM, but neither was our current behavior - we
were/are just relying on "it will work".

                 Linus
