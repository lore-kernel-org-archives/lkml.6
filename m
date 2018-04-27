Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqmbfFv8fvmsxo3MJFm8R6GPDJx+v5E4xnl1f8+fjW/bvvgjfPhFrTfwAIQdWBpC0J+CGaM
ARC-Seal: i=1; a=rsa-sha256; t=1524837690; cv=none;
        d=google.com; s=arc-20160816;
        b=rzoKyhK1VZkCOiQflryojn6xV5UevB8jHiSNUb+i3t/NoDBiUSaFjhOBKjzcF0/mgq
         fWaqihzcIYxa68Zdkd5hawSE4cRJd407KqntT6mGSPfn0EVmmgTAskH9sFx1Xaeq2jUD
         E7sjhQr71xPUM6BCMvdGSk3iLfkV+0JqTGUJCIidSOaicske0trfdwUyS5wYCD5zN/5R
         FylN6S2FddYfStFlz9XzkxMvrEnYJJJlD9qHMsraKmClzTzdbFF62zoaCNwydlMN9PAm
         OmyTNfehzFLGQOXXxDD/rmm/FVpqoU3K0AqQ2AokRNCA5QZauuu00vh6uv21dAr0yHP2
         Wq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=6t3nmaRQCvT8Q4KEUo/1In5c2h0xAagYbH4UylAwcJo=;
        b=e70TqrgHR2dhTJT6li8RbVGTkPtZNP7PZ4K5NRV5VpzT93VVfY7wUVZV3dDKZuww4L
         pB2JBgz+5rHOtAKLlN0O2MS/GN3KDCTbWHjKeupVOlcxRIo4lInbPxaZeMEddQf4ciSh
         UkVfF7gyx2Y9MwEomevD2jrsW6w+rHqFdbi0FsDAIOzV5xYCqr0+tjCKFPBNA8QwDxpc
         EQyjmOEoucRLIUQTbjTE6LV0vpCQV5cefdGvY3qoFLUzLTL518lugbc3Bys6Lwi9Pvg8
         f/jihXPd3KDvIWeELMFC7RmBMo1vRMwL267o0bm++5U8tGCqep4LNtQUkvToSsafhz3E
         ftkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A6821897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Eric Biggers <ebiggers@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 29/50] KEYS: DNS: limit the length of option strings
Date: Fri, 27 Apr 2018 15:58:31 +0200
Message-Id: <20180427135657.439047078@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908006478347957?=
X-GMAIL-MSGID: =?utf-8?q?1598908205535152347?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>


[ Upstream commit 9c438d7a3a52dcc2b9ed095cb87d3a5e83cf7e60 ]

Adding a dns_resolver key whose payload contains a very long option name
resulted in that string being printed in full.  This hit the WARN_ONCE()
in set_precision() during the printk(), because printk() only supports a
precision of up to 32767 bytes:

    precision 1000000 too large
    WARNING: CPU: 0 PID: 752 at lib/vsprintf.c:2189 vsnprintf+0x4bc/0x5b0

Fix it by limiting option strings (combined name + value) to a much more
reasonable 128 bytes.  The exact limit is arbitrary, but currently the
only recognized option is formatted as "dnserror=%lu" which fits well
within this limit.

Also ratelimit the printks.

Reproducer:

    perl -e 'print "#", "A" x 1000000, "\x00"' | keyctl padd dns_resolver desc @s

This bug was found using syzkaller.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 4a2d789267e0 ("DNS: If the DNS server returns an error, allow that to be cached [ver #2]")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dns_resolver/dns_key.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -25,6 +25,7 @@
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/ratelimit.h>
 #include <linux/kernel.h>
 #include <linux/keyctl.h>
 #include <linux/err.h>
@@ -91,9 +92,9 @@ dns_resolver_preparse(struct key_prepars
 
 			next_opt = memchr(opt, '#', end - opt) ?: end;
 			opt_len = next_opt - opt;
-			if (!opt_len) {
-				printk(KERN_WARNING
-				       "Empty option to dns_resolver key\n");
+			if (opt_len <= 0 || opt_len > 128) {
+				pr_warn_ratelimited("Invalid option length (%d) for dns_resolver key\n",
+						    opt_len);
 				return -EINVAL;
 			}
 
@@ -127,10 +128,8 @@ dns_resolver_preparse(struct key_prepars
 			}
 
 		bad_option_value:
-			printk(KERN_WARNING
-			       "Option '%*.*s' to dns_resolver key:"
-			       " bad/missing value\n",
-			       opt_nlen, opt_nlen, opt);
+			pr_warn_ratelimited("Option '%*.*s' to dns_resolver key: bad/missing value\n",
+					    opt_nlen, opt_nlen, opt);
 			return -EINVAL;
 		} while (opt = next_opt + 1, opt < end);
 	}
