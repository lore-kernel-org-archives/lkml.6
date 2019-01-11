Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83D4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA7E21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216305;
	bh=qgU6V4POssyL23AE/+FYVEkRnCwvO6mWddpLPhLjP1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K+4l/aM0INilPYOC0+3KZD7oVlqUU5DhBzKX4gXvh4s0DRGtGrFDrsBKwIbBF2a9R
	 cPX4sim4AB5kKI6rDiHCAIyYvANJCEZk6EL8V3lpoDDxShm77Ez9aKlCtBjjpwCohr
	 B6Iq+6mKgvf8qsgFTMnPW+fTEFFc9wcnM+sXYjNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfAKOSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:18:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730092AbfAKOST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:18:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4BF92177B;
        Fri, 11 Jan 2019 14:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216298;
        bh=qgU6V4POssyL23AE/+FYVEkRnCwvO6mWddpLPhLjP1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pYX/BHWynu8yz/NzafgG6yP6N41/9F480VROUh+wwJbmNAY2zPsKGQ0D7V7WFUUh2
         V25zGI5B819OjjE4XWoPncyWOS/6h+U46IG7pT+lhNk/xNHj4G7zly+QFBkW8h36+w
         HDkc6wQCeGH6wW3HcrijNw8zajaT6Z/IP7SpxW4o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 14/88] ip6mr: Fix potential Spectre v1 vulnerability
Date:   Fri, 11 Jan 2019 15:07:43 +0100
Message-Id: <20190111131048.253702315@linuxfoundation.org>
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

[ Upstream commit 69d2c86766da2ded2b70281f1bf242cb0d58a778 ]

vr.mifi is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

net/ipv6/ip6mr.c:1845 ip6mr_ioctl() warn: potential spectre issue 'mrt->vif_table' [r] (local cap)
net/ipv6/ip6mr.c:1919 ip6mr_compat_ioctl() warn: potential spectre issue 'mrt->vif_table' [r] (local cap)

Fix this by sanitizing vr.mifi before using it to index mrt->vif_table'

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6mr.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -72,6 +72,8 @@ struct mr6_table {
 #endif
 };
 
+#include <linux/nospec.h>
+
 struct ip6mr_rule {
 	struct fib_rule		common;
 };
@@ -1871,6 +1873,7 @@ int ip6mr_ioctl(struct sock *sk, int cmd
 			return -EFAULT;
 		if (vr.mifi >= mrt->maxvif)
 			return -EINVAL;
+		vr.mifi = array_index_nospec(vr.mifi, mrt->maxvif);
 		read_lock(&mrt_lock);
 		vif = &mrt->vif6_table[vr.mifi];
 		if (MIF_EXISTS(mrt, vr.mifi)) {
@@ -1945,6 +1948,7 @@ int ip6mr_compat_ioctl(struct sock *sk,
 			return -EFAULT;
 		if (vr.mifi >= mrt->maxvif)
 			return -EINVAL;
+		vr.mifi = array_index_nospec(vr.mifi, mrt->maxvif);
 		read_lock(&mrt_lock);
 		vif = &mrt->vif6_table[vr.mifi];
 		if (MIF_EXISTS(mrt, vr.mifi)) {


