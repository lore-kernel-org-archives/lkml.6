Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89938C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E652176F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975904;
	bh=gdqg255WCdru7izd4QObD+y0nUyjQpQ3RbFUDM2LHn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hVCI44UUbVxxXsGpOEaalcUqFFAcLz64CuBgUqjkLx7KEp5ZylYeb24KXKq/LtgfV
	 qk8oHBUpQ7+X/w/0OE8eUAeup3cu9/zhA3f7GdpmSGhiwMZFNdxznUjyqqfmEfO6on
	 e/z34BIFXgme4saGE8UogFQs/mQgtlpxBhP9NL2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbfAHTbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:31:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731147AbfAHTbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:31:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 341A92176F;
        Tue,  8 Jan 2019 19:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975900;
        bh=gdqg255WCdru7izd4QObD+y0nUyjQpQ3RbFUDM2LHn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XiwjlTFxlbXUMd4K/fpLJcfO2CHjI8RXpi/M+CbeZ122ynyxeXkcBsWQG3sVGKazH
         pvBi+7NxHTMM8LV1uLJrSPZPcTOeQuLnGN/k83bo9H+QSAkO9G7hHO3rBx1tqf8pv2
         jV+oW6t2pYnHzMC1qKVlfyTMPA05Ch8FbSihJ+J0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 69/97] netfilter: ipt_CLUSTERIP: remove wrong WARN_ON_ONCE in netns exit routine
Date:   Tue,  8 Jan 2019 14:29:18 -0500
Message-Id: <20190108192949.122407-69-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit b12f7bad5ad3724d19754390a3e80928525c0769 ]

When network namespace is destroyed, both clusterip_tg_destroy() and
clusterip_net_exit() are called. and clusterip_net_exit() is called
before clusterip_tg_destroy().
Hence cleanup check code in clusterip_net_exit() doesn't make sense.

test commands:
   %ip netns add vm1
   %ip netns exec vm1 bash
   %ip link set lo up
   %iptables -A INPUT -p tcp -i lo -d 192.168.0.5 --dport 80 \
	-j CLUSTERIP --new --hashmode sourceip \
	--clustermac 01:00:5e:00:00:20 --total-nodes 2 --local-node 1
   %exit
   %ip netns del vm1

splat looks like:
[  341.184508] WARNING: CPU: 1 PID: 87 at net/ipv4/netfilter/ipt_CLUSTERIP.c:840 clusterip_net_exit+0x319/0x380 [ipt_CLUSTERIP]
[  341.184850] Modules linked in: ipt_CLUSTERIP nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter bpfilter ip_tables x_tables
[  341.184850] CPU: 1 PID: 87 Comm: kworker/u4:2 Not tainted 4.19.0-rc5+ #16
[  341.227509] Workqueue: netns cleanup_net
[  341.227509] RIP: 0010:clusterip_net_exit+0x319/0x380 [ipt_CLUSTERIP]
[  341.227509] Code: 0f 85 7f fe ff ff 48 c7 c2 80 64 2c c0 be a8 02 00 00 48 c7 c7 a0 63 2c c0 c6 05 18 6e 00 00 01 e8 bc 38 ff f5 e9 5b fe ff ff <0f> 0b e9 33 ff ff ff e8 4b 90 50 f6 e9 2d fe ff ff 48 89 df e8 de
[  341.227509] RSP: 0018:ffff88011086f408 EFLAGS: 00010202
[  341.227509] RAX: dffffc0000000000 RBX: 1ffff1002210de85 RCX: 0000000000000000
[  341.227509] RDX: 1ffff1002210de85 RSI: ffff880110813be8 RDI: ffffed002210de58
[  341.227509] RBP: ffff88011086f4d0 R08: 0000000000000000 R09: 0000000000000000
[  341.227509] R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff1002210de81
[  341.227509] R13: ffff880110625a48 R14: ffff880114cec8c8 R15: 0000000000000014
[  341.227509] FS:  0000000000000000(0000) GS:ffff880116600000(0000) knlGS:0000000000000000
[  341.227509] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  341.227509] CR2: 00007f11fd38e000 CR3: 000000013ca16000 CR4: 00000000001006e0
[  341.227509] Call Trace:
[  341.227509]  ? __clusterip_config_find+0x460/0x460 [ipt_CLUSTERIP]
[  341.227509]  ? default_device_exit+0x1ca/0x270
[  341.227509]  ? remove_proc_entry+0x1cd/0x390
[  341.227509]  ? dev_change_net_namespace+0xd00/0xd00
[  341.227509]  ? __init_waitqueue_head+0x130/0x130
[  341.227509]  ops_exit_list.isra.10+0x94/0x140
[  341.227509]  cleanup_net+0x45b/0x900
[ ... ]

Fixes: 613d0776d3fe ("netfilter: exit_net cleanup check added")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/netfilter/ipt_CLUSTERIP.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/netfilter/ipt_CLUSTERIP.c b/net/ipv4/netfilter/ipt_CLUSTERIP.c
index e40e6795bd20..33491cb6b9d1 100644
--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -838,7 +838,6 @@ static void clusterip_net_exit(struct net *net)
 	cn->procdir = NULL;
 #endif
 	nf_unregister_net_hook(net, &cip_arp_ops);
-	WARN_ON_ONCE(!list_empty(&cn->configs));
 }
 
 static struct pernet_operations clusterip_net_ops = {
-- 
2.19.1

