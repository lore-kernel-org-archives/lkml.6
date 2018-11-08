Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84117C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA5E20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQJMhtFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA5E20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbeKIH5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:57:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730850AbeKIHns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:48 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9816F21019;
        Thu,  8 Nov 2018 22:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714777;
        bh=n3aeXXiZlJMJTmyJ7CWWK7L52nB/kdzUx1ej7Zf3igQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQJMhtFggMUOPGDGMlaDdSyFzZIwaLda3j+v2L+xniJlRXhmqRzAUH/EmX/emoWSr
         8R4RnExULB5o983RkKWCtCG6DuA+imBn1LKhRXnOaZPJFLvWEE+ZO8LXyxOGhc7zZz
         fjJaYAVvE+hkt5jDCdk+xMg7DeP+iJC9WOk58Dnc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Born <futur.andy@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 118/171] bonding: ratelimit failed speed/duplex update warning
Date:   Thu,  8 Nov 2018 13:51:28 -0800
Message-Id: <20181108215135.853334124@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 11e9d7829dd08dbafb24517fe922f11c3a8a9dc2 ]

bond_miimon_commit() handles the UP transition for each slave of a bond
in the case of MII. It is triggered 10 times per second for the default
MII Polling interval of 100ms. For device drivers that do not implement
__ethtool_get_link_ksettings() the call to bond_update_speed_duplex()
fails persistently while the MII status could remain UP. That is, in
this and other cases where the speed/duplex update keeps failing over a
longer period of time while the MII state is UP, a warning is printed
every MII polling interval.

To address these excessive warnings net_ratelimit() should be used.
Printing a warning once would not be sufficient since the call to
bond_update_speed_duplex() could recover to succeed and fail again
later. In that case there would be no new indication what went wrong.

Fixes: b5bf0f5b16b9c (bonding: correctly update link status during mii-commit phase)
Signed-off-by: Andreas Born <futur.andy@googlemail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b1ea29d8ad1a..389d1db69a32 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2132,9 +2132,10 @@ static void bond_miimon_commit(struct bonding *bond)
 			if (bond_update_speed_duplex(slave) &&
 			    bond_needs_speed_duplex(bond)) {
 				slave->link = BOND_LINK_DOWN;
-				netdev_warn(bond->dev,
-					    "failed to get link speed/duplex for %s\n",
-					    slave->dev->name);
+				if (net_ratelimit())
+					netdev_warn(bond->dev,
+						    "failed to get link speed/duplex for %s\n",
+						    slave->dev->name);
 				continue;
 			}
 			bond_set_slave_link_state(slave, BOND_LINK_UP,
-- 
2.17.1



