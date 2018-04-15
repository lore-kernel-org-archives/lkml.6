Return-Path: <jmoreira@suse.de>
X-Google-Smtp-Source: AIpwx48kc9y597SBjJzYj3aeTEX2ncfRLXPOhCcWdWlJwxPJPxw/ylMKSGlz/LQ1lexJ3zjcPoDU
ARC-Seal: i=1; a=rsa-sha256; t=1523765756; cv=none;
        d=google.com; s=arc-20160816;
        b=w3eVO64FaG1ww6rINpFe8zW8Y9450IX8L60NHw8C9NSAduXgcSEBfNSWwp/ygg7vyi
         8hQfe4XYbfk2/tRp7d0lLYzR8FYXdHKmycjIgPgswWSLB77ki39TMPhawuxtx0Jl/NjJ
         UNCbob3RBLVVovo1sJnOHKGY3cyBiRPAKPAAloe899YKtVzA9ig4SKE5IyscM8GocUfn
         7NxmY6pZRiT0A6EXk0Bdb79rDkBEIkNTDfuN94swjFj/kWpczNYSo6Tcqz34sbkcG/5P
         CdctjV8Xs4c73doUmPlF8/D4TlsahzGIUbL6J3elrODe/Ww7jmJ7I2aFdJiS9k68cL8H
         qrWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=WhlZErktiGxOcB+8ULB3KTi22gnO899ozs147RPZzlk=;
        b=UiYrp3sBpNT07QUhiyVW1nU+d94Rt4wxTUNxBHqYyttMC9VHYjE2qz4MPmhZtrxxHT
         U7bCzfU6bAISWdnuIiP1QV3H8GVV5RIg+JOcrAGN3rr+G0ZqoSaTWLcjbFjHJHoiz7R2
         +Ev9ovqWGmmxHvjgcMGvtpV+oEJUuNGoRj58AaDSP5622cEwsWkN6/4ZLa0VV+aoNSSK
         mEiHb9LwvLNXBcfmDt6W0KHURN+0JGkHCaQp4dcyCCYQnOFpA1Ic+mldAQAleEsIUGCE
         OBipjAkBYfcsSrUod8XxViOEjwtLglLOzyUYQMaKI0c3P4B1X52qiBSZcsUkhBY2XBj4
         lBTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jmoreira@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jmoreira@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jmoreira@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jmoreira@suse.de
From: Joao Moreira <jmoreira@suse.de>
To: kernel-hardening@lists.openwall.com
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	gregkh@linuxfoundation.org,
	keescook@chromium.org
Subject: [PATCH 0/4] x86/crypto: Fix function prototypes
Date: Sun, 15 Apr 2018 01:15:38 -0300
Message-Id: <20180415041542.5364-1-jmoreira@suse.de>
X-Mailer: git-send-email 2.13.6
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597784201953337868?=
X-GMAIL-MSGID: =?utf-8?q?1597784201953337868?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It is possible to indirectly invoke functions with prototypes that do not
match those of the respectively used function pointers by using void types.
This feature is frequently used as a way of relaxing function invocation,
making it possible that different data structures are passed to different
functions through the same pointer.

Despite the benefits, this can lead to a situation where functions with a
given prototype are invoked by pointers with a different prototype, what is
undesirable as it may prevent the use of heuristics such as prototype
matching-based Control-Flow Integrity, which can be used to prevent
ROP-based attacks.

One way of fixing this situation is through converting the function
prototypes to the one used in the pointer declaration, what means converting
function arguments from a given '<type> *' to a 'void *', and later casting
its uses accordingly throughout the function scope.

Given the above, the current efforts to improve the Linux security, and the
upcoming kernel support to compilers with CFI features, fix prototypes in
x86/crypto algorithms: camellia, cast6, serpent, and twofish.

This patch does not introduce semantic changes to the cryptographic
algorithms, yet, if someone finds relevant, the affected algorithms were
tested with the help of tcrypt.ko without any visible harm.

Joao Moreira (4):
  x86/crypto: camellia: Fix function prototypes
  x86/crypto: cast6: Fix function prototypes
  x86/crypto: serpent: Fix function prototypes
  x86/crypto: twofish: Fix function prototypes

 arch/x86/crypto/camellia_aesni_avx2_glue.c | 25 ++++++++---------
 arch/x86/crypto/camellia_aesni_avx_glue.c  | 21 +++++++--------
 arch/x86/crypto/camellia_glue.c            |  6 ++---
 arch/x86/crypto/cast6_avx_glue.c           | 22 ++++++---------
 arch/x86/crypto/serpent_avx2_glue.c        | 14 +++++-----
 arch/x86/crypto/serpent_avx_glue.c         | 19 ++++++-------
 arch/x86/crypto/twofish_avx_glue.c         | 30 +++++++++------------
 arch/x86/crypto/twofish_glue.c             |  7 +++--
 arch/x86/crypto/twofish_glue_3way.c        | 10 +++----
 arch/x86/include/asm/crypto/camellia.h     | 43 +++++++++++++-----------------
 arch/x86/include/asm/crypto/serpent-avx.h  | 25 ++++++++---------
 arch/x86/include/asm/crypto/serpent-sse2.h | 30 +++++++++------------
 arch/x86/include/asm/crypto/twofish.h      |  9 +++----
 13 files changed, 108 insertions(+), 153 deletions(-)

-- 
2.12.0
