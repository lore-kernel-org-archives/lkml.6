Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B457C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72A921477
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRTGfo0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72A921477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbeJKXEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJKXEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:04:23 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D09A621470;
        Thu, 11 Oct 2018 15:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272201;
        bh=OnTHbKnAjq1vTIaXeQSLsoRaxWr0JeQcEf+8Z+T+z2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WRTGfo0S4aKibGJz0hSv7CgsV5cNmLFMKLU7+WmPt8e9bvCoGCjZUgon7ETBIOwsJ
         XL/dl/BQyvuAshuJ1Ka+HUI6h/+Vnce3KSlZWnSFsmzwtIlCsB0a9+5h4NZmhQ1Cze
         0k9jq1AYFnfyzf7arwhOprsg65J9JjO8Tek7oQ40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Willy Tarreau <w@1wt.eu>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 007/120] net/appletalk: fix minor pointer leak to userspace in SIOCFINDIPDDPRT
Date:   Thu, 11 Oct 2018 17:33:08 +0200
Message-Id: <20181011152549.820257098@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willy Tarreau <w@1wt.eu>

[ Upstream commit 9824dfae5741275473a23a7ed5756c7b6efacc9d ]

Fields ->dev and ->next of struct ipddp_route may be copied to
userspace on the SIOCFINDIPDDPRT ioctl. This is only accessible
to CAP_NET_ADMIN though. Let's manually copy the relevant fields
instead of using memcpy().

BugLink: http://blog.infosectcbr.com.au/2018/09/linux-kernel-infoleaks.html
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/appletalk/ipddp.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/net/appletalk/ipddp.c
+++ b/drivers/net/appletalk/ipddp.c
@@ -284,8 +284,12 @@ static int ipddp_ioctl(struct net_device
                 case SIOCFINDIPDDPRT:
 			spin_lock_bh(&ipddp_route_lock);
 			rp = __ipddp_find_route(&rcp);
-			if (rp)
-				memcpy(&rcp2, rp, sizeof(rcp2));
+			if (rp) {
+				memset(&rcp2, 0, sizeof(rcp2));
+				rcp2.ip    = rp->ip;
+				rcp2.at    = rp->at;
+				rcp2.flags = rp->flags;
+			}
 			spin_unlock_bh(&ipddp_route_lock);
 
 			if (rp) {


