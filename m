Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 61A3EC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B1F20020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xGcu9Cuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B1F20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965898AbeFNO1w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:27:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965924AbeFNOMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:12:00 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55B26208DA;
        Thu, 14 Jun 2018 14:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985519;
        bh=LJ61G/Ackj15gxlQdXoqpAFXhAcY30om4EHFnzZRlWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xGcu9Cuy/glFgmgNa9C4r9eJjWKpaMTS+qlr+ivnaEDezSt05igG4VRKeNXm36u0Z
         p6jAnUCWud2pFFHAZmSO6xOcfw/gFaeOyzhkq10ZKRoCY9vYFFVd0fk0d75wPqEEUu
         WDimkxs/xuSdcQ+Th5Vs3lecI7KVy7KhmjUMuAwQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mahesh Bandewar <maheshb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nate Clark <nate@neworld.us>
Subject: [PATCH 4.9 02/30] bonding: correctly update link status during mii-commit phase
Date:   Thu, 14 Jun 2018 16:04:43 +0200
Message-Id: <20180614132600.351187645@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132600.255515394@linuxfoundation.org>
References: <20180614132600.255515394@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mahesh Bandewar <maheshb@google.com>

commit b5bf0f5b16b9c316c34df9f31d4be8729eb86845 upstream.

bond_miimon_commit() marks the link UP after attempting to get the speed
and duplex settings for the link. There is a possibility that
bond_update_speed_duplex() could fail. This is another place where it
could result into an inconsistent bonding link state.

With this patch the link will be marked UP only if the speed and duplex
values retrieved have sane values and processed further.

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Nate Clark <nate@neworld.us>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/bonding/bond_main.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2140,7 +2140,12 @@ static void bond_miimon_commit(struct bo
 			continue;
 
 		case BOND_LINK_UP:
-			bond_update_speed_duplex(slave);
+			if (bond_update_speed_duplex(slave)) {
+				netdev_warn(bond->dev,
+					    "failed to get link speed/duplex for %s\n",
+					    slave->dev->name);
+				continue;
+			}
 			bond_set_slave_link_state(slave, BOND_LINK_UP,
 						  BOND_SLAVE_NOTIFY_NOW);
 			slave->last_link_up = jiffies;


