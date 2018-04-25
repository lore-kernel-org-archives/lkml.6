Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Nil35dKsNGDitgwElrV2f7Dti/01YpfyzqabacOARgCJVSrIiDRraVJG7vqxCFln88IrB
ARC-Seal: i=1; a=rsa-sha256; t=1524653077; cv=none;
        d=google.com; s=arc-20160816;
        b=Tzyrp0nqHRBWYmOg0478oGuPrM2w9SKvxi3h7X7tux7DN/vTNTWPKt/9w7dln/Ipa0
         ZjAj2fFjSte/fMQ5caBaMcBO3WiXalPqrMUydF/HZWEg2zdUCbHLUWATa0zxl9CgfaKu
         CG5QTHmHuGl4qa/8mjOL+ju4HiFfVlXqWW/TeDkScPrrix/c0jAlaKLm88OdMXUfA8He
         6bQrd4aUJ1pdCQ7ZATXbNn27fcnddoYZxt3/Jq5NaZbc5auyQp97mDVwk+/vJV6AYvoE
         BsJQS7PvEewOSeUBsexfu8ehGn1KvcfNIsnXG8v2msUNCokjccL3LIBr2C8Pua2BXpQ4
         t4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RuEnrY9YxndC5ChY5ETGVuR5Gi0LDWylaI9rQp5D7ak=;
        b=NaCBzzrAF61oRAtdmoGHe2o0zoknvNpbaBZKiR2FepQxHR6A+J6XtH2F1FzlIyUKB/
         9ORF1hN3arSSF78R6pIHjELcdMWcAyH1NxvGyq/KrfsIzqbPVKQiZgkrO69ll6zA6A1C
         NwiNCtso4OmhOAB2f5VFkpWuAI/VFCBMsklsfsKYBFDkUNJ1xc7pm6cJCWPbcif3Z+Qy
         grVH7aUIEBFo/t/1gDKb0RUdq6DPTqlif0lCQ2f+/6Pl6JM7kt9Gh5C8Op7s0STL4j/6
         tM2b87UMbIP7t8AultPKndV87mA4YS2F+vEtN5BbT5lKHGxBOepx4O5UrNqgYWgOui0c
         uHNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 174/183] netfilter: x_tables: cap allocations at 512 mbyte
Date: Wed, 25 Apr 2018 12:36:34 +0200
Message-Id: <20180425103249.503229111@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598713973761828956?=
X-GMAIL-MSGID: =?utf-8?q?1598714625908228402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 19926968ea86a286aa6fbea16ee3f2e7442f10f0 upstream.

Arbitrary limit, however, this still allows huge rulesets
(> 1 million rules).  This helps with automated fuzzer as it prevents
oom-killer invocation.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/x_tables.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -40,6 +40,7 @@ MODULE_AUTHOR("Harald Welte <laforge@net
 MODULE_DESCRIPTION("{ip,ip6,arp,eb}_tables backend module");
 
 #define XT_PCPU_BLOCK_SIZE 4096
+#define XT_MAX_TABLE_SIZE	(512 * 1024 * 1024)
 
 struct compat_delta {
 	unsigned int offset; /* offset in kernel */
@@ -1031,7 +1032,7 @@ struct xt_table_info *xt_alloc_table_inf
 	struct xt_table_info *info = NULL;
 	size_t sz = sizeof(*info) + size;
 
-	if (sz < sizeof(*info))
+	if (sz < sizeof(*info) || sz >= XT_MAX_TABLE_SIZE)
 		return NULL;
 
 	/* Pedantry: prevent them from hitting BUG() in vmalloc.c --RR */
