Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AEEECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA35214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA35214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbeIREeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:34:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49202 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeIREeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:34:16 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C6F9CC77;
        Mon, 17 Sep 2018 23:04:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 097/126] inet: frags: refactor lowpan_net_frag_init()
Date:   Tue, 18 Sep 2018 00:42:25 +0200
Message-Id: <20180917211710.294765418@linuxfoundation.org>
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

We want to call lowpan_net_frag_init() earlier.
Similar to commit "inet: frags: refactor ipv6_frag_init()"

This is a prereq to "inet: frags: use rhashtables for reassembly units"

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 807f1844df4ac23594268fa9f41902d0549e92aa)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ieee802154/6lowpan/reassembly.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -615,14 +615,6 @@ int __init lowpan_net_frag_init(void)
 {
 	int ret;
 
-	ret = lowpan_frags_sysctl_register();
-	if (ret)
-		return ret;
-
-	ret = register_pernet_subsys(&lowpan_frags_ops);
-	if (ret)
-		goto err_pernet;
-
 	lowpan_frags.hashfn = lowpan_hashfn;
 	lowpan_frags.constructor = lowpan_frag_init;
 	lowpan_frags.destructor = NULL;
@@ -632,11 +624,21 @@ int __init lowpan_net_frag_init(void)
 	lowpan_frags.frags_cache_name = lowpan_frags_cache_name;
 	ret = inet_frags_init(&lowpan_frags);
 	if (ret)
-		goto err_pernet;
+		goto out;
+
+	ret = lowpan_frags_sysctl_register();
+	if (ret)
+		goto err_sysctl;
 
+	ret = register_pernet_subsys(&lowpan_frags_ops);
+	if (ret)
+		goto err_pernet;
+out:
 	return ret;
 err_pernet:
 	lowpan_frags_sysctl_unregister();
+err_sysctl:
+	inet_frags_fini(&lowpan_frags);
 	return ret;
 }
 


