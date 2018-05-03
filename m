Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZoTXcI+/7+XwbVR40LdfwJh2+FwCKO26SjUOAnTufxifyMdmL/u5QZq3e0erjNaEe9SuGDR
ARC-Seal: i=1; a=rsa-sha256; t=1525388894; cv=none;
        d=google.com; s=arc-20160816;
        b=RmEqXI6sssaOc2b1kf63mYEpi3A2qYjGxw11BgFYanFBHvnOsIZmZUnu1vEWzgeuHR
         HXV+MxhGD4BjIDn2W2LcW0fPDMwOflkDlsm8quzgoCez9iSXbPgALo0SRGeND/rUGK0b
         qyMo5K80cmT4DrOsscPBArA8SvVFNTnHFtVZmo9aLj18fVd77ZCAvz231JmBYUWIPNmc
         whvukROj2vs2mxd44wiGzHxrcS7L5k8RH2FFdr8VsHx7EGOPtFCBXS2qFY2ldtybJM2z
         1gxvF9XFv8/GwelNWTFbez34DPYNrSUh5Mx7k0vTCES30UpCINTt3sL3uaNyMLFbMWWv
         RtjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=/tlHFd+gMseJg3Es5y+K7QfAVmC8niEinke5k1NGjpQ=;
        b=rNH9jPtbKaqTm7cOw/sR/dZP9hjqRdBtxnQMyMmZ6pRsLWEg6gMREqWBeIX5lfv0Y6
         4yMVLuDuHaduqLroTYxN429eNLc9v550ZzrQEO+vsBVg/ljKOY6Dk63fMFdJb/Yryc/+
         s7IItvCQoaBT97eIN8xd9Ae4v3+VXQjch+1ykmPkHMlNn9HUt9BAS5JS2AED8AS+2lym
         aMPW3Oxo43GZM3fCXWy/b8WWO7/DAKJTxKUvPjIomzy9gzAiyG5LW5gmfXq/xVb40l13
         zNzoPBEJ7QCZcZU205dUQDYjPx2wVSAf2EY5fG8Ue9VshBg2gmTOy3uIzUCK/u2phgi2
         xvsA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=ps71ABuu;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Z2NoyJYX;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=ps71ABuu;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Z2NoyJYX;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:XZbrWvP4_OxtBs_g4XLP6qdZFwzCpkvQB-qhj_I4PPUHI9nZtd6x_Q>
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
Subject: [PATCH v3 0/4] enable early printing of hashed pointers
Date: Fri,  4 May 2018 09:07:37 +1000
Message-Id: <1525388861-27018-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599486185375481881?=
X-GMAIL-MSGID: =?utf-8?q?1599486185375481881?=
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
Patch 4 - Use insecure hashing with command line option 'debug_early_boot'.

thanks,
Tobin.


v2 -> v3
 - Add __ro_after_init (suggested by Kees).

v1 -> v2
 - Use min_t() instead of min() (thanks checkpatch).
 - Add __must_check to function declaration (thanks Steve).
 - Use hw RNG by default if available (as originally suggested by Kees).
 - Add command line option to use cryptographically insecure hashing.
   If debug_early_boot is enabled use hash_long() instead of siphash
   (as requested by Steve, and solves original problem for Anna-Maria).

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
