Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrrrLgQ/Td1zG96M+dVdzQehTht16Ff1xKuNLd5OAGJs5R4bjjIUhXR00rl3N1n43vohoMi
ARC-Seal: i=1; a=rsa-sha256; t=1524837874; cv=none;
        d=google.com; s=arc-20160816;
        b=OnXzjALkRqmOMGn7mlAAYHQOSWhDWELSFvfzk1M9wXJes4Sr731NR6o5mZiB7F/v5s
         E3XbW+oz+CRbAYgLbtD9fQcDXAzcK6OADcgF1T5ye2956uA9h1s2UXUSKeO+chK7j61i
         vA0btULlHreu3cZS9IX5Eyht5g7aMBoKK9pXP1vSHpDtSKQH9wUQ2YvjUuJExxbAddOh
         FTrME746mQCASAobNcdD71LsxkntutRvaBpT0pECgyU8Xwt9Rd1gj3gVDJCUEwNM3CIh
         3ZMuewEWHWMYfG2/Gy1dZjB/qz/Cd3wWSkLKuBUIvovOkc8NMdWWPnmddBKXU/iZwB4l
         hTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=HuG8mDBDMqEAOhOP/0CvUfSh9uQ3kiPDc8scBgpZGxo=;
        b=WMHPx/6eHLw6Qkkf7OnjtM5tchEgLz4tCjZj2MLXZQ4Gk5YVqu3ux08OOfZeuaiiqV
         Ko0eurwxvBa/b5fR48escLvWMPA6bOwQbrYWyv03hLaXwojgJjSuubCnu8ft4IBTg4aG
         tL+0yUQkY4VpJQA1/rbBsoCbKS35fllsY7N3YlA3rXH7zbEPpAi6MO7bfJooi5NV+avo
         XmsoT4x+bGzI9s4Wb59guEjFv5Wl/okQitCpmO5GOdE/v2j8IIWtKBGDjIiDGI6Hl3UC
         K0dVvD1YlcWGiYyRs3MM9K7xhZk3Y48bIobJWXcrwukVDYqHoGXGxjLPo4lqKZQ+lD/H
         ZlXw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDD421890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Eric Biggers <ebiggers@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 48/74] KEYS: DNS: limit the length of option strings
Date: Fri, 27 Apr 2018 15:58:38 +0200
Message-Id: <20180427135711.922951437@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908006478347957?=
X-GMAIL-MSGID: =?utf-8?q?1598908398930606447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
