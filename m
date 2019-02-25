Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBF4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FBE213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129932;
	bh=eoBr7iIt8v5quMGh6YDeEh5uEo9FmjetRy6J2t8IiEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KMFGCmPP2ReqJgeB4oR1f91lhXo7cyPLbgYPY8O/dgoUWQX/XEjzO+9rVuauKWe+b
	 pWKkBsT3U30/L4vArVPUF1FwHmVVnFt9XryBvQ4wHcBV6AqBqXnPmV5Bkx4teFy2vR
	 XGQs19uCbSV+vu1WXkqfsn8wzGAEoRpzkiv13AzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbfBYVZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:25:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:59948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731418AbfBYVZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:25:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AA442084D;
        Mon, 25 Feb 2019 21:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129928;
        bh=eoBr7iIt8v5quMGh6YDeEh5uEo9FmjetRy6J2t8IiEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbYiU9YEGAYtaAK5qBRb4etcKGg3S7oVw9XS/DDvWNd9K7XzJLUvJcksOZOvKZFMI
         EUKZqWXu5we2ZEof3SbiL12c948/h0XxUFsbnmHVR+r3Opedco3reNpxLx6RTUtPK9
         WSDkB/h9H504BRUL8V+yDD1E9uuMqXyBqxwElI8Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 113/152] geneve: should not call rt6_lookup() when ipv6 was disabled
Date:   Mon, 25 Feb 2019 22:11:45 +0100
Message-Id: <20190225195050.825318930@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit c0a47e44c0980b3b23ee31fa7936d70ea5dce491 ]

When we add a new GENEVE device with IPv6 remote, checking only for
IS_ENABLED(CONFIG_IPV6) is not enough as we may disable IPv6 in the
kernel command line (ipv6.disable=1), and calling rt6_lookup() would
cause a NULL pointer dereference.

v2:
- don't mix declarations and code (reported by Stefano Brivio, Eric Dumazet)
- there's no need to use in6_dev_get() as we only need to check that
  idev exists (reported by David Ahern). This is under RTNL, so we can
  simply use __in6_dev_get() instead (Stefano, Eric).

Reported-by: Jianlin Shi <jishi@redhat.com>
Fixes: c40e89fd358e9 ("geneve: configure MTU based on a lower device")
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/geneve.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1406,9 +1406,13 @@ static void geneve_link_config(struct ne
 	}
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6: {
-		struct rt6_info *rt = rt6_lookup(geneve->net,
-						 &info->key.u.ipv6.dst, NULL, 0,
-						 NULL, 0);
+		struct rt6_info *rt;
+
+		if (!__in6_dev_get(dev))
+			break;
+
+		rt = rt6_lookup(geneve->net, &info->key.u.ipv6.dst, NULL, 0,
+				NULL, 0);
 
 		if (rt && rt->dst.dev)
 			ldev_mtu = rt->dst.dev->mtu - GENEVE_IPV6_HLEN;


