Return-Path: <kernel-hardening-return-12486-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvP4GOwrCAO+X+JD2d7bg9pEO/IVkRHhIynrAEPijEYD/UWU28Jq0NdmSRapY6AKOksOGJZ
ARC-Seal: i=1; a=rsa-sha256; t=1520903652; cv=none;
        d=google.com; s=arc-20160816;
        b=XJqT+PFQslO8nS0u97jRjduQyCRwSmOAuuqKpBmh5S6kJdZqU2LMdRKeeAIa0LaLpV
         6swaIQx7kH5N0a+Z2/gRbPt/HbnHw6gxW9kS0nJjnW8BtK5m/bYM57Itmw5nk3UBpFmi
         ghYgHTErwF960GB8zw2oascU147sDPBEVHqJGn9aT3SDEWeg4d1WN068QJpyUIUktA2p
         lhYOIf+t4PMtQPua3INz2WindAbr7V4ehO2TMIqN7uHGHrQ0pBG0aoSqK24insfZBwQ5
         QIicqIubPOgm7OrbxA0z6PG5lMtz7UFU0yjY9H0XdxlU9KLGck4w7YeuBmH5DRM7zueQ
         YmFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=LyM2QPnD0oZNIgqvsoE8U0fcowxSxwDHoIOX8z/JHGc=;
        b=xX2DFGm8xe06AeKgxS1F7v6SXryjwOLcS7aKcu9WzXyfFSZlefw7wXgDXqPPHwUTCM
         9hS6Zl7P3Uq+Eb/nFA9XltUc9SIxzLoF3qDftjBIVll6/bFBonEOV2j422T1SC6QpvQ3
         6i/U5AkyNUo3hsPMoOv5ud4NUO2ToqOQmL1xtmNUEdWeffAxkM69G/bXFfujmAGOAuTv
         I2/T7dEKbeVV2XTEhrg1Ta9r/+HisTLBU4itodKJg3edeUkgE8sSfuHwG1sLduh5F3Ts
         GoN5hOUX7jmQiAjYhKEbxdauM2/uJm0KfZzkEdH1YpkCYa5E1GNQxMcQXie58jyhWIrW
         3H3g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12486-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12486-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12486-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12486-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 12 Mar 2018 20:13:49 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] netfilter: nf_tables: remove VLA usage
Message-ID: <20180313011349.GA31826@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.openwall.com
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1evYVj-001Iif-SF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:47598
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594783068185989991?=
X-GMAIL-MSGID: =?utf-8?q?1594783068185989991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation to enabling -Wvla, remove VLA and replace it
with dynamic memory allocation.

>From a security viewpoint, the use of Variable Length Arrays can be
a vector for stack overflow attacks. Also, in general, as the code
evolves it is easy to lose track of how big a VLA can get. Thus, we
can end up having segfaults that are hard to debug.

Also, fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/netfilter/nf_tables_api.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3f815b6..ea76903 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4357,16 +4357,20 @@ static struct nft_object *nft_obj_init(const struct nft_ctx *ctx,
 				       const struct nft_object_type *type,
 				       const struct nlattr *attr)
 {
-	struct nlattr *tb[type->maxattr + 1];
+	struct nlattr **tb;
 	const struct nft_object_ops *ops;
 	struct nft_object *obj;
-	int err;
+	int err = -ENOMEM;
+
+	tb = kcalloc(type->maxattr + 1, sizeof(*tb), GFP_KERNEL);
+	if (!tb)
+		goto err1;
 
 	if (attr) {
 		err = nla_parse_nested(tb, type->maxattr, attr, type->policy,
 				       NULL);
 		if (err < 0)
-			goto err1;
+			goto err2;
 	} else {
 		memset(tb, 0, sizeof(tb[0]) * (type->maxattr + 1));
 	}
@@ -4375,7 +4379,7 @@ static struct nft_object *nft_obj_init(const struct nft_ctx *ctx,
 		ops = type->select_ops(ctx, (const struct nlattr * const *)tb);
 		if (IS_ERR(ops)) {
 			err = PTR_ERR(ops);
-			goto err1;
+			goto err2;
 		}
 	} else {
 		ops = type->ops;
@@ -4383,18 +4387,21 @@ static struct nft_object *nft_obj_init(const struct nft_ctx *ctx,
 
 	err = -ENOMEM;
 	obj = kzalloc(sizeof(*obj) + ops->size, GFP_KERNEL);
-	if (obj == NULL)
-		goto err1;
+	if (!obj)
+		goto err2;
 
 	err = ops->init(ctx, (const struct nlattr * const *)tb, obj);
 	if (err < 0)
-		goto err2;
+		goto err3;
 
 	obj->ops = ops;
 
+	kfree(tb);
 	return obj;
-err2:
+err3:
 	kfree(obj);
+err2:
+	kfree(tb);
 err1:
 	return ERR_PTR(err);
 }
-- 
2.7.4
