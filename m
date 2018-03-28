Return-Path: <kernel-hardening-return-12786-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48AQaeIsh8kHtYct2OkdqpJxH4YBM4USQQGkKvChx89yPR98f/OJvBp3/23ayk/e57SIhZL
ARC-Seal: i=1; a=rsa-sha256; t=1522200882; cv=none;
        d=google.com; s=arc-20160816;
        b=XDunOefQTnB5jn/qtrRI2qWf1g7eGxpwpZzsBg+M/Hw36UpzghCjkDiyE24FTo5jYZ
         qvlTR54rOmo4mEudQiRvxgb58sNFwk7I+rF961y1TsqzSX3jJYbu0ehqitFzvRNyXWoU
         OXIiPZek9tsijCpy/Tid6vDNwUdrzUcv/SDLvueVjGlSRMjh37eQvDaSFGrBS8PUvCX5
         up2Va7yl6Y6FaVyy3fmN1ZeSJc+Bzv3QOAMF6HCM4t8h47peje/E2rXaEya+wTPAmrl1
         bi9qFuuxk/yFia8HUyU2uUQOms5yG3OMAqsI4f9HR1Q0yrz2ykTyf+o/NEqtkx2wyiiQ
         t/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=4ZswLyqz4hKPCNmvZ2MDFxewAyWU7oelo/WDMtbkqp4=;
        b=jzK6JW0BPkDik1dTWT75x3gheFgsjEVdSr7uu0Fl9876jcybQs3Yf6taDV18zhPg6G
         rorRMwkv8BuuiTYt9gTj4E5A7yYPH3ELDD7/xAPHkgH02q6XsctHYOCPedE9Su8syXuk
         r4s6vtsOjaExRnUagfj0qOxHQ5vYWhR1gUITZbj+zGMHS2NiRUgiTJlszPdXluMuktp7
         vX7yMQOu3jvnOTWRbSw2SM9BlQ93v7AAImup27oKncFJQbM5L0tCNifHgvB4FMXlieGe
         qX3CGJXJV712/2FhtHwV2w3czky/lnRHTR0m+PGLmYKT16tLCuvIqIAzP8eXxAoWlF9r
         ZQZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12786-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12786-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12786-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12786-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 27 Mar 2018 18:34:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Kernel Hardening
 <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH] task_struct: Only use anon struct under randstruct
 plugin
Message-Id: <20180327183419.8610a85f4ef90c68e157c5a9@linux-foundation.org>
In-Reply-To: <CAGXu5j+an4OwLMCqGMqCN=dh1GH-_PQTDGFL_WhpbOSNXgYynA@mail.gmail.com>
References: <20180327213609.GA2964@beast>
	<20180327160342.e2bc9a15afda5823c8daf4fb@linux-foundation.org>
	<CAGXu5j+an4OwLMCqGMqCN=dh1GH-_PQTDGFL_WhpbOSNXgYynA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596128328848013628?=
X-GMAIL-MSGID: =?utf-8?q?1596143311833678221?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 27 Mar 2018 17:30:47 -0700 Kees Cook <keescook@chromium.org> wrote:

> On Tue, Mar 27, 2018 at 4:03 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > On Tue, 27 Mar 2018 14:36:09 -0700 Kees Cook <keescook@chromium.org> wrote:
> >> Reported-by: Peter Zijlstra <peterz@infradead.org>
> >> Fixes: 29e48ce87f1e ("task_struct: Allow randomized")
> >> Cc: stable@vger.kernel.org
> >
> > Why cc:stable?
> 
> Since the padding existed in all configs, it's kind of an ugly wart
> and should likely be fixed up for 4.14 and 4.15 -stable.

That didn't tell us much :(
Documentation/process/stable-kernel-rules.rst doesn't mention "ugly
wart".

I think what you're hearing here is that this patch needs a better
changelog, please.  Not an uncommon failing, sigh.  A better
explanation of the origins of this padding and a better explanation of
the reasons for backporting the fix.
