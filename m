Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7781C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C230217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867264;
	bh=1e5ZPhKeCwFvf8qjegy3JCamvlqAdW22zX8QO9AklYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LMFaaO+6XXjKoItBuym5b4tWVbwGHiaWov2p6uIHLnuBz7EaFlYo08dVsZCObW4dp
	 KrVOXji9z1LwTilFCRjdz+j7f8QuG59cCWFDj05qVxeiitozrFHxQLIHWeI6RrJ/IN
	 T50WDElHBjafYKTORTG10psk3o8eNqXamZ0AkLkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfAGNVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:21:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbfAGMpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:45:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E27C218A1;
        Mon,  7 Jan 2019 12:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865125;
        bh=1e5ZPhKeCwFvf8qjegy3JCamvlqAdW22zX8QO9AklYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4NJAHhZLcv3dqrya4ubf5DH/J2QYFz7L+ASx4duV4XThqz/2Iwsm1yDB3KMEaj+L
         2Nm0k7uuewbhRTMm+psxXao++/cU+pa24wyW2bQ362EawOJaZaExX7c2oZUdwrexqN
         ClCgle3+l0YZRvgJYGOYmIi/RaIphCkZlAN+ccPc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Sergey Matyukevich <geomatsi@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 011/170] net: clear skb->tstamp in forwarding paths
Date:   Mon,  7 Jan 2019 13:30:38 +0100
Message-Id: <20190107104454.359398850@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

[ Upstream commit 8203e2d844d34af247a151d8ebd68553a6e91785 ]

Sergey reported that forwarding was no longer working
if fq packet scheduler was used.

This is caused by the recent switch to EDT model, since incoming
packets might have been timestamped by __net_timestamp()

__net_timestamp() uses ktime_get_real(), while fq expects packets
using CLOCK_MONOTONIC base.

The fix is to clear skb->tstamp in forwarding paths.

Fixes: 80b14dee2bea ("net: Add a new socket option for a future transmit time.")
Fixes: fb420d5d91c1 ("tcp/fq: move back to CLOCK_MONOTONIC")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Sergey Matyukevich <geomatsi@gmail.com>
Tested-by: Sergey Matyukevich <geomatsi@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_forward.c |    1 +
 net/ipv6/ip6_output.c |    1 +
 2 files changed, 2 insertions(+)

--- a/net/ipv4/ip_forward.c
+++ b/net/ipv4/ip_forward.c
@@ -72,6 +72,7 @@ static int ip_forward_finish(struct net
 	if (unlikely(opt->optlen))
 		ip_forward_options(skb);
 
+	skb->tstamp = 0;
 	return dst_output(net, sk, skb);
 }
 
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -378,6 +378,7 @@ static inline int ip6_forward_finish(str
 	__IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
 	__IP6_ADD_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTOCTETS, skb->len);
 
+	skb->tstamp = 0;
 	return dst_output(net, sk, skb);
 }
 


