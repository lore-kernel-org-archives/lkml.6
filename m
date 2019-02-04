Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDE6C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F24E217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277478;
	bh=cTAxPD1MVmw7TqsnBOdbYIyQnyCjeQ8hYytagpfeqA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IlWoqIWOK8VgkLoPMYa9VYmfBEA7ETGj+MFqicRr9qu44Kpr/bq86G7mOxe14IJxx
	 zVmQMnm67FGEulAOJ9fhVdWT2FiLJxE/5ttRqlczUaz/E2KMsToG73rZ5S6j9027gq
	 k4QK9IfqtdOHTHFx+rhmBPZN8BaGrMyxl3PZqgwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbfBDKvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:51:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732336AbfBDKvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:51:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30C002070C;
        Mon,  4 Feb 2019 10:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277474;
        bh=cTAxPD1MVmw7TqsnBOdbYIyQnyCjeQ8hYytagpfeqA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O3d3Yiv70887eNazsSd8n947G+W7WF2XIxInqzdAu62C5TQbKpRSXKfE2yyfjxPNl
         Nsxn1u6KTR1Hvg7Nj3zjWhlsMgQ83aXWdGpghduXj5szTNeMx7mHAwn8GnhcSV6id9
         euLEf5ExLaJLBjNXDBqCK04udZ4vXhRZfZ5yuD6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ying Xu <yinxu@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 24/80] sctp: set flow sport from saddr only when its 0
Date:   Mon,  4 Feb 2019 11:36:44 +0100
Message-Id: <20190204103623.377921163@linuxfoundation.org>
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


