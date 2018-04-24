Return-Path: <wvw@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524602379; cv=none;
        d=google.com; s=arc-20160816;
        b=eiX20cS7plqFKXrgp9xXaADwb95i7Ye6oBZeOhGJBwZG00HzRTlIvgFn9JG8zIXfiE
         H68Iiv2cCrALLrqs16i5WmMAP5lw8kg3tQQ0rOD2+dINbL+lrtVYREsrfu1yjeywmPdX
         18NjEMDe/rC/D+xPxvg9vbx6274ihaC4Q9rYAN7Glcr8J7iCuMWNqZI+jdWoj4IrBgmw
         PX4fbi551oLbkvKT0gJXjH2HzGAHGLoiEjMwYWOv65KYy5GzSj/yRqz1hMEdTjY20J8B
         Z/b629sCt2njDWi0IgX9tWl4ZBxk3Kw+E4DTuC8y4LvMCAc3iZRK0WVd2GMtUdZgYcxn
         xYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=EIbvTsDFJFM76ftJi3V3r7423OaRP15Ty8clscqRxI0=;
        b=S3b2+9hHulqlANEArVjyIwUGNk6S7eyTWOYYSVIpOmdhoF9kZglKA4irmEEFSbBLSu
         QE86rqvfR+x9xMSSAe7Z7jgMIPnMEFWS4VPnr73fisIBAyMpnWT6zwlQqYP44AlYS+fy
         PiCKmoosrTBC5z23ED9bmXJnFefTubbJ2PpgqaT//MgdB3f+/O3fP/qL3xWSwvauccwF
         Uu2KqJv4MN7JDwcpKjO5hnWS2xnC7uvUB0cLP+wU8Xj/H6yJytv/sJiFLQ/cB6ev7oh1
         cMzJA0WusxpCA7MhUKM07YngopmTLcnnSanCUS+mEsHgRZQ1f6Tt9MGMNNT4wHoURMx5
         c3WQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=rzeV+KGz;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=rzeV+KGz;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx49rUWPS9YcJqj0/oY/SsFWNj+az4rg72jF7E2IMA+HXDu1BFEMkgn+Z7PRB37mRZwkZrS2Z39CSiCUndFLC2Bw=
MIME-Version: 1.0
References: <20180424180812.215900-1-wvw@google.com> <20180424145056.7c29ea18@gandalf.local.home>
 <CAGXk5yo44kAku+ZYx=8HzOgkEVC7ARNSER4MvWTCz-i51up=ew@mail.gmail.com>
 <20180424151416.397fbbde@gandalf.local.home> <CAGXk5yriz2CtCN-vkL0q7gdpV+f8+9GJH-FT+v3KBLb-fWoCZA@mail.gmail.com>
 <20180424152607.71fbee34@gandalf.local.home>
In-Reply-To: <20180424152607.71fbee34@gandalf.local.home>
From: Wei Wang <wvw@google.com>
Date: Tue, 24 Apr 2018 20:39:27 +0000
Message-ID: <CAGXk5yre3aDtVbtEz4=DdBnLrT3U=LPA69jOp9zmkfeYiZ7w=Q@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1598661464629691475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018, 12:26 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 24 Apr 2018 19:20:03 +0000
> Wei Wang <wvw@google.com> wrote:

> > checkpatch.pl sounds good. One thing to add is we have many off tree
> > patches with abuse trace_printk. Also as you mentioned, given this is
> > really not for use in production and we have been cleaning this our on
our
> > side for years, could we consider to enforce this in kernel?

> That nasty warning was suppose to be the enforcement. I would expect
> nobody would ship a kernel where it produced such a message on boot (or
> loading of a module). If they don't notice, then they are not testing
> their code.

> A lot of kernel developers use trace_printk() and I want to make it as
> easy to use as possible. I don't want to add a config to enable it,
> because that would be something that could be rather annoying.

The config is not something new and it is controlling pr_debug and
pr_devel, so might not be too annoying, IMHO. But I agree this is not a
problem from us but from abusers.

Thanks!
-Wei

> Let's add it to checkpatch and see if that can draining the swamp of
> abusers.

> -- Steve
