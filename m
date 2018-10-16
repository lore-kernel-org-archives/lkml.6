Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2360EC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E376B20658
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0VKj9It"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E376B20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbeJQBQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:16:12 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EE5F20658;
        Tue, 16 Oct 2018 17:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710686;
        bh=xLk2STXAY7CnSoXlPjz4SHstfhW7AXwGIeXZEqpMmuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y0VKj9ItMJyCui4eHcdMMkEtn2WqEBhQZBRwQyxu7VuXGopksj972Fmhh9UAfDK69
         BCCy7XDgkQw8KacCgujCwZCbdRA1UB1jiMnzrnSMKKGvRg0ejLcJ6WTysA4BBQFk7D
         oZF1cKsZRw79RBfFpFEZy/YOOIys2/U2fu3ks9Dc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 47/71] inet: frags: refactor lowpan_net_frag_init()
Date:   Tue, 16 Oct 2018 19:09:44 +0200
Message-Id: <20181016170541.745869834@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -614,14 +614,6 @@ int __init lowpan_net_frag_init(void)
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
@@ -631,11 +623,21 @@ int __init lowpan_net_frag_init(void)
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
 


