Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAF6C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25047218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358754;
	bh=g5ZJ+iA0Ugp6aR55S5wiz0me3iXqKgdpF+ySKq8CeGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tEB93dZkozPOP4OaqrIhnUk2Qz1QGq+/L5EFyYah9zovjEWHFn8j+I4WJnL32MDQC
	 AVMdpqD3ESIu8XagNiZYfPuj7IRqMmvEZzw4TtO32StRSfWGB6p1TfSUFMVIxSoRk7
	 f0DpCrMd9lgGN8Dqk5UfuLRoRaU+4d6576qovGag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733008AbfAXTjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:39:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732013AbfAXTjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:39:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC2CD218D3;
        Thu, 24 Jan 2019 19:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358748;
        bh=g5ZJ+iA0Ugp6aR55S5wiz0me3iXqKgdpF+ySKq8CeGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qM4BhVpEjHwCy69b6Exef/8pEqLJLzavFOZZYf28T5T4kDtOhmo02oX8sR/uU+OMt
         p25zyWMbvZGRLzsfF/ClO/d3PIfTatRzs5Y84SHjIIqsouYeo3QE9SIwUkuokgPQsa
         +1MYw5xfLyQV0/aiLi0yB6Bjz5YEww+d8uvsZfuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Matteo Croce <mcroce@redhat.com>
Subject: [PATCH 4.20 013/127] net: clear skb->tstamp in bridge forwarding path
Date:   Thu, 24 Jan 2019 20:19:19 +0100
Message-Id: <20190124190212.721183049@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 41d1c8839e5f8cb781cc635f12791decee8271b7 ]

Matteo reported forwarding issues inside the linux bridge,
if the enslaved interfaces use the fq qdisc.

Similar to commit 8203e2d844d3 ("net: clear skb->tstamp in
forwarding paths"), we need to clear the tstamp field in
the bridge forwarding path.

Fixes: 80b14dee2bea ("net: Add a new socket option for a future transmit time.")
Fixes: fb420d5d91c1 ("tcp/fq: move back to CLOCK_MONOTONIC")
Reported-and-tested-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Acked-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_forward.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -65,6 +65,7 @@ EXPORT_SYMBOL_GPL(br_dev_queue_push_xmit
 
 int br_forward_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
+	skb->tstamp = 0;
 	return NF_HOOK(NFPROTO_BRIDGE, NF_BR_POST_ROUTING,
 		       net, sk, skb, NULL, skb->dev,
 		       br_dev_queue_push_xmit);


