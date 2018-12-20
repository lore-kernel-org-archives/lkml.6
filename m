Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493DCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1469020989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298053;
	bh=5d62EFmZFLY6J7qTB81VCy2vakAYxgoqLgH7q7QX3Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BtnsXMNCwODCdkQaxgxJy4TBDc2/Sa9pPQ+VDJOKjyXKNMGi2Xk/9hMYe1pEkugjd
	 ZyVIDK3T/Qk98eomWoA750r82DAK00pCsmL3bNU8jUmqouAYJTP6M2UwTGf5ZHpMNZ
	 n4GzlYQXIWROfKHJQLzsKvQkF5pgMUYIDDjWsgLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbeLTJ1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:27:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730662AbeLTJ13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:27:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3242720656;
        Thu, 20 Dec 2018 09:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298048;
        bh=5d62EFmZFLY6J7qTB81VCy2vakAYxgoqLgH7q7QX3Uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kJlWSGDPnCJcO5UZm45xDFU2wsJXnI57YwicltLTGR2Gf3q1DGiOXLsHQeklp7Vo8
         cFbS/wriQnDXr5rSf/XJvmG1mEEFG0yRGydmVBwGXO1qk8H2X3i7GKYX/QoupTnrm/
         NBdlDAvfq/hAgBw5aSsFajghkpw/vcwSNeE4UyQA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 52/72] clk: mvebu: Off by one bugs in cp110_of_clk_get()
Date:   Thu, 20 Dec 2018 10:18:51 +0100
Message-Id: <20181220085924.390972656@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d9f5b7f5dd0fa74a89de5a7ac1e26366f211ccee ]

These > comparisons should be >= to prevent reading beyond the end of
of the clk_data->hws[] buffer.

The clk_data->hws[] array is allocated in cp110_syscon_common_probe()
when we do:
	cp110_clk_data = devm_kzalloc(dev, sizeof(*cp110_clk_data) +
				      sizeof(struct clk_hw *) * CP110_CLK_NUM,
				      GFP_KERNEL);
As you can see, it has CP110_CLK_NUM elements which is equivalent to
CP110_MAX_CORE_CLOCKS + CP110_MAX_GATABLE_CLOCKS.

Fixes: d3da3eaef7f4 ("clk: mvebu: new driver for Armada CP110 system controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mvebu/cp110-system-controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
index ca9a0a536174..05c127cafa46 100644
--- a/drivers/clk/mvebu/cp110-system-controller.c
+++ b/drivers/clk/mvebu/cp110-system-controller.c
@@ -203,11 +203,11 @@ static struct clk_hw *cp110_of_clk_get(struct of_phandle_args *clkspec,
 	unsigned int idx = clkspec->args[1];
 
 	if (type == CP110_CLK_TYPE_CORE) {
-		if (idx > CP110_MAX_CORE_CLOCKS)
+		if (idx >= CP110_MAX_CORE_CLOCKS)
 			return ERR_PTR(-EINVAL);
 		return clk_data->hws[idx];
 	} else if (type == CP110_CLK_TYPE_GATABLE) {
-		if (idx > CP110_MAX_GATABLE_CLOCKS)
+		if (idx >= CP110_MAX_GATABLE_CLOCKS)
 			return ERR_PTR(-EINVAL);
 		return clk_data->hws[CP110_MAX_CORE_CLOCKS + idx];
 	}
-- 
2.19.1



