Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A3FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C6B2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C6B2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeH2DNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:13:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38022 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH2DNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:13:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id e2-v6so1439977pgv.5;
        Tue, 28 Aug 2018 16:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XqzziXXF3hYtBWJ2NxnhkBzTH8osK2x4YWGyi9jb6RA=;
        b=fTTDp4EEj0p7Pp3DCCxzY25HxnXf9TaxpH83Dl8X+TT033sFadCHMeg8+wYGkewxV4
         iDesM+TBtf0dvWgmOy37raEU5szeGReC0C8bJsOs9U8UIKReosDFq3SMWedKcRHrSJsI
         Xk5BT856OAyRVyHZt2NBG4tIGyu3rz3c3G2FKE/rlXKTSSsAHipm8AAqvQNWhAGdFsv+
         kdrsptrwYVWCdn9LTf9KbKqnuldMt336olRYQ+fyuGY8UPuVhvQF0DHsO3HAT1ULqKQU
         i0fHvg5G0uKoxqfbQmVn8X6l3CrnMMnzkn9oVuhtHklj339SnqxQR8hghIardZHWjJYq
         xBkA==
X-Gm-Message-State: APzg51Drr+t57EqJ3CIZq6oa/8+OcNynCBRwE2mScw+SsjUn2bWylv6z
        UUMMhLouF4geTfMcQwf7M//IinLMNUy7DQ==
X-Google-Smtp-Source: ANB0VdbDaapedRZv+JZxgDNSF/ls74DA3vnNyLivGpjOGle+CPCycyQzq6Vhnqydq2c3mYDa+MdfHA==
X-Received: by 2002:a63:d04f:: with SMTP id s15-v6mr3441525pgi.42.1535498390854;
        Tue, 28 Aug 2018 16:19:50 -0700 (PDT)
Received: from localhost.localdomain ([72.28.92.217])
        by smtp.gmail.com with ESMTPSA id q6-v6sm4217354pgq.19.2018.08.28.16.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 16:19:50 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next 2/5] if_addr: add IFA_IF_NETNSID
Date:   Wed, 29 Aug 2018 01:18:56 +0200
Message-Id: <20180828231859.29758-3-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828231859.29758-1-christian@brauner.io>
References: <20180828231859.29758-1-christian@brauner.io>
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

