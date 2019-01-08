Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C367DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEE12063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976874;
	bh=KVNXNmTOaEvwkEYE7FZ9p2DyCjwJD5x93HzUo829AwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BHtFEpzGULFcKqF5gWfxS69LzzSU3dI84A1eBvuIt8tkyROIAaop9fjMIH5/Zqutx
	 SUYRNNDLDJMkRPXqCxN2vTSt2xGNzUZqDfkdVuHmp9t+vW3QsHGKES+hMvvnt+8XpT
	 ++M0ibex1ua5MdlYHSe2+MXwcf75fkNsw1sOFPpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbfAHTrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730774AbfAHTcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:32:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D755020665;
        Tue,  8 Jan 2019 19:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975961;
        bh=KVNXNmTOaEvwkEYE7FZ9p2DyCjwJD5x93HzUo829AwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNbYraLmi4A23aEX+z176lJsRsaN7OzWPWP+i791WrtPi7sTUrcXy5WVcFsPf4SKG
         7A6+60sElNraPGSwQYuXNBIqHpViaFfKC+eMalFxkUea+WI43sivOfJIdh1FT+r6ko
         Q+Ag16jUMXQgmGy2kAaxA67+EoSJZrULh3z88LlY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 09/53] arm64: perf: set suppress_bind_attrs flag to true
Date:   Tue,  8 Jan 2019 14:31:37 -0500
Message-Id: <20190108193222.123316-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193222.123316-1-sashal@kernel.org>
References: <20190108193222.123316-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

[ Upstream commit 81e9fa8bab381f8b6eb04df7cdf0f71994099bd4 ]

The armv8_pmuv3 driver doesn't have a remove function, and when the test
'CONFIG_DEBUG_TEST_DRIVER_REMOVE=y' is enabled, the following Call trace
can be seen.

[    1.424287] Failed to register pmu: armv8_pmuv3, reason -17
[    1.424870] WARNING: CPU: 0 PID: 1 at ../kernel/events/core.c:11771 perf_event_sysfs_init+0x98/0xdc
[    1.425220] Modules linked in:
[    1.425531] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         4.19.0-rc7-next-20181012-00003-ge7a97b1ad77b-dirty #35
[    1.425951] Hardware name: linux,dummy-virt (DT)
[    1.426212] pstate: 80000005 (Nzcv daif -PAN -UAO)
[    1.426458] pc : perf_event_sysfs_init+0x98/0xdc
[    1.426720] lr : perf_event_sysfs_init+0x98/0xdc
[    1.426908] sp : ffff00000804bd50
[    1.427077] x29: ffff00000804bd50 x28: ffff00000934e078
[    1.427429] x27: ffff000009546000 x26: 0000000000000007
[    1.427757] x25: ffff000009280710 x24: 00000000ffffffef
[    1.428086] x23: ffff000009408000 x22: 0000000000000000
[    1.428415] x21: ffff000009136008 x20: ffff000009408730
[    1.428744] x19: ffff80007b20b400 x18: 000000000000000a
[    1.429075] x17: 0000000000000000 x16: 0000000000000000
[    1.429418] x15: 0000000000000400 x14: 2e79726f74636572
[    1.429748] x13: 696420656d617320 x12: 656874206e692065
[    1.430060] x11: 6d616e20656d6173 x10: 2065687420687469
[    1.430335] x9 : ffff00000804bd50 x8 : 206e6f7361657220
[    1.430610] x7 : 2c3376756d705f38 x6 : ffff00000954d7ce
[    1.430880] x5 : 0000000000000000 x4 : 0000000000000000
[    1.431226] x3 : 0000000000000000 x2 : ffffffffffffffff
[    1.431554] x1 : 4d151327adc50b00 x0 : 0000000000000000
[    1.431868] Call trace:
[    1.432102]  perf_event_sysfs_init+0x98/0xdc
[    1.432382]  do_one_initcall+0x6c/0x1a8
[    1.432637]  kernel_init_freeable+0x1bc/0x280
[    1.432905]  kernel_init+0x18/0x160
[    1.433115]  ret_from_fork+0x10/0x18
[    1.433297] ---[ end trace 27fd415390eb9883 ]---

Rework to set suppress_bind_attrs flag to avoid removing the device when
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y, since there's no real reason to
remove the armv8_pmuv3 driver.

Cc: Arnd Bergmann <arnd@arndb.de>
Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/perf_event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 86249a24592d..05fdae70e9f6 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1130,6 +1130,7 @@ static struct platform_driver armv8_pmu_driver = {
 	.driver		= {
 		.name	= ARMV8_PMU_PDEV_NAME,
 		.of_match_table = armv8_pmu_of_device_ids,
+		.suppress_bind_attrs = true,
 	},
 	.probe		= armv8_pmu_device_probe,
 };
-- 
2.19.1

