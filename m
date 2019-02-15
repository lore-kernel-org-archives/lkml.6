Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9425AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5281E222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550256116;
	bh=/f4X5h5Uz0E9/Hw89kJt7keztwZFJtrZMZaFtttUkvQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=BBNwf3QUr57DdQuxm7BygCQKEmq0aIk259yWAfavp4xDIkCyaR3mhr0VEHa3G8Z3v
	 lgyoF5OZvO1e4fiOIZN2hscl6qy3yjjveY+VAJbIBYHZ/dK+r1YVFjlSjCYxxUuCOF
	 Lh+8zb3tarmR54fgPfccyaecXTqNpnq3EljIUzMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbfBOSly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:41:54 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34832 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbfBOSlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hT0TeovveznQK/E4WRRJOI7iJe39xDH+UGDQsWKQRrg=; b=DThQ/qZ/cQR9
        9Lz+noRCTd5uaVJgBeJSH9Duk5UaXxT6wo+FshPLho4PGGW/JD3m2cq6exg/ZsCD4kig9tJfRgUyE
        u5+VmzvyzBdE1U0RjSRe78n/iexA0e1TaEXKayBCXquHvc9k2+Y0vNq3rLZmBAmwHxYt0U9yPxuas
        31OF0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1guiQp-0000hX-4C; Fri, 15 Feb 2019 18:41:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B13F611286B7; Fri, 15 Feb 2019 18:41:50 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Take lock before applying system load" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190215184150.B13F611286B7@debutante.sirena.org.uk>
Date:   Fri, 15 Feb 2019 18:41:50 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Take lock before applying system load

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From e5e21f70bfd3a201e627b48aed82793d1bcd6f78 Mon Sep 17 00:00:00 2001
From: Niklas Cassel <niklas.cassel@linaro.org>
Date: Fri, 15 Feb 2019 11:55:33 +0100
Subject: [PATCH] regulator: core: Take lock before applying system load

Take the regulator lock before applying system load.

Fixes the following lockdep splat:

[    5.583581] WARNING: CPU: 1 PID: 16 at drivers/regulator/core.c:925 drms_uA_update+0x114/0x360
[    5.588467] Modules linked in:
[    5.596833] CPU: 1 PID: 16 Comm: kworker/1:0 Not tainted 5.0.0-rc6-next-20190213-00002-g0fce66ab480f #18
[    5.599933] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    5.609544] Workqueue: events qcom_channel_state_worker
[    5.616209] pstate: 60000005 (nZCv daif -PAN -UAO)
[    5.621152] pc : drms_uA_update+0x114/0x360
[    5.626006] lr : drms_uA_update+0x110/0x360
[    5.630084] sp : ffff0000124b3490
[    5.634242] x29: ffff0000124b3490 x28: ffff800005326e00
[    5.637735] x27: ffff0000124b35f8 x26: 000000000032bc48
[    5.643117] x25: ffff800004c7e800 x24: ffff800004c6d500
[    5.648411] x23: ffff800004c38a80 x22: 00000000000000d1
[    5.653706] x21: 00000000001ab3f0 x20: ffff800004c7e800
[    5.659001] x19: ffff0000114c3000 x18: ffffffffffffffff
[    5.664297] x17: 0000000000000000 x16: 0000000000000000
[    5.669592] x15: ffff0000114c3808 x14: 0720072007200720
[    5.674888] x13: 00000000199c9b28 x12: ffff80002bcccc40
[    5.680183] x11: ffff000012286000 x10: ffff0000114c3808
[    5.685477] x9 : 0720072007200720 x8 : ffff000010e9e808
[    5.690772] x7 : ffff0000106da568 x6 : 0000000000000000
[    5.696067] x5 : 0000000000000000 x4 : 0000000000000000
[    5.701362] x3 : 0000000000000004 x2 : 0000000000000000
[    5.706658] x1 : 0000000000000000 x0 : 0000000000000000
[    5.711952] Call trace:
[    5.717223]  drms_uA_update+0x114/0x360
[    5.719405]  regulator_register+0xb30/0x1140
[    5.723230]  devm_regulator_register+0x4c/0xa8
[    5.727745]  rpm_reg_probe+0xfc/0x1b0
[    5.731992]  platform_drv_probe+0x50/0xa0
[    5.735727]  really_probe+0x20c/0x2b8
[    5.739718]  driver_probe_device+0x58/0x100
[    5.743368]  __device_attach_driver+0x90/0xd0
[    5.747363]  bus_for_each_drv+0x64/0xc8
[    5.751870]  __device_attach+0xd8/0x138
[    5.755516]  device_initial_probe+0x10/0x18
[    5.759341]  bus_probe_device+0x98/0xa0
[    5.763502]  device_add+0x3d0/0x640
[    5.767319]  of_device_add+0x48/0x58
[    5.770793]  of_platform_device_create_pdata+0xb0/0x128
[    5.774629]  of_platform_bus_create+0x174/0x370
[    5.779569]  of_platform_populate+0x78/0xe0
[    5.784082]  qcom_smd_rpm_probe+0x80/0xa0
[    5.788245]  rpmsg_dev_probe+0x114/0x1a0
[    5.792411]  really_probe+0x20c/0x2b8
[    5.796401]  driver_probe_device+0x58/0x100
[    5.799964]  __device_attach_driver+0x90/0xd0
[    5.803960]  bus_for_each_drv+0x64/0xc8
[    5.808468]  __device_attach+0xd8/0x138
[    5.812115]  device_initial_probe+0x10/0x18
[    5.815936]  bus_probe_device+0x98/0xa0
[    5.820099]  device_add+0x3d0/0x640
[    5.823916]  device_register+0x1c/0x28
[    5.827391]  rpmsg_register_device+0x4c/0x90
[    5.831216]  qcom_channel_state_worker+0x170/0x298
[    5.835651]  process_one_work+0x294/0x6e8
[    5.840241]  worker_thread+0x40/0x450
[    5.844318]  kthread+0x11c/0x120
[    5.847961]  ret_from_fork+0x10/0x18
[    5.851260] irq event stamp: 9090
[    5.854820] hardirqs last  enabled at (9089): [<ffff000010160798>] console_unlock+0x3e0/0x5b0
[    5.858086] hardirqs last disabled at (9090): [<ffff0000100817cc>] do_debug_exception+0x104/0x140
[    5.866596] softirqs last  enabled at (9086): [<ffff000010082024>] __do_softirq+0x474/0x574
[    5.875446] softirqs last disabled at (9079): [<ffff0000100f2254>] irq_exit+0x13c/0x148
[    5.883598] ---[ end trace 6984ef7f081afa21 ]---

Fixes: fa94e48e13a1 ("regulator: core: Apply system load even if no consumer loads")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2994ee023b40..19b35d9f3a97 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1349,7 +1349,9 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		 * We'll only apply the initial system load if an
 		 * initial mode wasn't specified.
 		 */
+		regulator_lock(rdev);
 		drms_uA_update(rdev);
+		regulator_unlock(rdev);
 	}
 
 	if ((rdev->constraints->ramp_delay || rdev->constraints->ramp_disable)
-- 
2.20.1

