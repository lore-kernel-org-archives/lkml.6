Return-Path: <wvw@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524596565; cv=none;
        d=google.com; s=arc-20160816;
        b=OviWrb3ug23yOpPa/2b7y5AbWMLHmNqF/rGrtAUlZXmmDsdgyqbdHjdGJzEVQTYNSs
         h/oD6qBO3IRg8wdYoUs20P6GpINmfGBIV/JcynFVois8l+FZ8LPONhCttgvuVkD3KryX
         k6TTd7d7OwKEBqVcQDZRDTmavxDPnGeAKLQ/gYbzaH5/2r01pIUZLiJXdaGASCXwTNHh
         CbC6cUsQY6KPjUqesmHjLmlsNYyfEc856EvLWEy/yzkecb/5ka/Q68qQe5IrGF3F21HS
         9DBZzjHQpJtYsbo5AMo8SgkOwDZwN+X9NIxcv+3AsPyTkuv2K6xKO8HqkeDNQ0L5/v5j
         C6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=4AXNzCfdUgDMxPYj+bNQNGR8UhgVM0T1je1iNaR9pzk=;
        b=LnIwcuXJK6edqWY22UPcksOEfFVvexYrjvh+xM2S6VO/tlG859ErXdfPWM50jUx9zh
         WeMy67vddAEzBqAW/w4B3ikKbCeZsoikOA4HRGnjn3GTFL78Udgrbyl2qtllubclK+Rw
         alKGrA/YajT6yVwrFbxS2sDFLNd9vYPgUHtSrdvTyo9s58LGfXzIIFdSMOCAZ/22v55h
         BL31EA4E0CaldIwZTxKR1XBm/6nHQu4hh1968WOE/7qKEZ+krDt01u/o1p3AWzGY92Fe
         JM91Tlkyb/ajFY9f4Zl7zuKoqZNOjUIBxkDpot+ALlLQ3D/t0QT2Jm0M+FJIEgC3TmNs
         B4ng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ZHE0Uu8Z;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ZHE0Uu8Z;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx49eFG+IHTEL53oyuet5BY5humYpHv8K5qpoF5U0jaB0hn7J8hSju57OQ41PEQSh+SSDt+RoJtesJeNoqO9ekl8=
MIME-Version: 1.0
References: <20180424180812.215900-1-wvw@google.com> <20180424145056.7c29ea18@gandalf.local.home>
In-Reply-To: <20180424145056.7c29ea18@gandalf.local.home>
From: Wei Wang <wvw@google.com>
Date: Tue, 24 Apr 2018 19:02:34 +0000
Message-ID: <CAGXk5yo44kAku+ZYx=8HzOgkEVC7ARNSER4MvWTCz-i51up=ew@mail.gmail.com>
Subject: Re: [PATCH] do not call trace_printk on non-debug build
To: Steven Rostedt <rostedt@goodmis.org>
Cc: gregkh@linuxfoundation.org, Wei Wang <wei.vince.wang@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Crt Mori <cmo@melexis.com>,
	Alexei Starovoitov <ast@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598651942651560845?=
X-GMAIL-MSGID: =?utf-8?q?1598655367770738006?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We have seen many cases vendor have shipped kernel/drivers with it, and
have to clean up that every year. This was brought up in an internal
discussion and Greg suggested have some feedback from upstream about what
should be taken to prevent this globally besides fixing individual drivers.
 From him "I think this change makes sense at a high level, but there could
be non-obvious reasons why this isn't the way things are handled right now."
On Tue, Apr 24, 2018 at 11:51 AM Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 24 Apr 2018 11:08:10 -0700
> Wei Wang <wvw@google.com> wrote:

> > From: Wei Wang <wvw@google.com>
> >
> > trace_printk will cause trace_printk_init_buffers executed in kernel
> > start, which will increase memory and also show bad warnings in
> > production kernel.
> >

> NAK!

> Where is trace_printk() being used to trigger this?

> trace_printk() is to be added while debugging, but one should not need
> to enable DEBUG to use it. But it should be removed when finished.


Yeah, ideal case is it *should* be removed, but if this is not for
production use, does it make sense we limit the usage with DEBUG?


> -- Steve

> > Signed-off-by: Wei Wang <wvw@google.com>
