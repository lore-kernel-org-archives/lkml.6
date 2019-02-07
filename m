Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A125EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532962147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lR2rYqZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfBGOVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:21:00 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:41837 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfBGOU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:20:59 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190207142053epoutp046adfd9734e5f9465be808b4064b2d40f~BGtYX5pGQ1129411294epoutp04a;
        Thu,  7 Feb 2019 14:20:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190207142053epoutp046adfd9734e5f9465be808b4064b2d40f~BGtYX5pGQ1129411294epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549549253;
        bh=SotwuL+r2/KpZLVPK2r0K8yk0mcJ2KMesHmKlkgWC6w=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lR2rYqZ3KVPvfIww3EYclf5fmX2bl6gyHuyo4vS3iWo7hG9YFO0IK4e1iepZ8i8af
         KE/4kt4xKT8OtqhhagepvrIcnK6HCJo+H4T/wdr07wunqUzYdO4V5DGJc4YtXFfui8
         ZWrZNCvAzELo5j+mEJEsBB0EroLvp0UBHTRukv5k=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207142053epcas1p249b72e7ad4f1074a3853e9ce4d094186~BGtYFHkeF2377523775epcas1p2Y;
        Thu,  7 Feb 2019 14:20:53 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.93.04173.5CE3C5C5; Thu,  7 Feb 2019 23:20:53 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207142052epcas1p22f1dc03c371674434ff40150cf376b6a~BGtXCqI-N2363923639epcas1p2i;
        Thu,  7 Feb 2019 14:20:52 +0000 (GMT)
X-AuditID: b6c32a36-5d9ff7000000104d-e4-5c5c3ec5a345
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.97.04015.3CE3C5C5; Thu,  7 Feb 2019 23:20:52 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK004JK7UJ1J80@mmp1.samsung.com>; Thu, 07 Feb 2019
        23:20:51 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: samsung: Prevent clk_get_rate() calls in atomic
 context
Date:   Thu, 07 Feb 2019 15:20:41 +0100
Message-id: <20190207142041.19394-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsWy7bCmru5Ru5gYg003uS2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZRydHFWy2rvhy7wNjA+Nv/S5GTg4J
        AROJJ592MoLYQgI7GCWa3qh2MXIB2d8ZJWYfmsEOU7Tu6z12iMRuRomfE3rZQBK8AoISPybf
        Y+li5OBgFpCXOHIpGyTMLKApsXX3eqj6X4wSHS+eM4Ek2AQMJXqP9oFtExEQk7g9p5MZpIhZ
        oIVJYs7cpcwgCWGBAIlFK26D2SwCqhJH/vZBLbOWWHB1JiPERfIS53vXgW2QENjDJvFw1juo
        hIvEtLln2UEukhCQlrh01BYiXC2xa3s3M0R9B6NEy4XtzBAJa4nDxy+yQpzNJ/Huaw8rRC+v
        REebEESJh8TmFwdZIEEUK3Hq2zqWCYxSs5D8Pwvh/1lI/l/AyLyKUSy1oDg3PbXYsMBIrzgx
        t7g0L10vOT93EyM46rXMdjAuOudziFGAg1GJh1dDLyZGiDWxrLgy9xCjBAezkggvnxVQiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOO96B+cYIYH0xJLU7NTUgtQimCwTB6dUA+PRj4YXihjvCBX9
        4U37IxAnXCtz5E7bqcD375XMOXi+dd490dho7SBau9UqpOn9p7+7PuZr/gmdMDl95RzNF4v4
        ygPMNbcwKk2qyJDtKmJSeFoj+Vz/QYvqnydXlh5+zVj/bdbn8C02wdLJzEeviaesaw84Hyum
        UHVyzuoP2e1xt36ube+Ra1RiKc5INNRiLipOBABEJD9D9gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t9jAd0jdjExBrunsVlcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyjk6OKthsXfHl3gfGBsbf+l2MnBwS
        AiYS677eY+9i5OIQEtjJKDG7bRsjSIJXQFDix+R7LF2MHBzMAvISRy5lg4SZBdQlJs1bxAxR
        /4tRou/cORaQBJuAoUTv0T6wXhEBMYnbczrBipgFmpgkdt2+yA6SEBbwk/jYtQusgUVAVeLI
        3z42iGXWEguuzmSEuEhe4nzvOvYJjLyzkNwxC+GOWUjuWMDIvIpRMrWgODc9t9iowDAvtVyv
        ODG3uDQvXS85P3cTIzCAtx3W6tvBeH9J/CFGAQ5GJR7eC9oxMUKsiWXFlbmHGCU4mJVEePms
        gEK8KYmVValF+fFFpTmpxYcYpTlYlMR5b+cdixQSSE8sSc1OTS1ILYLJMnFwSjUwClxmODjj
        q6Di+mr3RyomKmczija/+8ne//fRpjzHo9Jdit9KVfpyqs+Eirg2eWXnTanfI7A23G5TyT6L
        x4US9qzi+m6X0w3ltW2/35fZzDXdQemXQ6/R5bqXfVm/DV1eB/5nze6aP5V7SvUupQklV2/H
        iSS9bNxYWrd+5wuzR0snvtj67aChEktxRqKhFnNRcSIAlTDy1lwCAAA=
