Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A92C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FAB208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="db6j5TP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FAB208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbeG0RRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:17:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55230 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388497AbeG0RRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:17:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so5728567wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 08:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id;
        bh=KPyvd5o+I9Jov49HHmbeHutGib2mspLlbfetN7M1LJA=;
        b=db6j5TP1lZV2eJkpXW4jimetZmkeTqTz5yWhJblDbbVIq2vpr+5MaaYOtn013VlIt+
         EhB5CC6780kiNyWLBHtK3JJFnfW9vD6MNoil/yZ/pOf/Oo/fQeyyQTodtIrdz9WXIsne
         0jV9ZPTpCHF1hK+FBg/Ss388F7sOzbexAYV5ItJdnR7td4B3+4JKAMkJQGlWFTBPk3Sc
         mpK+gwjQgQzAry/75WdIR4+cOBJdaxOHVP+oogOGBh2vENjFwyyMCOHzpANMFbKB4pmO
         BfaCkgBMo55tpSsg/duDwMD67hkq+tmY+edRLEhc6ueKqLUXTgIGjGnr2RMqCSnB3HyM
         tJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KPyvd5o+I9Jov49HHmbeHutGib2mspLlbfetN7M1LJA=;
        b=if5JxECScsUyWT9W+hIlK4+SVrGmf+lhuF0n7otZAe3FWuIBWTKFDRCkU5LNRqmMME
         foN75tSsgM1cGETcm1vqTN97IM03umxmrJLjQFVzWvrMm7QqYMUDnAgNxzkc20wKeSkr
         UDKTnO7u9wSkJLJMd0y/Df8a5urfOFumcsRaYbr9S/u0MX9fTvMAcJHLx63+kZOJqOgZ
         C8G3GRVzPJ1Z5X7FJcLt05oDSURVzuwuIarxgjt/ToRsQu6nzNFaDiQpfLQqcMWgKiKD
         kNTak1xBX+h262IHE5KKE7boj8x7QIo4wFn/9daKMVSHLtLmfii/IdxKh4Ic4RuaRBEw
         QokA==
X-Gm-Message-State: AOUpUlGPIhFK7wEIRvYV5ArfLIP525F4j51v9OdfvWyPt6gseA20Mow3
        Bhf6tzqrtSHKawS6QQiZffXsSMR7uJI=
X-Google-Smtp-Source: AAOMgpfTNoyJuGR7NH6OddSSYHTBqz5cW+znCcL4NvUtXE+MFozlOuv+7+P+Ljik3gd0kyRlSs4KjQ==
X-Received: by 2002:a1c:ea9c:: with SMTP id g28-v6mr4754416wmi.65.1532706887207;
        Fri, 27 Jul 2018 08:54:47 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g125-v6sm3319590wmf.16.2018.07.27.08.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 08:54:46 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        netdev@vger.kernel.org
Subject: [PATCH] netlink: Do not subscribe to non-existent groups
Date:   Fri, 27 Jul 2018 16:54:44 +0100
Message-Id: <20180727155444.17081-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make ABI more strict about subscribing to group > ngroups.
Code doesn't check for that and it looks bogus.
(one can subscribe to non-existing group)
Still, it's possible to bind() to all possible groups with (-1)

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/netlink/af_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 393573a99a5a..ac805caed2e2 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1008,6 +1008,7 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 		if (err)
 			return err;
 	}
+	groups &= (1UL << nlk->ngroups) - 1;
 
 	bound = nlk->bound;
 	if (bound) {
-- 
2.13.6

