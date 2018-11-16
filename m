Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E6BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139792087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139792087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390032AbeKQBNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:13:23 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:60899 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389903AbeKQBNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 20:13:23 -0500
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie6.idc.renesas.com with ESMTP; 17 Nov 2018 00:00:38 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id C70ECE3B5E;
        Sat, 17 Nov 2018 00:00:38 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.56,240,1539615600"; 
   d="scan'208";a="297674585"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii2.idc.renesas.com with ESMTP; 17 Nov 2018 00:00:36 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@linux-mips.org
Subject: [PATCH v6 4/6] MIPS: AR7: Add clk_get_optional() function
Date:   Fri, 16 Nov 2018 14:59:35 +0000
Message-Id: <20181116145937.27660-5-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181116145937.27660-1-phil.edworthy@renesas.com>
References: <20181116145937.27660-1-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_get_optional() returns NULL if not found instead of -ENOENT,
otherwise the behaviour is the same as clk_get().

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/mips/ar7/clock.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/ar7/clock.c b/arch/mips/ar7/clock.c
index 6b64fd96dba8..b13f763948b1 100644
--- a/arch/mips/ar7/clock.c
+++ b/arch/mips/ar7/clock.c
@@ -454,6 +454,17 @@ struct clk *clk_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL(clk_get);
 
+struct clk *clk_get_optional(struct device *dev, const char *id)
+{
+	struct clk *clk = clk_get(dev, id);
+
+	if (clk == ERR_PTR(-ENOENT))
+		clk = NULL;
+
+	return clk;
+}
+EXPORT_SYMBOL(clk_get_optional);
+
 void clk_put(struct clk *clk)
 {
 }
-- 
2.17.1

