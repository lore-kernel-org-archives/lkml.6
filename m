Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EA4C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 05:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87C42147D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 05:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FNrMYqdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87C42147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeHZJjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 05:39:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37156 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeHZJjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 05:39:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8-v6so6016252pgs.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Aug 2018 22:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=AkagPnxDpVrAzllDBHb9Cd+YDId70uSkhKXJ2KEDkuU=;
        b=FNrMYqdJZ4lzfwQav84fKtbWhbfogYm13bsprXS3JoiaLAzb0fFsr89JmiERhl5oBL
         dGCDM/ZJ1RDjopmqX7yPybMhYssOHrPDKGXDtAiUqmy7vPC8zKOk00E31N5oDdvi0u7k
         8Ce4NgS+5/zKpBelsCy3SodjIpiSJRzpjWCkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AkagPnxDpVrAzllDBHb9Cd+YDId70uSkhKXJ2KEDkuU=;
        b=KkYnlvLLsFfgLMW8Mwo4Jlj/mDu/l9aiqWsGXgbI/vkYOt3VInsR/ZaXbl2TRI+gAh
         tfytnVeUkqoGg0VlqjPXjb8NYwTqmfV8+78fcgP3aN68Q6Evi3z/Eeqz9OFYkigmCDZx
         ruRGmQZ9TUt3UigleyzJ9r7JVioHNZ0wPZaN1wonyMEEmE3bAgQx40q2S/86w3mluq9b
         IRMj/po1Z84vXHVVgxYPQ/GH3JoM49HW0a/NZPxZ/JzSgB410hgk5ruzlgaMb2FLjW/6
         kypySKTFIhpyfkOdLe9JLMRiaNWwxLMdXymA+nVKpG3Nv/cnARur96VzW6+KRL3MZMHZ
         0XhQ==
X-Gm-Message-State: APzg51C8zSXfeS9SogPeud7iNOzEA9WukKdCWyYF3iwNIZEv0D0hQqg4
        w76tQvtR/mF73Sk4U3WiyskbVg==
X-Google-Smtp-Source: ANB0VdaKWJRIXA7Ud5AA5h+8lOJGT5RMyIjagwBswDkpVD1gZRWAL0sCWevWVouk33DYyq4bJ1IzHg==
X-Received: by 2002:a62:591a:: with SMTP id n26-v6mr8817584pfb.94.1535263083685;
        Sat, 25 Aug 2018 22:58:03 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id n18-v6sm18231605pfa.50.2018.08.25.22.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Aug 2018 22:58:02 -0700 (PDT)
Date:   Sat, 25 Aug 2018 22:58:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
Message-ID: <20180826055801.GA42063@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Via u32_change(), TCA_U32_SEL has an unspecified type in the netlink
policy, so max length isn't enforced, only minimum. This means nkeys
(from userspace) was being trusted without checking the actual size of
nla_len(), which could lead to a memory over-read, and ultimately an
exposure via a call to u32_dump(). Reachability is CAP_NET_ADMIN within
a namespace.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This should go through -stable please, but I have left off the "Cc:
stable" as per netdev patch policy. Note that use of struct_size()
will need manual expansion in backports, such as:
	sel_size = sizeof(*s) + sizeof(*s->keys) * s->nkeys;
---
 net/sched/cls_u32.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index d5d2a6dc3921..f218ccf1e2d9 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -914,6 +914,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 	struct nlattr *opt = tca[TCA_OPTIONS];
 	struct nlattr *tb[TCA_U32_MAX + 1];
 	u32 htid, flags = 0;
+	size_t sel_size;
 	int err;
 #ifdef CONFIG_CLS_U32_PERF
 	size_t size;
@@ -1076,8 +1077,13 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 	}
 
 	s = nla_data(tb[TCA_U32_SEL]);
+	sel_size = struct_size(s, keys, s->nkeys);
+	if (nla_len(tb[TCA_U32_SEL]) < sel_size) {
+		err = -EINVAL;
+		goto erridr;
+	}
 
-	n = kzalloc(sizeof(*n) + s->nkeys*sizeof(struct tc_u32_key), GFP_KERNEL);
+	n = kzalloc(offsetof(typeof(*n), sel) + sel_size, GFP_KERNEL);
 	if (n == NULL) {
 		err = -ENOBUFS;
 		goto erridr;
@@ -1092,7 +1098,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 	}
 #endif
 
-	memcpy(&n->sel, s, sizeof(*s) + s->nkeys*sizeof(struct tc_u32_key));
+	memcpy(&n->sel, s, sel_size);
 	RCU_INIT_POINTER(n->ht_up, ht);
 	n->handle = handle;
 	n->fshift = s->hmask ? ffs(ntohl(s->hmask)) - 1 : 0;
-- 
2.17.1


-- 
Kees Cook
Pixel Security
