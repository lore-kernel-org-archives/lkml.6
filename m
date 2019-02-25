Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E883C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF1B20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="eE5nVzwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbfBYV11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:27:27 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32910 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731700AbfBYV1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:27:24 -0500
Received: by mail-ed1-f67.google.com with SMTP id c55so8905436edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 13:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FulHKGK+C01DQCuWzsfZQemo7UUyLjvaf8+wgmRlrVI=;
        b=eE5nVzwvRFfHE+FpwEOPUNNj3tHEQPCyB9FjJEUkRs+Ai8N7I/Qp7ryWCMww/f2B33
         DvlPtkNQac/rY1o9f0V6ruJsGFAJzx/i0lliCZC8achnkb4jRGQ7qWHOwuvO/eLIazJo
         Tx0rYZKJ5jBmzD3iguIQ6yHHW4mcgIAsqevL8NIsT51Png2sOl0GEw9D+xt0ZKUdCR5d
         g8zIXw6GFy3lAzSjgZuTk+xLx8i6iRU83w0wrWPix75RFu4aZzwu9VMz4/YolttItsix
         /CaxvVWBBciCzSa+zxncM6yDbSzY1NHx8c43+H3aTdzlbueLTgxRzZJyO7eDNS846ZI+
         h1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FulHKGK+C01DQCuWzsfZQemo7UUyLjvaf8+wgmRlrVI=;
        b=ENDUDSOyLnUw/8MI9GWrRg9T4PU+EIWE1xWF992JnljQVza5RGgsARxYr/4Dk+SqgB
         Qf8zvv2uxjcw3v6Z43eVtr8MwwzyyO9G6Y1XkA/TZj9tehCoIGH8YspNUq6CpkNbL7Hm
         DIHR/6W/9jqNnWHndq46MGfe3MwKE12jnSkawwYKtABeBVTdSM+x+tyZP+EqjR+6Tk2v
         cEOXqJIps1UDB8cI2da8UICguJDTVTUjJ2RPmeR0DNbP9Ky8h+CPZH+jjnTKX0O/Ov1E
         4VAFAcieVwSOKrsggPh2ua2MJGRBsoyzjA7Ng8l0FIeGPPcL3iFdLOn7nfQD8iUskpFZ
         ZQGg==
X-Gm-Message-State: AHQUAuZ5Yj4q3trywxtKfFzhzluE+fJkW0ExSBGIMJjs2FpMhO4TPdGN
        1M2+D5o+0mYvFw5Autqs4yRFVvN3bRI=
X-Google-Smtp-Source: AHgI3Ibrcu1SNtXFKMANSiqMQgey+yhnCEpHmeaaOSlQ5T9csfiJUyDfZmmrNUMuNLVrVvuuFXUBiQ==
X-Received: by 2002:a50:aa2e:: with SMTP id o43mr3445491edc.67.1551130042613;
        Mon, 25 Feb 2019 13:27:22 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id d12sm2969908edb.3.2019.02.25.13.27.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Feb 2019 13:27:21 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        "Hannes Frederic Sowa" <hannes@stressinduktion.org>,
        netdev@vger.kernel.org
Subject: [PATCH] rtnetlink: Synchronze net in rtnl_unregister()
Date:   Mon, 25 Feb 2019 21:27:21 +0000
Message-Id: <20190225212721.2908-1-dima@arista.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtnl_unregister() unsets handler from table, which is protected
by rtnl_lock or RCU. At this moment only dump handlers access the table
with rcu_lock(). Every other user accesses under rtnl.

Callers may expect that rtnl_unregister() prevents any further handlers
calls, alike rtnl_unregister_all(). And they do expect it.

I've looked on in-tree caller uses:
br_mdb: safe, but in err-path br_netlink_init()
fib_rules: safe - err-path is very early in __init
ip6mr: safe - following unregister_pernet_subsys() calls internally rcu_barrier()
qrtr: safe - following sock_unregister() calls internally synchronize_rcu()

While it's possible to document that rtnl_unregister() requires
synchronize_net() afterwards - unlike rtnl_unregister_all(), I believe
the module exit is very much slow-path.

Issue seems to be very theoretical and unlikely, so I'm not Cc'ing
stable tree.

Fixes: 6853dd488119 ("rtnetlink: protect handler table with rcu")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Florian Westphal <fw@strlen.de>
Cc: "Hannes Frederic Sowa" <hannes@stressinduktion.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/core/rtnetlink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 5ea1bed08ede..3db70da4f951 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -308,7 +308,9 @@ int rtnl_unregister(int protocol, int msgtype)
 	rcu_assign_pointer(tab[msgindex], NULL);
 	rtnl_unlock();
 
-	kfree_rcu(link, rcu);
+	synchronize_net();
+
+	kfree(link);
 
 	return 0;
 }
-- 
2.20.1

