Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193D6C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 08:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873D2214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 08:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dectris.com header.i=@dectris.com header.b="VLhYmJHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfBJI7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 03:59:42 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46925 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfBJI7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 03:59:42 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so6201573edt.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 00:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RinWRnG5UYuu3N98c1zrXEKK5jg63KzvVKaJ7oduOs0=;
        b=VLhYmJHJ3hIAgsOE/NHT1IcDJizr5RDU/zU9SZ287s2m02NqW78ehIC7vuh+QL4d+6
         /8g2Kb/l9reN9udYJ3IPSgD1UYVi+aSaneddPUNCL+MFP+2+MorQ2tlFyq5oYrHlctXo
         kaEZtUK95iMbh4loUxAYzGOzsNtb8iLNt3ZpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RinWRnG5UYuu3N98c1zrXEKK5jg63KzvVKaJ7oduOs0=;
        b=Z15lC8F3q9Tq0GfoIfFgmhzsZDqGOZuRxxkc6NWPJ9CB6mUKsA79uzv09XhBWd0gKm
         nSr5jOZPEO2m8AzU4xU9hlpCv6IJgntL3KOKKzc5FQXwRJx/zakpwINRN5Qv/iVIMF2S
         ZuCACbLHlPLfzodWUZsJ0Bm8Y7Chm+a6Y8ZkQYU1KyKTjtEQEi+PpgnwRnrGt+WZfApD
         Z5srVadDE0LdfloX68yNlYkP5jzcN5s7TsMYgP4ogUteWN4DbvWxbEytgd6KnSkLnyBQ
         jj7phoAzepmB8Oxb47B0mmOkqptpzApHxZAdkOw2WtbAZzqNCgMo/ALFZfoLPXCTOyxX
         tgHw==
X-Gm-Message-State: AHQUAuZm1dKp6DIU73f6uKOOAC37GOWbMY1alNZIVTdicSJiYWQU8oj3
        CDgasxdzqpXjPECsPC/PVgNm1w==
X-Google-Smtp-Source: AHgI3IZphpC3xj6aR7N7/vHJ66ymFbHeIQ6gdM2jq2B1RJVl/3Lanlr/P9PnLo1zOictrTwOQc927A==
X-Received: by 2002:aa7:c6d1:: with SMTP id b17mr24389609eds.249.1549789180393;
        Sun, 10 Feb 2019 00:59:40 -0800 (PST)
Received: from th2-ws216-fed.dectris.local ([2a02:aa10:b57e:8400:c727:f827:3beb:2ecc])
        by smtp.googlemail.com with ESMTPSA id t12sm60701edj.61.2019.02.10.00.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 00:59:39 -0800 (PST)
From:   Kal Conley <kal.conley@dectris.com>
To:     davem@davemloft.net
Cc:     kal.conley@dectris.com, Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Li RongQing <lirongqing@baidu.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] net/packet: fix 4gb buffer limit due to overflow check
Date:   Sun, 10 Feb 2019 09:57:11 +0100
Message-Id: <20190210085712.31622-1-kal.conley@dectris.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190209.190114.542890373094719579.davem@davemloft.net>
References: <20190209.190114.542890373094719579.davem@davemloft.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calculating rb->frames_per_block * req->tp_block_nr the result
can overflow. Check it for overflow without limiting the total buffer
size to UINT_MAX.

This change fixes support for packet ring buffers >= UINT_MAX.

Fixes: 8f8d28e4d6d8 ("net/packet: fix overflow in check for tp_frame_nr")
Signed-off-by: Kal Conley <kal.conley@dectris.com>
---
Changes in v2:
- Add Signed-off-by and Fixes tag

 net/packet/af_packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 3b1a78906bc0..1cd1d83a4be0 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4292,7 +4292,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 		rb->frames_per_block = req->tp_block_size / req->tp_frame_size;
 		if (unlikely(rb->frames_per_block == 0))
 			goto out;
-		if (unlikely(req->tp_block_size > UINT_MAX / req->tp_block_nr))
+		if (unlikely(rb->frames_per_block > UINT_MAX / req->tp_block_nr))
 			goto out;
 		if (unlikely((rb->frames_per_block * req->tp_block_nr) !=
 					req->tp_frame_nr))
-- 
2.20.1

