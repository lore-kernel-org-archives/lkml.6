Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 41D2BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11EB208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMKC4Zlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11EB208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753965AbeFLEaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:30:06 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42459 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752632AbeFLEaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:30:04 -0400
Received: by mail-pl0-f65.google.com with SMTP id w17-v6so13609616pll.9;
        Mon, 11 Jun 2018 21:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bxqWUWhCKY9Y0pIQmPe1KyEDr/D7TjfHfUiC9NAULgU=;
        b=GMKC4Zlot2F4YtcjsdmYovwVAbLbn8jxljL4njSXVMZ6Iw+BZVa7asrCmzBeA8J2DR
         05XM64sZKpJzATfalnyKIP6Zbd5uDETbZbCkitR5fisBI7FF4Q8TVGQrIHkQEzrzFpsy
         h/hO4fu5BVP8YwKYgSkrT7Gag9GARh+HobQXBZPUdMigAiADRtdcEWutYBDNbcbospWd
         5kgAAWuEVqlxXq1WEMZmb/a4ZDu5fE9Athk7aQFQkrhxAz115tzO/TFWM/uMwFK86EIc
         7moLhnIwNWLi2X/wt2cx9dkq6BvquplJNeHuokL3Xb6BGMdwYGAG9ZvirnOsY73lIX6K
         E2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bxqWUWhCKY9Y0pIQmPe1KyEDr/D7TjfHfUiC9NAULgU=;
        b=QIOj/SIE6cqXqJfxmQkSiBcJZoid61B+7Hv18oDssKPiaqrfCsLKETwNya8OWi/hIy
         jXe62SEHeVrKHuTE/xNpuSe+fwSaxNedmUKv3WYgc4FQye9aGfdgcB4XvxiKbsbrSfN2
         KVTiHkMXS+FShNErSqeLkQ0UFsq/jgD9wq0WUlemGcG8mnIegFzZNPvTzN7tNaU7nyG/
         Wc1ooIEQViQ84oKJIhXOUSEh73ipdhMNeKMFealTC/vGeTKRXoG/1IH9JwCQe+cS22v0
         Nm5FoQiiSoJhydhow54BxLhRsL0XIOqp/rfmogWP2a0I9UruLVAD1zj/lVoeLRjiGmPy
         3c5g==
X-Gm-Message-State: APt69E2TWuAMBDRW4f9LysDjRutF37m0RbW6+e90cP7S4kHOdAaoaa7U
        PW7hAQVtgJqhPG/M3NJxgKU=
X-Google-Smtp-Source: ADUXVKJeb3ZBnKRc1gs87LgBqH9zmvBGrsVFZ+k+XktthWZmbFj1JU9MCr86T7D3qHt/7bSzxkobGg==
X-Received: by 2002:a17:902:8a82:: with SMTP id p2-v6mr2298190plo.244.1528777804408;
        Mon, 11 Jun 2018 21:30:04 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id d72-v6sm121913628pfe.150.2018.06.11.21.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:30:03 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Wei Wang <weiwan@google.com>, Martin KaFai Lau <kafai@fb.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Dumazet <edumazet@google.com>,
        Florian Westphal <fw@strlen.de>, Joe Perches <joe@perches.com>,
        linux-decnet-user@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: add error handling for kmem_cache_create
Date:   Tue, 12 Jun 2018 12:29:56 +0800
Message-Id: <1528777798-40722-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kmem_cache_create fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling kmem_cache_create.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 net/decnet/dn_route.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/decnet/dn_route.c b/net/decnet/dn_route.c
index e747650..2b743c7 100644
--- a/net/decnet/dn_route.c
+++ b/net/decnet/dn_route.c
@@ -1861,6 +1861,9 @@ void __init dn_route_init(void)
 	dn_dst_ops.kmem_cachep =
 		kmem_cache_create("dn_dst_cache", sizeof(struct dn_route), 0,
 				  SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
+	if (!dn_dst_ops.kmem_cachep)
+		panic("Failed to create dn_dst_cache cache\n");
+
 	dst_entries_init(&dn_dst_ops);
 	timer_setup(&dn_route_timer, dn_dst_check_expire, 0);
 	dn_route_timer.expires = jiffies + decnet_dst_gc_interval * HZ;
-- 
2.7.4

