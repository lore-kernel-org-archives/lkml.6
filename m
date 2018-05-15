Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZqZMhBYrEwI5moCUQ+QM5dSBPvyD6LKFeRgsEmaUhqTdaSd/0rGfPytSg7GFmb4DMAe3a7V
ARC-Seal: i=1; a=rsa-sha256; t=1526353607; cv=none;
        d=google.com; s=arc-20160816;
        b=y5VuzzwuQw5+raM2e+0BvofsWSP9Iz8YXXUuntb4IG7f7O9ZIFDjcZ32JFkEWH3Y1G
         cQwX8lwV0FXTs5s4WRGVKT/t+GnL7bRcTmKYyig5E4nqVIzcjtAtwF/sQvBz8C9ekJ19
         9adnLDKeeZ4t8xu1Qgtq653bnz+ROZp3fgwNpuxnp+Fg8HUmx659zmcMAOAFeY02mZKT
         zgmlQGiX+/8sLHw4F0IWod3gIJphcRWb/L3MKVNJtoc+UZGPDqLUdWCMT6blDS0QTnfQ
         qXbLfdRErf9GajjHr6T9Uu5zPoSFG/+RV9PZ6JkhxoXs0F58O5QVCZA61vwmH9mS0W8K
         q61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=aOPAFLcbNrUfBMokknoWWZh6F1XVl0e/zgtOw7uagaM=;
        b=MpWIj26pA5sfnP3LE4ROxdoAHksvqgFNba8w+bIq9gJJHK+gmQ8FkNijBkTWWsUggo
         W5n9yslHQ0IocilIx03nA/uD8RXBkkG2tcUye0fZsWMrp598EXW0R2kMWycWOVhXfqRT
         0wj6M2+XmMCMgqV4Yc99/O65LHqIcyVbLmnVESRbtCHCBHhT9TfEFlxtkv86ZoA31e8+
         0OODnp17OfFmuHfpmjG/iwCuaYzPqMRLShat0JrmSZ1bfi2fhKXVNIOPBuvWIh/DkTUh
         fGsSzxtr3YbyW4RKKcb42GidUu/nO680TU0dvjSwt6gu1z8YBAic/GUc3ODtD/LVEsEy
         gq4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=GuIjjn/q;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=WUjJlGXa;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=GuIjjn/q;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=WUjJlGXa;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:xU76Wp6ra9X0plb8vECtOAfLBJEipwDX9nlWlOnxWqCEtk_cvxHA4A>
From: "Tobin C. Harding" <me@tobin.cc>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] enable early printing of hashed pointers
Date: Tue, 15 May 2018 13:06:23 +1000
Message-Id: <1526353586-30092-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600497759818184768?=
X-GMAIL-MSGID: =?utf-8?q?1600497759818184768?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently if an attempt is made to print a pointer before there is
enough entropy then '(____ptrval____)' is printed.  This makes debugging
stack traces during early boot difficult.

One partial solution to this problem is to use the hw RNG if it is
available.

This version drops the final patch from the series to facilitate 
merge via Ted's tree.

Ted are you able to take these patches please?

Patch 1 - Whitespace fixes.
Patch 2 - Fix get_random_bytes_arch()
Patch 3 - Use hw RNG for pointer hashing if available (by default).


thanks,
Tobin.

v3 -> v4
 - remove last patch of series (command line option patch)

v2 -> v3
 - Add __ro_after_init (suggested by Kees).

v1 -> v2
 - Use min_t() instead of min() (thanks checkpatch).
 - Add __must_check to function declaration (thanks Steve).
 - Use hw RNG by default if available (as originally suggested by Kees).
 - Add command line option to use cryptographically insecure hashing.
   If debug_early_boot is enabled use hash_long() instead of siphash
   (as requested by Steve, and solves original problem for Anna-Maria).

Tobin C. Harding (3):
  random: Fix whitespace pre random-bytes work
  random: Return nbytes filled from hw RNG
  vsprintf: Use hw RNG for ptr_key

 drivers/char/random.c  | 19 ++++++++++---------
 include/linux/random.h |  2 +-
 lib/vsprintf.c         | 19 ++++++++++++++++---
 3 files changed, 27 insertions(+), 13 deletions(-)

-- 
2.7.4