X-CMS-MailID: 20190207142052epcas1p22f1dc03c371674434ff40150cf376b6a
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207142052epcas1p22f1dc03c371674434ff40150cf376b6a
References: <CGME20190207142052epcas1p22f1dc03c371674434ff40150cf376b6a@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves clk_get_rate() call from trigger() to hw_params()
callback to avoid calling sleeping clk API from atomic context
and prevent deadlock as indicated below.

Before this change clk_get_rate() was being called with same
spinlock held as the one passed to the clk API when registering
clocks exposed by the I2S driver.

[   82.109780] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:908
[   82.117009] in_atomic(): 1, irqs_disabled(): 128, pid: 1554, name: speaker-test
[   82.124235] 3 locks held by speaker-test/1554:
[   82.128653]  #0: cc8c5328 (snd_pcm_link_rwlock){...-}, at: snd_pcm_stream_lock_irq+0x20/0x38
[   82.137058]  #1: ec9eda17 (&(&substream->self_group.lock)->rlock){..-.}, at: snd_pcm_ioctl+0x900/0x1268
[   82.146417]  #2: 6ac279bf (&(&pri_dai->spinlock)->rlock){..-.}, at: i2s_trigger+0x64/0x6d4
[   82.154650] irq event stamp: 8144
[   82.157949] hardirqs last  enabled at (8143): [<c0a0f574>] _raw_read_unlock_irq+0x24/0x5c
[   82.166089] hardirqs last disabled at (8144): [<c0a0f6a8>] _raw_read_lock_irq+0x18/0x58
[   82.174063] softirqs last  enabled at (8004): [<c01024e4>] __do_softirq+0x3a4/0x66c
[   82.181688] softirqs last disabled at (7997): [<c012d730>] irq_exit+0x140/0x168
[   82.188964] Preemption disabled at:
[   82.188967] [<00000000>]   (null)
[   82.195728] CPU: 6 PID: 1554 Comm: speaker-test Not tainted 5.0.0-rc5-00192-ga6e6caca8f03 #191
[   82.204302] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   82.210376] [<c0111a54>] (unwind_backtrace) from [<c010d8f4>] (show_stack+0x10/0x14)
[   82.218084] [<c010d8f4>] (show_stack) from [<c09ef004>] (dump_stack+0x90/0xc8)
[   82.225278] [<c09ef004>] (dump_stack) from [<c0152980>] (___might_sleep+0x22c/0x2c8)
[   82.232990] [<c0152980>] (___might_sleep) from [<c0a0a2e4>] (__mutex_lock+0x28/0xa3c)
[   82.240788] [<c0a0a2e4>] (__mutex_lock) from [<c0a0ad80>] (mutex_lock_nested+0x1c/0x24)
[   82.248763] [<c0a0ad80>] (mutex_lock_nested) from [<c04923dc>] (clk_prepare_lock+0x78/0xec)
[   82.257079] [<c04923dc>] (clk_prepare_lock) from [<c049538c>] (clk_core_get_rate+0xc/0x5c)
[   82.265309] [<c049538c>] (clk_core_get_rate) from [<c0766b18>] (i2s_trigger+0x490/0x6d4)
[   82.273369] [<c0766b18>] (i2s_trigger) from [<c074fec4>] (soc_pcm_trigger+0x100/0x140)
[   82.281254] [<c074fec4>] (soc_pcm_trigger) from [<c07378a0>] (snd_pcm_do_start+0x2c/0x30)
[   82.289400] [<c07378a0>] (snd_pcm_do_start) from [<c07376cc>] (snd_pcm_action_single+0x38/0x78)
[   82.298065] [<c07376cc>] (snd_pcm_action_single) from [<c073a450>] (snd_pcm_ioctl+0x910/0x1268)
[   82.306734] [<c073a450>] (snd_pcm_ioctl) from [<c0292344>] (do_vfs_ioctl+0x90/0x9ec)
[   82.314443] [<c0292344>] (do_vfs_ioctl) from [<c0292cd4>] (ksys_ioctl+0x34/0x60)
[   82.321808] [<c0292cd4>] (ksys_ioctl) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
[   82.329431] Exception stack(0xeb875fa8 to 0xeb875ff0)
[   82.334459] 5fa0:                   00033c18 b6e31000 00000004 00004142 00033d80 00033d80
[   82.342605] 5fc0: 00033c18 b6e31000 00008000 00000036 00008000 00000000 beea38a8 00008000
[   82.350748] 5fe0: b6e3142c beea384c b6da9a30 b6c9212c
[   82.355789]
[   82.357245] ======================================================
[   82.363397] WARNING: possible circular locking dependency detected
[   82.369551] 5.0.0-rc5-00192-ga6e6caca8f03 #191 Tainted: G        W
[   82.376395] ------------------------------------------------------
[   82.382548] speaker-test/1554 is trying to acquire lock:
[   82.387834] 6d2007f4 (prepare_lock){+.+.}, at: clk_prepare_lock+0x78/0xec
[   82.394593]
[   82.394593] but task is already holding lock:
[   82.400398] 6ac279bf (&(&pri_dai->spinlock)->rlock){..-.}, at: i2s_trigger+0x64/0x6d4
[   82.408197]
[   82.408197] which lock already depends on the new lock.
[   82.416343]
[   82.416343] the existing dependency chain (in reverse order) is:
[   82.423795]
[   82.423795] -> #1 (&(&pri_dai->spinlock)->rlock){..-.}:
[   82.430472]        clk_mux_set_parent+0x34/0xb8
[   82.434975]        clk_core_set_parent_nolock+0x1c4/0x52c
[   82.440347]        clk_set_parent+0x38/0x6c
[   82.444509]        of_clk_set_defaults+0xc8/0x308
[   82.449186]        of_clk_add_provider+0x84/0xd0
[   82.453779]        samsung_i2s_probe+0x408/0x5f8
[   82.458376]        platform_drv_probe+0x48/0x98
[   82.462879]        really_probe+0x224/0x3f4
[   82.467037]        driver_probe_device+0x70/0x1c4
[   82.471716]        bus_for_each_drv+0x44/0x8c
[   82.476049]        __device_attach+0xa0/0x138
[   82.480382]        bus_probe_device+0x88/0x90
[   82.484715]        deferred_probe_work_func+0x6c/0xbc
[   82.489741]        process_one_work+0x200/0x740
[   82.494246]        worker_thread+0x2c/0x4c8
[   82.498408]        kthread+0x128/0x164
[   82.502131]        ret_from_fork+0x14/0x20
[   82.506204]          (null)
[   82.508976]
[   82.508976] -> #0 (prepare_lock){+.+.}:
[   82.514264]        __mutex_lock+0x60/0xa3c
[   82.518336]        mutex_lock_nested+0x1c/0x24
[   82.522756]        clk_prepare_lock+0x78/0xec
[   82.527088]        clk_core_get_rate+0xc/0x5c
[   82.531421]        i2s_trigger+0x490/0x6d4
[   82.535494]        soc_pcm_trigger+0x100/0x140
[   82.539913]        snd_pcm_do_start+0x2c/0x30
[   82.544246]        snd_pcm_action_single+0x38/0x78
[   82.549012]        snd_pcm_ioctl+0x910/0x1268
[   82.553345]        do_vfs_ioctl+0x90/0x9ec
[   82.557417]        ksys_ioctl+0x34/0x60
[   82.561229]        ret_fast_syscall+0x0/0x28
[   82.565477]        0xbeea384c
[   82.568421]
[   82.568421] other info that might help us debug this:
[   82.568421]
[   82.576394]  Possible unsafe locking scenario:
[   82.576394]
[   82.582285]        CPU0                    CPU1
[   82.586792]        ----                    ----
[   82.591297]   lock(&(&pri_dai->spinlock)->rlock);
[   82.595977]                                lock(prepare_lock);
[   82.601782]                                lock(&(&pri_dai->spinlock)->rlock);
[   82.608975]   lock(prepare_lock);
[   82.612268]
[   82.612268]  *** DEADLOCK ***

