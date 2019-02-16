Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DF6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BED222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJBU9FPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbfBPIfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 03:35:32 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55573 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbfBPIfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 03:35:31 -0500
Received: by mail-it1-f194.google.com with SMTP id z131so19416405itf.5;
        Sat, 16 Feb 2019 00:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nHJUlW5rqXjmqQvn/sTeS2OlzI29+iHtaPnW6iRFsdw=;
        b=WJBU9FPSmCMy9tFlbnDUOhVuh/XOeXmgGeCDjskNjM27cN0zqAH56ae7qrAxuJKjC9
         ymQ/xm/2xmCscKA0JquXlYGHvv7fHHYZQ1FKTa9Ac9BQyJmNteqKfHESkqT40pDuBZxM
         Nwev0B+4BmbnwxCLxLQAZBkM9sUg193tOquiH5HmxVxUmbhSGx+84x6Og6QEJ/0NsadP
         hSLNp2P0zIlEo3yRLlvDlPhpaNfU5XsR1+0tpwZjV775Hdd7+EXkhrhRofq9Mj9izolx
         Av5ZCLq9DIOg0nePH37dUGSYQKD3pNsxlS23S7dmamfUXk5wn6EBMPZ7AqeaBhYZ9qg4
         WoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nHJUlW5rqXjmqQvn/sTeS2OlzI29+iHtaPnW6iRFsdw=;
        b=MEOhT1K4UpckjS34LW2QWDVoPm1I4bMrOw6Ppl6dyUUdCNCAltBnFe95MRmSvTRSBo
         bdOzul71ZGyoFij09jsLxtfeaENtQ9ckpMuSpVtvaw4ck9ZBsJd18QupTXBzc7Eyo1i3
         jOM6Bm172jS/SlC8CP+U1KnGe/actT/jLD0zrwen8XBVF5wxpOl+WsnWXe9YhP3UFdio
         hr2cGiVrtNDxcCCaeiF/8UqZEMdHcnqEtd7zQ9b24X8WVpqfJNR+Q+8YiHm5ecQFlqAQ
         saLL+OxDUbLLeG0B45BF8oXsYA7FTDVQR4NaCMscnJHglFw8npC+YXY3tzGFyjkQTTBv
         tRWQ==
X-Gm-Message-State: AHQUAuYsuUjDxzjt75OQAZ3MwNGN4xc9F3ltGwYkewFT2D9MfCyz4hI6
        MGrR6HHo9+S57KrZ515v8g==
X-Google-Smtp-Source: AHgI3IagmYXhVBszVWNh+VppksXcybRfsk3ia3s028k9Uhhar9SgyxlodjbirgSnF3xdPUittLq3bQ==
X-Received: by 2002:a5e:8416:: with SMTP id h22mr7383420ioj.118.1550306130666;
        Sat, 16 Feb 2019 00:35:30 -0800 (PST)
Received: from ip-172-31-35-247.us-east-2.compute.internal (ec2-52-15-165-154.us-east-2.compute.amazonaws.com. [52.15.165.154])
        by smtp.gmail.com with ESMTPSA id k26sm3121239iol.14.2019.02.16.00.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 00:35:30 -0800 (PST)
From:   Rundong Ge <rdong.ge@gmail.com>
To:     andrew@lunn.ch
Cc:     vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdong.ge@gmail.com
Subject: [PATCH v2] net: dsa: Implement flow_dissect callback for tag_dsa.
Date:   Sat, 16 Feb 2019 08:35:24 +0000
Message-Id: <20190216083524.860-1-rdong.ge@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPS not work for DSA devices since the 'skb_get_hash'
will always get the invalid hash for dsa tagged packets.

"[PATCH] tag_mtk: add flow_dissect callback to the ops struct"
introduced the flow_dissect callback to get the right hash for
MTK tagged packet. Tag_dsa and tag_edsa  also need to implement
the callback.

Signed-off-by: Rundong Ge <rdong.ge@gmail.com>
---
 net/dsa/tag_dsa.c  | 9 +++++++++
 net/dsa/tag_edsa.c | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/net/dsa/tag_dsa.c b/net/dsa/tag_dsa.c
index 8b2f92e..67ff3fa 100644
--- a/net/dsa/tag_dsa.c
+++ b/net/dsa/tag_dsa.c
@@ -146,8 +146,17 @@ static struct sk_buff *dsa_rcv(struct sk_buff *skb, struct net_device *dev,
 	return skb;
 }
 
+static int dsa_tag_flow_dissect(const struct sk_buff *skb, __be16 *proto,
+				int *offset)
+{
+	*offset = 4;
+	*proto = ((__be16 *)skb->data)[1];
+	return 0;
+}
+
 const struct dsa_device_ops dsa_netdev_ops = {
 	.xmit	= dsa_xmit,
 	.rcv	= dsa_rcv,
+	.flow_dissect   = dsa_tag_flow_dissect,
 	.overhead = DSA_HLEN,
 };
diff --git a/net/dsa/tag_edsa.c b/net/dsa/tag_edsa.c
index f5b87ee..234585e 100644
--- a/net/dsa/tag_edsa.c
+++ b/net/dsa/tag_edsa.c
@@ -165,8 +165,17 @@ static struct sk_buff *edsa_rcv(struct sk_buff *skb, struct net_device *dev,
 	return skb;
 }
 
+static int edsa_tag_flow_dissect(const struct sk_buff *skb, __be16 *proto,
+				 int *offset)
+{
+	*offset = 8;
+	*proto = ((__be16 *)skb->data)[3];
+	return 0;
+}
+
 const struct dsa_device_ops edsa_netdev_ops = {
 	.xmit	= edsa_xmit,
 	.rcv	= edsa_rcv,
+	.flow_dissect   = edsa_tag_flow_dissect,
 	.overhead = EDSA_HLEN,
 };
-- 
1.8.3.1

