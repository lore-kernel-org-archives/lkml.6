Return-Path: <kernel-hardening-return-12641-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvHZDVzWmruq4jzLuzsX67o/LitwRTogf2VSPCOusb6eRMhyicP92yqLsURCV+2e1QTB0mz
ARC-Seal: i=1; a=rsa-sha256; t=1521143330; cv=none;
        d=google.com; s=arc-20160816;
        b=s37m3Hfftbp39wQfXHH2UMkHqw+40W6uqKAjDtNyajjDiNaNQIVxe42he6G8fyHHnH
         N+V2Iu1Al66MjBGpNHjNnVsBnrLg7nPQJVIxvJE1Rx1tCWUpo2sQ3n0XXhb9JD8BTaf9
         I29VtwiZxPpCokf7fTj6hCn9mu4xAqjN0efiUB/ZP0gU2kXYyJ8vwgXl9mVLu0BFDk0s
         NhP5iY490brgpY8z/ngq3Yrecer6Qy5r3s2bqb+4rwREJAcXjN+LTZXTcJheBSrUQ+lg
         L4dylH+GVxdyB9nntoiV5bhNV85g3RVoteSM8tsMmuL86828G3EL56sfEU8i8dAjPIT2
         ri8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=WEX7hmkA7/BtMNQu45Oivq9q+iL7cN8WdOfbkas5JS4=;
        b=o/gW7njaj33LCYYYCPOlvKPvrahpMFtV7WwdSjS/4eFUJwBZglH413tSRpMYKDT3AL
         UQvFG+3f1UhOfNpXd2+cq9O+3x/fOi8sTgI/mjLPFUMb8t0sqPntQ5L/TZ5OYWkhUeUe
         O+YUSiOicYFCrB/y88YtvbOQv6AsFqcoy6C1jf9BC5qEbuBr4j6HkFqFZnqwrrtZolo6
         eTd872PbhT0qJ65hXnCOIfwnHXPBZaYISfGt9CGF8AhT+iJDJLO/08AIWvED39KnAp5G
         vLWgplW8MXLC8NykHcFgLQJIe1RLcoVB2liTVqMDnXTT3gjeWdFGilAfDJ5fetMV+Aed
         3Myg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=EPkFf7iw;
       spf=pass (google.com: domain of kernel-hardening-return-12641-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12641-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=EPkFf7iw;
       spf=pass (google.com: domain of kernel-hardening-return-12641-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12641-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	linux-input@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH v4 0/2] Remove false-positive VLAs when using max()
Date: Thu, 15 Mar 2018 12:47:44 -0700
Message-Id: <1521143266-31350-1-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595034389609913870?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I'm calling this "v4" since the last effort at this was v3, even
if it's a different approach. Patch 1 adds const_max(), patch 2
uses it in all the places max() was used for stack arrays. Commit
log from patch 1:

---snip---
kernel.h: Introduce const_max() for VLA removal

In the effort to remove all VLAs from the kernel[1], it is desirable to
build with -Wvla. However, this warning is overly pessimistic, in that
it is only happy with stack array sizes that are declared as constant
expressions, and not constant values. One case of this is the evaluation
of the max() macro which, due to its construction, ends up converting
constant expression arguments into a constant value result. Attempts
to adjust the behavior of max() ran afoul of version-dependent compiler
behavior[2].

To work around this and still gain -Wvla coverage, this patch introduces
a new macro, const_max(), for use in these cases of stack array size
declaration, where the constant expressions are retained. Since this means
losing the double-evaluation protections of the max() macro, this macro is
designed to explicitly fail if used on non-constant arguments.

Older compilers will fail with the unhelpful message:

    error: first argument to ‘__builtin_choose_expr’ not a constant

Newer compilers will fail with a hopefully more helpful message:

    error: call to ‘__error_not_const_arg’ declared with attribute error: const_max() used with non-compile-time constant arg

To gain the ability to compare differing types, the arguments are
explicitly cast to size_t. Without this, some compiler versions will
fail when comparing different enum types or similar constant expression
cases. With the casting, it's possible to do things like:

int foo[const_max(6, sizeof(something))];

[1] https://lkml.org/lkml/2018/3/7/621
[2] https://lkml.org/lkml/2018/3/10/170
---eol---

Hopefully this reads well as a summary from all the things that got tried.
I've tested this on allmodconfig builds with gcc 4.4.4 and 6.3.0, with and
without -Wvla.

-Kees
