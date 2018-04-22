Return-Path: <kernel-hardening-return-13083-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZqIbCJpEXH+xG6vXffcLmRmPASdRPTUZv0laa2ngFX4n8NznQgj00ZZoCH4+fLw6X9bnJVj
ARC-Seal: i=1; a=rsa-sha256; t=1524414761; cv=none;
        d=google.com; s=arc-20160816;
        b=cS+0W/EU6JHFRZfAMP0l67CzZg9cvlKHbqZ/rKQQ+4wWyVCVVyKqLgEC8hKFkt9PiU
         q1mkmlmdksUr4VUsK9R6J05tGqGPCUK6YU2n37zTfNvutCM97M9Uo+OorRUiWRjNTYOM
         /dg6lYmnP42gWlzcFgMQN0X4wy0v/VuYdYAvefMsuMlXk4YcRx+XHhyq17fyLBqNuF7R
         JhFsM59XU7aJRDekzy/PW/z1OvAys+WJp6nsXKVe35P5vPQTtjySYgDobKGxWPsOv7Gu
         ma1+BoGJLSECJC7w4G2j/Lv4UXVxrB0Qo8kFj5uYY3mqB4VRawYdLLCvCEbUBnme7+O3
         OXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=P0WZPMRwWKi0MHdD27L8D1kXkXgibnXtggFnWAIlEnw=;
        b=q6RLqgL/ndDXlwZaJqF4C9QAZ3HNPY/zkaUCSvI9XLHwNOBeyYisoYs5GVvzcJ3vfP
         DoFUh84XSa/K0ZBaJT1FGG3ooBFdoldFjUwVu0vGZVtLYcnsYV+CCVSfoyv3MhDjFfv1
         5fsUFyQ7siFW3xy51HLB+5R5EvYCnaX70U2+369ZfGuvMMiC6d7+Ajl5FqT9N0gYGQG+
         Li+Vcc5nr1cdaqF1KOoOCT6MA9Epr6RQczu0GjGJLlenkwyE8ApRJahfCBpuBPgBJ8mk
         R34TfXm7uuZyOVniJLDqRQa9oV0r6YgYJm0kxfm2gS81Pvm8XcO6xZxhqUqMDWEFNxkY
         1hQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13083-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13083-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13083-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13083-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Message-Id: <20180422162512.363154748@linutronix.de>
User-Agent: quilt/0.63-1
Date: Sun, 22 Apr 2018 18:23:46 +0200
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
 Tony Luck <tony.luck@intel.com>, Neil Brown <neilb@suse.com>
Subject: [patch V3 01/10] rslib: Add GFP aware init function
References: <20180422162345.004292133@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=rslib--Add-GFP-aware-init-function.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598464733406749436?=
X-GMAIL-MSGID: =?utf-8?q?1598464733406749436?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The rslib usage in dm/verity_fec is broken because init_rs() can nest in
GFP_NOIO mempool allocations as init_rs() is invoked from the mempool alloc
callback.

Provide a variant which takes gfp_t flags as argument.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Neil Brown <neilb@suse.com>
---
 include/linux/rslib.h           |   26 +++++++++++++++++++++++---
 lib/reed_solomon/reed_solomon.c |   36 ++++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 19 deletions(-)

--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -77,10 +77,30 @@ int decode_rs16(struct rs_control *rs, u
 #endif
 
 /* Create or get a matching rs control structure */
-struct rs_control *init_rs(int symsize, int gfpoly, int fcr, int prim,
-			   int nroots);
+struct rs_control *init_rs_gfp(int symsize, int gfpoly, int fcr, int prim,
+			       int nroots, gfp_t gfp);
+
+/**
+ * init_rs - Create a RS control struct and initialize it
+ *  @symsize:	the symbol size (number of bits)
+ *  @gfpoly:	the extended Galois field generator polynomial coefficients,
+ *		with the 0th coefficient in the low order bit. The polynomial
+ *		must be primitive;
+ *  @fcr:	the first consecutive root of the rs code generator polynomial
+ *		in index form
+ *  @prim:	primitive element to generate polynomial roots
+ *  @nroots:	RS code generator polynomial degree (number of roots)
+ *
+ * Allocations use GFP_KERNEL.
+ */
+static inline struct rs_control *init_rs(int symsize, int gfpoly, int fcr,
+					 int prim, int nroots)
+{
+	return init_rs_gfp(symsize, gfpoly, fcr, prim, nroots, GFP_KERNEL);
+}
+
 struct rs_control *init_rs_non_canonical(int symsize, int (*func)(int),
-                                         int fcr, int prim, int nroots);
+					 int fcr, int prim, int nroots);
 
 /* Release a rs control structure */
 void free_rs(struct rs_control *rs);
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -59,19 +59,20 @@ static DEFINE_MUTEX(rslistlock);
  * @fcr:	first root of RS code generator polynomial, index form
  * @prim:	primitive element to generate polynomial roots
  * @nroots:	RS code generator polynomial degree (number of roots)
