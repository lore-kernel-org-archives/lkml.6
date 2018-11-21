Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4824C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A65206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk1+1Q4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A65206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbeKVFmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:42:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730172AbeKVFmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:42:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24130214D9;
        Wed, 21 Nov 2018 19:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827195;
        bh=hzHQ7nu5HGWjRs90yK2jy7Uw9Y7gqzwn40CG8q0GUIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dk1+1Q4z3W4NqTGBNr6k9JnS4R3m1z1fNsx7Lzp8c1QOJna6ZWKLrTetoz3nqiIlu
         xKZAr8FRiQ82rkzgR6qTm92d29uWFTzQP2OkDayQ9vI4EGToAwZi5i54i01lJ/Xe1R
         nSkthELUPam6p45i7lBu8vWQcGdAyiCavT4dW2LM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?=EB=B0=B0=EC=84=9D=EC=A7=84?= <soukjin.bae@samsung.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 01/42] flow_dissector: do not dissect l4 ports for fragments
Date:   Wed, 21 Nov 2018 20:05:37 +0100
Message-Id: <20181121183147.938018961@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: 배석진 <soukjin.bae@samsung.com>

[ Upstream commit 62230715fd2453b3ba948c9d83cfb3ada9169169 ]

Only first fragment has the sport/dport information,
not the following ones.

If we want consistent hash for all fragments, we need to
ignore ports even for first fragment.

This bug is visible for IPv6 traffic, if incoming fragments
do not have a flow label, since skb_get_hash() will give
different results for first fragment and following ones.

It is also visible if any routing rule wants dissection
and sport or dport.

See commit 5e5d6fed3741 ("ipv6: route: dissect flow
in input path if fib rules need it") for details.

[edumazet] rewrote the changelog completely.

Fixes: 06635a35d13d ("flow_dissect: use programable dissector in skb_flow_dissect and friends")
Signed-off-by: 배석진 <soukjin.bae@samsung.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/flow_dissector.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1026,8 +1026,8 @@ ip_proto_again:
 		break;
 	}
 
-	if (dissector_uses_key(flow_dissector,
-			       FLOW_DISSECTOR_KEY_PORTS)) {
+	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS) &&
+	    !(key_control->flags & FLOW_DIS_IS_FRAGMENT)) {
 		key_ports = skb_flow_dissector_target(flow_dissector,
 						      FLOW_DISSECTOR_KEY_PORTS,
 						      target_container);


