Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5ABC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3E620645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3E620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeICI5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 04:57:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46871 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeICI5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 04:57:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id a108-v6so16324221wrc.13;
        Sun, 02 Sep 2018 21:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MAXfVGzsIqmA+wyo0wYzYx18bQFQuNziqTws7Do2Ntk=;
        b=BYg+OB5tBUl4UqWgvE/1Z8Wgj6h7AFfnsuzDCKCil8bciAAmaeOtkrwmzIOcYrab33
         l+TrVM2r60C4N16bJUt5jipnQuFvJ37iyqw787r+nzsbevm5Hzj9NAzNVLjwPHU5TmrF
         KxXcHEnZcBSJFj7gXxYINX5I2NZQZdE3DN3zFOHo4NgZ9e0W/2WJAl61joM0OaJtzN/x
         ZYrwlIeKc4UTKTsvYFfdWkgPNjW8mGRZE7xTK1zWZdK/kLlYdU9XzJLuKzU0BDTF1vBv
         Y5KYRU9iNYzqNcV9b05OhHkl5TrzqcuK1VMSazuqHX0W0+CkZFTiyGNze6L65JYVau1q
         Ujbw==
X-Gm-Message-State: APzg51DL3qbsyu1h9vvHio9JFpIL4eKKV+FaVlcOOM184SmjcO4JkfeO
        St000UHhNKfiBFSKd/XlX7srRqf+aCY6hw==
X-Google-Smtp-Source: ANB0VdZJXPpmMtPf9d4MGvSjlkXQjLtOOZod+4HqriZXjvqD751o1Obkv+xd7OhmmQNiXFVWTBT5XQ==
X-Received: by 2002:adf:9404:: with SMTP id 4-v6mr18765323wrq.129.1535949558463;
        Sun, 02 Sep 2018 21:39:18 -0700 (PDT)
Received: from localhost.localdomain ([88.128.81.0])
        by smtp.gmail.com with ESMTPSA id j66-v6sm22453364wrj.28.2018.09.02.21.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 21:39:17 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next v1 2/5] if_addr: add IFA_IF_NETNSID
Date:   Mon,  3 Sep 2018 06:37:14 +0200
Message-Id: <20180903043717.20136-3-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903043717.20136-1-christian@brauner.io>
References: <20180903043717.20136-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new IFA_IF_NETNSID property to be used by address families such
as PF_INET and PF_INET6.
The IFA_IF_NETNSID property can be used to send a network namespace
identifier as part of a request. If a IFA_IF_NETNSID property is identified
it will be used to retrieve the target network namespace in which the
request is to be made.

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Jiri Benc <jbenc@redhat.com>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
v0->v1:
- unchanged
  Note, I did not change the property name to IFA_TARGET_NSID as there
  was no clear agreement what would be preferred. My personal preference
  is to keep the IFA_IF_NETNSID name because it aligns naturally with
  the IFLA_IF_NETNSID property for RTM_*LINK requests. Jiri seems to
  prefer this name too.
  However, if there is agreement that another property name makes more
  sense I'm happy to send a v2 that changes this.
---
 include/uapi/linux/if_addr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/if_addr.h b/include/uapi/linux/if_addr.h
index ebaf5701c9db..0e0cd588cac0 100644
--- a/include/uapi/linux/if_addr.h
+++ b/include/uapi/linux/if_addr.h
@@ -34,6 +34,7 @@ enum {
 	IFA_MULTICAST,
 	IFA_FLAGS,
 	IFA_RT_PRIORITY,  /* u32, priority/metric for prefix route */
+	IFA_IF_NETNSID,
 	__IFA_MAX,
 };
 
-- 
2.17.1