Fixes: 647d04f8e07a ("ASoC: samsung: i2s: Ensure the RCLK rate is properly determined")
Reported-by: Krzysztof Kozłowski <krzk@kernel.org>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index d6c62aa13041..ce00fe2f6aae 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -700,6 +700,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 {
 	struct i2s_dai *i2s = to_info(dai);
 	u32 mod, mask = 0, val = 0;
+	struct clk *rclksrc;
 	unsigned long flags;
 
 	WARN_ON(!pm_runtime_active(dai->dev));
@@ -782,6 +783,10 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 
 	i2s->frmclk = params_rate(params);
 
+	rclksrc = i2s->clk_table[CLK_I2S_RCLK_SRC];
+	if (rclksrc && !IS_ERR(rclksrc))
+		i2s->rclk_srcrate = clk_get_rate(rclksrc);
+
 	return 0;
 }
 
@@ -886,11 +891,6 @@ static int config_setup(struct i2s_dai *i2s)
 		return 0;
 
 	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
-		struct clk *rclksrc = i2s->clk_table[CLK_I2S_RCLK_SRC];
-
-		if (rclksrc && !IS_ERR(rclksrc))
-			i2s->rclk_srcrate = clk_get_rate(rclksrc);
-
 		psr = i2s->rclk_srcrate / i2s->frmclk / rfs;
 		writel(((psr - 1) << 8) | PSR_PSREN, i2s->addr + I2SPSR);
 		dev_dbg(&i2s->pdev->dev,
-- 
2.20.1

