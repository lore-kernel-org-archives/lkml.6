Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CC7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECC721736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867213;
	bh=V0gEXI1Ez2ZT0jM76V5cHlNuL4wRLygbWh6yIBV9e5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=POBBzlp1CZDOPgJhNnH6xjnXawNRWg91JyCns6bErY40IkIeb94WlGKnVWei6aj2u
	 z+hjyofADDwJiHt2RNeygVPXFoN4u3Iaf3l0oQvH5LgKnJC5CGUedvs5McCjQcMbSk
	 BGdzO4fIyLCnLtBZBySeIJKlQZ5+w/yp5fbvINB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfAGNUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbfAGMru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:47:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80E6120651;
        Mon,  7 Jan 2019 12:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865270;
        bh=V0gEXI1Ez2ZT0jM76V5cHlNuL4wRLygbWh6yIBV9e5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V2Q5HaZ2//G9+aplo/VrPeg3JP/FfbDrvYZQjJP2nCesS0VwAe6Krcjt32fNgsrlX
         ZA0w9K6CwH7iM1BCBrEtAiNd+FnsIJSss9k9aVOACC3AVQIxWtIXmfZJL517QeEEAW
         VanBtxRUZ1t/4ZO2IwiooQkKTrx+tfTwjC686XuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+5e5e969e525129229052@syzkaller.appspotmail.com
Subject: [PATCH 4.19 022/170] net/wan: fix a double free in x25_asy_open_tty()
Date:   Mon,  7 Jan 2019 13:30:49 +0100
Message-Id: <20190107104455.676064273@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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
@@ -486,8 +486,10 @@ static int x25_asy_open(struct net_devic
 
 	/* Cleanup */
 	kfree(sl->xbuff);
+	sl->xbuff = NULL;
 noxbuff:
 	kfree(sl->rbuff);
+	sl->rbuff = NULL;
 norbuff:
 	return -ENOMEM;
 }


