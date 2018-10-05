Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7145EC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF6E208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1p3KtgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF6E208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbeJEXTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729607AbeJEXRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:17:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3637214C3;
        Fri,  5 Oct 2018 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756264;
        bh=5yNGz1oHRU3ssk+1bJFTjw9mhiE2+foNVJ7pF1LRMFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1p3KtgUYcJ0jGCCZt4zZF/bZuCNySX5IVjTAAQQa57qggN0P+zMmtWZ6QUEBzQ0v
         10/Ab+qJAVxdMMz1ihlRY9BZ7uwvLJHBOEvkL+KWUDnbqrYSofm7zU1t10LOeolRVz
         3s8S6b5lLoyOn5QX5FsysZjErhC9RX5f4hcGA6cQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jongsung Kim <neidhard.kim@lge.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 06/11] stmmac: fix valid numbers of unicast filter entries
Date:   Fri,  5 Oct 2018 12:17:31 -0400
Message-Id: <20181005161736.20765-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161736.20765-1-sashal@kernel.org>
References: <20181005161736.20765-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jongsung Kim <neidhard.kim@lge.com>

[ Upstream commit edf2ef7242805e53ec2e0841db26e06d8bc7da70 ]

Synopsys DWC Ethernet MAC can be configured to have 1..32, 64, or
128 unicast filter entries. (Table 7-8 MAC Address Registers from
databook) Fix dwmac1000_validate_ucast_entries() to accept values
between 1 and 32 in addition.

Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index d02691ba3d7f..20aa34f45f07 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -71,7 +71,7 @@ static int dwmac1000_validate_mcast_bins(int mcast_bins)
  * Description:
  * This function validates the number of Unicast address entries supported
  * by a particular Synopsys 10/100/1000 controller. The Synopsys controller
- * supports 1, 32, 64, or 128 Unicast filter entries for it's Unicast filter
+ * supports 1..32, 64, or 128 Unicast filter entries for it's Unicast filter
  * logic. This function validates a valid, supported configuration is
  * selected, and defaults to 1 Unicast address if an unsupported
  * configuration is selected.
@@ -81,8 +81,7 @@ static int dwmac1000_validate_ucast_entries(int ucast_entries)
 	int x = ucast_entries;
 
 	switch (x) {
-	case 1:
-	case 32:
+	case 1 ... 32:
 	case 64:
 	case 128:
 		break;
-- 
2.17.1

