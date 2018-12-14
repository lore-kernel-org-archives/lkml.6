Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596E1C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED222146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788916;
	bh=igHB7H/m0mUo8Mxz8ugV08OSfZOxkPyXtr/e+rM2S+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bsqmgRI/2k3Ha+JViVCK17PTmGsaeVjeBVyvAaDEkDZpB+tWis9yXfCNqM95uvYEN
	 Cp6H9YT140xidHqJXiOTBp0ynWbTSdqry5P50RRcN8avRybaTvwQAazK9ZVm/fBuhG
	 aHrWJ/+XmFCjUb1eLA5o1zhXxioHZ/GoljhwbePQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED222146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbeLNMBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:01:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729523AbeLNMBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:01:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6554D2146E;
        Fri, 14 Dec 2018 12:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788906;
        bh=igHB7H/m0mUo8Mxz8ugV08OSfZOxkPyXtr/e+rM2S+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fo33gIoXwtIlNyEJNT7sf5M7w6+fgNmts1Dh3qThP7MOJzD/H5iOoF0YpbZGIGsOc
         wm+WkZ7k7oGr7xVf7hjfQR6l0KYwZZJPmo5wQfUk1sXmuTbv6/vKOwjA+FMlQx/iRh
         kwgTwArXkAET5iMvhHcXX0P/6zmT7g9vec523Pp8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 004/142] ipv6: sr: properly initialize flowi6 prior passing to ip6_route_output
Date:   Fri, 14 Dec 2018 12:58:09 +0100
Message-Id: <20181214115747.231205004@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shmulik Ladkani <shmulik@metanetworks.com>

[ Upstream commit 1b4e5ad5d6b9f15cd0b5121f86d4719165958417 ]

In 'seg6_output', stack variable 'struct flowi6 fl6' was missing
initialization.

Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/seg6_iptunnel.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -347,6 +347,7 @@ static int seg6_output(struct net *net,
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
 		struct flowi6 fl6;
 
+		memset(&fl6, 0, sizeof(fl6));
 		fl6.daddr = hdr->daddr;
 		fl6.saddr = hdr->saddr;
 		fl6.flowlabel = ip6_flowinfo(hdr);


