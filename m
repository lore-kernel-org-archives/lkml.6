Return-Path: <kernel-hardening-return-12648-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELumThcptgwf3JU33XrF4kX3XP/cM37KlfkxDBQpGW66Q6YVypRwfYk2/siaGZBN7TvzHbAs
ARC-Seal: i=1; a=rsa-sha256; t=1521154782; cv=none;
        d=google.com; s=arc-20160816;
        b=SfSvh0VRI49KshTXNjwxDGY994bkdg4Ju4uHZuuihBJEuCwRtQb6C185wxbhH6/xg6
         y1smfP+uW+cNXEI9LMg8VlmI4u8c2Nw6I8btUiWWbHo2Tb05Mwif6ALhBC4EVdVsJnoE
         iulsa+gK8CqIemJ4lEYtIkkHqV4XVAuBbGXxX256Dky5KE7bxeMtB1Bb4i2HAM1zCcxV
         0EhuRnctLY1HY+JGPzBy8SHzyPxmEWOF4dSapGlL1kQYzNoONuvVMT6Lp/pXJNzAGkrL
         mMPT1iHGt4jfkPF5mrOjwxDpr+jL8Ybp2HBDzRSdzvnKB8DPimnd+ofEs1T5vvOI0cpc
         8atw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=GWWUPtSQNK2IDvhhm0q5KbKvb1DOvcvuPcWGgtDSL3g=;
        b=ww1i3gdLY5H8IJOQzOxS6XS8IikgHAnTP1JpeRz50yC60+U4LhukX51eqaVBPeU6jY
         gYMjCcYkyvkrvOnTxD1jaNn3p2aZrDxDBRK7XOSFwndWA7t3hFVqDCNH8fQiAJi2QuQS
         kcACeySVbyNJALOGlD27H1jrGDPB8N6AEEH8NQ/KuxkV1AWzoiLZqeq1rSGFZfm4v5Ny
         cDbk3Ob+Jr+nHzWDHhDNUg76/x4KdZHz79bh97H2Q2pH3UuE4WxLMBhvCU4uOnwaCyDy
         278WFS9tT+17Y0pYSYPpEzmpKo/Hxlov23OsOmxA5oW20nKRI59UivOmqE5gOmyVfMJA
         rTJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=bMFOl67B;
       spf=pass (google.com: domain of kernel-hardening-return-12648-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12648-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=bMFOl67B;
       spf=pass (google.com: domain of kernel-hardening-return-12648-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12648-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 15 Mar 2018 15:59:19 -0700
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kernel-hardening@lists.openwall.com
Subject: [PATCH v2] rslib: Remove VLAs by setting upper bound on nroots
Message-ID: <20180315225919.GA43806@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595046396754035881?=
X-GMAIL-MSGID: =?utf-8?q?1595046396754035881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Avoid stack VLAs[1] by always allocating the upper bound of stack space
needed. The existing users of rslib appear to max out at 24 roots[2],
so use that as the upper bound until we have a reason to change it.

Alternative considered: make init_rs() a true caller-instance and
pre-allocate the workspaces. This would possibly need locking and
a refactoring of the returned structure.

Using kmalloc in this path doesn't look great, especially since at
least one caller (pstore) is sensitive to allocations during rslib
usage (it expects to run it during an Oops, for example).

[1] https://lkml.org/lkml/2018/3/7/621
[2] https://lkml.org/lkml/2018/3/9/838

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
v2:
Resending to akpm, since this is in lib without an obvious owner. Added
tglx's Reviewed-by.
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
index 06d04cfa9339..3e218e70ac2e 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -51,6 +51,9 @@ static LIST_HEAD (rslist);
 /* Protection for the list */
 static DEFINE_MUTEX(rslistlock);
 
+/* Ultimately controls the upper bounds of the on-stack buffers. */
+#define RS_MAX_ROOTS	24
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
