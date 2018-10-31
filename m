Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A69CECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D403F2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wji3cMJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D403F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbeKAII6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730085AbeKAII5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C99E20847;
        Wed, 31 Oct 2018 23:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027326;
        bh=7z0022tJJsMycd82ZqF16jSjmn3Fa0IV68xZFZQFQgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wji3cMJZKCycGoxg+13TriY+/O6GD2V+c0nTCZWN3KaP1jB3WZVJcso0TID/L5DUw
         31MxbMNRA8aPm7haOYknTdVlTLXx9ezXk9MyGfjjx8of3yn5KkC2bCxG45C1sTx1/+
         oQl5Rj+3/ngo7LkD6dyZvcQgW26S+ON0t2XB2RCI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 057/126] failover: Add missing check to validate 'slave_dev' in net_failover_slave_unregister
Date:   Wed, 31 Oct 2018 19:06:45 -0400
Message-Id: <20181031230754.29029-57-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 9e7e6cabf371cc008cb2244a04c012b516753693 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/net_failover.c: In function 'net_failover_slave_unregister':
drivers/net/net_failover.c:598:35: warning:
 variable 'primary_dev' set but not used [-Wunused-but-set-variable]

There should check the validity of 'slave_dev'.

Fixes: cfc80d9a1163 ("net: Introduce net_failover driver")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/net_failover.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index 4f390fa557e4..8ec02f1a3be8 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -602,6 +602,9 @@ static int net_failover_slave_unregister(struct net_device *slave_dev,
 	primary_dev = rtnl_dereference(nfo_info->primary_dev);
 	standby_dev = rtnl_dereference(nfo_info->standby_dev);
 
+	if (WARN_ON_ONCE(slave_dev != primary_dev && slave_dev != standby_dev))
+		return -ENODEV;
+
 	vlan_vids_del_by_dev(slave_dev, failover_dev);
 	dev_uc_unsync(slave_dev, failover_dev);
 	dev_mc_unsync(slave_dev, failover_dev);
-- 
2.17.1

