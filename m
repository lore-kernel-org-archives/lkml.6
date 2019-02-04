Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3C0C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC552186A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277439;
	bh=nF8ObUGesoknJU/Txh+RZ/uDGjmmY7jgowRuEtBk9XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B0caZYlMA4SCMI6HIl+leRtSPcqO9jc5lJCMVVbaGwpLyODwaOpPATA9hlxrgBbB9
	 mBjG2GtWyarD/iNi5eFL3zCjY7bpexmHY0TPVKVmnDLi7ARZFxe9cy4StasRPSd6k8
	 RijVcGHZlRpFD5u+eZAGg0cYtjTh91KgQWxi04lI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbfBDKuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:50:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732238AbfBDKuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:50:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E3462070C;
        Mon,  4 Feb 2019 10:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277432;
        bh=nF8ObUGesoknJU/Txh+RZ/uDGjmmY7jgowRuEtBk9XQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UAOeFEqrkz85fKv0PET7vLlt/6jov8ZeCURnLkPqx2osytv1fYWfWm029+kOSSHLR
         gQ90u84whZTKORLtYdg814vSNzr7fZv9284w+JG8fzcm1RQ2x17qvy88WwbdSRVUgp
         +o1azYrS22K2+q9ngIxWtCNVoeq9XJPDlEM3Q4fE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yohei Kanemaru <yohei.kanemaru@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 02/80] ipv6: sr: clear IP6CB(skb) on SRH ip4ip6 encapsulation
Date:   Mon,  4 Feb 2019 11:36:22 +0100
Message-Id: <20190204103620.530350486@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

From: Yohei Kanemaru <yohei.kanemaru@gmail.com>

[ Upstream commit ef489749aae508e6f17886775c075f12ff919fb1 ]

skb->cb may contain data from previous layers (in an observed case
IPv4 with L3 Master Device). In the observed scenario, the data in
IPCB(skb)->frags was misinterpreted as IP6CB(skb)->frag_max_size,
eventually caused an unexpected IPv6 fragmentation in ip6_fragment()
through ip6_finish_output().

This patch clears IP6CB(skb), which potentially contains garbage data,
on the SRH ip4ip6 encapsulation.

Fixes: 32d99d0b6702 ("ipv6: sr: add support for ip4ip6 encapsulation")
Signed-off-by: Yohei Kanemaru <yohei.kanemaru@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/seg6_iptunnel.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -146,6 +146,8 @@ int seg6_do_srh_encap(struct sk_buff *sk
 	} else {
 		ip6_flow_hdr(hdr, 0, flowlabel);
 		hdr->hop_limit = ip6_dst_hoplimit(skb_dst(skb));
+
+		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
 	}
 
 	hdr->nexthdr = NEXTHDR_ROUTING;


