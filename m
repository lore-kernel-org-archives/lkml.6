Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE201C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05D32077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05D32077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733021AbeHWMRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:17:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50830 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbeHWMRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:17:06 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7AFBC941;
        Thu, 23 Aug 2018 08:48:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 070/324] net: propagate dev_get_valid_name return code
Date:   Thu, 23 Aug 2018 09:52:16 +0200
Message-Id: <20180823074959.434901406@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit 7892bd081045222b9e4027fec279a28d6fe7aa66 ]

if dev_get_valid_name failed, propagate its return code

and remove the setting err to ENODEV, it will be set to
0 again before dev_change_net_namespace exits.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8608,7 +8608,8 @@ int dev_change_net_namespace(struct net_
 		/* We get here if we can't use the current device name */
 		if (!pat)
 			goto out;
-		if (dev_get_valid_name(net, dev, pat) < 0)
+		err = dev_get_valid_name(net, dev, pat);
+		if (err < 0)
 			goto out;
 	}
 
@@ -8620,7 +8621,6 @@ int dev_change_net_namespace(struct net_
 	dev_close(dev);
 
 	/* And unlink it from device chain */
-	err = -ENODEV;
 	unlist_netdevice(dev);
 
 	synchronize_net();


