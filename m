Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F5FC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A859825269
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A859825269
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030542AbeGAQbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:31:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35028 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030482AbeGAQbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:31:39 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B78A092B;
        Sun,  1 Jul 2018 16:31:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.14 056/157] of: platform: stop accessing invalid dev in of_platform_device_destroy
Date:   Sun,  1 Jul 2018 18:22:08 +0200
Message-Id: <20180701160855.447793767@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

commit 522811e944ed9b36806faa019faec10f9d259cca upstream.

Immediately after the platform_device_unregister() the device will be
cleaned up. Accessing the freed pointer immediately after that will
crash the system.

Found this bug when kernel is built with CONFIG_PAGE_POISONING and testing
loading/unloading audio drivers in a loop on Qcom platforms.

Fix this by moving of_node_clear_flag() just before the unregister calls.

Below is the crash trace:

Unable to handle kernel paging request at virtual address 6b6b6b6b6b6c03
Mem abort info:
  ESR = 0x96000021
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000021
  CM = 0, WnR = 0
[006b6b6b6b6b6c03] address between user and kernel address ranges
Internal error: Oops: 96000021 [#1] PREEMPT SMP
Modules linked in:
CPU: 2 PID: 1784 Comm: sh Tainted: G        W         4.17.0-rc7-02230-ge3a63a7ef641-dirty #204
Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
pstate: 80000005 (Nzcv daif -PAN -UAO)
pc : clear_bit+0x18/0x2c
lr : of_platform_device_destroy+0x64/0xb8
sp : ffff00000c9c3930
x29: ffff00000c9c3930 x28: ffff80003d39b200
x27: ffff000008bb1000 x26: 0000000000000040
x25: 0000000000000124 x24: ffff80003a9a3080
x23: 0000000000000060 x22: ffff00000939f518
x21: ffff80003aa79e98 x20: ffff80003aa3dae0
x19: ffff80003aa3c890 x18: ffff800009feb794
x17: 0000000000000000 x16: 0000000000000000
x15: ffff800009feb790 x14: 0000000000000000
x13: ffff80003a058778 x12: ffff80003a058728
x11: ffff80003a058750 x10: 0000000000000000
x9 : 0000000000000006 x8 : ffff80003a825988
x7 : bbbbbbbbbbbbbbbb x6 : 0000000000000001
x5 : 0000000000000000 x4 : 0000000000000001
x3 : 0000000000000008 x2 : 0000000000000001
x1 : 6b6b6b6b6b6b6c03 x0 : 0000000000000000
Process sh (pid: 1784, stack limit = 0x        (ptrval))
Call trace:
 clear_bit+0x18/0x2c
 q6afe_remove+0x20/0x38
 apr_device_remove+0x30/0x70
 device_release_driver_internal+0x170/0x208
 device_release_driver+0x14/0x20
 bus_remove_device+0xcc/0x150
 device_del+0x10c/0x310
 device_unregister+0x1c/0x70
 apr_remove_device+0xc/0x18
 device_for_each_child+0x50/0x80
 apr_remove+0x18/0x20
 rpmsg_dev_remove+0x38/0x68
 device_release_driver_internal+0x170/0x208
 device_release_driver+0x14/0x20
 bus_remove_device+0xcc/0x150
 device_del+0x10c/0x310
 device_unregister+0x1c/0x70
 qcom_smd_remove_device+0xc/0x18
 device_for_each_child+0x50/0x80
 qcom_smd_unregister_edge+0x3c/0x70
 smd_subdev_remove+0x18/0x28
 rproc_stop+0x48/0xd8
 rproc_shutdown+0x60/0xe8
 state_store+0xbc/0xf8
 dev_attr_store+0x18/0x28
 sysfs_kf_write+0x3c/0x50
 kernfs_fop_write+0x118/0x1e0
 __vfs_write+0x18/0x110
 vfs_write+0xa4/0x1a8
 ksys_write+0x48/0xb0
 sys_write+0xc/0x18
 el0_svc_naked+0x30/0x34
Code: d2800022 8b400c21 f9800031 9ac32043 (c85f7c22)
---[ end trace 32020935775616a2 ]---

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/platform.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -533,6 +533,9 @@ int of_platform_device_destroy(struct de
 	if (of_node_check_flag(dev->of_node, OF_POPULATED_BUS))
 		device_for_each_child(dev, NULL, of_platform_device_destroy);
 
+	of_node_clear_flag(dev->of_node, OF_POPULATED);
+	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
+
 	if (dev->bus == &platform_bus_type)
 		platform_device_unregister(to_platform_device(dev));
 #ifdef CONFIG_ARM_AMBA
@@ -540,8 +543,6 @@ int of_platform_device_destroy(struct de
 		amba_device_unregister(to_amba_device(dev));
 #endif
 
-	of_node_clear_flag(dev->of_node, OF_POPULATED);
-	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_platform_device_destroy);


