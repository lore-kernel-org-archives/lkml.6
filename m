Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7DFC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA1D21855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900000;
	bh=YVuDz8Bfp6Em5DuvIbVOjNB2mFz6e1FITTZB0U0MUwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=up98uDYheTly7mPeKUbYawfHWxNiJYUf8+4Yv/Y02SpkEb6IhPYk94MvjDM7fI4jz
	 kI3Rr1W1O/IKwFinCL3P4Z3hjh9F/gHELBUdmjKzrKO2wdX16rjm3bn8YcRqX/1oyE
	 l7M4dj7xUg9KYs9TIl7FBM/Y4U9Jw7tHlCAPr1X8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbfBKPqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:46:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:54030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732002AbfBKOmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:42:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0783021B18;
        Mon, 11 Feb 2019 14:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896135;
        bh=YVuDz8Bfp6Em5DuvIbVOjNB2mFz6e1FITTZB0U0MUwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ck6AHI34oecWaiZkxuW6AiZ/ibMqw8y5jzW09UCWjSvVlYOOigr7vtMZEAXo+MN7Z
         n2e+sa1FVr6b4V56Pvx4/Qkzv1wMxX2Wib1sEWIHgJvW55oPDMzy6SsgsYgbtdeYtc
         NP4C2u182OOwO7ddvOBRBpDXX0waUmF5uZvdiFys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 057/313] clk: meson: meson8b: mark the CPU clock as CLK_IS_CRITICAL
Date:   Mon, 11 Feb 2019 15:15:37 +0100
Message-Id: <20190211141857.623286559@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit 0dad1ec65bc30a549aba38d34a727309bbf41bc8 ]

We don't want the common clock framework to disable the "cpu_clk" if
it's not used by any device. The cpufreq-dt driver does not enable the
CPU clocks. However, even if it would we would still want the CPU clock
to be enabled at all times because the CPU clock is also required even
if we disable CPU frequency scaling on a specific board.

The reason why we want the CPU clock to be enabled is a clock further up
in the tree:
Since commit 6f888e7bc7bd58 ("clk: meson: clk-pll: add enable bit") the
sys_pll can be disabled. However, since the CPU clock is derived from
sys_pll we don't want sys_pll to get disabled. The common clock
framework takes care of that for us by enabling all parent clocks of our
CPU clock when we mark the CPU clock with CLK_IS_CRITICAL.

Until now this is not a problem yet because all clocks in the CPU
clock's tree (including sys_pll) are read-only. However, once we allow
modifications to the clocks in that tree we will need this.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lkml.kernel.org/r/20181115224048.13511-4-martin.blumenstingl@googlemail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/meson8b.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 0da8334f2e43..9d79ff857d83 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -634,7 +634,8 @@ static struct clk_regmap meson8b_cpu_clk = {
 						  "cpu_scale_out_sel" },
 		.num_parents = 2,
 		.flags = (CLK_SET_RATE_PARENT |
-			  CLK_SET_RATE_NO_REPARENT),
+			  CLK_SET_RATE_NO_REPARENT |
+			  CLK_IS_CRITICAL),
 	},
 };
 
-- 
2.19.1



