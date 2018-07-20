Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4EEECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E1D20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E1D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389661AbeGTN2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:28:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49054 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388907AbeGTN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:28:00 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1257BCAF;
        Fri, 20 Jul 2018 12:34:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        John Sperbeck <jsperbeck@google.com>,
        Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 66/92] netfilter: ipv6: nf_defrag: drop skb dst before queueing
Date:   Fri, 20 Jul 2018 14:14:10 +0200
Message-Id: <20180720121421.598096914@linuxfoundation.org>
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

From: Florian Westphal <fw@strlen.de>

commit 84379c9afe011020e797e3f50a662b08a6355dcf upstream.

Eric Dumazet reports:
 Here is a reproducer of an annoying bug detected by syzkaller on our production kernel
 [..]
 ./b78305423 enable_conntrack
 Then :
 sleep 60
 dmesg | tail -10
 [  171.599093] unregister_netdevice: waiting for lo to become free. Usage count = 2
 [  181.631024] unregister_netdevice: waiting for lo to become free. Usage count = 2
 [  191.687076] unregister_netdevice: waiting for lo to become free. Usage count = 2
 [  201.703037] unregister_netdevice: waiting for lo to become free. Usage count = 2
 [  211.711072] unregister_netdevice: waiting for lo to become free. Usage count = 2
 [  221.959070] unregister_netdevice: waiting for lo to become free. Usage count = 2

Reproducer sends ipv6 fragment that hits nfct defrag via LOCAL_OUT hook.
skb gets queued until frag timer expiry -- 1 minute.

Normally nf_conntrack_reasm gets called during prerouting, so skb has
no dst yet which might explain why this wasn't spotted earlier.

Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Reported-by: John Sperbeck <jsperbeck@google.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Tested-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv6/netfilter/nf_conntrack_reasm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -618,6 +618,8 @@ int nf_ct_frag6_gather(struct net *net,
 	    fq->q.meat == fq->q.len &&
 	    nf_ct_frag6_reasm(fq, skb, dev))
 		ret = 0;
+	else
+		skb_dst_drop(skb);
 
 out_unlock:
 	spin_unlock_bh(&fq->q.lock);


