Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B8AC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3C420874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216738;
	bh=CLrQ2f7p0BCYFcPPNIjenI59IyS/5WiGqT6KibLjFhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kXsw1OYxz113e2apn5Ozl65XA28ZGXGF7yWprUqRGs8OzFs+dFc5zDrMfgyvA2IHm
	 Al5Rs34WVxe5Kj0+LRErqK8zEm2wN9/5ThPUOXdWyaCTbVNUULgS7WSFNhAR6j+Jhb
	 qn2xVZQ+IZwuR7WDn+yWIl2MnSaEivpVMtA6uPhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbfAKOS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:18:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732016AbfAKOSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:18:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D54FA21783;
        Fri, 11 Jan 2019 14:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216301;
        bh=CLrQ2f7p0BCYFcPPNIjenI59IyS/5WiGqT6KibLjFhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kzE8WvHALP/eRPwAvNbhu/BsduxNM5JTHBrmU3WR8EeRqMJE9x3ciQEddvTlXPffm
         OZEidFYdIfT2iHyQTLTu6/Ox6bhm8lgQ3iXaN7jNJM6+a4nEaUdxDmSxDNlQHvPYvj
         pRJrPUz9MNLicLlqBq/alEE2eJzqBuGWUIca6JCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 15/88] ipv4: Fix potential Spectre v1 vulnerability
Date:   Fri, 11 Jan 2019 15:07:44 +0100
Message-Id: <20190111131048.434148956@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit 5648451e30a0d13d11796574919a359025d52cce ]

vr.vifi is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

net/ipv4/ipmr.c:1616 ipmr_ioctl() warn: potential spectre issue 'mrt->vif_table' [r] (local cap)
net/ipv4/ipmr.c:1690 ipmr_compat_ioctl() warn: potential spectre issue 'mrt->vif_table' [r] (local cap)

Fix this by sanitizing vr.vifi before using it to index mrt->vif_table'

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ipmr.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -66,6 +66,7 @@
 #include <net/netlink.h>
 #include <net/fib_rules.h>
 #include <linux/netconf.h>
+#include <linux/nospec.h>
 
 #if defined(CONFIG_IP_PIMSM_V1) || defined(CONFIG_IP_PIMSM_V2)
 #define CONFIG_IP_PIMSM	1
@@ -1574,6 +1575,7 @@ int ipmr_compat_ioctl(struct sock *sk, u
 			return -EFAULT;
 		if (vr.vifi >= mrt->maxvif)
 			return -EINVAL;
+		vr.vifi = array_index_nospec(vr.vifi, mrt->maxvif);
 		read_lock(&mrt_lock);
 		vif = &mrt->vif_table[vr.vifi];
 		if (VIF_EXISTS(mrt, vr.vifi)) {


