Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769DDC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 20:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60AD218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 20:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dectris.com header.i=@dectris.com header.b="sJ1P0I7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfBIUh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 15:37:59 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39201 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfBIUh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 15:37:58 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so5622823edt.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 12:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APhSD+PqtpJXFHU2VJSOwBXtyiRVtTxs2XUJJDme/Hk=;
        b=sJ1P0I7YQAF8pYjJnTlLRcTh5LD8Doezxdki5oV6mCueZmSDyQRln9CHl6jkFzmZyq
         jl69nySEhKJ2x3mPwDcOQeGyOTp5PaOSzq7YDuVVRbNp7dmNUs1S0VQb0mF4be9WSw7u
         s89NQfswNjmIWHm/RRDt9JYtQ/QTToqFcp6do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APhSD+PqtpJXFHU2VJSOwBXtyiRVtTxs2XUJJDme/Hk=;
        b=shO0TMbzGXm4Zb+eLQUasafyPCKfuecvzAfEpa32k5cstK6GdoyChaq00UaMLFMKa1
         7svcQ1n4rUG7k1PP+PWhrsFCmiZIo0SmZuK+MbQ3CfMkkAAopXSvKMczSVG+G88dcrdN
         YBIv/I8J/QnlER1BcDqotYTj+9Hc2V7cBlfYswWQuJI/X6K8oDY7p1ipDw5CfWvrGp8z
         9dM79c+tLusDSfMKB6U+cIKceBTHd3ZlKy/lglmxy1IPQlGO3nyHcQo/Ck2lvN2mxj+1
         RH9iKN94BKF4KzPl3dDoLs2ErREvjzXWgS//DOWJvKyFLSJYsJZj1twoYnUJ5cd1CzIn
         U7wg==
X-Gm-Message-State: AHQUAuayu6Qaa78GxQi/6G2h0isPKbwmglIQA5AwrZfHcfn9RYtjCBg9
        xibeU7gW8c6P8Mfs2XqZEhaz0g==
X-Google-Smtp-Source: AHgI3IafXDKlBCMZAouLkoZlckigjHIEySXlUOX93PZXUj60RelWkx/poQX2bs8NTW6gz5scNd+WaQ==
X-Received: by 2002:a17:906:228f:: with SMTP id p15mr15030240eja.104.1549744676878;
        Sat, 09 Feb 2019 12:37:56 -0800 (PST)
Received: from th2-ws216-fed.dectris.local ([2a02:aa10:b57e:8400:c727:f827:3beb:2ecc])
        by smtp.googlemail.com with ESMTPSA id q50sm1653652edd.66.2019.02.09.12.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 12:37:56 -0800 (PST)
From:   Kal Conley <kal.conley@dectris.com>
To:     davem@davemloft.net
Cc:     kal.conley@dectris.com, Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Li RongQing <lirongqing@baidu.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/packet: fix 4gb buffer limit due to overflow check
Date:   Sat,  9 Feb 2019 21:37:00 +0100
Message-Id: <20190209203701.27252-1-kal.conley@dectris.com>
X-Mailer: git-send-email 2.20.1
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
---
 net/packet/af_packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index d0945253f43b..d603a430378e 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4291,7 +4291,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
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

