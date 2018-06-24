Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2DEC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FBB24FFD
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FBB24FFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755249AbeFXPe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:34:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59382 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753244AbeFXPew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:34:52 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7C5D349F;
        Sun, 24 Jun 2018 15:34:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiangning Yu <yuxiangning@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 01/64] bonding: re-evaluate force_primary when the primary slave name changes
Date:   Sun, 24 Jun 2018 23:21:42 +0800
Message-Id: <20180624142743.717951031@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142743.613370789@linuxfoundation.org>
References: <20180624142743.613370789@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiangning Yu <yuxiangning@gmail.com>

[ Upstream commit eb55bbf865d9979098c6a7a17cbdb41237ece951 ]

There is a timing issue under active-standy mode, when bond_enslave() is
called, bond->params.primary might not be initialized yet.

Any time the primary slave string changes, bond->force_primary should be
set to true to make sure the primary becomes the active slave.

Signed-off-by: Xiangning Yu <yuxiangning@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_options.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1142,6 +1142,7 @@ static int bond_option_primary_set(struc
 				   slave->dev->name);
 			rcu_assign_pointer(bond->primary_slave, slave);
 			strcpy(bond->params.primary, slave->dev->name);
+			bond->force_primary = true;
 			bond_select_active_slave(bond);
 			goto out;
 		}


