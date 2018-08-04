Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B770CC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658642177A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658642177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389395AbeHDLMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:12:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50400 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732902AbeHDLMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:12:12 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 70B05BBF;
        Sat,  4 Aug 2018 09:12:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jeremy Cline <jcline@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 116/124] netlink: Fix spectre v1 gadget in netlink_create()
Date:   Sat,  4 Aug 2018 11:01:45 +0200
Message-Id: <20180804082706.800648641@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Cline <jcline@redhat.com>

[ Upstream commit bc5b6c0b62b932626a135f516a41838c510c6eba ]

'protocol' is a user-controlled value, so sanitize it after the bounds
check to avoid using it for speculative out-of-bounds access to arrays
indexed by it.

This addresses the following accesses detected with the help of smatch:

* net/netlink/af_netlink.c:654 __netlink_create() warn: potential
  spectre issue 'nlk_cb_mutex_keys' [w]

* net/netlink/af_netlink.c:654 __netlink_create() warn: potential
  spectre issue 'nlk_cb_mutex_key_strings' [w]

* net/netlink/af_netlink.c:685 netlink_create() warn: potential spectre
  issue 'nl_table' [w] (local cap)

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Jeremy Cline <jcline@redhat.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netlink/af_netlink.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -62,6 +62,7 @@
 #include <asm/cacheflush.h>
 #include <linux/hash.h>
 #include <linux/genetlink.h>
+#include <linux/nospec.h>
 
 #include <net/net_namespace.h>
 #include <net/sock.h>
@@ -654,6 +655,7 @@ static int netlink_create(struct net *ne
 
 	if (protocol < 0 || protocol >= MAX_LINKS)
 		return -EPROTONOSUPPORT;
+	protocol = array_index_nospec(protocol, MAX_LINKS);
 
 	netlink_lock_table();
 #ifdef CONFIG_MODULES


