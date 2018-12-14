Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98521C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6F320892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791460;
	bh=Jwvp6HFBhEOyQbrgmdHS0AstgMrD860x0Q6UoEvnZLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PH1sALp2RUqZbKvFh1IWZVtMPxO8NBw+GQ8md5lXWHaVQIZDUpigLhsQPsLGQjDXA
	 5fu4gCIHfms098oser920H5s4ftj81/nOcrX8fCmJcfahCqfRrDzH7jk9vvg7JxjPt
	 A1p1Jcmr2e1mtrPMvqWIGc+gMMEU9e866P4UiHDs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6F320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbeLNMoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:44:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729774AbeLNMBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:01:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EFD82145D;
        Fri, 14 Dec 2018 12:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788894;
        bh=Jwvp6HFBhEOyQbrgmdHS0AstgMrD860x0Q6UoEvnZLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hq12z/t7XWYa1+PQvaCPUY2r4nq7viD6o3f3xgUrR2SgaU6xRLNHeSsm5orNhC0aq
         Qen45YSSkAmDCAP2eoPJ2r8nPa64cVMTZ3sPDAWvlhKeIWDsRnfBm1a9j2ROxXxtO7
         e45stzXb5kWAXNPVbi9S8nYuzdtnROC+sT2K5FLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 014/142] tcp: Do not underestimate rwnd_limited
Date:   Fri, 14 Dec 2018 12:58:19 +0100
Message-Id: <20181214115747.617053615@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 41727549de3e7281feb174d568c6e46823db8684 ]

If available rwnd is too small, tcp_tso_should_defer()
can decide it is worth waiting before splitting a TSO packet.

This really means we are rwnd limited.

Fixes: 5615f88614a4 ("tcp: instrument how long TCP is limited by receive window")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_output.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2338,8 +2338,11 @@ static bool tcp_write_xmit(struct sock *
 		} else {
 			if (!push_one &&
 			    tcp_tso_should_defer(sk, skb, &is_cwnd_limited,
-						 max_segs))
+						 max_segs)) {
+				if (!is_cwnd_limited)
+					is_rwnd_limited = true;
 				break;
+			}
 		}
 
 		limit = mss_now;


