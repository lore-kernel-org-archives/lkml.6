Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DF9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0A720989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298207;
	bh=QN2DfQulBi4c+sP6mUMXprXuaoA1v6lwjVoUI6c/1zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TIIz8Irk3IH0JRpZo5xEfSpkWZ4OTckfq7MKMtn5MDUv1nYPE1JMCfzGy/tMROVZL
	 QtTC0pDM6XmQW64L+1EaClt+tBQUEbTgkE6FhbmMcCBrLXZREB3RlzP5uqa7JG909c
	 S6vzEFbda1L4oEACzy3tHqO7TaYLAjvNGPbzTb1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbeLTJaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732841AbeLTJaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 831C720656;
        Thu, 20 Dec 2018 09:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298202;
        bh=QN2DfQulBi4c+sP6mUMXprXuaoA1v6lwjVoUI6c/1zU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qx1QRmQdlKDjzyuulHuceiLRvqoSIwdutZFvtxWoqn0G9aklMPSkGb23lZKpD+XsV
         RYgLCmocdWt7CXJ7U3ZyRV/19FJOreySrDByUMbUR6NcYrT3Eg+uebrjB7fl1OoujS
         JGs//gH5rb8dEOLSwPBBhOY8wzh15LXVXYcIuv9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 38/67] clk: mvebu: Off by one bugs in cp110_of_clk_get()
Date:   Thu, 20 Dec 2018 10:18:50 +0100
Message-Id: <20181220085905.046003129@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 75bf7b8f282f..0153c76d4a20 100644
--- a/drivers/clk/mvebu/cp110-system-controller.c
+++ b/drivers/clk/mvebu/cp110-system-controller.c
@@ -202,11 +202,11 @@ static struct clk_hw *cp110_of_clk_get(struct of_phandle_args *clkspec,
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



