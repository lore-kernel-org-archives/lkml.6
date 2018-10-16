Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95548C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D51D204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9aduYc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D51D204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbeJQBR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:17:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730677AbeJQBR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:17:28 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC68B20866;
        Tue, 16 Oct 2018 17:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710762;
        bh=HpgkwsSyg/rzpd9XQxxPjNDU5Wbp1wih1xRnsjpjQwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9aduYc3fWMzDEX2ELQkkBHlAx+AzJIciAKcMy9E1/CERVZkFvjoV+nb2Aup/wMxz
         CgtUHYkMuQDfsZMcsjK0q0WEDXMT4YbzslNpcRaUzRXcjEoP3ao8flPuraGU0DsAhX
         TtKemo+Gb1W90g6EVgdk296IXDLw8axbONq1Mz58=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 46/71] inet: frags: refactor ipv6_frag_init()
Date:   Tue, 16 Oct 2018 19:09:43 +0200
Message-Id: <20181016170541.686036838@linuxfoundation.org>
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
@@ -740,10 +740,21 @@ int __init ipv6_frag_init(void)
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
@@ -752,16 +763,6 @@ int __init ipv6_frag_init(void)
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
 
@@ -769,6 +770,8 @@ err_pernet:
 	ip6_frags_sysctl_unregister();
 err_sysctl:
 	inet6_del_protocol(&frag_protocol, IPPROTO_FRAGMENT);
+err_protocol:
+	inet_frags_fini(&ip6_frags);
 	goto out;
 }
 


