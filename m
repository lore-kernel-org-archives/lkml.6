Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A250C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510CA21477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh6X0P9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510CA21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeJQBED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbeJQBEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:04:02 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AD422089E;
        Tue, 16 Oct 2018 17:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709960;
        bh=paN14ZUWdPc1IcXhhKZAEXwaD/tI6D/p60FPwZJXgU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jh6X0P9ODRdTTusdM5+AR5czV8ZvfSRV7Ke7Xfq6C+TIdtZ1NMB1nEt2v5EluPEeV
         FCQHsIlrGvszZ4Qtg9G8hkY7bG0rXlOJrOoO5gE8/mHM53v7swqJWas7EXXuFKUiUa
         PzMqfAr6OQSsHC6g2KZZSQrb+cZGsetO7Mqq9l00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 056/135] net/ipv6: Remove extra call to ip6_convert_metrics for multipath case
Date:   Tue, 16 Oct 2018 19:04:46 +0200
Message-Id: <20181016170518.413223683@linuxfoundation.org>
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

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 36f19d5b4f99fa9fa8263877e5f8e669d7fddc14 ]

The change to move metrics from the dst to rt6_info moved the call
to ip6_convert_metrics from ip6_route_add to ip6_route_info_create. In
doing so it makes the call in ip6_route_info_append redundant and
actually leaks the metrics installed as part of the ip6_route_info_create.
Remove the now unnecessary call.

Fixes: d4ead6b34b67f ("net/ipv6: move metrics from dst to rt6_info")
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4314,11 +4314,6 @@ static int ip6_route_info_append(struct
 	if (!nh)
 		return -ENOMEM;
 	nh->fib6_info = rt;
-	err = ip6_convert_metrics(net, rt, r_cfg);
-	if (err) {
-		kfree(nh);
-		return err;
-	}
 	memcpy(&nh->r_cfg, r_cfg, sizeof(*r_cfg));
 	list_add_tail(&nh->next, rt6_nh_list);
 


