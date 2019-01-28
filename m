Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25963C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E896C2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697288;
	bh=DFqmGOJ3LBP+z8Wjz8u/2EGfM5QptJOFDIpszZXQ/0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oCa+p4i+Kl1sx60ffiZUytPI+xWSlhajQUTQ8qgBNDGRKtYuvaTt8RVo4xtz038hf
	 2hPHdfJ2PHh/Bo4DjXJg0I4gSYVrlPvuzGuHsLyaEJzkhzlyzqslP0vHHHLI38Uvb5
	 Tg6NCksmZujbvaKK+nBJ9+pDvPqumND0S9Hf2vxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfA1Rl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:41:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbfA1PvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:51:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25E122147A;
        Mon, 28 Jan 2019 15:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690662;
        bh=DFqmGOJ3LBP+z8Wjz8u/2EGfM5QptJOFDIpszZXQ/0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9Owtn/FTRoSWicFs7mdTH3Pl+XonWVQZlqdCJADLOkAD7EkS9WmuN+sObMx9H6PD
         lrAv0ScTwMTvmXQ3e4qXFkIcWGgENj5h++PX5BMvvXBG0DUEc5CFRdnmgWnw+DqPb3
         sCNjUjyas3mub3UK9cQmcEGud7fsZ0ekQL6Hh8og=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 158/304] cpuidle: big.LITTLE: fix refcount leak
Date:   Mon, 28 Jan 2019 10:41:15 -0500
Message-Id: <20190128154341.47195-158-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit 9456823c842f346c74265fcd98d008d87a7eb6f5 ]

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
bl_idle_init() doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/cpuidle-big_little.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index db2ede565f1a..b44476a1b7ad 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -167,6 +167,7 @@ static int __init bl_idle_init(void)
 {
 	int ret;
 	struct device_node *root = of_find_node_by_path("/");
+	const struct of_device_id *match_id;
 
 	if (!root)
 		return -ENODEV;
@@ -174,7 +175,11 @@ static int __init bl_idle_init(void)
 	/*
 	 * Initialize the driver just for a compliant set of machines
 	 */
-	if (!of_match_node(compatible_machine_match, root))
+	match_id = of_match_node(compatible_machine_match, root);
+
+	of_node_put(root);
+
+	if (!match_id)
 		return -ENODEV;
 
 	if (!mcpm_is_available())
-- 
2.19.1

