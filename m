Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA1FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9F4206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9F4206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbeGTNXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:23:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43378 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387998AbeGTNXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:23:35 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 732C4A80;
        Fri, 20 Jul 2018 12:33:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Iamartino <danielei@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 45/92] tcp: fix Fast Open key endianness
Date:   Fri, 20 Jul 2018 14:13:49 +0200
Message-Id: <20180720121420.590020197@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuchung Cheng <ycheng@google.com>

[ Upstream commit c860e997e9170a6d68f9d1e6e2cf61f572191aaf ]

Fast Open key could be stored in different endian based on the CPU.
Previously hosts in different endianness in a server farm using
the same key config (sysctl value) would produce different cookies.
This patch fixes it by always storing it as little endian to keep
same API for LE hosts.

Reported-by: Daniele Iamartino <danielei@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/sysctl_net_ipv4.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -258,8 +258,9 @@ static int proc_tcp_fastopen_key(struct
 {
 	struct ctl_table tbl = { .maxlen = (TCP_FASTOPEN_KEY_LENGTH * 2 + 10) };
 	struct tcp_fastopen_context *ctxt;
-	int ret;
 	u32  user_key[4]; /* 16 bytes, matching TCP_FASTOPEN_KEY_LENGTH */
+	__le32 key[4];
+	int ret, i;
 
 	tbl.data = kmalloc(tbl.maxlen, GFP_KERNEL);
 	if (!tbl.data)
@@ -268,11 +269,14 @@ static int proc_tcp_fastopen_key(struct
 	rcu_read_lock();
 	ctxt = rcu_dereference(tcp_fastopen_ctx);
 	if (ctxt)
-		memcpy(user_key, ctxt->key, TCP_FASTOPEN_KEY_LENGTH);
+		memcpy(key, ctxt->key, TCP_FASTOPEN_KEY_LENGTH);
 	else
-		memset(user_key, 0, sizeof(user_key));
+		memset(key, 0, sizeof(key));
 	rcu_read_unlock();
 
+	for (i = 0; i < ARRAY_SIZE(key); i++)
+		user_key[i] = le32_to_cpu(key[i]);
+
 	snprintf(tbl.data, tbl.maxlen, "%08x-%08x-%08x-%08x",
 		user_key[0], user_key[1], user_key[2], user_key[3]);
 	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
@@ -288,12 +292,16 @@ static int proc_tcp_fastopen_key(struct
 		 * first invocation of tcp_fastopen_cookie_gen
 		 */
 		tcp_fastopen_init_key_once(false);
-		tcp_fastopen_reset_cipher(user_key, TCP_FASTOPEN_KEY_LENGTH);
+
+		for (i = 0; i < ARRAY_SIZE(user_key); i++)
+			key[i] = cpu_to_le32(user_key[i]);
+
+		tcp_fastopen_reset_cipher(key, TCP_FASTOPEN_KEY_LENGTH);
 	}
 
 bad_key:
 	pr_debug("proc FO key set 0x%x-%x-%x-%x <- 0x%s: %u\n",
-	       user_key[0], user_key[1], user_key[2], user_key[3],
+		 user_key[0], user_key[1], user_key[2], user_key[3],
 	       (char *)tbl.data, ret);
 	kfree(tbl.data);
 	return ret;


