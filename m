Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B79C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5B72087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5B72087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeH2DNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:13:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41717 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbeH2DNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:13:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id s15-v6so1435138pgv.8;
        Tue, 28 Aug 2018 16:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2dRWU6wXAvgxo28/Qu85Kq6vQ1rK/y9KO2to2DTfQno=;
        b=ZX1rbYezI1kQOkkCkYHAb9HB93RHg7iApBwoudnGath78RxF93ZId6xFBHyLLOG3F5
         CL29jkCpItspuEeMZaG+3xbyh5HGFiaSrZOzrd3s32jZs9YmanHrsWbDZwQIaf11/nvx
         wbEffTfKSmxKEbAT4I7UpMvTzcwyHyrPq2KWT6RZbF9VKaLyh3tYber6RQ0qkzWc4/Gw
         fXNleJeLIqWz98R8Buygxf0XXHXMi7Mu+vKdo2it/0MoGV9Cy4EA5ylIgsHKK619hH84
         h3fLxvftd0TIk/1HJyCGm9UG+BPtjn+7/m56NaSI2PqJjVAU7IHrVGcrBW/S+Ueiuoob
         zWbQ==
X-Gm-Message-State: APzg51AgdWhfAyZXSLZ/PuPt3OO3ka5/ZV8WKWP66OHGCCpS2FIhOj/a
        t9VlOTwpdVtpqCRe0lHZ6hBKN+Kctw3HUw==
X-Google-Smtp-Source: ANB0VdZ7UvmeeVqVXe2LcC+l6bYCqOqOOByaA/6gP56gsMd/tcAMM+cPgAehiR6qEZqrT0o8psh0wQ==
X-Received: by 2002:a63:4663:: with SMTP id v35-v6mr3474850pgk.178.1535498393718;
        Tue, 28 Aug 2018 16:19:53 -0700 (PDT)
Received: from localhost.localdomain ([72.28.92.217])
        by smtp.gmail.com with ESMTPSA id q6-v6sm4217354pgq.19.2018.08.28.16.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 16:19:53 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next 5/5] rtnetlink: move type calculation out of loop
Date:   Wed, 29 Aug 2018 01:18:59 +0200
Message-Id: <20180828231859.29758-6-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828231859.29758-1-christian@brauner.io>
References: <20180828231859.29758-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see how the type - which is one of
RTM_{GETADDR,GETROUTE,GETNETCONF} - can change. So do the message type
calculation once before entering the for loop.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index c6c6f93cd195..a644d392918b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3215,13 +3215,13 @@ static int rtnl_dump_all(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	int idx;
 	int s_idx = cb->family;
+	int type = cb->nlh->nlmsg_type - RTM_BASE;
 
 	if (s_idx == 0)
 		s_idx = 1;
 
 	for (idx = 1; idx <= RTNL_FAMILY_MAX; idx++) {
 		struct rtnl_link **tab;
-		int type = cb->nlh->nlmsg_type-RTM_BASE;
 		struct rtnl_link *link;
 		rtnl_dumpit_func dumpit;
 
-- 
2.17.1

