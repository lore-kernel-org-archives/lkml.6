Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92006C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F192075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760178;
	bh=40nZ95VBEO+58iX3mE8hOj7IF2ruqMtk8mNk6ngSjQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aSUakWJO41BmhCo408zIdhKky1WHqSUqS8w53cdpZkGKGjW3m+bAiZqodSUSWWmPQ
	 ogND5FOZhIeoO92kn5FIxTTpHGTFlwb+ObqxKuKw8k/jv6H6CHah2I4A4mbJUogkbq
	 uhg09AoRUJlGFREkH7Ed4sP60WCfNkTCUNh3+stQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfBUOm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:42:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbfBUOmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:42:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0116920838;
        Thu, 21 Feb 2019 14:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760173;
        bh=40nZ95VBEO+58iX3mE8hOj7IF2ruqMtk8mNk6ngSjQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wzQYALe1ilKHjwMhIlA212j0BVWtTHmbC6uMSFy7eX0b9tfbmBkvR7OZ9GIbkK5CW
         qA8l5E8kszWXsz9+DLRBfhj/iY/1zMWZqJcREUPy1skrAAvtiZupUvpuoNsKOvBMn9
         LcbiPVDdWbJFRGFV4uZQQtoFTOrjrlK7U6Tw6Esw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 19/32] net: netcp: Fix ethss driver probe issue
Date:   Thu, 21 Feb 2019 15:36:07 +0100
Message-Id: <20190221125252.017486723@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.855065214@linuxfoundation.org>
References: <20190221125250.855065214@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1f43f400a2cbb02f3d34de8fe30075c070254816 ]

Recent commit below has introduced a bug in netcp driver that causes
the ethss driver probe failure and thus break the networking function
on K2 SoCs such as K2HK, K2L, K2E etc. This patch fixes the issue to
restore networking on the above SoCs.

Fixes: 21c328dcecfc ("net: ethernet: Convert to using %pOFn instead of device_node.name")
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/netcp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index 1f612268c9987..d847f672a705f 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -259,7 +259,7 @@ static int netcp_module_probe(struct netcp_device *netcp_device,
 		const char *name;
 		char node_name[32];
 
-		if (of_property_read_string(node, "label", &name) < 0) {
+		if (of_property_read_string(child, "label", &name) < 0) {
 			snprintf(node_name, sizeof(node_name), "%pOFn", child);
 			name = node_name;
 		}
-- 
2.19.1



