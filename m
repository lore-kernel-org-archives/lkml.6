Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88843C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C6F20837
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8sww7uC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C6F20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbeKCDrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:47:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbeKCDrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:47:53 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 038732082E;
        Fri,  2 Nov 2018 18:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183981;
        bh=+FiNWyYf+rWcL2H52QxCfIoU/t7oH4HWlvEJrDjvMCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B8sww7uCVP3YYIDpuk32LNjl9Epirlk2j9TqyU+YbJgnGTbdYTmqtTZmRbG3nR0cW
         ZxpelAsz0png0fNtFuXtit8hWRRMgV+ZbrDTWM77AyRjkYtCcI/apaGloswHptwVV4
         mP2O+pGAjJ2ZRk3hVTo3IxgC+gWxFcwDb0FCx+UE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 041/150] netfilter: avoid erronous array bounds warning
Date:   Fri,  2 Nov 2018 19:33:23 +0100
Message-Id: <20181102182906.232620214@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 421c119f558761556afca6a62ad183bc2d8659e0 ]

Unfortunately some versions of gcc emit following warning:
  $ make net/xfrm/xfrm_output.o
  linux/compiler.h:252:20: warning: array subscript is above array bounds [-Warray-bounds]
  hook_head = rcu_dereference(net->nf.hooks_arp[hook]);
                            ^~~~~~~~~~~~~~~~~~~~~
xfrm_output_resume passes skb_dst(skb)->ops->family as its 'pf' arg so compiler
can't know that we'll never access hooks_arp[].
(NFPROTO_IPV4 or NFPROTO_IPV6 are only possible cases).

Avoid this by adding an explicit WARN_ON_ONCE() check.

This patch has no effect if the family is a compile-time constant as gcc
will remove the switch() construct entirely.

Reported-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netfilter.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index dd2052f0efb7..11b7b8ab0696 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -215,6 +215,8 @@ static inline int nf_hook(u_int8_t pf, unsigned int hook, struct net *net,
 		break;
 	case NFPROTO_ARP:
 #ifdef CONFIG_NETFILTER_FAMILY_ARP
+		if (WARN_ON_ONCE(hook >= ARRAY_SIZE(net->nf.hooks_arp)))
+			break;
 		hook_head = rcu_dereference(net->nf.hooks_arp[hook]);
 #endif
 		break;
-- 
2.17.1



