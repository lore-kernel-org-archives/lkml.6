Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7CDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C3D2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uurRNFsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfBTEJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:09:06 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37341 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbfBTEJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 23:09:04 -0500
Received: by mail-qk1-f194.google.com with SMTP id m9so1140808qkl.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 20:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jrq0vtH0QTYMuPVHkZU/Hm3vLoDV6p5bboaCxjtmhVY=;
        b=uurRNFsCYX6PMRTytiTuGcwrMTTZOTBDjQ0SUTATr2KRFxnBwKKjEwnlSXek2YTNry
         X71aG3hwnTf83MjrTNF3rf4eGy1EbtFJmvot9TUOIzgKpamBMIJRhF6TNppZ1oyFumGZ
         jNkX4Yih63iakKtmAiXSCCC/QvAhMeUBBSmJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrq0vtH0QTYMuPVHkZU/Hm3vLoDV6p5bboaCxjtmhVY=;
        b=qfS2pNjzW3hFKj2Ms3dgL2K0qBoJfHtklhiHn5+mX5QfK5M34EcFNpDLDE5HW5Q/FJ
         79GSXTOc8h1yZGMATwJ1BIe4dzbh2CF4zCWfiVyQzPXK8v9XZBZTQ4QI+7+9qZ3J+TyD
         VD9J6pQey+u74dd7sA9xEfKUTMtxMcDQfveDS74jnx7YVhK2i13qVk342+TGSVbp4EIy
         LTKDVg3Tr2hbVzyLe9d6vF78PHCFQtOxq/99/CpwuqYG1UcwmQTUvq5wfxN9SAuGTv/K
         rG5q487bh4YVPTun9iFMaKxmyCr3HpC4tzgR+rDxHxbkDVVNj8egu0rmMEEaEScT7cOV
         +SaA==
X-Gm-Message-State: AHQUAuZQxTDA1vD/fLaU8o7iQ0Vfobih4FZsOPJ9Y7tgVwuRn2ntwqCW
        HTw/sYrLzMSbjmC3WWKx4mQFSH8vgLU=
X-Google-Smtp-Source: AHgI3Ia7YoOElwfe8HaAbCXFOXZzcUs9K0vepyG7W9xHaGzRVpKDa0ihwXO7xyUV56yhtFRvzUhStQ==
X-Received: by 2002:ac8:554d:: with SMTP id o13mr25775337qtr.105.1550635743082;
        Tue, 19 Feb 2019 20:09:03 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id s19sm2024593qth.80.2019.02.19.20.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 20:09:02 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>, paulmck@linux.ibm.com
Subject: [RFC 1/5] net: rtnetlink: Fix incorrect RCU API usage
Date:   Tue, 19 Feb 2019 23:08:23 -0500
Message-Id: <20190220040827.136184-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190220040827.136184-1-joel@joelfernandes.org>
References: <20190220040827.136184-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Fernandes <joel@joelfernandes.org>

rtnl_register_internal() and rtnl_unregister_all tries to directly
dereference an RCU protected pointed outside RCU read side section.
While this is Ok to do since a lock is held, let us use the correct
API to avoid programmer bugs in the future.

This also fixes sparse warnings arising from not using RCU API.

net/core/rtnetlink.c:332:13: warning: incorrect type in assignment
(different address spaces) net/core/rtnetlink.c:332:13:    expected
struct rtnl_link **tab net/core/rtnetlink.c:332:13:    got struct
rtnl_link *[noderef] <asn:4>*<noident>

Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
---
 net/core/rtnetlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 5ea1bed08ede..98be4b4818a9 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -188,7 +188,7 @@ static int rtnl_register_internal(struct module *owner,
 	msgindex = rtm_msgindex(msgtype);
 
 	rtnl_lock();
-	tab = rtnl_msg_handlers[protocol];
+	tab = rtnl_dereference(rtnl_msg_handlers[protocol]);
 	if (tab == NULL) {
 		tab = kcalloc(RTM_NR_MSGTYPES, sizeof(void *), GFP_KERNEL);
 		if (!tab)
@@ -329,7 +329,7 @@ void rtnl_unregister_all(int protocol)
 	BUG_ON(protocol < 0 || protocol > RTNL_FAMILY_MAX);
 
 	rtnl_lock();
-	tab = rtnl_msg_handlers[protocol];
+	tab = rtnl_dereference(rtnl_msg_handlers[protocol]);
 	if (!tab) {
 		rtnl_unlock();
 		return;
-- 
2.21.0.rc0.258.g878e2cd30e-goog

