Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A315C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D44206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864588;
	bh=GyXzTn+A3uss30ENz1p2c6b9P5KFzuj29zJZ07N4q+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oZlsRV3Xbfe8affkC7O9xFI/OWi+0/g/mcS/ncM6LEJ6k+tHf0bzfFIj6F+pwxtk1
	 h0l2Wcg84NcNTFM9GoXpK9U1iY+wOYNlhtjY1auFPf873A16Gur/t93WhE7x7Ppphv
	 wkYMDk06b6eJvUHKwGqxoZ06d+ZEg/vGCpXFM4TY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfAGMg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:36:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfAGMgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:36:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78DE4206BB;
        Mon,  7 Jan 2019 12:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864585;
        bh=GyXzTn+A3uss30ENz1p2c6b9P5KFzuj29zJZ07N4q+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LeBMP9Z9QrTurfMeyELsg2Wnaq1o1yGwJzqTKPjmb1hr46oqh7nqZ2Jz5tgkCNzDu
         a8gu/BIkMkk+OWiM0oNTnXggKAN4lV6YmDB7hQuPq+y9ER7SJJM7f5uw10aK9YrlZ/
         YRbxPyDZFPm83kniyykqKqFf0CLOepCL+1A9dduE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+5e5e969e525129229052@syzkaller.appspotmail.com
Subject: [PATCH 4.20 014/145] net/wan: fix a double free in x25_asy_open_tty()
Date:   Mon,  7 Jan 2019 13:30:51 +0100
Message-Id: <20190107104439.234661171@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -485,8 +485,10 @@ static int x25_asy_open(struct net_devic
 
 	/* Cleanup */
 	kfree(sl->xbuff);
+	sl->xbuff = NULL;
 noxbuff:
 	kfree(sl->rbuff);
+	sl->rbuff = NULL;
 norbuff:
 	return -ENOMEM;
 }


