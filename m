Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B425ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D122E2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D122E2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbeIREeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:34:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49194 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeIREeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:34:13 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A330EC03;
        Mon, 17 Sep 2018 23:04:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 096/126] inet: frags: refactor ipv6_frag_init()
Date:   Tue, 18 Sep 2018 00:42:24 +0200
Message-Id: <20180917211710.240608367@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

We want to call inet_frags_init() earlier.

This is a prereq to "inet: frags: use rhashtables for reassembly units"

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 5b975bab23615cd0fdf67af6c9298eb01c4b9f61)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/reassembly.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -746,10 +746,21 @@ int __init ipv6_frag_init(void)
 {
 	int ret;
 
-	ret = inet6_add_protocol(&frag_protocol, IPPROTO_FRAGMENT);
+	ip6_frags.hashfn = ip6_hashfn;
+	ip6_frags.constructor = ip6_frag_init;
+	ip6_frags.destructor = NULL;
+	ip6_frags.qsize = sizeof(struct frag_queue);
+	ip6_frags.match = ip6_frag_match;
+	ip6_frags.frag_expire = ip6_frag_expire;
+	ip6_frags.frags_cache_name = ip6_frag_cache_name;
+	ret = inet_frags_init(&ip6_frags);
 	if (ret)
 		goto out;
 
+	ret = inet6_add_protocol(&frag_protocol, IPPROTO_FRAGMENT);
+	if (ret)
+		goto err_protocol;
+
 	ret = ip6_frags_sysctl_register();
 	if (ret)
 		goto err_sysctl;
@@ -758,16 +769,6 @@ int __init ipv6_frag_init(void)
 	if (ret)
 		goto err_pernet;
 
-	ip6_frags.hashfn = ip6_hashfn;
-	ip6_frags.constructor = ip6_frag_init;
-	ip6_frags.destructor = NULL;
-	ip6_frags.qsize = sizeof(struct frag_queue);
-	ip6_frags.match = ip6_frag_match;
-	ip6_frags.frag_expire = ip6_frag_expire;
-	ip6_frags.frags_cache_name = ip6_frag_cache_name;
-	ret = inet_frags_init(&ip6_frags);
-	if (ret)
-		goto err_pernet;
 out:
 	return ret;
 
@@ -775,6 +776,8 @@ err_pernet:
 	ip6_frags_sysctl_unregister();
 err_sysctl:
 	inet6_del_protocol(&frag_protocol, IPPROTO_FRAGMENT);
+err_protocol:
+	inet_frags_fini(&ip6_frags);
 	goto out;
 }
 


