Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA04EC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A013121486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789258;
	bh=QDEIqdHqznz4aw8yFwFjfEs+1cYl/Yy5h9JccUPzxGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tL+7xxeqNyybOJU2qPQ7D2wfDkxuHiqpazt940bty0bYJJxY+egw/cG0iArzLrK9X
	 5jVGij91pFwcBt6O+6qMs2bK/Zh2KFfgd3LANcpXbh8L7WEzJ9IEg50prvFDdzLX3K
	 BmDy+C2WfqqWK8SIwDutpYwQw7pnV4O8Kh/skh24=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A013121486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbeLNMHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:07:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729836AbeLNMHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:07:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAAA621486;
        Fri, 14 Dec 2018 12:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789255;
        bh=QDEIqdHqznz4aw8yFwFjfEs+1cYl/Yy5h9JccUPzxGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uFbRcfWiQzUVUgoy5M4zeBHpSrtWGqobVEG88rsz74N87HrQxHKecAqgmGwdkoxC3
         OpeA4fJN6d8Zil69aIaaRTrR8wLvZCD26uVK40J6l8Kca1ap6+52QgAUDjNSLH1+rK
         qvhFmjSj0ttnrWHkRHeinyKqxLMnWXnAMpv6GwM0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 12/89] tcp: Do not underestimate rwnd_limited
Date:   Fri, 14 Dec 2018 12:59:25 +0100
Message-Id: <20181214115730.277730409@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2328,8 +2328,11 @@ static bool tcp_write_xmit(struct sock *
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


