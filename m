Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0C6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B69E205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="Pvnpn+he"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393425AbfAPO0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:26:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32897 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390995AbfAPO0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:26:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so2913943pgu.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 06:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OFYi0B0xaMyvevGQpx6Nyn5JWeEzLpCt1jdHdRE25uY=;
        b=Pvnpn+heih5+7CDHMgICaTLHo1866UMg7a46Nfq+olAo/Avf8jw69IGFS93WQGSmQx
         Ooko3VxNfjFdX2uu4kE3t1SObzeYughNhUFtGu5n5GC+gEM3tKkjxc7J8xmkwplrtGSE
         P0AfBlcXuJQW2mZ3HKAGCKaEnCf9E8/902uDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OFYi0B0xaMyvevGQpx6Nyn5JWeEzLpCt1jdHdRE25uY=;
        b=ADeBML5+ZoP24Yi26kIrIYUlv+XzraXJ+AvBCVEgxC98FE5H2q+dfh8zr25OId+U8f
         CCpG8xKIz5RDg/E9IkdknFt7KsewqMpeUBJGwRSeiIW8PFZ0BdjOaY9+s5QSZt5mojlk
         ZzZ4lTfvk7nne16vjRR9W32mKiIsB1yxHopxcdu1ou84HK7N617iDb9Uim1gI3nEvT/f
         7RN66yzI/1bOgUcUg7+xE+PcyLknuMF1rr1fy0alViPFksFmPGwbqV4A+gLdq34BVCVF
         I/mc+KhkT7ovjmdFPpnMSWPPr9rfID8NtYii5i92FFRFzj7Iq7nrCJSzkwSxpNpWrvr4
         cCJQ==
X-Gm-Message-State: AJcUukeO9L+ZJAGNa6sqd3paJG93yfEhwYG3pqLmBXOkak0fd/dP0+/F
        9pJrwT8uDLWtNcqAyhnfgN2A8A==
X-Google-Smtp-Source: ALg8bN74EQAx6xaPCby36H5blYZySCEw6xY6RY8NbQmY1fCiJjZYABituDk5LtY49qbnKuCuBtqYUQ==
X-Received: by 2002:a63:a064:: with SMTP id u36mr9143400pgn.145.1547648762037;
        Wed, 16 Jan 2019 06:26:02 -0800 (PST)
Received: from starnight.local ([150.116.255.181])
        by smtp.gmail.com with ESMTPSA id a17sm9211783pgm.26.2019.01.16.06.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 06:26:01 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     Ben Whitten <ben.whitten@lairdtech.com>,
        linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [RFC PATCH 3/5] net; lorawan: Fix net device leakage
Date:   Wed, 16 Jan 2019 22:24:58 +0800
Message-Id: <20190116142458.19542-3-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116142048.19446-1-starnight@g.ncu.edu.tw>
References: <20190116142048.19446-1-starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The net device may be missed to be put after error check.  This patch
fixes the issue to prevent the leakage.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
 net/lorawan/socket.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/lorawan/socket.c b/net/lorawan/socket.c
index 9c0722379e25..7139fab63159 100644
--- a/net/lorawan/socket.c
+++ b/net/lorawan/socket.c
@@ -51,8 +51,10 @@ lrw_get_dev_by_addr(struct net *net, u32 devaddr)
 
 	rcu_read_lock();
 	ndev = dev_getbyhwaddr_rcu(net, ARPHRD_LORAWAN, (char *)&be_addr);
-	if (ndev)
+	if (ndev && ndev->type == ARPHRD_LORAWAN)
 		dev_hold(ndev);
+	else
+		ndev = NULL;
 	rcu_read_unlock();
 
 	return ndev;
@@ -99,11 +101,6 @@ dgram_bind(struct sock *sk, struct sockaddr *uaddr, int len)
 	}
 	netdev_dbg(ndev, "%s: get ndev\n", __func__);
 
-	if (ndev->type != ARPHRD_LORAWAN) {
-		ret = -ENODEV;
-		goto dgram_bind_end;
-	}
-
 	ro->src_devaddr = addr->addr_in.devaddr;
 	ro->bound = 1;
 	ret = 0;
@@ -152,7 +149,7 @@ dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	if (size > ndev->mtu) {
 		netdev_dbg(ndev, "size = %zu, mtu = %u\n", size, ndev->mtu);
 		ret = -EMSGSIZE;
-		goto dgram_sendmsg_end;
+		goto dgram_sendmsg_no_skb;
 	}
 
 	netdev_dbg(ndev, "%s: create skb\n", __func__);
@@ -189,7 +186,6 @@ dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	kfree_skb(skb);
 dgram_sendmsg_no_skb:
 	dev_put(ndev);
-
 dgram_sendmsg_end:
 	return ret;
 }
-- 
2.20.1

