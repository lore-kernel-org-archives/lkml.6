Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6C1C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8CF2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867013;
	bh=g8C1nGI/CiMNcaSGHLqCCTe17+yv/EdejMjaH8Ui+ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IXZ8dHsMaQov1ujjR64TpLHOlB5RFacKxRKUCp0B+kD9rVA0U9RIjai75lrEYgIhx
	 fMWT9F8bPJc4kePRO337WZjzQuMHf867eKoouczBrxrD5crhNuexLRIOI+fA7nw2tl
	 e1ovZzeOC8qgZcLGxuedLHdD7cvdxQrKw+5GyGX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfAGNQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:16:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730462AbfAGNAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:00:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7573721736;
        Mon,  7 Jan 2019 13:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866025;
        bh=g8C1nGI/CiMNcaSGHLqCCTe17+yv/EdejMjaH8Ui+ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y45UMitnlA8xugrDjNSIJlkRUDcIn+b1C824HREfnMI8C/ik2d6rIuwmGC67wlp+P
         nJSHoL5wk+IuCr0998ZaZYws5fxW9kCw9dQojQMY+J/ilO1R8NlwogZOvhE3evFLd5
         tyH8AOzqe7N1gCt9GcW+bTtMY3QADYLPxHLGa8ZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 003/101] ipv4: Fix potential Spectre v1 vulnerability
Date:   Mon,  7 Jan 2019 13:31:51 +0100
Message-Id: <20190107105330.587860461@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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
 net/ipv4/ipmr.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -68,6 +68,8 @@
 #include <linux/netconf.h>
 #include <net/nexthop.h>
 
+#include <linux/nospec.h>
+
 struct ipmr_rule {
 	struct fib_rule		common;
 };
@@ -1620,6 +1622,7 @@ int ipmr_compat_ioctl(struct sock *sk, u
 			return -EFAULT;
 		if (vr.vifi >= mrt->maxvif)
 			return -EINVAL;
+		vr.vifi = array_index_nospec(vr.vifi, mrt->maxvif);
 		read_lock(&mrt_lock);
 		vif = &mrt->vif_table[vr.vifi];
 		if (VIF_EXISTS(mrt, vr.vifi)) {


