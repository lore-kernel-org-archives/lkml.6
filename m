Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DB9C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB61120878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108008;
	bh=tKyOmMG0DXVaPs+cFexGrbea1fbDg/Qmx+THbeRCPAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kb11jd/A/pXiGYv50xnM+8Lw3vGeTXJJ2YakrCucjxRWWEqPIDnAWuiWuu/nKQdXN
	 vhHhu/WFsW7HD0kM2FFWOc1O4JNMLYXWcYu3ZNdQ8XU+0qtFZOCSarE18LnHPYKtlY
	 y/wqiP4upMn3RutxJer3F7FrwVGzotmcTJrjerGA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB61120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeLFOx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:53:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731039AbeLFOp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:45:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87D5C20892;
        Thu,  6 Dec 2018 14:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107526;
        bh=tKyOmMG0DXVaPs+cFexGrbea1fbDg/Qmx+THbeRCPAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oDqwPfHGwDO3MtIoD4Siy0E5ukf6AM/Zu1YjQH3lPkLkBHnpAaKJ7RVQCZ2kGzIsy
         C3Az+mOou8PKUELCMurdCeGbO1k4zIHxUXR1c5dD/TRwbjVUvr0t/lM3A9aOoCFRvI
         jsBYG/JpSXtPvKfJ0j5yfvEtgJqga7XBLCLpCZhs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sultan Alsawaf <sultanxda@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 007/101] ip_tunnel: Fix name string concatenate in __ip_tunnel_create()
Date:   Thu,  6 Dec 2018 15:38:06 +0100
Message-Id: <20181206143012.027549735@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -261,8 +261,8 @@ static struct net_device *__ip_tunnel_cr
 	} else {
 		if (strlen(ops->kind) > (IFNAMSIZ - 3))
 			goto failed;
-		strlcpy(name, ops->kind, IFNAMSIZ);
-		strncat(name, "%d", 2);
+		strcpy(name, ops->kind);
+		strcat(name, "%d");
 	}
 
 	ASSERT_RTNL();


