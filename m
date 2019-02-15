Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDC1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FF620821
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT/mPfsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404195AbfBOIW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:22:59 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36879 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403860AbfBOIW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:22:59 -0500
Received: by mail-it1-f196.google.com with SMTP id l131so21335414ita.2;
        Fri, 15 Feb 2019 00:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rNN8ycMkfIDlILiOoDG6JxU5FPIMQ8gR3UP9GLcGRlM=;
        b=XT/mPfsDFeI0dkV2jm1ERLqN4NVtL0OMs1yTjFmwgTU5525tGVbpCDTcB9m2mdijfE
         oUNtpDIgHEANqNJ6zlQmRYz3Kt6kfyORYgfDAGYNyQcT5nqbyg9lguO3aFTxuQc/OYF+
         3jxeG6CC6xuo2iaCPuc7mafR3YmZ0MRtsT9MyGzr4N1eiFod3SD1DDtggBZbXbaV+2ux
         EHhWYqhGpo9L3n6FDs3TbvtoBYPgYnCggx2yIUoX+0AqZSkWx/fCsa0o8Er8OP/7Gvo1
         xGA5fj4pOXoARlkMNKYAwVCSmNiznkDUCvQ4nlPyK9vs+aVUhhRqyG8R2UI25xZt8UW6
         E8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rNN8ycMkfIDlILiOoDG6JxU5FPIMQ8gR3UP9GLcGRlM=;
        b=R0eMTxL33WU/+IsOAr8N1r9SCb5NUTtEUVIqPN/YTdl8IiLOtmH7gZx75/EdgzF7Ty
         X79d/nHl2f5UyHXI6l22UNjqS/JVi5Z4L80yZ2rM5ZgaXAcBIHHDn6NzW+W6iLFBHmh2
         BrKq82AAxpjt+cFTZiN3zl39IuLEMgtdNZtkapZ4oSaKJo56GNhRhP+GmZec83H/tPQQ
         +Fi88E4Wwt9ZSmGtxHHR81aygqd7Eu+5FaH4uc7EuQzaKcdBFuuODpT4dWsI+YQiaiFZ
         nvsAY1Fd/IpeLCq7WYWqqNm97iqTgP/N+SfnbYw9TL1QXY4fM5/KaMeYvWEoMyP2OHhD
         7sGg==
X-Gm-Message-State: AHQUAuZIwx9C1edWVbDjvp0P7gUEbGizOsR9ixjrsfT2T30LtdRDyIb/
        /i7cSXAUTWzS1/wZ/uxTag==
X-Google-Smtp-Source: AHgI3IZ2Uc8/S5ovLLKhgtHkgPheZ+vkXdOxttS65RZl/eM5ofGIWboq9XuR3jrX9hMYDeC83KaZAw==
X-Received: by 2002:a05:660c:814:: with SMTP id j20mr3979684itk.20.1550218978051;
        Fri, 15 Feb 2019 00:22:58 -0800 (PST)
Received: from ip-172-31-35-247.us-east-2.compute.internal (ec2-52-15-165-154.us-east-2.compute.amazonaws.com. [52.15.165.154])
        by smtp.gmail.com with ESMTPSA id m25sm370619iti.16.2019.02.15.00.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 00:22:57 -0800 (PST)
From:   Rundong Ge <rdong.ge@gmail.com>
To:     andrew@lunn.ch
Cc:     vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdong.ge@gmail.com
Subject: [PATCH] net: dsa: Implement flow_dissect callback for tag_dsa.
Date:   Fri, 15 Feb 2019 08:22:53 +0000
Message-Id: <20190215082253.2682-1-rdong.ge@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPS not work for DSA devices since the 'skb_get_hash'
will always get the invalid hash for dsa tagged packets.

"[PATCH] tag_mtk: add flow_dissect callback to the ops struct"
introduced the flow_dissect callback to get the right hash for
MTK tagged packet. And tag_dsa also needs to implement
the callback.

Signed-off-by: Rundong Ge <rdong.ge@gmail.com>
---
 net/dsa/tag_dsa.c | 9 +++++++++
 1 file changed, 9 insertions(+)

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
-- 
1.8.3.1

