Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572AAC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A0520659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A0520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeIEAWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:22:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51974 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeIEAUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:20:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so5671602wma.1;
        Tue, 04 Sep 2018 12:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HYLu7BRWYq4Y+O1AlB6zIzkf3ok76s8VSyCT8YUb4wE=;
        b=UAF8uKMEZ/Q5M2eW2I5Rps7evBBtQAlLRjJOg8kiTAesLs4BDkokd4X8Vjwk3XDuh1
         jVb5TdaZXPZtxS0CdVwPIpwsSh3eEACPEhXPOebJMTTT7MVfMwE+8YNCq28BPnXbF3dG
         Eo1OY5TqSEI3llfSh958qGVY6C4cV0NRFM5e/V8K5Jac/Ye+LFA/NH1W1KFeHJC6GG9t
         RkfPQ0Y6X89ffz1kFOrSvf+Z0J9n55crQ2lGQ+UGnlDzLER3WaqlBJ1RxCGsEUxBgAU5
         aDPdFjVXj0+5Wo08bnNapS8IJM6huN61P3CP6FQRILB8ufkJ/E0HlyZacgeSBmlQ2caq
         Eksw==
X-Gm-Message-State: APzg51DbWZsA+vq9idJM42y7wNNjanWW6NDm6nhM6gzU9ofEQq0UcvDz
        ekT5RqLKfJ29Kb+V0MpSEW4V7vTpG8lUlg==
X-Google-Smtp-Source: ANB0VdaQfb1rlEj+t3RQ9+b/2ZGiVn5ykSjtjemGcGZ+CyxUKFxvjjAe7qbIGePlJJM/M6D+MSQ1lQ==
X-Received: by 2002:a1c:adca:: with SMTP id w193-v6mr3423579wme.147.1536090851146;
        Tue, 04 Sep 2018 12:54:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:f474:3704:f9a0:fc57])
        by smtp.gmail.com with ESMTPSA id 144-v6sm99440wma.19.2018.09.04.12.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 12:54:10 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next v2 2/9] if_addr: add IFA_TARGET_NETNSID
Date:   Tue,  4 Sep 2018 21:53:48 +0200
Message-Id: <20180904195355.4695-3-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180904195355.4695-1-christian@brauner.io>
References: <20180904195355.4695-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new IFA_TARGET_NETNSID property to be used by address
families such as PF_INET and PF_INET6.
The IFA_TARGET_NETNSID property can be used to send a network namespace
identifier as part of a request. If a IFA_TARGET_NETNSID property is
identified it will be used to retrieve the target network namespace in
which the request is to be made.

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Jiri Benc <jbenc@redhat.com>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
v1->v2:
- rename from IFA_IF_NETNSID to IFA_TARGET_NETNSID

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
index ebaf5701c9db..dfcf3ce0097f 100644
--- a/include/uapi/linux/if_addr.h
+++ b/include/uapi/linux/if_addr.h
@@ -34,6 +34,7 @@ enum {
 	IFA_MULTICAST,
 	IFA_FLAGS,
 	IFA_RT_PRIORITY,  /* u32, priority/metric for prefix route */
+	IFA_TARGET_NETNSID,
 	__IFA_MAX,
 };
 
-- 
2.17.1

