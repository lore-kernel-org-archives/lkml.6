Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53B3C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BEC20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545456;
	bh=s8RZ+tBxpqEJoDpXJ3685k50fBfjDhFaEVSFFBvMKp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nBB0QZ4jMUIb61ONU2wqTmFw8R/YGVQmWOZPAJ+Z8swZ7vwx6J0emSkQlZWixXu50
	 he/S/D5YMwiRrIQEgKya5vjyeFbZ11nD+SBeDBpOQvzDqdAYR/CSr/TuJkl63HSBRw
	 eRBTOP6IXRxMfkoDNKebwdtUSE5qPGqermZ6tZnM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BEC20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeLKPmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:42:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeLKPmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:42:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1826E20855;
        Tue, 11 Dec 2018 15:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544542971;
        bh=s8RZ+tBxpqEJoDpXJ3685k50fBfjDhFaEVSFFBvMKp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=au6YKcRE2yv5wBRaH+bi7pThupd1u+KYKm0LWif/ht7qMysbMxlXn+lYc4Ji0RAPa
         159GALkxUXSbavz66Tay/4IVHkQm88OahyZxuFFLejNoGbzOokofhEGu6R0xwEjaAn
         QZfuf9RxdH9+EeMejL5ZuLo74+AVndWQRCaTMS8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sultan Alsawaf <sultanxda@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 18/54] ip_tunnel: Fix name string concatenate in __ip_tunnel_create()
Date:   Tue, 11 Dec 2018 16:41:06 +0100
Message-Id: <20181211151547.004615385@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sultan Alsawaf <sultanxda@gmail.com>

commit 000ade8016400d93b4d7c89970d96b8c14773d45 upstream.

By passing a limit of 2 bytes to strncat, strncat is limited to writing
fewer bytes than what it's supposed to append to the name here.

Since the bounds are checked on the line above this, just remove the string
bounds checks entirely since they're unneeded.

Signed-off-by: Sultan Alsawaf <sultanxda@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/ip_tunnel.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -310,8 +310,8 @@ static struct net_device *__ip_tunnel_cr
 	} else {
 		if (strlen(ops->kind) > (IFNAMSIZ - 3))
 			goto failed;
-		strlcpy(name, ops->kind, IFNAMSIZ);
-		strncat(name, "%d", 2);
+		strcpy(name, ops->kind);
+		strcat(name, "%d");
 	}
 
 	ASSERT_RTNL();


