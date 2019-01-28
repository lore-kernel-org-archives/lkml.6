Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301ADC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033112175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694965;
	bh=3UflcYX6xzicA00MPkobu64i0dS15WbeL7pzIXD4VnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=moAgJt4yLJSDf4H9ij/AEKZZuW2ZS1BlrMal8ZFzv99S0Uy7QIxFpiOT/WMO/p6nU
	 OU55+Lp4LDEkerXIuHBhMrAt8wP7Tq2ew/MLhyK/xPFnbhB6SZ9N8ErbvKWC6AE4M5
	 UtErTpmOuudjiV3Sbr0BlCCV0EhuP6S77F2TxLfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbfA1RCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:02:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387574AbfA1QOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:14:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B53E42086C;
        Mon, 28 Jan 2019 16:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692048;
        bh=3UflcYX6xzicA00MPkobu64i0dS15WbeL7pzIXD4VnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pwDTEXHI6+B3aLWWgTIqGMHu6UwESZ6Qoqu/Z3Y1Ec1ut54kFL47baf+YPpFUwApV
         1tadckyuBE4GsGzHr97zrZg4B2lYZZMZajFUYqzEldoN2m1ldAjrHzKUzxrmZPppY7
         +/GX1FanOAfvG6kG+quvLMmH9SUBmQjNxpbQEgtI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 052/170] soc: bcm: brcmstb: Don't leak device tree node reference
Date:   Mon, 28 Jan 2019 11:10:02 -0500
Message-Id: <20190128161200.55107-52-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit 1861a7f07e02292830a1ca256328d370deefea30 ]

of_find_node_by_path() acquires a reference to the node returned by it
and that reference needs to be dropped by its caller. soc_is_brcmstb()
doesn't do that, so fix it.

[treding: slightly rewrite to avoid inline comparison]

Fixes: d52fad262041 ("soc: add stubs for brcmstb SoC's")
Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/bcm/brcmstb/common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
index 22e98a90468c..2f5ec424a390 100644
--- a/drivers/soc/bcm/brcmstb/common.c
+++ b/drivers/soc/bcm/brcmstb/common.c
@@ -31,13 +31,17 @@ static const struct of_device_id brcmstb_machine_match[] = {
 
 bool soc_is_brcmstb(void)
 {
+	const struct of_device_id *match;
 	struct device_node *root;
 
 	root = of_find_node_by_path("/");
 	if (!root)
 		return false;
 
-	return of_match_node(brcmstb_machine_match, root) != NULL;
+	match = of_match_node(brcmstb_machine_match, root);
+	of_node_put(root);
+
+	return match != NULL;
 }
 
 static const struct of_device_id sun_top_ctrl_match[] = {
-- 
2.19.1

