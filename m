Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA2DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7ED2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498517;
	bh=Mc1Q5Htk+2Z8WtC2Vo6DGz5MOoqU7GfgI529GswZYp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z1G9zlwWlQJydZ5wWXP1aBGmLBdx81imK+ubON0QU/Mg8PEdIPm+r7c8d82dMwnP+
	 xHQ7e76/cuzBc/kklucK4mAZPFKc6FBTd9YLkvweEcJItE07jQkE8s+9mfAjkkIWxm
	 e4A+qmRw39l7eRC3bMJ4choV/VKN+usjJngG7U+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389215AbfBROBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:01:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:43442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389184AbfBROBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:01:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F31A2173C;
        Mon, 18 Feb 2019 14:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498512;
        bh=Mc1Q5Htk+2Z8WtC2Vo6DGz5MOoqU7GfgI529GswZYp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ci/793jMEH9zgsrWcjWfxKJ9hhGbnAJmkabms9A3wP2mTUZ0TMbIyvBj260NP4Tab
         UGiqS3bnCwwe8f51a9HC94wHgbsIQwHvYvNYzO0voaOBlEiStJvU/BU92ozWadMPXb
         A+koZV08sre1w8YJr+sAsh+toJ4apq3/tM34KBWU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 033/143] cpuidle: big.LITTLE: fix refcount leak
Date:   Mon, 18 Feb 2019 14:42:41 +0100
Message-Id: <20190218133530.347032435@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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



