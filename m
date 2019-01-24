Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C75C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71ABD21726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359537;
	bh=qwvkFBM9Su8Z/nqZNM1uHghsZi87H8l9+lp2tT+/D8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XzmWt98GONoOqAe9hVX5mf4WwiP9YNtAeGQCKzMqPUtjvt3uFzXLIHT3qQUVx3a0p
	 ZdaNRvqXDxOawUXq+w7xGt0cug/dFSORuUtOitDO+5MK1vHCB3s/DhkSab6HZ07NJm
	 EGw7hEk+hBhHcOK3z7UzdQ2/xeeGSPxLFggUPLL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbfAXTjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:39:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732978AbfAXTjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:39:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 540C820663;
        Thu, 24 Jan 2019 19:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358745;
        bh=qwvkFBM9Su8Z/nqZNM1uHghsZi87H8l9+lp2tT+/D8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xat3We2QI5OWvZU88DWTWyPUuH0dW9godOyxVfxp5E8XqzpTJkJBywkXsUba9c2qh
         Dh1gB4mmXxacZQFcwxIhMfZGcuVpOqIw1hfNLLAO5EAVEEgWUtVjg1nvIDStfF6ow4
         v3g+3G1+g7eASs/AaXuAn0OKCiiH62VNxviDazX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Mi <chrism@mellanox.com>,
        Greg Rose <gvrose8192@gmail.com>,
        Yi-Hung Wei <yihung.wei@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 012/127] openvswitch: Fix IPv6 later frags parsing
Date:   Thu, 24 Jan 2019 20:19:18 +0100
Message-Id: <20190124190212.668405365@linuxfoundation.org>
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

From: Yi-Hung Wei <yihung.wei@gmail.com>

[ Upstream commit 41e4e2cd75346667b0c531c07dab05cce5b06d15 ]

The previous commit fa642f08839b
("openvswitch: Derive IP protocol number for IPv6 later frags")
introduces IP protocol number parsing for IPv6 later frags that can mess
up the network header length calculation logic, i.e. nh_len < 0.
However, the network header length calculation is mainly for deriving
the transport layer header in the key extraction process which the later
fragment does not apply.

Therefore, this commit skips the network header length calculation to
fix the issue.

Reported-by: Chris Mi <chrism@mellanox.com>
Reported-by: Greg Rose <gvrose8192@gmail.com>
Fixes: fa642f08839b ("openvswitch: Derive IP protocol number for IPv6 later frags")
Signed-off-by: Yi-Hung Wei <yihung.wei@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/flow.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -276,10 +276,12 @@ static int parse_ipv6hdr(struct sk_buff
 
 	nexthdr = ipv6_find_hdr(skb, &payload_ofs, -1, &frag_off, &flags);
 	if (flags & IP6_FH_F_FRAG) {
-		if (frag_off)
+		if (frag_off) {
 			key->ip.frag = OVS_FRAG_TYPE_LATER;
-		else
-			key->ip.frag = OVS_FRAG_TYPE_FIRST;
+			key->ip.proto = nexthdr;
+			return 0;
+		}
+		key->ip.frag = OVS_FRAG_TYPE_FIRST;
 	} else {
 		key->ip.frag = OVS_FRAG_TYPE_NONE;
 	}


