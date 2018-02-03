Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517654763; cv=none;
        d=google.com; s=arc-20160816;
        b=eIROTwXgnA8R3kqfV5vBrqk+PSvGyE3TDbONL18BZky3EtogCFiwYDNs7WGYQBwejO
         qNW930mpV0S+D+cn5JuIAp5huwpDmGWQeRsymq2ZntRhNOZCTpOSpJaZCpWMfQL/tQsb
         fVfEMZypZFpdpTBlF4NhbQC0EX50dSRuuz2kWScc7kdE0h41X4oECip8WcMhe6ST3IHa
         dG5vBrqkzt1KQah4E9RmH17hJ6yNt4X4lv5h75tNXPUL9kDXaCsnLks8k8JmoDG+CDW2
         OhapHbJaRCnJhETzpn6qo+uIjFRacYyFD4B1GNqX2g85lNdBKPYto6UaURkxAvAkCUxt
         LaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=D9cVQ0osoBCdC8C9df2ApguUFHD48YqCbe9m0mee8ks=;
        b=KVAPxB4KfwCevT6DH94m+vj3ADlcz8EXkB8eGsKBkGwAbb0YQKi4kuI6+X7Ju+3j+e
         2blc2qEIghIq0qqIQx7tVCgRIQg/Y234x7ecPTCJsw6ca8vqwrZeCb7J8TW5Ga48qOWm
         45t6fhSDbtMFixrhenHzbzOCoWTiBHNNVo4QN3wtcNqDEYRSQrgYFsIqmlo+9mt5ns2k
         7ncVezDPgTr8O+YnOm5yKKgkiJXhLIfdW4ZtXmm6hLSwfk5t9QeOOeQCohlw2J98gt5i
         vNeauANbg7DySN4Nu7CNhjwr+0Mnd6WnHthPQKQIrgJ6Ydc3WaqHRYtN4fPIEmWlJ5+/
         89dA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=c9JtIt9J;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=c9JtIt9J;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x225CqOXK+Woasn/ezpGJPB9x0rJv1xURrg44gTvOQotN/01xl+qJtCN1xm1eCNF5wozrsekXfg==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 3 Feb 2018 11:45:59 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-gpio@vger.kernel.org
Subject: Re: [GIT PULL] pin control bulk changes for v4.16
Message-ID: <20180203104559.hyhjbmab7oo5zzx2@gmail.com>
References: <CACRpkdaTv4NBrRXeJE6dVi4W88+LZdsTCSzTHi0vdcKMW3Qfmw@mail.gmail.com>
 <CA+55aFzMBptQt-QHMR0MM9MA3=1rxcf8ca5qHxrf4Mm0ZobE_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzMBptQt-QHMR0MM9MA3=1rxcf8ca5qHxrf4Mm0ZobE_A@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591331743286572652?=
X-GMAIL-MSGID: =?utf-8?q?1591376361039292614?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I also wonder if there are any automated tools that try to find these
> kinds of crazy things. I suspect a lot of our build times is the poor
> compiler just reading and parsing header files over and over again,
> and a lot of them are probably not needed.

Yes. I'd guesstimate that in a typical defconfig kernel build the compiler is 
building at least 10x as much as it should with a cleaner header file layout, 
based on preprocessed source code file sizes.

Interestingly the .i file linecount difference isn't all that large between 
allmodconfig and allnoconfig kernels - which I think is further proof of our 
'header spaghetti bloat' problems.

While central files like fork.c or sched/*.c are expected to have a lot of 
dependencies, we also have a lot of bloat if we build much more isolated, 
standalone core kernel functionality:

  # allmodconfig:

  triton:~/tip> wc -l kernel/task_work.i
  43522 kernel/task_work.i

  # allnoconfig:

  triton:~/tip> wc -l kernel/task_work.i
  37123 kernel/task_work.i

  # source code size:

  triton:~/tip> wc -l kernel/task_work.c
  118 kernel/task_work.c

We are bringing in 37 KLOC of headers to build a 0.1 KLOC .c file ...

> A year ago, Ingo did patches limit some of the header file issues for
> the core headers (<linux/sched.h> in particular). Maybe he had
> tooling? Ingo?

No, unfortunately I didn't use much tooling: I only used simple manual tools like 
'grep' and small ad-hoc shell scripts to discover some of the deeper dependencies 
(long lost - nor was there any real value in them). What I relied on mostly was 
randconfig build coverage.

In that sched.h split-up effort a year ago I literally removed/moved the 
prototypes and header files one by one and tried to see what breaks. If the 
breakage was too widespread I tried to grep.

But based on the sched.h experiment I do think our kernel build times could be 
significantly improved by organizing the headers better. Splitting up sched.h also 
improved readability and maintainability, so it was a win-win all around.

With a more aggressive reorganization of our header architecture I believe we 
could achieve a more than 5x improvement in kernel build times (!) - but that 
would involve some trade-offs for header maintainability: a finer grained 
hierarchy is somewhat harder to maintain.

With extreme measures that would involve runtime performance trade-offs as well 
(to get rid of excessive inlining cross-dependencies) we could possibly achieve a 
30x improvement in kernel compilation times: the build would be link time and 
build parallelism limited on most systems.

Thanks,

	Ingo
