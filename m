Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4C0C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8892098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbkLMbkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8892098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeJPMB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728205AbeJPMB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63AD52145D;
        Tue, 16 Oct 2018 04:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663184;
        bh=5dLmQxAQ0U3kOhLyOHBm0gy8vglB/xW6VDF02ORZlH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EbkLMbkfQh1ls9VP5x7keQP7hLGyveiFV+MPdya6mk1F9NAlCmtZjrvN0qm/uBAs7
         FlE5BsiKyEVmGvk4cD6EPAyH7uE1btT/CbMaaSNzhoV63W1tlyaJzeZO9k9ibQhRhn
         MwraepAwgOzW7TmYRTrnjosR5/zYWMDjNIgigxvY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 045/100] netfilter: avoid erronous array bounds warning
Date:   Tue, 16 Oct 2018 00:11:26 -0400
Message-Id: <20181016041221.135528-45-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

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

