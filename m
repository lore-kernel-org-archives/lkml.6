Return-Path: <wvw@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524597614; cv=none;
        d=google.com; s=arc-20160816;
        b=qeCM4qyONgLQXSZr3HsaW/rH8gYnGZaDQDQAc/JiAiIDN1z3Dwduvn3OyJbJT/CQZm
         5fuon+GKSJLye3u6rwRjtg6uFwWpVRlh+6dYbvvJZeIgnN05YW9dgJNPneD+UhDZCGFM
         KmgJd2TQ5EvKgLBQtPWxbunIZuyw/ow0AZ5vNzKEGhxxpr/OEHGSwgVy8QdtD8w+vG/3
         ww3bKx96MgjpDqqGAU3kuGPKATL/VFpJuyZ6kwFkogX4KFXUx+ELlRQ8oZ1LqNqTv/Gj
         qegVVE/0gZqxcFxbFWUHspg/lnZKjPhC9X4kDSk8XE7SjSn5DBAu63+s8ttDa5JkgF1j
         sZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=z8awwIQ/WbSUlJFVYf43ZMZIKtrHU+TPDPvaQ/nqPIE=;
        b=IrlnWFSVRX8q+JJP68E9EzoHLIQ+6O2wHoJg15WGpQuClLXxY0vGL6h2Cn2ZcrMrEm
         4oqycDoKmT7TeNiZppX6XJfIIpNGjumelsasf/XtL34FtRi/Qo4PmAEZtOjesyC6QurD
         WOaUTUX4ay0cpG4xVDyTyP8V7xIq0ziJhs/slzEBqkZA6UrXAEapRx2BlHlx/EVvoMZt
         ouLjYoWy26THUcFAaIv1PW7DRN1MohJZXc4s4vhT8nj7OyOjt80GQu/0IrI4rVN2gxPq
         kxWePASvijtxXMXlwWkLzJKfdm1WlHy7PdQO155g0ThnJ9+B7Rcq1dKQGmzC5TXZm7uS
         7IJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=D791feuw;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=D791feuw;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4+MLryISL/3FzFNWSRPE8PEHhU2sGoB/UPX53RInNHZTm1lpco0ucB1bXqwmk53uAda5KLwun/cFEv/ua65Pyk=
MIME-Version: 1.0
References: <20180424180812.215900-1-wvw@google.com> <20180424145056.7c29ea18@gandalf.local.home>
 <CAGXk5yo44kAku+ZYx=8HzOgkEVC7ARNSER4MvWTCz-i51up=ew@mail.gmail.com> <20180424151416.397fbbde@gandalf.local.home>
In-Reply-To: <20180424151416.397fbbde@gandalf.local.home>
From: Wei Wang <wvw@google.com>
Date: Tue, 24 Apr 2018 19:20:03 +0000
Message-ID: <CAGXk5yriz2CtCN-vkL0q7gdpV+f8+9GJH-FT+v3KBLb-fWoCZA@mail.gmail.com>
Subject: Re: [PATCH] do not call trace_printk on non-debug build
To: Steven Rostedt <rostedt@goodmis.org>
Cc: gregkh@linuxfoundation.org, Wei Wang <wei.vince.wang@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Crt Mori <cmo@melexis.com>,
	Alexei Starovoitov <ast@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598651942651560845?=
X-GMAIL-MSGID: =?utf-8?q?1598656468284063975?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

checkpatch.pl sounds good. One thing to add is we have many off tree
patches with abuse trace_printk. Also as you mentioned, given this is
really not for use in production and we have been cleaning this our on our
side for years, could we consider to enforce this in kernel?

Thanks!
Wei
On Tue, Apr 24, 2018 at 12:14 PM Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 24 Apr 2018 19:02:34 +0000
> Wei Wang <wvw@google.com> wrote:

> > We have seen many cases vendor have shipped kernel/drivers with it, and
> > have to clean up that every year. This was brought up in an internal
> > discussion and Greg suggested have some feedback from upstream about
what
> > should be taken to prevent this globally besides fixing individual
drivers.
> >  From him "I think this change makes sense at a high level, but there
could
> > be non-obvious reasons why this isn't the way things are handled right
now."

> The thing is, trace_printk() should not be used except for development
> and debugging. There should be no use cases in the kernel that us it,
> unless it's part of something else that should never be used (I use it
> for the ring buffer benchmark which itself will destabilize the
> system and is why I use it - I want that warning for it too).

> Any trace_printk() in a patch submitted to the kernel should simply be
> stripped out. If someone wants a trace_printk() in their code, then
> they should create a trace event, which is the proper way of retrieving
> static data from the kernel. Using trace_printk() is just a lazy fast
> way to create trace events.

> Hmm, ideally I think check_patch needs to add a warning if
> trace_printk() is used.

> -- Steve