+ * @gfp:	GFP_ flags for allocations
  *
  * Allocate a control structure and the polynom arrays for faster
  * en/decoding. Fill the arrays according to the given parameters.
  */
 static struct rs_control *rs_init(int symsize, int gfpoly, int (*gffunc)(int),
-                                  int fcr, int prim, int nroots)
+				  int fcr, int prim, int nroots, gfp_t gfp)
 {
 	struct rs_control *rs;
 	int i, j, sr, root, iprim;
 
 	/* Allocate the control structure */
-	rs = kmalloc(sizeof (struct rs_control), GFP_KERNEL);
-	if (rs == NULL)
+	rs = kmalloc(sizeof(*rs), gfp);
+	if (!rs)
 		return NULL;
 
 	INIT_LIST_HEAD(&rs->list);
@@ -85,15 +86,15 @@ static struct rs_control *rs_init(int sy
 	rs->gffunc = gffunc;
 
 	/* Allocate the arrays */
-	rs->alpha_to = kmalloc(sizeof(uint16_t) * (rs->nn + 1), GFP_KERNEL);
+	rs->alpha_to = kmalloc(sizeof(uint16_t) * (rs->nn + 1), gfp);
 	if (rs->alpha_to == NULL)
 		goto errrs;
 
-	rs->index_of = kmalloc(sizeof(uint16_t) * (rs->nn + 1), GFP_KERNEL);
+	rs->index_of = kmalloc(sizeof(uint16_t) * (rs->nn + 1), gfp);
 	if (rs->index_of == NULL)
 		goto erralp;
 
-	rs->genpoly = kmalloc(sizeof(uint16_t) * (rs->nroots + 1), GFP_KERNEL);
+	rs->genpoly = kmalloc(sizeof(uint16_t) * (rs->nroots + 1), gfp);
 	if(rs->genpoly == NULL)
 		goto erridx;
 
@@ -195,13 +196,14 @@ void free_rs(struct rs_control *rs)
  *		in index form
  *  @prim:	primitive element to generate polynomial roots
  *  @nroots:	RS code generator polynomial degree (number of roots)
+ *  @gfp:	GFP_ flags for allocations
  */
 static struct rs_control *init_rs_internal(int symsize, int gfpoly,
-                                           int (*gffunc)(int), int fcr,
-                                           int prim, int nroots)
+					   int (*gffunc)(int), int fcr,
+					   int prim, int nroots, gfp_t gfp)
 {
-	struct list_head	*tmp;
-	struct rs_control	*rs;
+	struct list_head *tmp;
+	struct rs_control *rs;
 
 	/* Sanity checks */
 	if (symsize < 1)
@@ -236,7 +238,7 @@ static struct rs_control *init_rs_intern
 	}
 
 	/* Create a new one */
-	rs = rs_init(symsize, gfpoly, gffunc, fcr, prim, nroots);
+	rs = rs_init(symsize, gfpoly, gffunc, fcr, prim, nroots, gfp);
 	if (rs) {
 		rs->users = 1;
 		list_add(&rs->list, &rslist);
@@ -247,7 +249,7 @@ static struct rs_control *init_rs_intern
 }
 
 /**
- * init_rs - Find a matching or allocate a new rs control structure
+ * init_rs_gfp - Find a matching or allocate a new rs control structure
  *  @symsize:	the symbol size (number of bits)
  *  @gfpoly:	the extended Galois field generator polynomial coefficients,
  *		with the 0th coefficient in the low order bit. The polynomial
@@ -256,11 +258,12 @@ static struct rs_control *init_rs_intern
  *		in index form
  *  @prim:	primitive element to generate polynomial roots
  *  @nroots:	RS code generator polynomial degree (number of roots)
+ *  @gfp:	GFP_ flags for allocations
  */
-struct rs_control *init_rs(int symsize, int gfpoly, int fcr, int prim,
-                           int nroots)
+struct rs_control *init_rs_gfp(int symsize, int gfpoly, int fcr, int prim,
+			       int nroots, gfp_t gfp)
 {
-	return init_rs_internal(symsize, gfpoly, NULL, fcr, prim, nroots);
+	return init_rs_internal(symsize, gfpoly, NULL, fcr, prim, nroots, gfp);
 }
 
 /**
@@ -279,7 +282,8 @@ struct rs_control *init_rs(int symsize,
 struct rs_control *init_rs_non_canonical(int symsize, int (*gffunc)(int),
                                          int fcr, int prim, int nroots)
 {
-	return init_rs_internal(symsize, 0, gffunc, fcr, prim, nroots);
+	return init_rs_internal(symsize, 0, gffunc, fcr, prim, nroots,
+				GFP_KERNEL);
 }
 
 #ifdef CONFIG_REED_SOLOMON_ENC8
