Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B81C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9372241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A65oBEnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9372241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbeKMIIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:08:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35809 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeKMIIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:08:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id z16-v6so11097674wrv.2;
        Mon, 12 Nov 2018 14:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UlAFDvpkLWvEwWRA8ZxVT3M82HAStgd1I+FIrT2z4c=;
        b=A65oBEnz5d/N865ZZuYvubCk/hhGL/OOaZJ/uF5z+QAH/scBGR+jVsb20nQfLu9bHG
         bG9oG8+hrK5TzS2/BIuPOwMa2+K+93hr9NFYWv5rIByKrVgIzkL0dKe7UFn8J8I7tOIZ
         d+Ov41i/gOQxqSs1310Ac5j5PEDuo+xpOhmYvKxypsyrFbNH0qDfMS+ctzfjVzhZaFoz
         y6I4MHY+Z8mzYhiTxx3Clwkz3koGqgin1L4CCZEDStAvDgelewEoD0KXgBcKcy17Khg2
         j5nMvOo/X9XLLjEaEydzLf3hK+cJ9gl4dDb9wSJ0XB7q3BIhqH6FgmcUzKKEKkKJKLJN
         fBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UlAFDvpkLWvEwWRA8ZxVT3M82HAStgd1I+FIrT2z4c=;
        b=gLM516JE+i523Ba8ValF8Ael8Ykvir2ZPBAVE5oNQ2hiJxYZf5avnUBseuYF4pPcG8
         siComhP8l9hP/WYlyPMmvfVmuuK3yqZ3rDrMQ5zK7/Cd53/RDQc1SL3Yz65lsHBCW94F
         MoPCYC5d1NYxtImbhorSTUnjps81zdFk7riOrJyJmsjeMyQkk1USX81bqU27an+SiOv2
         q31ZoJ/WXaMeRd5Sz0ElM4v/AT8UUAy8zoE39046qkSHM4o0drUmn4ChH4LJwN2XmfvW
         pVCyTn9NPq0wMxCtZ/s+5BccLuXzdrhjCZPhlcCD5QOL8Owq6Z/5wO5g+Klp1BwWl6Mj
         4wUg==
X-Gm-Message-State: AGRZ1gKaU69uigag/WZlZLnxpogbmaoc/HtRhR9g98D+TGwbt76Czfk0
        rEz8ao794veK1/ahLxsbpBw=
X-Google-Smtp-Source: AJdET5fNWUXEW8E1l6jHZ63w1XtVYoPM1O3q2cY3uOUWfkxuUY49zgIOVh7zTVMprWHsMNGnszYwuA==
X-Received: by 2002:adf:e3c2:: with SMTP id k2-v6mr2782409wrm.156.1542060821241;
        Mon, 12 Nov 2018 14:13:41 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id e10-v6sm14871470wmg.23.2018.11.12.14.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 14:13:40 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] geneve: Add missing braces in addr6 initializer
Date:   Mon, 12 Nov 2018 15:12:48 -0700
Message-Id: <20181112221248.11477-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/net/geneve.c:428:29: error: suggest braces around initialization
of subobject [-Werror,-Wmissing-braces]
                struct in6_addr addr6 = { 0 };
                                          ^
                                          {}

Fixes: a07966447f39 ("geneve: ICMP error lookup handler")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/geneve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 7c53e06b31c3..224d8b0bb5de 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -425,7 +425,7 @@ static int geneve_udp_encap_err_lookup(struct sock *sk, struct sk_buff *skb)
 #if IS_ENABLED(CONFIG_IPV6)
 	if (geneve_get_sk_family(gs) == AF_INET6) {
 		struct ipv6hdr *ip6h = ipv6_hdr(skb);
-		struct in6_addr addr6 = { 0 };
+		struct in6_addr addr6 = { { 0 } };
 
 		if (!gs->collect_md) {
 			vni = geneve_hdr(skb)->vni;
-- 
2.19.1

