Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BFAC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE3C2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE3C2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeIEAUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:20:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40747 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeIEAUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:20:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id n2-v6so5213219wrw.7;
        Tue, 04 Sep 2018 12:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C3e50uBehofTAxCwaV0Z48xO6oU67mNuEtETp9lv5WA=;
        b=emZUzlIObL/auzmWXwEy5c/1UHLiaiIlJQXqc0hrywV/gS/WMM4wXwV14XXwhfvu3s
         jmdHH4BtPtgK/uKqgVTaVRvD/e/9o2qB7Qs087lDiD6m94pS6hth9QHI7SghFNQzamZ3
         CmTonHYtIy1L40pbvbVMAoGIoWmq50/gX3H4C6g7d75t4HCqA9Q9dFwKqz8L13MiXnxT
         vEGWByuU9cP+TTVnQwfUW+NhzNxj1Z43FnXleIwGl3q44qaV+1pWQWLFmzZI2gthy0ml
         VtW31dI7/RnFydSmFk0qXZFb/Eb7IFKqg/L08tqq3Y10KJiDgwfIk+qlVyFZr7vpHAiZ
         /Dtw==
X-Gm-Message-State: APzg51DtIJMCmwNrCu8QjdCrcNGDygwLk6sD0PXxYle2x4kibHWtnPRh
        V5XSlZM+pvxT4pchmhME+jtkz1LBf3RTSA==
X-Google-Smtp-Source: ANB0VdYAbqiQriRh/9M+J87CUYDXPfoqV2bdRzSBsDrju82MjDlKZ6nzPjjVM2IENsmMXzX5r9EfOQ==
X-Received: by 2002:adf:a708:: with SMTP id c8-v6mr14142800wrd.56.1536090855655;
        Tue, 04 Sep 2018 12:54:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:f474:3704:f9a0:fc57])
        by smtp.gmail.com with ESMTPSA id 144-v6sm99440wma.19.2018.09.04.12.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 12:54:15 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next v2 5/9] rtnetlink: move type calculation out of loop
Date:   Tue,  4 Sep 2018 21:53:51 +0200
Message-Id: <20180904195355.4695-6-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180904195355.4695-1-christian@brauner.io>
References: <20180904195355.4695-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see how the type - which is one of
RTM_{GETADDR,GETROUTE,GETNETCONF} - can change. So do the message type
calculation once before entering the for loop.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v1->v2:
- unchanged

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

