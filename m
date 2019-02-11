Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC059C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34DF218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901064;
	bh=ZfrjwEx0Pf/2cY1GIoN0+cJKPY1I3bkE/JCIaWwSo5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w5DoLtRPjo8Ttirg5xrHgugRUEdwsDOG4kjk6k1Ip/GIr4JwNFb2n1OmSKswaCN9v
	 /1+gJPDX0aG5EI0SwjYsGWXtqtLXshoIt4sPgSg+K9DiAcL4W3y+LpBRZD88DZH1cG
	 cBPzDXTMOaSRbT+R6gzOtXTYV194L9v/sFDzjb5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfBKQEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:04:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbfBKO2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:28:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4D6F20838;
        Mon, 11 Feb 2019 14:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895321;
        bh=ZfrjwEx0Pf/2cY1GIoN0+cJKPY1I3bkE/JCIaWwSo5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WtMluyrBQpCmL76pivmW1kcTbTKNMuC8FzUYbbacvN1NCgR9V0xDp9NfF95R9XStY
         jp6wPCxf4oLE7S703DVXwb6V0g+FjoH3I887oqR8VFukHiU+BC5gM1DtuiaF63kFJY
         KXuzfFR4j4t5a4cZHSM3OMHooRXSkQh+wgsLLxOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 166/352] clk: qcom: Leave mmss noc on for 8998
Date:   Mon, 11 Feb 2019 15:16:33 +0100
Message-Id: <20190211141857.557760461@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 12eced09cd301aa7b1868a67c50a651c2aacd363 ]

Similar to other qcom targets, gcc_mmss_noc_cfg_ahb_clk should not be
disabled.  Any mmss access depends on this clock, and its been observed
that enabling mmssnoc_axi_rpm_clk with rpmcc results in an implicit
access to mmss and will crash the system if gcc_mmss_noc_cfg_ahb_clk is
disabled.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Fixes: 4807c71cc688 (arm64: dts: Add msm8998 SoC and MTP board support)
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-msm8998.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index 9f0ae403d5f5..cb714c3e2924 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -2042,6 +2042,12 @@ static struct clk_branch gcc_mmss_noc_cfg_ahb_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_mmss_noc_cfg_ahb_clk",
 			.ops = &clk_branch2_ops,
+			/*
+			 * Any access to mmss depends on this clock.
+			 * Gating this clock has been shown to crash the system
+			 * when mmssnoc_axi_rpm_clk is inited in rpmcc.
+			 */
+			.flags = CLK_IS_CRITICAL,
 		},
 	},
 };
-- 
2.19.1



