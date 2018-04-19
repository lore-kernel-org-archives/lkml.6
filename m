Return-Path: <kernel-hardening-return-13059-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/f1aCqucyU03jMJXBl+gNtBIX+aDVhAJDxHfR0UWb8K+kF/j4ygqVZeUYiD/mIaww12dkT
ARC-Seal: i=1; a=rsa-sha256; t=1524132744; cv=none;
        d=google.com; s=arc-20160816;
        b=CIyawDrLjk7Reg97ciQ19ETcXmYpW96BIO8EJMeiAGpSCRZDMSDXGHBhF+KL+81o+u
         epO/3nHj+eqMVkJI4+S/iCRih9XHVPtBJttBQjt2adcLbYApVB11XBf95Sp+VZjjUsQ1
         s9IqyS5VH3Mcxd483p/n+YvIUH7AJmlEjeoVrvWv1w10MaELCRflVuPa92ncHk/KQgJN
         ygjNPXgvQhcNi3poSFnd0csyoo6k200AgB1HmdmcLQ73wLAJMZyM89gc+NyCN4oK5AhB
         f1vVLZGPFlX08sCFGQ1YxSuCbJGgLAJUmJ/pxBLNy7GnD3t6Wqhl9YNXl0WgJzBGkhJI
         OaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=jf4vAMeeDiq1v7SRvAQYSUcbzI5VttuNqy5ZAa6iwvw=;
        b=U7HsoKGTDa2TH8e+RGfU5IDFSuqgpkbUdAFbm4CbznXkudfWCac3gFC1O4bqpzzyPz
         rUin7mIpqQ4y3lJ1gOkcDqdHDGUFexvrnjGQcnFBrzUmsJB9OPfYrzCrC+/wrSJK2Xis
         75nFGfwApV64FgIgTjzHsuKPPUnBp42TljfhHrvDQ+I9wAWwWwXKq84LDb+P03YZs5Ws
         M3QQ/X8NN2D2r0ihvbTrJoUBs/rcFhQRku1siWTFS+LuvQfBIjXXZf1nXhVxQ5ESrTqy
         gXn3bmZ2WTqe5EgX0+OquOUSxZaI3SbxcqEyV5uncF593UPR2ikmtwBrzDnYN+e82wFL
         baFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13059-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13059-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13059-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13059-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Message-Id: <20180419100935.424056863@linutronix.de>
User-Agent: quilt/0.63-1
Date: Thu, 19 Apr 2018 12:04:49 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Andrew Morton <akpm@linuxfoundation.org>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
 Tony Luck <tony.luck@intel.com>
Subject: [patch V2 8/8] rslib: Allocate decoder buffers to avoid VLAs
References: <20180419100441.548834519@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=rslib--Allocate_decoder_buffers_to_avoid_VLAs.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598169017082850243?=
X-GMAIL-MSGID: =?utf-8?q?1598169017082850243?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

To get rid of the variable length arrays on stack in the RS decoder it's
necessary to allocate the decoder buffers per control structure instance.

All usage sites have been checked for potential parallel decoder usage and
fixed where necessary. Kees confirmed that the pstore decoding is strictly
single threaded so there should be no surprises.

Allocate them in the rs control structure sized depending on the number of
roots for the chosen codec and adapt the decoder code to make use of them.

Document the fact that decode operations based on a particular rs control
instance cannot run in parallel and the caller has to ensure that as it's
not possible to provide a proper locking construct which fits all use
cases.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Andrew Morton <akpm@linuxfoundation.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Alasdair Kergon <agk@redhat.com>

---
 include/linux/rslib.h           |    1 +
 lib/reed_solomon/decode_rs.c    |   20 +++++++++++++-------
 lib/reed_solomon/reed_solomon.c |   31 ++++++++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 8 deletions(-)

