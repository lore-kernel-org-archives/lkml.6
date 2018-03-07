Return-Path: <kernel-hardening-return-12209-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvGAW8GJCLjk9zXBZ0/fgpUO3CnVD3EJAdG7rRDw8CO1b9h5xkTiSgaGbA46GXvUTC+h6bB
ARC-Seal: i=1; a=rsa-sha256; t=1520451678; cv=none;
        d=google.com; s=arc-20160816;
        b=Eezo7WahOrNY0c9BX6O334O7s244+vhCkWjt9rPhVZYgpHaeAl+NlUxOLOQNYz8pg4
         LYPio3SnkT4aE7y/31foNUT6XgCMb97IIRTspADm6nsogve4ml4FqN2uPt73TWDxuR4l
         acRM+VGFoTnBi3DInyRVt1MsX12COPBl0w5DL3RWvz/iMKgGIUPjjDjL9+uoWq3CAu0U
         aInTC+H4gDAJQ9WNhAuYU0E7TmyVx7GBf9kvfSY+1C6oDL5dR+dyyEOAPBwes88za0rp
         EaPQ7uK5DPLWsPn18GztkaZZkNIJ/8DZNMpMiF1HMUJUnIwZgz7HOYTMaWzoD+u3YS5G
         LnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=QOe79mf6uTVcFzs5hmhXdAxvO+JZiYkx0I0ZIx1HWvE=;
        b=MaFKNdGvqWX7Tp2OndkY//TtVgMugS9XgT+OOjc4N9GoINZYzqkerEUWeqhlzyNfMa
         mNDcaJ96xHfwxw7tflg+mrenki7C7pqLgnpLwIoy7jCyhqcLUBovyro3XSBypC6A7yix
         /Qu1UW7fkDio/jr1ESGfNzCN1sRlBhcPV3nA1B5OMVLOc4yTCBLPJnLAQRo2uUw+cDzk
         uj389cXBtMu33EpYITwuGUwuND75qcPuuDAZSzC/Q7+H61h1fVQU60rKlO+GdPWiV6wA
         Cv6jNBo8H6Qz6mt/q6LkHlfp+KCGiwQNnhemi+xydYJTq2AYQfVH0s/TAvxl+VDpRPQo
         0ZwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12209-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12209-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12209-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12209-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 7 Mar 2018 20:31:10 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/vsyscall/64: Drop "native" vsyscalls
Message-ID: <20180307193110.GA3307@isilmar-4.linta.de>
References: <519fee5268faea09ae550776ce969fa6e88668b0.1520449896.git.luto@kernel.org>
 <CAGXu5jKOQPNuXR5At7984FSMHHrT7G6z7Tx5SdfP+62WON7JNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKOQPNuXR5At7984FSMHHrT7G6z7Tx5SdfP+62WON7JNA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594307354733708248?=
X-GMAIL-MSGID: =?utf-8?q?1594309139337966821?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 11:21:46AM -0800, Kees Cook wrote:
> On Wed, Mar 7, 2018 at 11:12 AM, Andy Lutomirski <luto@kernel.org> wrote:
> > Since Linux 3.2, vsyscalls have been deprecated and slow.  From 3.2
> > on, Linux had three vsyscall modes: "native", "emulate", and "none".
> >
> > "emulate" is the default.  All known user programs work correctly in
> > emulate mode, but vsyscalls turn into page faults and are emulated.
> > This is very slow.  In "native" mode, the vsyscall page is easily
> > usable as an exploit gadget, but vsyscalls are a bit faster -- they
> > turn into normal syscalls.  (This is in contrast to vDSO functions,
> > which can be much faster than syscalls.)  In "none" mode, there are
> > no vsyscalls.
> >
> > For all practical purposes, "native" was really just a chicken bit
> > in case something went wrong with the emulation.  It's been over six
> > years, and nothing has gone wrong.  Delete it.
> >
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> I related news, I wonder how long before we can switch from EMULATE to
> NONE as the default? glibc 2.15 (which stopped using vsyscall) is (not
> coincidentally) 6 years old too...

Or, in the meantime, add a warning

        if (vsyscall_mode == EMULATE) {
                warn_bad_vsyscall(KERN_INFO, regs,
                                  "vsyscalls are deprecated -- use vDSO instead");
        }

Otherwise, the patch looks good.

Thanks,
	Dominik
