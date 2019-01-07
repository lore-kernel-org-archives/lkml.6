Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE90C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF9421736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866316;
	bh=uyosTlheWnsWWO+QGX1AtcGvPSDy1oofwoma0I39X+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KH3+sfGqC61W7zi/8b4wrnQrgWZbNmhRD72pKWrAZQB+bSFVF14/OFPXnmSUrUE8i
	 F9lDJvPVH1eZRs0GCjNW2+Wm4epNRTGLlcBqnq4C+55q7dD2uZW52krLAbbKZ3t5iX
	 a/1C37c2EN+YOWMycbpitLPjZGI7Cufxp3JJklHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbfAGNFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:05:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731426AbfAGNFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:05:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37A902089F;
        Mon,  7 Jan 2019 13:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866309;
        bh=uyosTlheWnsWWO+QGX1AtcGvPSDy1oofwoma0I39X+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g1ggIzvqbDSwx1wciKxL+lbPuU+WnnNiq91s1zuLHjrkIRvFu8TVidbi0QPqCheJH
         lkUjC3axAOKCDOYrlDWkT0SUQ2v6OzYJ/Hhxjzbqy5gc7su+FzEVeWX9Si6Zc2e2Da
         ab4E5+R00ErImhRQ7Wvnxn6B2VBCbGx3DZQCe1vo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+5e5e969e525129229052@syzkaller.appspotmail.com
Subject: [PATCH 4.9 15/71] net/wan: fix a double free in x25_asy_open_tty()
Date:   Mon,  7 Jan 2019 13:32:44 +0100
Message-Id: <20190107105331.880690467@linuxfoundation.org>
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

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit d5c7c745f254c6cb98b3b3f15fe789b8bd770c72 ]

When x25_asy_open() fails, it already cleans up by itself,
so its caller doesn't need to free the memory again.

It seems we still have to call x25_asy_free() to clear the SLF_INUSE
bit, so just set these pointers to NULL after kfree().

Reported-and-tested-by: syzbot+5e5e969e525129229052@syzkaller.appspotmail.com
Fixes: 3b780bed3138 ("x25_asy: Free x25_asy on x25_asy_open() failure.")
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wan/x25_asy.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wan/x25_asy.c
+++ b/drivers/net/wan/x25_asy.c
@@ -488,8 +488,10 @@ static int x25_asy_open(struct net_devic
 
 	/* Cleanup */
 	kfree(sl->xbuff);
+	sl->xbuff = NULL;
 noxbuff:
 	kfree(sl->rbuff);
+	sl->rbuff = NULL;
 norbuff:
 	return -ENOMEM;
 }


