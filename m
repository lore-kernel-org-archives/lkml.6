Return-Path: <SRS0=KIOc=HN=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AIpwx48PzXQApJW8AZnkomosmLj+qlEfFGiaGX0aLSFnmfuoQ2M0FVHyOOlasMfyZF6KB49qGPJo
ARC-Seal: i=1; a=rsa-sha256; t=1524597260; cv=none;
        d=google.com; s=arc-20160816;
        b=cJgksOZxVdkZAtkl4BGgKgfHP4LA3zdgy/1Dnsm4QnfQ7QstoHoLEXL4bppIptG0La
         LBNWatbScWLWxPdptXu6cUvlVph3ot69pQaDVM9HKuApnvLrWg/PKwqX5FMmWfN8C4Jh
         c0TI2wXWvmbjhkdLViXKV5wz9dYXH8F1G770UVs9lpmpe+HF+1YRh6PeQt/dj833h8VI
         GnGMW8HHbg21OZymlTI334HYkiCi3xMk5xbJVeUv9xHJpS+wcrnx4q3X+J1b9bqAtEuP
         oaLVxtrydOdMJiUCFr8MOkH3ybl6RFRNBQ3w71GTwsRZJD83lWFVWWncaB1SjUIY6BME
         NiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=cU59TzCz5ymcXyEisvHUR4wqL4Sk2IES+QsWj6vRY7w=;
        b=n72kmYTk8xuAO5xX8bx49pYrIGVxS8rJfHFoZicztBl7ilysqhkQJKXYJG1XhozEbw
         Y/VFccUqbL8WizwSC2EyqoNF1ki0vOeem5BuekzdhQe0sGvETCoqk3enj4csKjCNaTaN
         pF+JjGCc+9nZZgVTEJ4iLiLI+M93IzffBwGP7LTpIu4V7BMcG4U8TpwACkDV/bWOSdUt
         pu0AC11GXk+CZL1V+xKSONj6MHPpwRxkX7B0m56U9cR5cICc7Y2ZalwSgVTvk11c6/IN
         cI9XeQH5UY1DGGR5DV3OVKuvqJxuuMImnSKCVg63doQUz0OrGYBQRu/mruMf+wwUTjYX
         ywlg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=kioc=hn=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=KIOc=HN=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=kioc=hn=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=KIOc=HN=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C19B217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 24 Apr 2018 15:14:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wei Wang <wvw@google.com>
Cc: gregkh@linuxfoundation.org, Wei Wang <wei.vince.wang@gmail.com>, Ingo
 Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kees
 Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Crt Mori <cmo@melexis.com>, Alexei
 Starovoitov <ast@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] do not call trace_printk on non-debug build
Message-ID: <20180424151416.397fbbde@gandalf.local.home>
In-Reply-To: <CAGXk5yo44kAku+ZYx=8HzOgkEVC7ARNSER4MvWTCz-i51up=ew@mail.gmail.com>
References: <20180424180812.215900-1-wvw@google.com>
	<20180424145056.7c29ea18@gandalf.local.home>
	<CAGXk5yo44kAku+ZYx=8HzOgkEVC7ARNSER4MvWTCz-i51up=ew@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598651942651560845?=
X-GMAIL-MSGID: =?utf-8?q?1598656097177416846?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 24 Apr 2018 19:02:34 +0000
Wei Wang <wvw@google.com> wrote:

> We have seen many cases vendor have shipped kernel/drivers with it, and
> have to clean up that every year. This was brought up in an internal
> discussion and Greg suggested have some feedback from upstream about what
> should be taken to prevent this globally besides fixing individual drivers.
>  From him "I think this change makes sense at a high level, but there could
> be non-obvious reasons why this isn't the way things are handled right now."

The thing is, trace_printk() should not be used except for development
and debugging. There should be no use cases in the kernel that us it,
unless it's part of something else that should never be used (I use it
for the ring buffer benchmark which itself will destabilize the
system and is why I use it - I want that warning for it too).

Any trace_printk() in a patch submitted to the kernel should simply be
stripped out. If someone wants a trace_printk() in their code, then
they should create a trace event, which is the proper way of retrieving
static data from the kernel. Using trace_printk() is just a lazy fast
way to create trace events.

Hmm, ideally I think check_patch needs to add a warning if
trace_printk() is used.

-- Steve
