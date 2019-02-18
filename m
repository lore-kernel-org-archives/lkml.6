Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32782C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA058204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498899;
	bh=3afvL7LUJlKCba6bm8M/6TxIxYqltafst52lmGl9mb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nKBRtKf6i9+WuKtc08JSOQHcvI3mvi1SOfp2pcrTMOzA2PiaRSZ8W/Nsd30aC6tZ8
	 ApVxzz+E646OkdvZf6DQCYGyffIylJ7eoLCUy7wiQlSyJa5bWr00AJI2iyqkz5InNo
	 2/WVAC5scTUWJv4vI0kcoj/qPbPyXDAukddGyYN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390612AbfBROIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:08:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390537AbfBROIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:08:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCE7E204FD;
        Mon, 18 Feb 2019 14:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498895;
        bh=3afvL7LUJlKCba6bm8M/6TxIxYqltafst52lmGl9mb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xpbknEqacaH/STjtfrUkoID9cyFOyH70JQ9LbraWWvv6fq2Ylpk548bn1OsL3xwMo
         RTn0e86TSPYJLsIRimmbW9jtOzFfF5yEV/nk7YiOuvXhQY+PBBPIB2JC+cNsHAjBK9
         eilHhMlybYMBcNM+XWBBdb7ULpJjWuD1MH/AdpME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 012/108] soc/tegra: Dont leak device tree node reference
Date:   Mon, 18 Feb 2019 14:43:08 +0100
Message-Id: <20190218133520.078107277@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

[ Upstream commit 9eb40fa2cd2d1f6829e7b49bb22692f754b9cfe0 ]

of_find_node_by_path() acquires a reference to the node returned by it
and that reference needs to be dropped by its caller. soc_is_tegra()
doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
[treding: slightly rewrite to avoid inline comparison]
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/tegra/common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index a71cb74f3674..04323ade15dd 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -20,11 +20,15 @@ static const struct of_device_id tegra_machine_match[] = {
 
 bool soc_is_tegra(void)
 {
+	const struct of_device_id *match;
 	struct device_node *root;
 
 	root = of_find_node_by_path("/");
 	if (!root)
 		return false;
 
-	return of_match_node(tegra_machine_match, root) != NULL;
+	match = of_match_node(tegra_machine_match, root);
+	of_node_put(root);
+
+	return match != NULL;
 }
-- 
2.19.1



