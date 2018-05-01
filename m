Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZo8UjUSaUpVVoaWTQvyUupk+xnk33RYBFT87O3RFKxeFyWn7qZ5L1dzbDt+hnmAnG3OLZ0h
ARC-Seal: i=1; a=rsa-sha256; t=1525217661; cv=none;
        d=google.com; s=arc-20160816;
        b=1Hvm2diXycsgQR+LtTz2Xc7XPuZdxLJFkOMYQC476fN/8WTkIdSNtQH7pxxkUbzvin
         LEXjPw5LJFm1NhDzQ8m1liU2VHcaV+JfUw5wRhD9s9zHXznRnf1j51MagTx0bI5kyI4J
         k8EcaPqUnytHpIFMGrHIJ3xUro50TR+vv9Da1ZlD1WgkgjvCFD91dL0Tak1vOnkmoFn5
         ctOYxQZQSkdPj9Twpc7XzORt09AqLKrmjnV13nQ38WsKXxoZb3FNeosoKqThQ6tVXIz5
         Bs6xTK6SuHS3ZT9PRSNwL/mu+UFIeAP/yJNFavfcPsepu5ppZuAwUIWEp+0dDps4wDrO
         zMNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=0JlHTlVYoFi+DEQerNIjTyv5rTW2PQaGt0X/oO2hmLg=;
        b=z/91THoVzsRt0pmxbBLWCj4uL6GwfLekWtxHupvGl0bbty0wg8K4X5fjCo8pKA6pvm
         ScNOawhDHYsOFqi6jxhnaxQ+5PsQOA/d6dKb8wPq4eHgNnBINsF0IQ6S8t9XM41GJOuv
         o074E67oi1Vt/Jt/94Qw3vd+Nzh9Q/ieIcrgEdRtOdSRZv+u/bQoA9fsI+UWYojVqa3f
         CVpfglV+byj9OKQIEmZ/mhIp9VyokNOYl9m5IZLP6SU8+SZ7saZjO5j90u7nTp7kRrj1
         QMwtu/aBBoH0+YfoKx2MxO4KNJpXEx1ZB23drzRrWYZnwJ17IR5bHUc9U0IbZBCCPfOv
         4dSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=PWfKMki2;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=a7mbvA7p;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=PWfKMki2;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=a7mbvA7p;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:fPnoWgphQOk1PVOv91_YUvxQGRA2aQXe4WwDLpGxa0aT3_-WyCNW5Q>
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
Subject: [PATCH 0/3] enable early printing of hashed pointers
Date: Wed,  2 May 2018 09:33:37 +1000
Message-Id: <1525217620-4107-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599306634651133431?=
X-GMAIL-MSGID: =?utf-8?q?1599306634651133431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently if an attempt is made to print a pointer before there is
enough entropy then '(____ptrval____)' is printed.  This makes debugging
stack traces during early boot difficult.

It was observed that we can relax the requirement for cryptographically
secure hashing when debugging while still maintaining pointer hashing
behaviour.  This allows kernels to be debugged without developers
relying on different pointer printing behavior.

Most of this code (excluding the command line option stuff) was written
by Kees and Linus on LKML.  Any mistakes introduced are however my own.

For the command line option stuff I copied crypto/fips.c mixed with
kernel/power/hibernate.c 

Taking suggestions please on the get_random_bytes_arch() local variable
name 'left' (I thought of 'togo' and 'rem' (as in remaining) as well).

Testing

The command line option stuff has been verified to work.  I have built
and booted a patched kernel on a machine without RDRAND (qemu) and on a
machine with RDRAND (intel core M5Y70).  The code appears to work as it
is written.  I am unsure however whether this solves the initial
problem.  I tried printing a pointer from within 
init/main.c:kernel_init() and that did _not_ work.  I do not know how
early is early, or in other words, when we are hoping for this to work.

thanks,
Tobin.


Tobin C. Harding (3):
  random: Fix whitespace pre random-bytes work
  random: Return nbytes filled from hw RNG
  vsprintf: Add use-early-random-bytes cmd line option

 drivers/char/random.c  | 19 ++++++++++---------
 include/linux/random.h |  2 +-
 lib/vsprintf.c         | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 58 insertions(+), 13 deletions(-)

-- 
2.7.4
