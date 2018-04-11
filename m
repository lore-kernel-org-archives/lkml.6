Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbeDKO1G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:27:06 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:11485 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbeDKO1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:27:04 -0400
X-RZG-AUTH: :P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zW8BKRp5UFiyGZZ4jof7Xg==
X-RZG-CLASS-ID: mo00
From: Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        Eric Biggers <ebiggers3@gmail.com>,
        syzbot <syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] crypto: DRBG - guard uninstantion by lock
Date: Wed, 11 Apr 2018 16:26:18 +0200
Message-ID: <2186798.qrgUIDAn9S@positron.chronox.de>
In-Reply-To: <CACT4Y+bRmYMt3WuVHE7e624KgRUTXQWa36wn-pr_gm2STq80bQ@mail.gmail.com>
References: <001a114467482dbc4b05692df8f9@google.com> <2704286.80iLvC0rRL@tauon.chronox.de> <CACT4Y+bRmYMt3WuVHE7e624KgRUTXQWa36wn-pr_gm2STq80bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dimitry,

This fix prevents the kernel from crashing when injecting the fault. 
Stack traces are yet shown but I guess that is expected every time
a fault is injected.

As to why KASAN did not notice this one, I am not sure. Maybe it is
because I use two buffer pointers to point to (almost) the same memory
(one that is aligned and one pointing to the complete buffer)?

---8<---

During freeing of the internal buffers used by the DRBG, set the pointer
to NULL. It is possible that the context with the freed buffers is
reused. In case of an error during initialization where the pointers
do not yet point to allocated memory, the NULL value prevents a double
free.

Signed-off-by: Stephan Mueller <smueller@chronox.de>
Reported-by: syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com
---
 crypto/drbg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index 4faa2781c964..466a112a4446 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1134,8 +1134,10 @@ static inline void drbg_dealloc_state(struct drbg_state *drbg)
 	if (!drbg)
 		return;
 	kzfree(drbg->Vbuf);
+	drbg->Vbuf = NULL;
 	drbg->V = NULL;
 	kzfree(drbg->Cbuf);
+	drbg->Cbuf = NULL;
 	drbg->C = NULL;
 	kzfree(drbg->scratchpadbuf);
 	drbg->scratchpadbuf = NULL;
-- 
2.14.3
