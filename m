Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522085541; cv=none;
        d=google.com; s=arc-20160816;
        b=eGpkLYGX8slGsL65tKTu5fShCDHdifLlxb61B8p6xQq2fHCQWoxQPk0FRwE7AeTaxD
         BulC0m0Ui3YVfvr6N9L6JOMWjujZ8iYIWgxtseMKrzxIG8FgvYPI/Z4Bt/TJgQV3emP6
         Mg50G+6W3wLL+iy1zciKh64TFeDMgQms9xNHLOCoR9pl4GuKH7IjzBy7mUa1l+YsIc7E
         Y0LSsBNBcGMgD62FbJJ5AunhyObktBHcizxVA8y7uDs10Dg5BhkFYbq+rydSkiG5VI1M
         CnvJH/FPq2JPuae8W9RIE1kdvdCLzY/Vzgs37g403ZeOYsw3bBAxnpTv8p4SKTrP5wMS
         8b2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=LUBgbgI7yvlMtf36cSs+cg/hvzlMvBPaHo/WoSGxD9k=;
        b=Uo+KAZgDxNnfH7obNLsSmLaEuenTfj4dSgvMunEx4fphD+JLXDCk+RbwBoH3zUYnD0
         t7pf8rvusxJ2+qZSuHOih2ZQK/TEP2kPzlVEet9tTPzQmiVZvNdSlkqBu44MP7fI7GdY
         yIe0l8bZuANPUEHKexnwW3pV3u5PcyUPPGI23a2aIJEPmykB1eJGw1+n0e8ZzwcqaleD
         Kyx1TVanz64diXIxKJK8rdCODF8Tk3vXRI5cyTl5B5uUo+4HEHiGw+284RqBV7MybT5Z
         j1xWIUsXXMdmzBQWaQksyuj4ZkbaH5Qn/LsYYKDayXHETh5gnXy5HyzoVsroi1SGCugk
         T4hA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Vwdh+5iZ;
       dkim=pass header.i=@chromium.org header.s=google header.b=GyQ0EuNy;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Vwdh+5iZ;
       dkim=pass header.i=@chromium.org header.s=google header.b=GyQ0EuNy;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4/P4bZAqatnpMbEVnBG2KQmzHT6rG0KwzId2p7jlAnv1Erpmv/QH66mQOvSd4szC1RVnRgYmWm+CrUPN1uD7Yw=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <ac1a2090-e120-d202-35b4-b158d4787ab5@linux.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-3-git-send-email-alex.popov@linux.com> <d968e58a-3abd-8e3c-cee3-00c19c1b6430@linux.intel.com>
 <94f268b2-31a4-620a-86ed-325d5bb33c57@redhat.com> <20180305202535.GX25201@hirez.programming.kicks-ass.net>
 <e043e0d6-3265-4bc2-ae11-ab430832a8e2@linux.com> <295a6830-fce9-ee00-f45d-7dafd74d11a1@linux.intel.com>
 <ac1a2090-e120-d202-35b4-b158d4787ab5@linux.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 26 Mar 2018 10:32:04 -0700
X-Google-Sender-Auth: 7jj-o8j2U-i7jBl9rc7FbycemMM
Message-ID: <CAGXu5jKLErrvewvSiusr7qPup-08YgvLKC1ZT7FKTR_RyDSTuQ@mail.gmail.com>
Subject: Re: [PATCH RFC v9 2/7] x86/entry: Add STACKLEAK erasing the kernel
 stack at the end of syscalls
To: alex.popov@linux.com, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Laura Abbott <labbott@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>,
	PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>,
	Ingo Molnar <mingo@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Borislav Petkov <bp@alien8.de>,
	Richard Sandiford <richard.sandiford@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	"H . Peter Anvin" <hpa@zytor.com>, "Dmitry V . Levin" <ldv@altlinux.org>, Emese Revfy <re.emese@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Garnier <thgarnie@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Josef Bacik <jbacik@fb.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, "David S . Miller" <davem@davemloft.net>,
	Ding Tianhong <dingtianhong@huawei.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>, Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Mathias Krause <minipli@googlemail.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947982901315923?=
X-GMAIL-MSGID: =?utf-8?q?1596022369017369603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 1:56 PM, Alexander Popov <alex.popov@linux.com> wrote:
> By the way, during my work on STACKLEAK, I've found one case when we get to the
> userspace directly from the thread stack. Please see sysret32_from_system_call
> in entry_64_compat.S. I checked that.
>
> IMO it seems odd, can the adversary use that to bypass PTI?

If it was missing the page table swap, shouldn't this mean that the
missing NX bit would immediately crash userspace?

-Kees

-- 
Kees Cook
Pixel Security
