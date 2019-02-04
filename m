Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7E3C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6BA2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278067;
	bh=BqSl4/oZA8RMRBki4J8fxRnEkrWxNgnpAduud3PJqNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jZmVpQ7LW4z6OLLhPlG/1+XNTUzfpPDN3rQPQTlFxOQyitbKLnu7sgyQ/5OmyetZK
	 +9DZe1nDA4I8jevGie1ph8dhv1mFBx9fFNaFZUtXXm3hJ7oGIJiYwxAO3nl7xBeuTt
	 dS0DPWnCp00Y8I1/bnikniUZ9WWs7SpO7poESYuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbfBDLBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:01:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731376AbfBDKs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:48:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 550352070C;
        Mon,  4 Feb 2019 10:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277307;
        bh=BqSl4/oZA8RMRBki4J8fxRnEkrWxNgnpAduud3PJqNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tp19e8R8P3D8wga78f3zNhiyZK62peBUdKGT8sMOOFZTA6n1TNXef6pbLNyt3Bdzj
         0Dw+gjUyAQ33U9oiQHFABxr9N1FvaXMwwjzkFKPX7bapmuP1vgry9xbtGyuMZZQbks
         qehpXJs8qKwtDcnCTc0fc4Epvkmo2xYufyxGIVgM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ying Xu <yinxu@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 25/74] sctp: set flow sport from saddr only when its 0
Date:   Mon,  4 Feb 2019 11:36:38 +0100
Message-Id: <20190204103622.938500553@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit ecf938fe7d0088077ee1280419a2b3c5429b47c8 ]

Now sctp_transport_pmtu() passes transport->saddr into .get_dst() to set
flow sport from 'saddr'. However, transport->saddr is set only when
transport->dst exists in sctp_transport_route().

If sctp_transport_pmtu() is called without transport->saddr set, like
when transport->dst doesn't exists, the flow sport will be set to 0
from transport->saddr, which will cause a wrong route to be got.

Commit 6e91b578bf3f ("sctp: re-use sctp_transport_pmtu in
sctp_transport_route") made the issue be triggered more easily
since sctp_transport_pmtu() would be called in sctp_transport_route()
after that.

In gerneral, fl4->fl4_sport should always be set to
htons(asoc->base.bind_addr.port), unless transport->asoc doesn't exist
in sctp_v4/6_get_dst(), which is the case:

  sctp_ootb_pkt_new() ->
    sctp_transport_route()

For that, we can simply handle it by setting flow sport from saddr only
when it's 0 in sctp_v4/6_get_dst().

Fixes: 6e91b578bf3f ("sctp: re-use sctp_transport_pmtu in sctp_transport_route")
Reported-by: Ying Xu <yinxu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/ipv6.c     |    3 ++-
 net/sctp/protocol.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -277,7 +277,8 @@ static void sctp_v6_get_dst(struct sctp_
 
 	if (saddr) {
 		fl6->saddr = saddr->v6.sin6_addr;
-		fl6->fl6_sport = saddr->v6.sin6_port;
+		if (!fl6->fl6_sport)
+			fl6->fl6_sport = saddr->v6.sin6_port;
 
 		pr_debug("src=%pI6 - ", &fl6->saddr);
 	}
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -440,7 +440,8 @@ static void sctp_v4_get_dst(struct sctp_
 	}
 	if (saddr) {
 		fl4->saddr = saddr->v4.sin_addr.s_addr;
-		fl4->fl4_sport = saddr->v4.sin_port;
+		if (!fl4->fl4_sport)
+			fl4->fl4_sport = saddr->v4.sin_port;
 	}
 
 	pr_debug("%s: dst:%pI4, src:%pI4 - ", __func__, &fl4->daddr,


