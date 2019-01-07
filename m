Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F201C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C8C2183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866344;
	bh=fw+E4eQZnkp+aW9oNnGkAfs7eoC98GhhaBLwSguVDko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PQ+okBVbIGS3cNebNhAXVJJWS476HfVBRra0YLE+W1/Fmc2VBegRFs8oIfLlWFSL8
	 bVU1sTozgZPDZwTH06/qZKYpo9uIO9QkHvI6bojX/Tt9hmo1eGIB6tNp5SIrj4rHaa
	 OMfq6lgLbkid48Uwn6sPg5YKv3MyY/hEF8VLmONg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfAGNFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:05:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbfAGNFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:05:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35A9921736;
        Mon,  7 Jan 2019 13:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866339;
        bh=fw+E4eQZnkp+aW9oNnGkAfs7eoC98GhhaBLwSguVDko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJGJNzonwA/24wQrqjs4660+1qxGKgwxi9+8ZNcQh+wz7hmlLYAm8n//d7lTwf93N
         xaEChKyrYQ7R2zsDFwZNT6O/Gzd+b23gg2qmdWKbBx0V/7LpnR5+RGBerk7ZNJwL4x
         QdX+2JLQtZBgyfMVidisBlUItLzQuyBqrsGNTAYI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 02/71] ip6mr: Fix potential Spectre v1 vulnerability
Date:   Mon,  7 Jan 2019 13:32:31 +0100
Message-Id: <20190107105330.412715113@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1873,6 +1875,7 @@ int ip6mr_ioctl(struct sock *sk, int cmd
 			return -EFAULT;
 		if (vr.mifi >= mrt->maxvif)
 			return -EINVAL;
+		vr.mifi = array_index_nospec(vr.mifi, mrt->maxvif);
 		read_lock(&mrt_lock);
 		vif = &mrt->vif6_table[vr.mifi];
 		if (MIF_EXISTS(mrt, vr.mifi)) {
@@ -1947,6 +1950,7 @@ int ip6mr_compat_ioctl(struct sock *sk,
 			return -EFAULT;
 		if (vr.mifi >= mrt->maxvif)
 			return -EINVAL;
+		vr.mifi = array_index_nospec(vr.mifi, mrt->maxvif);
 		read_lock(&mrt_lock);
 		vif = &mrt->vif6_table[vr.mifi];
 		if (MIF_EXISTS(mrt, vr.mifi)) {


