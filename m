Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E90C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4C62086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfAlk8dj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4C62086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbeKTCyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:54:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730018AbeKTCyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:54:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C31B20831;
        Mon, 19 Nov 2018 16:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645047;
        bh=Gbnui4LVQaNxhgJ0YqYic3S3EsG7CVLFvHl2aA7s3w0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QfAlk8djCKTlZE9Io3mPLvPpzBEPvTNhOoTTHBDuFUGYYY13E9Axi1zH1r9E9dbIe
         m6CWGTx63OJrkrCe+vh+1V0mOS+sJotx4j7514LAwISOdO14COSMqsCnYMus2SI7nM
         2yUZEUMoVMUvzi13P5HLCCi0gRcZY9tqlhAr7AtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeykumar Sankaran <jsanka@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 016/205] drm/msm/disp/dpu: Use proper define for drm_encoder_init() encoder_type
Date:   Mon, 19 Nov 2018 17:25:23 +0100
Message-Id: <20181119162620.108809867@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit 2c043eeffea4813b8f569e84b46035a08de5eb47 ]

We got a bug report that this function oopses when trying to do a kasprintf().

PC is at string+0x2c/0x60
LR is at vsnprintf+0x28c/0x4ec
pc : [<ffffff80088d35d8>] lr : [<ffffff80088d5fc4>] pstate: a0c00049
sp : ffffff80095fb540
x29: ffffff80095fb540 x28: ffffff8008ad42bc
x27: 00000000ffffffd8 x26: 0000000000000000
x25: ffffff8008c216c8 x24: 0000000000000000
x23: 0000000000000000 x22: ffffff80095fb720
x21: 0000000000000000 x20: ffffff80095fb720
x19: ffffff80095fb6f0 x18: 000000000000000a
x17: 00000000b42ba473 x16: ffffff800805bbe8
x15: 00000000000a157d x14: 000000000000000c
x13: 0000000000000000 x12: 0000ffff0000000f
x11: 0000000000000003 x10: 0000000000000001
x9 : 0000000000000040 x8 : 000000000000001c
x7 : ffffffffffffffff x6 : 0000000000000000
x5 : 0000000000000228 x4 : 0000000000000000
x3 : ffff0a00ffffff04 x2 : 0000000000007961
x1 : 0000000000000000 x0 : 0000000000000000
Process kworker/3:1 (pid: 61, stack limit = 0xffffff80095f8000)
Call trace:
Exception stack(0xffffff80095fb400 to 0xffffff80095fb540)
b400: 0000000000000000 0000000000000000 0000000000007961 ffff0a00ffffff04
b420: 0000000000000000 0000000000000228 0000000000000000 ffffffffffffffff
b440: 000000000000001c 0000000000000040 0000000000000001 0000000000000003
b460: 0000ffff0000000f 0000000000000000 000000000000000c 00000000000a157d
b480: ffffff800805bbe8 00000000b42ba473 000000000000000a ffffff80095fb6f0
b4a0: ffffff80095fb720 0000000000000000 ffffff80095fb720 0000000000000000
b4c0: 0000000000000000 ffffff8008c216c8 0000000000000000 00000000ffffffd8
b4e0: ffffff8008ad42bc ffffff80095fb540 ffffff80088d5fc4 ffffff80095fb540
b500: ffffff80088d35d8 00000000a0c00049 ffffff80095fb550 ffffff80080d06a4
b520: ffffffffffffffff ffffff80088d5e0c ffffff80095fb540 ffffff80088d35d8
[<ffffff80088d35d8>] string+0x2c/0x60
[<ffffff80088d5fc4>] vsnprintf+0x28c/0x4ec
[<ffffff80083973b8>] kvasprintf+0x68/0x100
[<ffffff800839755c>] kasprintf+0x60/0x80
[<ffffff800849cc24>] drm_encoder_init+0x134/0x164
[<ffffff80084d9a7c>] dpu_encoder_init+0x60/0x94
[<ffffff80084eced0>] _dpu_kms_drm_obj_init+0xa0/0x424
[<ffffff80084ed870>] dpu_kms_hw_init+0x61c/0x6bc
[<ffffff80084f7614>] msm_drm_bind+0x380/0x67c
[<ffffff80085114e4>] try_to_bring_up_master+0x228/0x264
[<ffffff80085116e8>] component_master_add_with_match+0x90/0xc0
[<ffffff80084f722c>] msm_pdev_probe+0x260/0x2c8
[<ffffff800851a910>] platform_drv_probe+0x58/0xa8
[<ffffff80085185c8>] driver_probe_device+0x2d8/0x40c
[<ffffff8008518928>] __device_attach_driver+0xd4/0x10c
[<ffffff800851644c>] bus_for_each_drv+0xb4/0xd0
[<ffffff8008518230>] __device_attach+0xd0/0x160
[<ffffff8008518984>] device_initial_probe+0x24/0x30
[<ffffff800851744c>] bus_probe_device+0x38/0x98
[<ffffff8008517aac>] deferred_probe_work_func+0x144/0x148
[<ffffff80080c8654>] process_one_work+0x218/0x3bc
[<ffffff80080c883c>] process_scheduled_works+0x44/0x48
[<ffffff80080c95bc>] worker_thread+0x288/0x32c
[<ffffff80080cea30>] kthread+0x134/0x13c
[<ffffff8008084750>] ret_from_fork+0x10/0x18
Code: 910003fd 2a0403e6 eb0400ff 54000060 (38646845)

Looking at the code I see that drm_encoder_init() is called from the DPU
code with 'DRM_MODE_CONNECTOR_DSI' passed in as the 'encoder_type'
argument (follow from _dpu_kms_initialize_dsi()). That corresponds to
the integer 16. That is then indexed into drm_encoder_enum_list in
drm_encoder_init() to look up the name of the encoder. If you're still
following along, that's an encoder not a connector! We really want to
use DRM_MODE_ENCODER_DSI (integer 6) instead of DRM_MODE_CONNECTOR_DSI
here, or we'll go out of bounds of the encoder array. Pass the right
thing and everything is fine.

Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Sean Paul <seanpaul@chromium.org>
Fixes: 25fdd5933e4c (drm/msm: Add SDM845 DPU support)
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Reviewed-by: Jeykumar Sankaran <jsanka@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>

Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -450,7 +450,7 @@ static void _dpu_kms_initialize_dsi(stru
 	int i, rc;
 
 	/*TODO: Support two independent DSI connectors */
-	encoder = dpu_encoder_init(dev, DRM_MODE_CONNECTOR_DSI);
+	encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DSI);
 	if (IS_ERR_OR_NULL(encoder)) {
 		DPU_ERROR("encoder init failed for dsi display\n");
 		return;


