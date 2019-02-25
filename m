Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3844C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31AC217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129290;
	bh=yz++xjJP+tyJ5DXzefZq9ZGtYyxVWUGUoqilYvwJMOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YY1Bk+lW58XhQFo2Cxn2MjEl7ZpF/a9823NX0qARxjhB9xspTG/YA2twpcQJFysc6
	 xURCnTt3W+F8GqwmJnz6EIOV/eh/TEvJcj3ktADcqV2SIQZqegt0qimVE6OizHzfxS
	 uoLl+zp8768JhEOfiaakxWPpbCDJtdXQy2dTuIjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfBYVOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:14:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbfBYVOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:14:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9547C21734;
        Mon, 25 Feb 2019 21:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129285;
        bh=yz++xjJP+tyJ5DXzefZq9ZGtYyxVWUGUoqilYvwJMOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YyFSR9XxdWF0i13sAT3XU7oCuaBloCPi5qJzrh0/QxAtH+DYfc77LPdzntbEjzO27
         3mAzrzt1rFAGZBE9GV0yRTWWt5i4LihRlM+rEek20Ffv1D2QBuEKlcYA+99+BDZ4CR
         0yDbHo6P3avx9Jng06WfpQshwb8cHocmYxaV0Vc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 44/63] netpoll: Fix device name check in netpoll_setup()
Date:   Mon, 25 Feb 2019 22:11:44 +0100
Message-Id: <20190225195039.183661869@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

From: Matthias Kaehlcke <mka@chromium.org>

commit 0c3a8f8b8fabff4f3ad2dd7b95ae0e90cdd1aebb upstream.

Apparently netpoll_setup() assumes that netpoll.dev_name is a pointer
when checking if the device name is set:

if (np->dev_name) {
  ...

However the field is a character array, therefore the condition always
yields true. Check instead whether the first byte of the array has a
non-zero value.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/netpoll.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -666,7 +666,7 @@ int netpoll_setup(struct netpoll *np)
 	int err;
 
 	rtnl_lock();
-	if (np->dev_name) {
+	if (np->dev_name[0]) {
 		struct net *net = current->nsproxy->net_ns;
 		ndev = __dev_get_by_name(net, np->dev_name);
 	}


