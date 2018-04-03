Return-Path: <ndesaulniers@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522792695; cv=none;
        d=google.com; s=arc-20160816;
        b=xQC/DrwIfTlCLSHpX4GPZvTMnqNveoLypguN8E7CLxLAyd3KhRKlCO2vUweRZPPQCR
         H3CxRRtYXXVDkudHizfE0u9AAuC0O/VYR6J2TXmXDRQHAC6X3WC7EjxOHOhp4FYJ0D6K
         eQR0XJd5cMzdW9aCefGhSMMCFT0G0K7Uzy4+O7zR1Ex71BiqKPN1TLs43kpzrAhz8cTP
         sNcmWihfGaN81Sy8JJG2J1kfaKgGzR9qw9d4+SAFUTpsNfcUfSW2GXuevd8RC9eGIW87
         SOcBd4DZv/2o1R+BxbVT/EEZOrKlXUK37w7yHkUlBaKgY8YmiyMDZOqaVqWHcWgYBY4a
         osig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=isfDbmgu2BqmXPUTdg1CZGIqWytoDRiIZTAONraJa5k=;
        b=sFBYCCW6up8LUrtLKWoK62QpErCOjeZsgR+xvfmORsD5Z98z1cGscAYB/UW2T6j9cQ
         6qzYSn4/mjPfIIcuFriKf6BK6CrQrYO+yF736yx3bC8Yv/X35ohM5kyG0BVaYwwc1TNk
         92/I7d88LS9+6YpSPWZE0F8RKgONwicbdAEr0rw70A+lD4UK5+L9ABtsKukCJp6C3LEZ
         rzADmAgIp8jh16Mb/wf8alUP0cH6v4i2Ls+Q8Ik+ozBZ2DmEfttgfZewCCdkXE/dH0lt
         bZiG80mGjuOd8PWmatIgWtYEhpcWnRwoHZ6wtlABDOzp6433tTYzTqvtWaV+WAYkdaxP
         R52w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SaKSsrkm;
       spf=pass (google.com: domain of ndesaulniers@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ndesaulniers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SaKSsrkm;
       spf=pass (google.com: domain of ndesaulniers@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ndesaulniers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48Sfpn4bRKpQOfoJ8EbgLDyrcSSH2lY9PE2JJ5/+ZTSZoDAKSW57qkV6z6mA/vXP7xqsifCQpgrLCPPuzLN6us=
MIME-Version: 1.0
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com> <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net> <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com>
In-Reply-To: <20180403180658.GE87376@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 03 Apr 2018 21:58:03 +0000
Message-ID: <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
	James Y Knight <jyknight@google.com>, Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Kees Cook <keescook@google.com>, groeck@chromium.org,
	Greg Hackmann <ghackmann@google.com>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596763873267430240?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Speaking more with our internal LLVM teams, there ARE a few different
approaches to implementing asm-goto in LLVM proposed, by external parties
to Google.  These proposals haven't progressed to code review, so we've
asked our LLVM teams to reignite these discussions with increased priority,
if not implement the feature outright.  We (Google kernel AND llvm hackers)
are committed to supporting the Linux kernel being built with Clang.

I can see both sides where eventually a long-requested feature-request
should come to a head, especially with good evidence (
https://lkml.org/lkml/2018/2/14/895), but just as you wouldn't accept a
patch that doesn't compile with GCC, I'd like to request that we don't
merge patches that fail to compile with Clang (or at least start to think
what that might look like).  I realize that would increase the burden on
patch authors and maintainers, so I'm interested in better approaches or
ideas.

I've been in contact with the 0-day bot maintainers, kernel-ci maintainers,
and even run my own run down version of 0-day bot on my workstation
hourly.  I think those will help reduce the burden of testing patches with
multiple different compilers.
--
Thanks,
~Nick Desaulniers
