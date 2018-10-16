Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCE0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B708D2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="laWZAbG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B708D2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbeJQBLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729960AbeJQBLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:11:03 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43DCF21476;
        Tue, 16 Oct 2018 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710378;
        bh=Oc23CUmSY9AQOsLrwRZlA+fCT/CtFsgQVLG6pk2XctY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=laWZAbG7o6cqsZY0CIYxErNDvPfvSR8KqOsm2Ri8c52DFSUSJOBw5kPNwvROZVinx
         pZ+1G0i65sdIOEXoj1gRjN6cIc+sCCPNdlUbSV3dO4+OAv5Z6LaI1q0P04R+monUot
         byxm9e/rHuORnwLcuiqvgN6S7Jw0pgxiiJcmF7Wo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 057/109] clk: x86: add "ether_clk" alias for Bay Trail / Cherry Trail
Date:   Tue, 16 Oct 2018 19:05:25 +0200
Message-Id: <20181016170528.007640940@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit b1e3454d39f992e5409cd19f97782185950df6e7 ]

Commit d31fd43c0f9a ("clk: x86: Do not gate clocks enabled by the
firmware") causes all unclaimed PMC clocks on Cherry Trail devices to be on
all the time, resulting on the device not being able to reach S0i2 or S0i3
when suspended.

The reason for this commit is that on some Bay Trail / Cherry Trail devices
the ethernet controller uses pmc_plt_clk_4. This commit adds an "ether_clk"
alias, so that the relevant ethernet drivers can try to (optionally) use
this, without needing X86 specific code / hacks, thus fixing ethernet on
these devices without breaking S0i3 support.

This commit uses clkdev_hw_create() to create the alias, mirroring the code
for the already existing "mclk" alias for pmc_plt_clk_3.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=193891#c102
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=196861
Cc: Johannes Stezenbach <js@sig21.net>
Cc: Carlo Caione <carlo@endlessm.com>
Reported-by: Johannes Stezenbach <js@sig21.net>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/x86/clk-pmc-atom.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/clk/x86/clk-pmc-atom.c
+++ b/drivers/clk/x86/clk-pmc-atom.c
@@ -55,6 +55,7 @@ struct clk_plt_data {
 	u8 nparents;
 	struct clk_plt *clks[PMC_CLK_NUM];
 	struct clk_lookup *mclk_lookup;
+	struct clk_lookup *ether_clk_lookup;
 };
 
 /* Return an index in parent table */
@@ -351,11 +352,20 @@ static int plt_clk_probe(struct platform
 		goto err_unreg_clk_plt;
 	}
 
+	data->ether_clk_lookup = clkdev_hw_create(&data->clks[4]->hw,
+						  "ether_clk", NULL);
+	if (!data->ether_clk_lookup) {
+		err = -ENOMEM;
+		goto err_drop_mclk;
+	}
+
 	plt_clk_free_parent_names_loop(parent_names, data->nparents);
 
 	platform_set_drvdata(pdev, data);
 	return 0;
 
+err_drop_mclk:
+	clkdev_drop(data->mclk_lookup);
 err_unreg_clk_plt:
 	plt_clk_unregister_loop(data, i);
 	plt_clk_unregister_parents(data);
@@ -369,6 +379,7 @@ static int plt_clk_remove(struct platfor
 
 	data = platform_get_drvdata(pdev);
 
+	clkdev_drop(data->ether_clk_lookup);
 	clkdev_drop(data->mclk_lookup);
 	plt_clk_unregister_loop(data, PMC_CLK_NUM);
 	plt_clk_unregister_parents(data);


