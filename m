Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F157C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D09E2190B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539762;
	bh=aYVdSjKz6mOyiXztVrcLXAJSrakBXsyk99vZVM4aJTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XXCExtIt9/CLIMyaSdM6K+VBaKNMSEFVdopqjE2A2ent1KIkVF/JKnoUNq/jax23L
	 e82miF9pJCY0ZMKAHDnPE1Ct9LeE6XY1QubBlnVvKU7ddUHWfuq4Vh06vOLblHwWHN
	 p1iRU0gGbG1Bdg6KWHbl8zJdKPYxUxY1gO0IUoCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfBGLmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:42:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfBGLmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:42:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C10622190A;
        Thu,  7 Feb 2019 11:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539757;
        bh=aYVdSjKz6mOyiXztVrcLXAJSrakBXsyk99vZVM4aJTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m3VKAQTeVf9jLxjqt4mBMu4ElPaihV1wtWmTsiskV9WNLMlNEzfNnwOX04U+FkOES
         c43vEx/0zhpHw8BHjyDhNmCza8OEmEN7rC4Rub7Kw3PJ6lx+Vl5+DJZuRriOrK02+V
         g+SZzyrALvI1r7/ZDtcHvvfgOAHFbriuJigdruH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 04/34] inet: frags: refactor ipv6_frag_init()
Date:   Thu,  7 Feb 2019 12:41:46 +0100
Message-Id: <20190207113025.738735210@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
References: <20190207113025.552605181@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 5b975bab23615cd0fdf67af6c9298eb01c4b9f61 upstream.

We want to call inet_frags_init() earlier.

This is a prereq to "inet: frags: use rhashtables for reassembly units"

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 4.4: Also delete a redundant assignment to
 ip6_frags.skb_free]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/reassembly.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -739,10 +739,21 @@ int __init ipv6_frag_init(void)
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
@@ -751,17 +762,6 @@ int __init ipv6_frag_init(void)
 	if (ret)
 		goto err_pernet;
 
-	ip6_frags.hashfn = ip6_hashfn;
-	ip6_frags.constructor = ip6_frag_init;
-	ip6_frags.destructor = NULL;
-	ip6_frags.skb_free = NULL;
-	ip6_frags.qsize = sizeof(struct frag_queue);
-	ip6_frags.match = ip6_frag_match;
-	ip6_frags.frag_expire = ip6_frag_expire;
-	ip6_frags.frags_cache_name = ip6_frag_cache_name;
-	ret = inet_frags_init(&ip6_frags);
-	if (ret)
-		goto err_pernet;
 out:
 	return ret;
 
@@ -769,6 +769,8 @@ err_pernet:
 	ip6_frags_sysctl_unregister();
 err_sysctl:
 	inet6_del_protocol(&frag_protocol, IPPROTO_FRAGMENT);
+err_protocol:
+	inet_frags_fini(&ip6_frags);
 	goto out;
 }
 


