Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EC8C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8F720866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmrsPEa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8F720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbeJQBEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbeJQBEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:04:05 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 402072098A;
        Tue, 16 Oct 2018 17:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709962;
        bh=GpBohf9VGS890TdtMRBQG6ZDAhDLwBfcn2cDG1hrRqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UmrsPEa4iO690M2AU+u5CzEAOirYphByvdiXbWbHQS9tbhHAtaNGOxUkopvcK5llN
         K8Y00SNfWlMBwCv/yEUIKPGThxoAgbVG0NFTw9TRpEZZy273++Raeu/nT9t7F0D9j0
         2egm1kd7Bfi+TvBB8foPIL6a+vS46FLItUNV41IU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 057/135] net/ipv6: stop leaking percpu memory in fib6 info
Date:   Tue, 16 Oct 2018 19:04:47 +0200
Message-Id: <20181016170518.491920828@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Rapoport <rppt@linux.vnet.ibm.com>

[ Upstream commit 7abab7b9b498650404800a08765f44929fee8f31 ]

The fib6_info_alloc() function allocates percpu memory to hold per CPU
pointers to rt6_info, but this memory is never freed. Fix it.

Fixes: a64efe142f5e ("net/ipv6: introduce fib6_info struct and helpers")
Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_fib.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -196,6 +196,8 @@ void fib6_info_destroy_rcu(struct rcu_he
 				*ppcpu_rt = NULL;
 			}
 		}
+
+		free_percpu(f6i->rt6i_pcpu);
 	}
 
 	lwtstate_put(f6i->fib6_nh.nh_lwtstate);


