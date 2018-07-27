Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E55C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B787620857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B787620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389007AbeG1AIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:08:13 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36598 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389008AbeG1AIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:08:12 -0400
Received: by mail-qt0-f196.google.com with SMTP id t5-v6so6691126qtn.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 15:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lHNb2W+15FcTjTJNR8ymJ/LEpkmvgA15d7wOWrGq98I=;
        b=d4ojau/xe6A8Sx69ycYO5Zvzg6cnZ+n59m2tCLbqY7OhHZhjQl5usqwyylA0KJ0MqF
         E6nFGCygBzcr3wTAP5zT7k8Y5ySxbD0BeP+//VDasTeLbA6FK4AnmUOACFHw2O6h+R/w
         ZbLRv9PrIHdNayIbh4yhRNyFghbmcEVOQrqjBL3Esw6/Y+x+l9djv0Ink9/llF9k0Wrq
         LAAOrb3viwklG11J2PrN94AlowlpNuoqSCY89Xn+T5srDZP4yuMXiCXcF3b/jdNpru4l
         cQ4wozXaZqpMzRHCTgZJ1y8CbToaFMazln4dI/U85oFeR0AyTSlVKCBWKXymVx8s3VJG
         Jg5g==
X-Gm-Message-State: AOUpUlFvkdE6XG+jI6Y2rN1tgLFNn64H9Q+IpbkHHwpzFKGoruGcoIrJ
        jnWGKMXk5S8cijYjYEtQOCIdsw==
X-Google-Smtp-Source: AAOMgpdQWFCMF1IeOo5Pii516DJUmh89egepDTQ85yd0jDEiU75dsO7CMELmt8klY+ihQxdnVYFlIg==
X-Received: by 2002:ac8:16dd:: with SMTP id y29-v6mr8220773qtk.34.1532731452758;
        Fri, 27 Jul 2018 15:44:12 -0700 (PDT)
Received: from builder.jcline.org.com ([2605:a601:80ce:4700:77a5:8983:ea8b:82ec])
        by smtp.gmail.com with ESMTPSA id g39-v6sm4145984qtb.47.2018.07.27.15.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 15:44:12 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jeremy Cline <jcline@redhat.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] net: socket: Fix potential spectre v1 gadget in sock_is_registered
Date:   Fri, 27 Jul 2018 22:43:02 +0000
Message-Id: <20180727224302.5503-3-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727224302.5503-1-jcline@redhat.com>
References: <20180727224302.5503-1-jcline@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'family' can be a user-controlled value, so sanitize it after the bounds
check to avoid speculative out-of-bounds access.

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 net/socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index f15d5cbb3ba4..608e29ae6baf 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2672,7 +2672,8 @@ EXPORT_SYMBOL(sock_unregister);
 
 bool sock_is_registered(int family)
 {
-	return family < NPROTO && rcu_access_pointer(net_families[family]);
+	return family < NPROTO &&
+		rcu_access_pointer(net_families[array_index_nospec(family, NPROTO)]);
 }
 
 static int __init sock_init(void)
-- 
2.17.1

