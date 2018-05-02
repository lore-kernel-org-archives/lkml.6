Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZrClFR+ka0+OHrnBhTmw4xcr1Ql54R/OKsgFfDAcI8SgJvR181lLI6jCq1jBSTlD1XGLR0o
ARC-Seal: i=1; a=rsa-sha256; t=1525301449; cv=none;
        d=google.com; s=arc-20160816;
        b=Lof0BbyX0gw5Tbg5XaS7Sn+r6L/7qLwBg0TRZNoQ0YxiLubmyVQWYWVMff04iAQQy9
         6bZoImUcWG222eAaOliOSZIhNiF/LTVuNzM6w2L/pb6Y6NhiN7uqzSZJ5eByTBRPBi57
         vuhXZiFAeyT3UgCX3jqkfbLvAfw+nDK1BN0N3gbCQGR0bdgVs7tNXqGYLlp3SZKx9yhs
         oXm1iQ0jHP98RFyqeR4U0hhv64+HCjIDKQouPiyNAoFUHhHZR1v/LwYfhCuinFjufezT
         1z/4xW5i5OBGgnqN5AcI6AvSArUO9ChAVuVUGq8uLuzBw6F0PGZLF/t4oBS5xdRsHYQr
         zS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=7gO43wz8UYHRaLZ2Fl1Rj1tQ0qty6vORCwDE1NgeC/8=;
        b=w5V3Vcbvojoexscp6FWbech/K20NLfEWtB6RoglsmYY45eg+VevPwT/29tgQxj38Tr
         yY0+ML3Rler0W5q7wGwRfg33pLmThm+VW2A6DP1IHr3Ghc1BXMnE4wkszHv+gUCTtuwi
         QPtoG/dAPApEGjINs7EqqnlABYOg7OTaZ1D3xo9G1utDNRjQd/a756ThOYDoM+9qgCHl
         jPsbodyaYK9Mn1Iq+wpMmgurNya8oIo+yG2S76h/u5gY+gJ2i22HMGZ4rLIYsaXAXJwR
         fzG2QlWW1reN1uL0XAY+oV3PGBoXj2LSwSMb+Udl3N4f1Sxjsqx1cESKe6/ELRvJLex/
         KiMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=ZD6Vf+Ye;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=CjE5ijS+;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=ZD6Vf+Ye;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=CjE5ijS+;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:yUDqWlCO5-f8AGeXp6-xhbfNXBIjMEnHnzsnv2hg2E4iTLKk9WHwbw>
From: "Tobin C. Harding" <me@tobin.cc>
To: linux-kernel@vger.kernel.org
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 0/4] enable early printing of hashed pointers
Date: Thu,  3 May 2018 08:50:22 +1000
Message-Id: <1525301426-23543-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599394493002797024?=
X-GMAIL-MSGID: =?utf-8?q?1599394493002797024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently if an attempt is made to print a pointer before there is
enough entropy then '(____ptrval____)' is printed.  This makes debugging
stack traces during early boot difficult.

It was observed that we can relax the requirement for cryptographically
secure hashing when debugging while still maintaining pointer hashing
behaviour.  This allows kernels to be debugged without developers
relying on different pointer printing behavior.

Using the hw RNG if available solves this problem for those machines
that have a hardware RNG, we would like to solve it for _all_ machines.

Patch 1 - Whitespace fixes.
Patch 2 - Fix get_random_bytes_arch()
Patch 3 - Use hw RNG for pointer hashing if available (by default).
Patch 4 - Use insecure hashing with command line option 'debug_early_boot'

Ted,

I retained your ack for patch 1 and patch 2 even though this version
changes patch 2.  Specifically, uses min_t() instead of min() and adds
__must_check function declaration in header file.

Changes since v1

 - Use min_t() instead of min() (thanks checkpatch).
 - Add __must_check to function declaration (thanks Steve).
 - Use hw RNG by default if available (as originally suggested by Kees).
 - Add command line option to use cryptographically insecure hashing.
   If debug_early_boot is enabled use hash_long() instead of siphash
   (as requested by Steve, and solves original problem for Anna-Maria).



thanks,
Tobin.


Tobin C. Harding (4):
  random: Fix whitespace pre random-bytes work
  random: Return nbytes filled from hw RNG
  vsprintf: Use hw RNG for ptr_key
  vsprintf: Add command line option debug_early_boot

 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++
 drivers/char/random.c                           | 19 +++++++------
 include/linux/random.h                          |  2 +-
 lib/vsprintf.c                                  | 37 +++++++++++++++++++++++--
 4 files changed, 53 insertions(+), 13 deletions(-)

-- 
2.7.4
