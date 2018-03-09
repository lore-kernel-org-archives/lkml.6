Return-Path: <kernel-hardening-return-12326-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELti+wzNiMcSBBTd7AM2TXNCvKsiyPdIUuItEP07140GcvxlDgZdOwAZ/jz6qdevzExCKF/8
ARC-Seal: i=1; a=rsa-sha256; t=1520606795; cv=none;
        d=google.com; s=arc-20160816;
        b=Q1P5S6yEUbiswvAxPedKP4sDuZuD1nb2hYKrgMx73vzwc26fj7iR/oGfYBjWdCb/w2
         DR1tbcOUkt8qr/PswspUnB/d4izHW77bT4xwQdE9nkBw/4YSS0793Cx9c6/yvftR/uLa
         xd8zsAPwOfmQf7ljPu/ozcXv9Bb2yQ2aj+0qQ2hYFYWWV/pZv6WOuUNxKpIxw2NsXdCj
         jMaQ9uydGQHYf7UZBGOaZKRWzcqxGCjUzng7uGwO+b/OeoP1GtolLc/2FH4O09tKwt4r
         yZDtpuwR9F9Bqlf2RvnkoUziRXsJgY9hQ+qjmHC9JSbGBp7e6XwHoTXAnjPiftm0mWm3
         Upwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=q0VzOF52Dq6HyWLumCgzjCAydt0BRNKrK6W+LyfTT+A=;
        b=LOsZwsW8Fx8D3Zj0GdtbV5B+U8vv9WtxOXjO1i0xrdDJB2Y4MOltfNWCrkdtbXT8S4
         lF2o8585B6o5E7XZmsoze63LZlLdvoUZODly6dodB73h1ReGlcXYHbvujJspUiQGgx/m
         xQPd1Fch+JsMKq0ioyC1HzO8Tc7Ul8TRiDQZFUrFg3v/TnlLjB/6uwIzKYrG3562QYGW
         xVcpRFZiojE246CB2yJxi1kMD9/Tscuhfbcu+mUxn97E3BzCC2+0w0EBuwNeNAhwm5Ib
         Qcwuq49gx3k1eY8cimvN783EJfxK2A8Af10+f9CUvq2HJPYDHnh/JYDatgAfVhi64wN+
         D2jw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=lO/zf0/a;
       spf=pass (google.com: domain of kernel-hardening-return-12326-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12326-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=lO/zf0/a;
       spf=pass (google.com: domain of kernel-hardening-return-12326-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12326-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 9 Mar 2018 06:46:13 -0800
From: Kees Cook <keescook@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Segher Boessenkool <segher@kernel.crashing.org>,
	kernel-hardening@lists.openwall.com
Subject: [PATCH][RFC] rslib: Remove VLAs by setting upper bound on nroots
Message-ID: <20180309144613.GA48965@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594471791016821837?=
X-GMAIL-MSGID: =?utf-8?q?1594471791016821837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Avoid VLAs[1] by always allocating the upper bound of stack space
needed. The existing users of rslib appear to max out at 32 roots,
so use that as the upper bound.

Alternative: make init_rs() a true caller-instance and pre-allocate
the workspaces. Will this need locking or are the callers already
single-threaded in their use of librs?

Using kmalloc in this path doesn't look great, especially since at
least one caller (pstore) is sensitive to allocations during rslib
usage (it expects to run it during an Oops, for example).

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/reed_solomon/decode_rs.c    | 7 ++++---
 lib/reed_solomon/reed_solomon.c | 5 ++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 0ec3f257ffdf..3e3becb836a6 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -31,9 +31,10 @@
 	 * of nroots is 8. So the necessary stack size will be about
 	 * 220 bytes max.
 	 */
-	uint16_t lambda[nroots + 1], syn[nroots];
-	uint16_t b[nroots + 1], t[nroots + 1], omega[nroots + 1];
-	uint16_t root[nroots], reg[nroots + 1], loc[nroots];
+	uint16_t lambda[RS_MAX_ROOTS + 1], syn[RS_MAX_ROOTS];
+	uint16_t b[RS_MAX_ROOTS + 1], t[RS_MAX_ROOTS + 1];
+	uint16_t omega[RS_MAX_ROOTS + 1], root[RS_MAX_ROOTS];
+	uint16_t reg[RS_MAX_ROOTS + 1], loc[RS_MAX_ROOTS];
 	int count = 0;
 	uint16_t msk = (uint16_t) rs->nn;
 
diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
index 06d04cfa9339..1ad9094ddf66 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -51,6 +51,9 @@ static LIST_HEAD (rslist);
 /* Protection for the list */
 static DEFINE_MUTEX(rslistlock);
 
+/* Ultimately controls the upper bounds of the on-stack buffers. */
+#define RS_MAX_ROOTS	32
+
 /**
  * rs_init - Initialize a Reed-Solomon codec
  * @symsize:	symbol size, bits (1-8)
@@ -210,7 +213,7 @@ static struct rs_control *init_rs_internal(int symsize, int gfpoly,
     		return NULL;
 	if (prim <= 0 || prim >= (1<<symsize))
     		return NULL;
-	if (nroots < 0 || nroots >= (1<<symsize))
+	if (nroots < 0 || nroots >= (1<<symsize) || nroots > RS_MAX_ROOTS)
 		return NULL;
 
 	mutex_lock(&rslistlock);
-- 
2.7.4


-- 
Kees Cook
Pixel Security
