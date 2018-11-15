Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DA5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C132133D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C132133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbeKPIMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:12:42 -0500
Received: from muru.com ([72.249.23.125]:54108 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbeKPIMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:12:41 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 4B8098160;
        Thu, 15 Nov 2018 22:03:05 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] bus: ti-sysc: Fix getting optional clocks in clock_roles
Date:   Thu, 15 Nov 2018 14:02:36 -0800
Message-Id: <20181115220237.32129-2-tony@atomide.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115220237.32129-1-tony@atomide.com>
References: <20181115220237.32129-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can have holes in clock_roles with interface clock missing for
example. Currently getting an optional clock will fail if there are
only a functional clock and an optional clock.

Fixes: 09dfe5810762 ("bus: ti-sysc: Add handling for clkctrl opt clocks")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -214,8 +214,13 @@ static int sysc_get_clocks(struct sysc *ddata)
 	if (!ddata->clocks)
 		return -ENOMEM;
 
-	for (i = 0; i < ddata->nr_clocks; i++) {
-		error = sysc_get_one_clock(ddata, ddata->clock_roles[i]);
+	for (i = 0; i < SYSC_MAX_CLOCKS; i++) {
+		const char *name = ddata->clock_roles[i];
+
+		if (!name)
+			continue;
+
+		error = sysc_get_one_clock(ddata, name);
 		if (error && error != -ENOENT)
 			return error;
 	}
-- 
2.19.1
