Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4031C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBC321A0D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA3b4P03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBC321A0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbeHFN4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:56:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36378 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730822AbeHFN4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:56:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so6748127pfo.3;
        Mon, 06 Aug 2018 04:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yijoUS1MFBPFg+VL+kX0YrD63FqfAB1oTUd4eglEjbI=;
        b=lA3b4P03jwg1gQZSAKh2A8czLjx4TAJoro8R1emSS3pKd+LXCa8u1Mn/TqoOxo+GKi
         qBjEiIObdo0ZIDo2+18+oO0v8NwDumV75hebclfI+hwRzmxouR3ihvkhVGw1kjBXqhk/
         M7E4K3sI4TVipli6oxFpszD2/rCUNs2wYpLbaWyvq5SvyZyK8a4DUECjlCqG0ylJGW1O
         G/BJ8z+uKBUpTaDzf+61cn4R/2u+2mffELYRinJ/P/j3D5A/17vSI8S8Ch2vw0J9x4aI
         6WXqG4W4lVQ6OxD0ICw/zMMxBFxCI8svwBDlXPHDPQAExJ/PGE9a4mmL5GOjm1bxjuU+
         JQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yijoUS1MFBPFg+VL+kX0YrD63FqfAB1oTUd4eglEjbI=;
        b=Lb8Hn8ZEVzrSe8KN/0rLGsunb4lqfhLcMm/7FykQmnDwUVSh4wzNP8O7INvqdrAnBb
         9XurUq5KJOyzKhRirSH1/pDuAG3pCByAS6gYLw6aq8DY6UytyiJDtDoy+J8LDGseRdJ0
         8fObtWB7l1Bj83CDAMie1YWHLrWNA6V6GLRKC4jDqKOGXzOB42sPKDlOUY3Suj6RXnOh
         aRFrCY2oNqZBTLL0SULbJbMCMJhVoAqQXyO0ffXkK+bmXstoKZYZTyspGXJQ00g6mseV
         dWIUggLZaJFNO95Yqfo/QC8RGatpRgsU82/Hl8LoDKvLbm0Mr0Yy2Ic/2P+Xqzk/eECb
         O7Kg==
X-Gm-Message-State: AOUpUlFXPRcVPezYe68QT8e/x/ukXRadHQAy+6dpNVsZicVfP0uA5BLD
        W/NYXPcN0zA26oaaDfpdRGCkLNCRr/c=
X-Google-Smtp-Source: AAOMgper+C9kshf9RiUBBgJjid2k87S7382nMeu6udp0vHHJpHAs/rxzV5VdvB/eL3QABo3GuaegOw==
X-Received: by 2002:a63:7b1b:: with SMTP id w27-v6mr13715564pgc.199.1533556040097;
        Mon, 06 Aug 2018 04:47:20 -0700 (PDT)
Received: from bogon.didichuxing.com ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id j72-v6sm19357098pge.19.2018.08.06.04.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 04:47:19 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net,
        yanhaishuang@cmss.chinamobile.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] tcp: fix the calculation of sysctl_max_tw_buckets in tcp_sk_init()
Date:   Mon,  6 Aug 2018 19:47:00 +0800
Message-Id: <1533556020-20778-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcp_hashinfo.ehash_mask is always an odd number, which is set in function
alloc_large_system_hash(). See bellow,
	if (_hash_mask)
		*_hash_mask = (1 << log2qty) - 1; <<< always odd number

Hence the local variable 'cnt' is a even number, as a result of that it is
no difference to do the incrementation here.

Maybe the compiler could also optimize it, but this code is a little ugly.

Fix: fee83d09 ("ipv4: Namespaceify tcp_max_syn_backlog knob")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/ipv4/tcp_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 9e041fa..a9b7c4b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2543,7 +2543,7 @@ static int __net_init tcp_sk_init(struct net *net)
 	net->ipv4.sysctl_tcp_tw_reuse = 2;
 
 	cnt = tcp_hashinfo.ehash_mask + 1;
-	net->ipv4.tcp_death_row.sysctl_max_tw_buckets = (cnt + 1) / 2;
+	net->ipv4.tcp_death_row.sysctl_max_tw_buckets = cnt / 2;
 	net->ipv4.tcp_death_row.hashinfo = &tcp_hashinfo;
 
 	net->ipv4.sysctl_max_syn_backlog = max(128, cnt / 256);
-- 
1.8.3.1

