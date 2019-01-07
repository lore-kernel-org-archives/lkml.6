Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECDEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91170206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865337;
	bh=nkdF49Yx/OLj+vT1lnVPlg/H50KU6Z4bI3yGr/JU4sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uKBHAaIKIS7pNfiBlUozEOswibWVom2VfmQtnw5aVjoNSRoUueK00UpE1TNbbE1m+
	 xEFSsqjZn9m+xDgPuapskemU65Rcaf/qr5Q02HMYl2RQvlGuTqgZv5U2liHrfD5rBZ
	 KfbWQCfH4HmQ2TXXBa9ccuHboiMdh0+IbNQmfFUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfAGMs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729267AbfAGMsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E05F20651;
        Mon,  7 Jan 2019 12:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865333;
        bh=nkdF49Yx/OLj+vT1lnVPlg/H50KU6Z4bI3yGr/JU4sY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H1Rgui/FApO5Uz7LQ6ZN5oLa8OzSYy5Iy6dYZj+ehrJLQ6122h1GIbEqQ4wr/+WWh
         x/iTuaFDqWXW4K/4QJ06pq3N3q/Q46tlnyPEY9jlVruFFJ99uoir+exz3r5uNKS3DS
         qS6BCX7GOGrRT3nteuyySJU9/to5MxYi+PtoOTQw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 058/170] r8169: fix WoL device wakeup enable
Date:   Mon,  7 Jan 2019 13:31:25 +0100
Message-Id: <20190107104459.930066884@linuxfoundation.org>
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

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 3bd8264511035dc97c902f03fa9f1d07f95f8f62 ]

In rtl8169_runtime_resume() we configure WoL but don't set the device
to wakeup-enabled. This prevents PME generation once the cable is
re-plugged. Fix this by moving the call to device_set_wakeup_enable()
to __rtl8169_set_wol().

Fixes: 433f9d0ddcc6 ("r8169: improve saved_wolopts handling")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -1528,6 +1528,8 @@ static void __rtl8169_set_wol(struct rtl
 	}
 
 	RTL_W8(tp, Cfg9346, Cfg9346_Lock);
+
+	device_set_wakeup_enable(tp_to_dev(tp), wolopts);
 }
 
 static int rtl8169_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
@@ -1549,8 +1551,6 @@ static int rtl8169_set_wol(struct net_de
 
 	rtl_unlock_work(tp);
 
-	device_set_wakeup_enable(d, tp->saved_wolopts);
-
 	pm_runtime_put_noidle(d);
 
 	return 0;


