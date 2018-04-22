Return-Path: <kernel-hardening-return-13080-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZpMZUeIB6OsBTNS+Hh1a/caRR12qr0TTTIR+qEoVql7l361znb3VwcNAjNSaxEBr5+u5UNY
ARC-Seal: i=1; a=rsa-sha256; t=1524414743; cv=none;
        d=google.com; s=arc-20160816;
        b=CFt24HT3c7kCkyfhVVX2KWLu+L5mO4gvb1T4zer//vEy/NRq1c+SVZTAIYlJ5R+V8D
         /G5OC5lgcUhZ8sa4MFeToQCgYuCsUNdiDp/L0RIKQjRONeGV9OWuz+1wxug8MNWxsIK8
         oUipWiWLVWqfcOZ1yEdiWXXowdmc7/HjY2UKuwT/LDrNByTv+RWrC7Secmtw+90NwKir
         UEJ0i//2LGwBAjKYsEQbvRH7U0xt4TjSNtfzKuTTIfOZQgfL72XiK23DI7QPIl4+9smK
         0evjf3zSHVhgry57N07Nn92MJZwgY30Ez41QGOtFs4UDZTlfWtgPr/M80NeqjrO0Bd2L
         T5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=c0eiX6K+qBP1wmqqKYtuGR8Ha1nfER1moDXgNW7wEmc=;
        b=DWayzjIaUPHVQk80gXXDJnQASlwjRI0b2q8KH5ftmU4QqyP9UzOCVn7mVY4hDsrFGb
         rLXEpai6BleNviCiC3qjXYEjcVwfD+hA0FjO+2fb4Gt6HLheoMOXSzJ5/j/y5uV6efpq
         7RYJj+tI88QGre3OFDfzyBMy93oaFp1NCtoMqzfV8u40Z+zdq4yVKXV2l/5JDIx7bZtP
         l8LlhCZPh7x77kdMqvseviA3wNrYcT9L/UStVRfotQcVt0QW6wtJUJe2dX+RFTvfo3o6
         TPjATPCgX2Mo0T7GPH/f6veUW8j0wQsh3+CDgRloYvWBG5ZJmV9Tj/NUfEx9DtaKE9xg
         tVng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13080-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13080-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13080-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13080-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Message-Id: <20180422162512.915544167@linutronix.de>
User-Agent: quilt/0.63-1
Date: Sun, 22 Apr 2018 18:23:52 +0200
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
Subject: [patch V3 07/10] rslib: Simplify error path
References: <20180422162345.004292133@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=rslib--Simplify-error-path.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598464714516564553?=
X-GMAIL-MSGID: =?utf-8?q?1598464714516564553?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The four error path labels in rs_init() can be reduced to one by allocating
the struct with kzalloc so the pointers in the struct are NULL and can be
unconditionally handed in to kfree() because they either point to an
allocation or are NULL.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/reed_solomon/reed_solomon.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -60,8 +60,7 @@ static struct rs_control *rs_init(int sy
 	struct rs_control *rs;
 	int i, j, sr, root, iprim;
 
-	/* Allocate the control structure */
-	rs = kmalloc(sizeof(*rs), gfp);
+	rs = kzalloc(sizeof(*rs), gfp);
 	if (!rs)
 		return NULL;
 
@@ -78,15 +77,15 @@ static struct rs_control *rs_init(int sy
 	/* Allocate the arrays */
 	rs->alpha_to = kmalloc(sizeof(uint16_t) * (rs->nn + 1), gfp);
 	if (rs->alpha_to == NULL)
-		goto errrs;
+		goto err;
 
 	rs->index_of = kmalloc(sizeof(uint16_t) * (rs->nn + 1), gfp);
 	if (rs->index_of == NULL)
-		goto erralp;
+		goto err;
 
 	rs->genpoly = kmalloc(sizeof(uint16_t) * (rs->nroots + 1), gfp);
 	if(rs->genpoly == NULL)
-		goto erridx;
+		goto err;
 
 	/* Generate Galois field lookup tables */
 	rs->index_of[0] = rs->nn;	/* log(zero) = -inf */
@@ -111,7 +110,7 @@ static struct rs_control *rs_init(int sy
 	}
 	/* If it's not primitive, exit */
 	if(sr != rs->alpha_to[0])
-		goto errpol;
+		goto err;
 
 	/* Find prim-th root of 1, used in decoding */
 	for(iprim = 1; (iprim % prim) != 0; iprim += rs->nn);
@@ -141,14 +140,10 @@ static struct rs_control *rs_init(int sy
 		rs->genpoly[i] = rs->index_of[rs->genpoly[i]];
 	return rs;
 
-	/* Error exit */
-errpol:
+err:
 	kfree(rs->genpoly);
-erridx:
 	kfree(rs->index_of);
-erralp:
 	kfree(rs->alpha_to);
-errrs:
 	kfree(rs);
 	return NULL;
 }
