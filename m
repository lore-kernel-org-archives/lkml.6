Return-Path: <kernel-hardening-return-12217-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuO+xgozSh+eB2X3LiXb15S9uPVAKKHltMS8kWehradQX1TdBjhkmNNctCyY7sBfEHF71Cw
ARC-Seal: i=1; a=rsa-sha256; t=1520464057; cv=none;
        d=google.com; s=arc-20160816;
        b=pA1KB5i3Jr76cv+rrs1DAV9FFtzM624VAqin9LWV9gFZytWCR8HrD9wBtfgziX0uKr
         qk/hj72WdEzuy3EysLeGHia/Lp6C8cvyvktD6Xzat+QmhQlZ4DOVcd0mNdR2bVS2FM5L
         Br1ZA0Zcry5VGFpEv1EexHgeu8lFVFY56k7GF5lYtyqVvCVc0F4MPurnHJe6Goy06vfA
         uzIimetxy1AMT3eFSfvGo1JBlgzoXtCE7sfoJkLT5beIkbYqCEuPTmqVnPjPdQg+ECfE
         06izGvZjXf2vRG5Cf85gZNSfLko85e6nbNvZ7aax4CaK6UlSvEUSrZkdjd5hXGxR0nNv
         mNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=PcGgUXhytehr9tmh1Agcgit62y1yoNvFyzEBCx+RPfs=;
        b=WX45REAfrkaMSRVLJtDLhiLp8mQRL0z1+9l5jTS/w9/MSfTK/NP/iy0RxoImlpvfI6
         pxCSHYb+hFDK1Xp1Wq3sJylH4VhQrvPhFqtDCUaaYrjE027DfEfCFFhrv80STe7Hc+F2
         l8LGEFMZ8f0PCZ7Vm4c6RWz3g0EBAI/0H/1SsLBXGLQ24sJWg1viYI5qJMcayuOKVXAr
         O9O+U2345vtFRhdYaXxOJtKY97VVhgFhQNYHgAvqpEbTNKeFo8P7IetP77PIVHeRwqhm
         AaIiRiqEQ+PduWNeCW5pu40mw9GyxWfo8nmbSxb+P9LGNYughU48kVSNI2sftJVPwnbn
         YJUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=jvzr0ykf;
       spf=pass (google.com: domain of kernel-hardening-return-12217-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12217-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=jvzr0ykf;
       spf=pass (google.com: domain of kernel-hardening-return-12217-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12217-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 7 Mar 2018 15:07:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] vsprintf: Remove accidental VLA usage
Message-ID: <20180307230714.GA20797@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594322119542311159?=
X-GMAIL-MSGID: =?utf-8?q?1594322119542311159?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "sym" calculation is actually a fixed size, but since the max()
macro uses some extensive tricks for safety, it ends up looking like a
variable size. This replaces max() with a simple max macro which is
sufficient for the calculation of the array size.

Seen with -Wvla. Fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/vsprintf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d7a708f82559..f420ab1477cb 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -744,8 +744,9 @@ char *resource_string(char *buf, char *end, struct resource *res,
 #define FLAG_BUF_SIZE		(2 * sizeof(res->flags))
 #define DECODED_BUF_SIZE	sizeof("[mem - 64bit pref window disabled]")
 #define RAW_BUF_SIZE		sizeof("[mem - flags 0x]")
-	char sym[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
-		     2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
+#define SIMPLE_MAX(x, y)	((x) > (y) ? (x) : (y))
+	char sym[SIMPLE_MAX(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
+			    2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
 
 	char *p = sym, *pend = sym + sizeof(sym);
 	int decode = (fmt[0] == 'R') ? 1 : 0;
-- 
2.7.4


-- 
Kees Cook
Pixel Security
