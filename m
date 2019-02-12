Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DF2C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCB52080F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIAgkhMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfBLLco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:32:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44336 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfBLLcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:32:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id p4so1153660plq.11;
        Tue, 12 Feb 2019 03:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L0NrI1CL30E62nAhFJvGircIXNYAaqv7VLTzgBB9BZk=;
        b=cIAgkhMrm/GeIa+uDukkaIXV41pB3W+QB1+M8V3I6wfBmTmZNDeYv1Z0vlfc2D5xvh
         DvUAhrmVhOGOWak/0VRCcLD3TZ0lB3spOzirKg/97jB8BANGgsJHyRWdxhqo2ZYoXZYD
         UNkQL2XrVqN/6qM+3DxYD80CkrajkvBpm8tYby2r0hGD/mx+syTRF+RwqWZZKOREFU6r
         aOnu9bjQgZpV+WeaW5RJdeyXzD/u0IxQIszRjy/qxgHCJfZNlVVoOknqRURFBM3kkYw/
         GWeonlIWvsxtqrvOTqrle76yIdpDFJ69RNBtblZQQq5mDCPQ3Ugb96T+Om4GCxJWkw6C
         iBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L0NrI1CL30E62nAhFJvGircIXNYAaqv7VLTzgBB9BZk=;
        b=h5rNCrlE8GfwaMh8TUkxqntLNQ84Qa62hqQ/Qv+jDf3K4yL5F5oqNDdm6U55WFOKgT
         EkMVFVq4tWKurqINu9cTMnHtLrq9Ibqhadkm3Mzuu3dAWdowVGVP6RI5MUzdv7md4mTf
         su73g2cUZWFhpu0wIo725leYgiPg+WZRUWep5Y/HS9I9yoNJf7faVWu52GA1O3UjNm8J
         4UsCbS5bwjhsZ64/vHanJhIaAateZ7XjwqJSG4pYsq7eZ3KPgbEgUGf/k/Dc+8ilorML
         xqNpwi3fiDratsFLH88XZounL40wbsYq2HlAVIG11prFF3hjhLboXsR1EaiaeXp04Jrc
         XTeQ==
X-Gm-Message-State: AHQUAub4/gJ1Xgy+f3qILpG2nPjq6+ieSFFyigL1vAPkwHMmrljZmDt7
        mfABg0JwCKeffv4yZZBeVbM=
X-Google-Smtp-Source: AHgI3Ibdm6D22NcdTGIXvtpfZr0vh23HbJ9oaOVQ3gCHSBGBVKS7sRpvXZriv+SC3i0W0/RKRwiC8w==
X-Received: by 2002:a17:902:2468:: with SMTP id m37mr3571224plg.314.1549971158732;
        Tue, 12 Feb 2019 03:32:38 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id q21sm28701034pfq.138.2019.02.12.03.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 03:32:38 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     daniel@iogearbox.net, ast@kernel.org
Cc:     yhs@fb.com, brakmo@fb.com, edumazet@google.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [bpf-next 2/2] bpf: add BPF_SOCK_OPS_STATS_CB for tcp_stats()
Date:   Tue, 12 Feb 2019 19:31:37 +0800
Message-Id: <1549971097-12627-3-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1549971097-12627-1-git-send-email-laoar.shao@gmail.com>
References: <1549971097-12627-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introuce this new op BPF_SOCK_OPS_STATS_CB for tcp_stats() such that it
can be traced via BPF on a per socket basis.
There's one argument in BPF_SOCK_OPS_STATS_CB, which is Linux MIB index
LINUX_MIB_* to indicate the TCP event.
All these Linux MIBs are defined in include/uapi/linux/snmp.h.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/uapi/linux/bpf.h | 5 +++++
 net/ipv4/tcp_input.c     | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1777fa0..0314ddd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2894,6 +2894,11 @@ enum {
 	BPF_SOCK_OPS_TCP_LISTEN_CB,	/* Called on listen(2), right after
 					 * socket transition to LISTEN state.
 					 */
+	BPF_SOCK_OPS_STATS_CB,		/*
+					 * Called on tcp_stats().
+					 * Arg1: Linux MIB index
+					 * 	 LINUX_MIB_*
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 88deb1f..4acf458 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3557,6 +3557,7 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
 static void tcp_stats(struct sock *sk, int mib_idx)
 {
 	NET_INC_STATS(sock_net(sk), mib_idx);
+	tcp_call_bpf(sk, BPF_SOCK_OPS_STATS_CB, 1, &mib_idx);
 }
 
 /* This routine deals with incoming acks, but not outgoing ones. */
-- 
1.8.3.1

