Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C02C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E5720645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E5720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeICI6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 04:58:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53822 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeICI6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 04:58:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id b19-v6so10103723wme.3;
        Sun, 02 Sep 2018 21:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Ttasv9wAA50TWH1RmglYBXDp2m1htM+fUMfHro5KZg=;
        b=sbB2COJyBJg8BtdrFr3O1uz3867NMXApilNuhN2LkcqKkLun9/kQRXkzkNklxcZrnv
         tN/2MP8f/jbl6RDWMhtw3FeE0ppujI5iI9UEqTiYbcGdCpYA8ZsniT+rPrQK8ka7jTxl
         kEWXTWDAaZCJ/xH8Hn7RQO4skHd8abD2etvmbp/xfH1aW1sZFqJRQeP1/ZeujtTNTr5a
         zUAlXgl5IPs8kVgsqntdvbZt1+hELd5N9VL9rU2WodChmfxsMmibG9IX2UTKIvp3K/vT
         wzaaHitzJWOShEHsNCLkRjbP4cDB54khIRdZQDcYG8N40EyG7ThC51HXw0XdiajJHlGC
         kQiA==
X-Gm-Message-State: APzg51AzJtPwcuz42ysBLr0nfAY3D0wupfLek/3XH1LIm6ubpI3arDGL
        tvOzRl0F49JKA0oeg976NbH4PvfRuy2+lw==
X-Google-Smtp-Source: ANB0VdZawAX0s1mdbLGugqOsIrHxb88cKb9qNHcYNMRm/8qt/xBm5htH3xrs5VL6O0hA5R5+yvMDXw==
X-Received: by 2002:a1c:ae94:: with SMTP id x142-v6mr4239910wme.125.1535949618361;
        Sun, 02 Sep 2018 21:40:18 -0700 (PDT)
Received: from localhost.localdomain ([88.128.81.0])
        by smtp.gmail.com with ESMTPSA id j66-v6sm22453364wrj.28.2018.09.02.21.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 21:40:17 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next v1 5/5] rtnetlink: move type calculation out of loop
Date:   Mon,  3 Sep 2018 06:37:17 +0200
Message-Id: <20180903043717.20136-6-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903043717.20136-1-christian@brauner.io>
References: <20180903043717.20136-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see how the type - which is one of
RTM_{GETADDR,GETROUTE,GETNETCONF} - can change. So do the message type
calculation once before entering the for loop.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
- unchanged
---
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 30645d9a9801..b36dab7507a0 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3265,13 +3265,13 @@ static int rtnl_dump_all(struct sk_buff *skb, struct netlink_callback *cb)
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

