Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Xv9d6eyGtrJOlJ0qlL296yqOR2VMMdZjgatlyfCPqpygh4A3EulQaHCTNvOFlF/9cPBXT
ARC-Seal: i=1; a=rsa-sha256; t=1524652883; cv=none;
        d=google.com; s=arc-20160816;
        b=D9hthOoh/lIpFqQBpAaiBjeqLKtDKDvwMmkOSHA0pqTe5HhfGcNSxRV75N5lJGOwuS
         nW4pl9Nz5wGx9jQ+jJuxCR3Lq2dmS1oqgzEKzTvmE4SZTGCBdTWfaUtxOGDH4r1LC7dA
         yLlbg9w3J1lwrs9aK3QRyvrjwW1gJ6eTalm2X8TGZIWnWoybmBdGpj+D8544Qv7Gbva/
         lsKrBJcUVyyAN4J6DTQpr3HjTK4TrMwHcZFOlBs6QnUeMJ3ra2sTSbslI9O9M6FoCFqW
         7rUYtJy6sb4kxfkMsGXlhnYng8PLwbg6fPE9Uort6FmhcywzSgdRZImKk6XBe0MBsPjB
         ekXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ceuDMJow9MJa7o1DqYbVYlD9C6s9R5i6n+IFVMH6ak4=;
        b=kxSAV1HL96ui3VqAtZhZfMSnZkDD2LN76YH+zaETt5skyn26/sr+iqvP2zrGkDP8oF
         b4uf1OGgydUdL9VztOCHPLGepE9TTh4ENxh8vx7ZuvhQJXKZJd7iEMnhxIg0R0F/brvb
         UYoCg+regiDJvDMsNW6sxwnaGe3CwMd7g7+lxDUoadzcBrmqAaGLgcMP0vAgFgjS0q/l
         ARfoI5EyW+wWPOlTk5e/gKrgtcI3+Vx4PeW9QcnwGkqFJM7nDhCPKhMCqpYvJta6U0i/
         8FbzwZLrheWUNBYGdDk0+qccx9OXRdSfNbysIFuW9bR6sb+SKH0Vy+UC3BVQiBB9X4QG
         u7ww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 103/183] netfilter: x_tables: fix pointer leaks to userspace
Date: Wed, 25 Apr 2018 12:35:23 +0200
Message-Id: <20180425103246.593638345@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714421748893633?=
X-GMAIL-MSGID: =?utf-8?q?1598714421748893633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Vyukov <dvyukov@google.com>


[ Upstream commit 1e98ffea5a8935ec040ab72299e349cb44b8defd ]

Several netfilter matches and targets put kernel pointers into
info objects, but don't set usersize in descriptors.
This leads to kernel pointer leaks if a match/target is set
and then read back to userspace.

Properly set usersize for these matches/targets.

Found with manual code inspection.

Fixes: ec2318904965 ("xtables: extend matches and targets with .usersize")
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/xt_IDLETIMER.c |    1 +
 net/netfilter/xt_LED.c       |    1 +
 net/netfilter/xt_limit.c     |    3 +--
 net/netfilter/xt_nfacct.c    |    1 +
 net/netfilter/xt_statistic.c |    1 +
 5 files changed, 5 insertions(+), 2 deletions(-)

--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -256,6 +256,7 @@ static struct xt_target idletimer_tg __r
 	.family		= NFPROTO_UNSPEC,
 	.target		= idletimer_tg_target,
 	.targetsize     = sizeof(struct idletimer_tg_info),
+	.usersize	= offsetof(struct idletimer_tg_info, timer),
 	.checkentry	= idletimer_tg_checkentry,
 	.destroy        = idletimer_tg_destroy,
 	.me		= THIS_MODULE,
--- a/net/netfilter/xt_LED.c
+++ b/net/netfilter/xt_LED.c
@@ -198,6 +198,7 @@ static struct xt_target led_tg_reg __rea
 	.family		= NFPROTO_UNSPEC,
 	.target		= led_tg,
 	.targetsize	= sizeof(struct xt_led_info),
+	.usersize	= offsetof(struct xt_led_info, internal_data),
 	.checkentry	= led_tg_check,
 	.destroy	= led_tg_destroy,
 	.me		= THIS_MODULE,
--- a/net/netfilter/xt_limit.c
+++ b/net/netfilter/xt_limit.c
@@ -193,9 +193,8 @@ static struct xt_match limit_mt_reg __re
 	.compatsize       = sizeof(struct compat_xt_rateinfo),
 	.compat_from_user = limit_mt_compat_from_user,
 	.compat_to_user   = limit_mt_compat_to_user,
-#else
-	.usersize         = offsetof(struct xt_rateinfo, prev),
 #endif
+	.usersize         = offsetof(struct xt_rateinfo, prev),
 	.me               = THIS_MODULE,
 };
 
--- a/net/netfilter/xt_nfacct.c
+++ b/net/netfilter/xt_nfacct.c
@@ -62,6 +62,7 @@ static struct xt_match nfacct_mt_reg __r
 	.match      = nfacct_mt,
 	.destroy    = nfacct_mt_destroy,
 	.matchsize  = sizeof(struct xt_nfacct_match_info),
+	.usersize   = offsetof(struct xt_nfacct_match_info, nfacct),
 	.me         = THIS_MODULE,
 };
 
--- a/net/netfilter/xt_statistic.c
+++ b/net/netfilter/xt_statistic.c
@@ -84,6 +84,7 @@ static struct xt_match xt_statistic_mt_r
 	.checkentry = statistic_mt_check,
 	.destroy    = statistic_mt_destroy,
 	.matchsize  = sizeof(struct xt_statistic_info),
+	.usersize   = offsetof(struct xt_statistic_info, master),
 	.me         = THIS_MODULE,
 };
 
