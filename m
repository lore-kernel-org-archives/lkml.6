Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45883C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092F920869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEe1xzPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092F920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388960AbeKGBL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:11:29 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34320 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbeKGBL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:11:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id f12-v6so5200386plo.1;
        Tue, 06 Nov 2018 07:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1MrB5yf3k6Vh4n7BS2cHNATRztz8yFqbsqSu4L931yY=;
        b=qEe1xzPfb5svXjfXt3ZzyXoXvsrm2BlgbD8ZYZeQ8DQZmk3OsHPue0AC4n0J+b79Cm
         vds0e+FsOONf/kh3zVPEdDIoJHo1NTmW513yFgIpK5RrnQg0/YvUkO0B9BspVQoWbGNi
         7aSXCNBbsXLGyrLhowzdqkWqh77x/6RuJ0asmeHsYUM977k8+C6Jps7XeSP0pqOy/2g2
         CDuFXwYdnmj40jo3M9Q5S/Ls/EN36Z3lzSLibtPO6tI93tgiq0XMNesUeLUPQwSHb5Cd
         l7DuvcgLouAL6hKgQqFQq4pWbjwdsCZlz8j8v+TLcauXscxSHGGulhrnUVKd7PV9u98P
         Z6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1MrB5yf3k6Vh4n7BS2cHNATRztz8yFqbsqSu4L931yY=;
        b=hfW3Fx5/v8NLflPyPWv6moSJqisCbYJCgCrHvz+oQD2H/KXT5TMe6Hklj7TVfFe99C
         3nan5iW++SI86NbNFfyFu18XmpJdQCZga0/u389/unsPtTg8jC7m/AzIOqIcZ0RcCJd9
         bjP7koydEw/gMv9KOefU4Vj7OuYnbii7pZI3atI8hi/lHVkFBkUck9c4tloSyj4HtLZC
         thgDEj7fNDAndSGfGgBJJUT/E3YfzwWHWgwzMO1+8Jzwmy8uDPstTEr9OA+UO13/lP0l
         OwYxyPjYTXEUc8VXgSDzorhN6b6NbgouDpxI0KhmbpzHJt1RjYgSBzCpc1H7XrcgU93a
         Tjzw==
X-Gm-Message-State: AGRZ1gKXkGW5RKGx9OP5/GTngykagaOUKXwi/b6B/PBJ3lA74g9ZSZz9
        mGUKdZuSaAlsVnG2C/LBq2U=
X-Google-Smtp-Source: AJdET5fHnMD9EP/PRZBt8Xg5V7vxvL9gNGjL2lyaBu5GycND2wUFh1/B31l8KpN2OFGM9twWWdV/UA==
X-Received: by 2002:a17:902:6948:: with SMTP id k8-v6mr27160759plt.22.1541519140551;
        Tue, 06 Nov 2018 07:45:40 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id g8-v6sm28586310pfh.57.2018.11.06.07.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 07:45:39 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, dja@axtens.net,
        willemb@google.com, ast@kernel.org, sbrivio@redhat.com,
        posk@google.com, pabeni@redhat.com, borisp@mellanox.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] net: skbuff.h: remove unnecessary unlikely()
Date:   Tue,  6 Nov 2018 10:45:36 -0500
Message-Id: <20181106154536.8789-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to use
unlikely.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 include/linux/skbuff.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0ba687454267..7dcfb5591dc3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2508,10 +2508,8 @@ int ___pskb_trim(struct sk_buff *skb, unsigned int len);
 
 static inline void __skb_set_length(struct sk_buff *skb, unsigned int len)
 {
-	if (unlikely(skb_is_nonlinear(skb))) {
-		WARN_ON(1);
+	if (WARN_ON(skb_is_nonlinear(skb)))
 		return;
-	}
 	skb->len = len;
 	skb_set_tail_pointer(skb, len);
 }
-- 
2.17.0

