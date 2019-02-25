Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9F8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A01020C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129257;
	bh=bLIoPXQ0Y4KiZ/Xs7VvaKqwthaQKCI7o5AuWXgQcs5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Al9v1r0ar5HI3buBXXsNEehHidibIYwxzOtMZbL8QA7ihLIGjyJ9ab08kg5Zk2q3B
	 KATjQbm0Cp+O1I0YeHaYkUejhm9Ii6S5mBRd+l4QDwKQ4UYotyz6riCtW250r8t05d
	 fjn+lzbYQua29wF0rwctE+85hmF+ao0286+z/Wxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfBYVOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:14:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729157AbfBYVON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:14:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1451520C01;
        Mon, 25 Feb 2019 21:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129252;
        bh=bLIoPXQ0Y4KiZ/Xs7VvaKqwthaQKCI7o5AuWXgQcs5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FOxPS5HQG8LkewIK9fyHk32xyy0SmJ2u77/yjjrRf/8s6hwQucgWM3M6k1EzT6pPh
         D68Px1HlSaMRGA3NLZGUeLQEiBWxZniTy4v8S3Uwmi5N0IJCwuhSnf0KMNvX5jOq2h
         +PFTBKv/Bu/kYiiUSKGtppLRTE1p8IatbbXPShmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Oussama Ghorbel <ghorbel@pivasoftware.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 35/63] sit: check if IPv6 enabled before calling ip6_err_gen_icmpv6_unreach()
Date:   Mon, 25 Feb 2019 22:11:35 +0100
Message-Id: <20190225195038.503951254@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 173656accaf583698bac3f9e269884ba60d51ef4 ]

If we disabled IPv6 from the kernel command line (ipv6.disable=1), we should
not call ip6_err_gen_icmpv6_unreach(). This:

  ip link add sit1 type sit local 192.0.2.1 remote 192.0.2.2 ttl 1
  ip link set sit1 up
  ip addr add 198.51.100.1/24 dev sit1
  ping 198.51.100.2

if IPv6 is disabled at boot time, will crash the kernel.

v2: there's no need to use in6_dev_get(), use __in6_dev_get() instead,
    as we only need to check that idev exists and we are under
    rcu_read_lock() (from netif_receive_skb_internal()).

Reported-by: Jianlin Shi <jishi@redhat.com>
Fixes: ca15a078bd90 ("sit: generate icmpv6 error when receiving icmpv4 error")
Cc: Oussama Ghorbel <ghorbel@pivasoftware.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/sit.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -540,7 +540,8 @@ static int ipip6_err(struct sk_buff *skb
 	}
 
 	err = 0;
-	if (!ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4, type, data_len))
+	if (__in6_dev_get(skb->dev) &&
+	    !ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4, type, data_len))
 		goto out;
 
 	if (t->parms.iph.daddr == 0)


