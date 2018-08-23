Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4068BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15B720847
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15B720847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387840AbeHWM14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:27:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53088 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbeHWM14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:27:56 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5950FC83;
        Thu, 23 Aug 2018 08:59:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 211/324] bpf: fix sk_skb programs without skb->dev assigned
Date:   Thu, 23 Aug 2018 09:54:37 +0200
Message-Id: <20180823075006.712464475@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 0c6bc6e531a6db36f49622f1f115770160f7afb0 ]

Multiple BPF helpers in use by sk_skb programs calculate the max
skb length using the __bpf_skb_max_len function. However, this
calculates the max length using the skb->dev pointer which can be
NULL when an sk_skb program is paired with an sk_msg program.

To force this a sk_msg program needs to redirect into the ingress
path of a sock with an attach sk_skb program. Then the the sk_skb
program would need to call one of the helpers that adjust the skb
size.

To fix the null ptr dereference use SKB_MAX_ALLOC size if no dev
is available.

Fixes: 8934ce2fd081 ("bpf: sockmap redirect ingress support")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/filter.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2516,7 +2516,8 @@ static int bpf_skb_net_shrink(struct sk_
 
 static u32 __bpf_skb_max_len(const struct sk_buff *skb)
 {
-	return skb->dev->mtu + skb->dev->hard_header_len;
+	return skb->dev ? skb->dev->mtu + skb->dev->hard_header_len :
+			  SKB_MAX_ALLOC;
 }
 
 static int bpf_skb_adjust_net(struct sk_buff *skb, s32 len_diff)


