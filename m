Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZpCPYFlJ3Qi+gWPK25exZFPyVm1+GcwKJmKBXKhuFgTCN/ENQ3VAeKrZKsMo6+HwrGHOMcC
ARC-Seal: i=1; a=rsa-sha256; t=1526426282; cv=none;
        d=google.com; s=arc-20160816;
        b=nMLQu08xRLJqIF37prp58ZOEaSxXJNXLo+RcVWLCtSWfIhmUhwIlVeyVRh1hSip/u4
         NVUG5u8sWkAeyyeZOTVKxnpR69fWoQp6tjUiLJ8AlfAWSbYbjr2s+B3kJA5F2g2zYuZg
         yFeYGvjZPD1AAmJM2PIO0tySCO868DFbBXJjQGL0Az5VoL6WR822XdWrtipqRl0oEbvn
         WwJYYqqowCnvsio5t/09TESmZXTfln1EkEwUsZlvGnt2tkKVGk0PTtc/85q+wAsojdHW
         WOuhiE9LKybYsVWBLW/SBEvPaAUir9+uQzJoORraU+uaVzCjdo/grQREJ7CWIqN51XVf
         DhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=u2+X47n/HA2dQ6eJ2GBkhfW4iQv7zWNjh87hM8NfXtQ=;
        b=xp1sAzGGAm6DX8AybNJbz0sVLjCo4XG6v0B5izWoYRo+FVXpVpqDJiIUTZjvhnPZgc
         aIiPaEEF1jqePtbldQEltD+fMdr0QB1lAm0CL6yWell6FBMVb3SeZ5nWRe6oWNouwyMP
         NE1g7bCeMsS07BKXJtAbzP7v75i6yyk0JVSyYpFlTeCVYzZUouAwKOY9vtW5iWLTFpwU
         FTaqzo7QNplOHsJLZ1BkNG2PTFW9U1n10NTq1y7kJU/7Xl9J0r+t2cXNnFCCVOC+sI+b
         577O8avw3B2JqnCs86/SLlrN76YyFU8hj4p1kJJCqk+pQpzRDJHI3OExrWA6DCu+KryM
         iwLA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=o9Cs4DUY;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=dr/hyPWj;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=o9Cs4DUY;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=dr/hyPWj;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:qWr7Wpe_kBT3mW4ZkwHaqRzMf9TvwsQbUKUFTIPqJkF_5QS0hnhyeQ>
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
Subject: [PATCH v5 0/3] enable early printing of hashed pointers
Date: Wed, 16 May 2018 09:17:36 +1000
Message-Id: <1526426259-23012-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600573966123035587?=
X-GMAIL-MSGID: =?utf-8?q?1600573966123035587?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently if an attempt is made to print a pointer before there is
enough entropy then '(____ptrval____)' is printed.  This makes debugging
stack traces during early boot difficult.

One partial solution to this problem is to use the hw RNG if it is
available.

Patch 1 - Whitespace fixes.
Patch 2 - Fix get_random_bytes_arch()
Patch 3 - Use hw RNG for pointer hashing if available (by default).


thanks,
Tobin.

v4 -> v5
 - Use 'upside-down-xmas-tree' style to declare local variables (Steve)
 - Added Reviewed-by tag from Steve (patch 2 and 3).

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
 - Added Acked-by tag from Ted (patch 1 and 2)



*** BLURB HERE ***

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
