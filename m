Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CDCC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB622089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866013;
	bh=j652PlJRTUysAUx0+nAQEQmZa+Fs+cpF7Ydsvu4UoRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zIvS2wGuCD2DXDr5UYy8eTdLbyF4tZ5Llt9O2ftECllvDCPQPNdtQgkf+IwgpBuZe
	 s84M9sKQt1UywEdVVpVIbiHT5Ii6NuQxWniaYi+gg0vYXwL756l9nokYJkiIbVesUh
	 j1nz8xGSbxcuoNoAD7oabuJfjGUvKokMjI7YRm7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbfAGNAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730391AbfAGNAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:00:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE097206BB;
        Mon,  7 Jan 2019 13:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866008;
        bh=j652PlJRTUysAUx0+nAQEQmZa+Fs+cpF7Ydsvu4UoRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DP7gBu8zaHB3Ub0IaT2AKesVlZJDIAsboRArVm6AuTIH8UUv9Ml8e3QufnfHVXYks
         HZBxacH17BZnAhoJodiWU8XsPajgkd1uk4jt4K3isx0BzTT21JKEWSfTxadkEIiMT7
         yKHepChxVgOjnzFogFVJ4AgSEhMgBmppaPl6Gpl0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+5e5e969e525129229052@syzkaller.appspotmail.com
Subject: [PATCH 4.14 016/101] net/wan: fix a double free in x25_asy_open_tty()
Date:   Mon,  7 Jan 2019 13:32:04 +0100
Message-Id: <20190107105332.884410546@linuxfoundation.org>
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


