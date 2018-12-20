Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576A6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2854F21773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297716;
	bh=yErdfOpqJAAeA+/8igG3GGMh3PawtwCNyN3PeWU7OSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Xp4b+LMiPhMwjTiRcxx5EZS0b5DRLt/L21fEugNzVXFiuyJQKoa365ERJDQRF9Su
	 w3U8VVb9mExati6U3KZKnpSunt2psskPfssayOcdYhKcn3liLNkzR5ookin6mzn5UV
	 1JH8zCufV9rSUFshR+x5mgxOPSOXgoU00H32OmJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeLTJVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:21:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731173AbeLTJVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:21:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A5912177B;
        Thu, 20 Dec 2018 09:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297709;
        bh=yErdfOpqJAAeA+/8igG3GGMh3PawtwCNyN3PeWU7OSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BlpYLeguMyw38KXoQFvHK1H7u3cz82bjSlOo+daiMuwe7DCGhyi7BXX3uuIkYt9jb
         YLRCqOQISEtIEGz/vD+GfkJ3m9dpyhyQrfX9oWCGXmXh7PmE+qCvulkBKCFJPtO8H8
         JNuLdyUT+0ZrxTFC+AJHzG4WaDOpYCtC19SWUhRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 28/40] drivers/tty: add missing of_node_put()
Date:   Thu, 20 Dec 2018 10:18:40 +0100
Message-Id: <20181220085827.588969702@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
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

[ Upstream commit dac097c4546e4c5b16dd303a1e97c1d319c8ab3e ]

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
This place is not doing this, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/suncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/suncore.c b/drivers/tty/serial/suncore.c
index 127472bd6a7c..209f314745ab 100644
--- a/drivers/tty/serial/suncore.c
+++ b/drivers/tty/serial/suncore.c
@@ -111,6 +111,7 @@ void sunserial_console_termios(struct console *con, struct device_node *uart_dp)
 		mode = of_get_property(dp, mode_prop, NULL);
 		if (!mode)
 			mode = "9600,8,n,1,-";
+		of_node_put(dp);
 	}
 
 	cflag = CREAD | HUPCL | CLOCAL;
-- 
2.19.1