--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -51,6 +51,7 @@ struct rs_codec {
  */
 struct rs_control {
 	struct rs_codec	*codec;
+	uint16_t	buffers[0];
 };
 
 /* General purpose RS codec, 8-bit data width, symbol width 1-15 bit  */
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -21,16 +21,22 @@
 	uint16_t *alpha_to = rs->alpha_to;
 	uint16_t *index_of = rs->index_of;
 	uint16_t u, q, tmp, num1, num2, den, discr_r, syn_error;
-	/* Err+Eras Locator poly and syndrome poly The maximum value
-	 * of nroots is 8. So the necessary stack size will be about
-	 * 220 bytes max.
-	 */
-	uint16_t lambda[nroots + 1], syn[nroots];
-	uint16_t b[nroots + 1], t[nroots + 1], omega[nroots + 1];
-	uint16_t root[nroots], reg[nroots + 1], loc[nroots];
 	int count = 0;
 	uint16_t msk = (uint16_t) rs->nn;
 
+	/*
+	 * The decoder buffers are in the rs control struct. They are
+	 * arrays sized [nroots + 1]
+	 */
+	uint16_t *lambda = rsc->buffers + RS_DECODE_LAMBDA * (nroots + 1);
+	uint16_t *syn = rsc->buffers + RS_DECODE_SYN * (nroots + 1);
+	uint16_t *b = rsc->buffers + RS_DECODE_B * (nroots + 1);
+	uint16_t *t = rsc->buffers + RS_DECODE_T * (nroots + 1);
+	uint16_t *omega = rsc->buffers + RS_DECODE_OMEGA * (nroots + 1);
+	uint16_t *root = rsc->buffers + RS_DECODE_ROOT * (nroots + 1);
+	uint16_t *reg = rsc->buffers + RS_DECODE_REG * (nroots + 1);
+	uint16_t *loc = rsc->buffers + RS_DECODE_LOC * (nroots + 1);
+
 	/* Check length parameter for validity */
 	pad = nn - nroots - len;
 	BUG_ON(pad < 0 || pad >= nn);
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -37,6 +37,18 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 
+enum {
+	RS_DECODE_LAMBDA,
+	RS_DECODE_SYN,
+	RS_DECODE_B,
+	RS_DECODE_T,
+	RS_DECODE_OMEGA,
+	RS_DECODE_ROOT,
+	RS_DECODE_REG,
+	RS_DECODE_LOC,
+	RS_DECODE_NUM_BUFFERS
+};
+
 /* This list holds all currently allocated rs codec structures */
 static LIST_HEAD(codec_list);
 /* Protection for the list */
@@ -205,6 +217,7 @@ static struct rs_control *init_rs_intern
 {
 	struct list_head *tmp;
 	struct rs_control *rs;
+	unsigned int bsize;
 
 	/* Sanity checks */
 	if (symsize < 1)
@@ -216,7 +229,13 @@ static struct rs_control *init_rs_intern
 	if (nroots < 0 || nroots >= (1<<symsize))
 		return NULL;
 
-	rs = kzalloc(sizeof(*rs), GFP_KERNEL);
+	/*
+	 * The decoder needs buffers in each control struct instance to
+	 * avoid variable size or large fixed size allocations on
+	 * stack. Size the buffers to arrays of [nroots + 1].
+	 */
+	bsize = sizeof(uint16_t) * RS_DECODE_NUM_BUFFERS * (nroots + 1);
+	rs = kzalloc(sizeof(*rs) + bsize, GFP_KERNEL);
 	if (!rs)
 		return NULL;
 
@@ -327,6 +346,11 @@ EXPORT_SYMBOL_GPL(encode_rs8);
  *  The syndrome and parity uses a uint16_t data type to enable
  *  symbol size > 8. The calling code must take care of decoding of the
  *  syndrome result and the received parity before calling this code.
+ *
+ *  Note: The rs_control struct @rsc contains buffers which are used for
+ *  decoding, so the caller has to ensure that decoder invocations are
+ *  serialized.
+ *
  *  Returns the number of corrected bits or -EBADMSG for uncorrectable errors.
  */
 int decode_rs8(struct rs_control *rsc, uint8_t *data, uint16_t *par, int len,
@@ -371,6 +395,11 @@ EXPORT_SYMBOL_GPL(encode_rs16);
  *  @corr:	buffer to store correction bitmask on eras_pos
  *
  *  Each field in the data array contains up to symbol size bits of valid data.
+ *
+ *  Note: The rc_control struct @rsc contains buffers which are used for
+ *  decoding, so the caller has to ensure that decoder invocations are
+ *  serialized.
+ *
  *  Returns the number of corrected bits or -EBADMSG for uncorrectable errors.
  */
 int decode_rs16(struct rs_control *rsc, uint16_t *data, uint16_t *par, int len,
