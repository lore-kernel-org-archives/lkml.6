Return-Path: <kernel-hardening-return-12658-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtBF3tHH/JRXvx3rvaBQPF9vpwogMjzVP4B05+n6+13X/0fM+ImWOfcAXuv+iYYmp5bcQDH
ARC-Seal: i=1; a=rsa-sha256; t=1521174394; cv=none;
        d=google.com; s=arc-20160816;
        b=0dCO30gFzl1sg0tejZSI3KjNBliqhbekuO8/yhVW7vRwIfbdIMY11a2bcIN6T8EMfT
         i3+DC5chyTH6VjPqjYtN4kcShVWt7PM12KGwz+zy23RPk8NRmDtWnf05QRg0si/9b/PM
         487xeOPJtas6TfmYF6dUq065K/8u7ie4V60EWXuZ1KMgEm1Km64XiEDmUnSjkpRG2/SF
         tenD7g74rHhwGCWnmYSCk0eeX+exiD6ImNhGT5NLunqadzUAGR/BSxCy/3mrbm1qoq71
         g8MHkDReVX4okLVOVGeMA/fYGAuymmSyXbEHyRwmsXxa7rGnx2q2tdYvrvVhb05ve5py
         5ZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=g16ym/nd7GNeGq39SRZ3sMEIfgv0YoIJRI/vc2tPF8Q=;
        b=uAmlfaOa/GzO2DPIL/1q29QaWLT4V6XRrYVUzBAn/8nF7fzCH16HE2p1QRRb06YF5X
         FRogxIeDHJI8Bk3inZ6bMPE9g6GkYIzEoXfZaxIfgM4w9DQblwqOYxvLgl1ByvBEIGpD
         S9GrgZ8QBewfrd44zAefHC8OJZI0bDeeBIhZTrn/nxnPHLgp7piKfXG/TCGokc0Xw5ba
         X4KoDNgINdPGpnUlOxbX7AxXlrZcIQf60zYrk1wAuW4fpcFBj7qu2gabE7+Oduuqhuf3
         EhNG2pdTkNOiu3dkIkBThSQW5SnFqwpZvnGykB2zTSYu65iqbFSXKo+kGkOQfQKMy9+J
         QnzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=LCtqeYCQ;
       spf=pass (google.com: domain of kernel-hardening-return-12658-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12658-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=LCtqeYCQ;
       spf=pass (google.com: domain of kernel-hardening-return-12658-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12658-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH v5 0/2] Remove false-positive VLAs when using max()
Date: Thu, 15 Mar 2018 21:25:57 -0700
Message-Id: <1521174359-46392-1-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595066961299947624?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Patch 1 adds const_max_t(), patch 2 uses it in all the places max()
was used for stack arrays. Commit log from patch 1:

---snip---
kernel.h: Introduce const_max_t() for VLA removal

In the effort to remove all VLAs from the kernel[1], it is desirable to
build with -Wvla. However, this warning is overly pessimistic, in that
it is only happy with stack array sizes that are declared as constant
expressions, and not constant values. One case of this is the evaluation
of the max() macro which, due to its construction, ends up converting
constant expression arguments into a constant value result. Attempts
to adjust the behavior of max() ran afoul of version-dependent compiler
behavior[2].

To work around this and still gain -Wvla coverage, this patch introduces
a new macro, const_max_t(), for use in these cases of stack array size
declaration, where the constant expressions are retained. Since this means
losing the double-evaluation protections of the max() macro, this macro is
designed to explicitly fail if used on non-constant arguments.

Older compilers will fail with the unhelpful message:

    error: first argument to ‘__builtin_choose_expr’ not a constant

Newer compilers will fail with a hopefully more helpful message:

    error: call to ‘__error_non_const_arg’ declared with attribute error: const_max_t() used with non-constant expression

To gain the ability to compare differing types, the desired type must
be explicitly declared, as with the existing max_t() macro. This is
needed when comparing different enum types and to allow things like:

    int foo[const_max_t(size_t, 6, sizeof(something))];

[1] https://lkml.org/lkml/2018/3/7/621
[2] https://lkml.org/lkml/2018/3/10/170
---eol---

Hopefully this reads well as a summary from all the things that got tried.
I've tested this on allmodconfig builds with gcc 4.4.4 and 6.3.0, with and
without -Wvla.

-Kees

v5: explicit type argument
v4: forced size_t type
