Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F69C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536FF2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zCM+ATV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536FF2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbeKCEEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbeKCEEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:04:00 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECAF120848;
        Fri,  2 Nov 2018 18:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184944;
        bh=5LzUwj5bsoEuY8+l7iPNB8K3KuzqWKcJW1RJEda967s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zCM+ATV4e1g/KR4pfnSz5mDjjfS2q4RDLcp0flWvmlwZE+lMeHersl86I7sl7dJ85
         LUczrP3S7AHqqqNkCKtBkgaxpyT97GQ61qnfZZsnzlJCi0/ytWw7zZOFXeaWxg1Bi0
         IRHLyGEuEEcdrf34JEC7pMemp7uD+n3911Y1HMgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Sutter <phil@nwl.cc>,
        Jiri Pirko <jiri@mellanox.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 136/143] net: sched: Fix for duplicate class dump
Date:   Fri,  2 Nov 2018 19:35:21 +0100
Message-Id: <20181102182908.626196713@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit 3c53ed8fef6881a864f0ee8240ed2793ef73ad0d ]

When dumping classes by parent, kernel would return classes twice:

| # tc qdisc add dev lo root prio
| # tc class show dev lo
| class prio 8001:1 parent 8001:
| class prio 8001:2 parent 8001:
| class prio 8001:3 parent 8001:
| # tc class show dev lo parent 8001:
| class prio 8001:1 parent 8001:
| class prio 8001:2 parent 8001:
| class prio 8001:3 parent 8001:
| class prio 8001:1 parent 8001:
| class prio 8001:2 parent 8001:
| class prio 8001:3 parent 8001:

This comes from qdisc_match_from_root() potentially returning the root
qdisc itself if its handle matched. Though in that case, root's classes
were already dumped a few lines above.

Fixes: cb395b2010879 ("net: sched: optimize class dumps")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_api.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1917,7 +1917,8 @@ static int tc_dump_tclass_root(struct Qd
 
 	if (tcm->tcm_parent) {
 		q = qdisc_match_from_root(root, TC_H_MAJ(tcm->tcm_parent));
-		if (q && tc_dump_tclass_qdisc(q, skb, tcm, cb, t_p, s_t) < 0)
+		if (q && q != root &&
+		    tc_dump_tclass_qdisc(q, skb, tcm, cb, t_p, s_t) < 0)
 			return -1;
 		return 0;
 	}


