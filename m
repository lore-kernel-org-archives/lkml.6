Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B56C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486F72148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486F72148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbeIXSgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:36:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58400 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387467AbeIXSgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:36:01 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0FEB91018;
        Mon, 24 Sep 2018 12:34:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, George Cherian <george.cherian@cavium.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 4.18 107/235] ipmi: Fix I2C client removal in the SSIF driver
Date:   Mon, 24 Sep 2018 13:51:33 +0200
Message-Id: <20180924113116.360812596@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Minyard <cminyard@mvista.com>

commit 0745dde62835be7e2afe62fcdb482fcad79cb743 upstream.

The SSIF driver was removing any client that came in through the
platform interface, but it should only remove clients that it
added.  On a failure in the probe function, this could result
in the following oops when the driver is removed and the
client gets unregistered twice:

 CPU: 107 PID: 30266 Comm: rmmod Not tainted 4.18.0+ #80
 Hardware name: Cavium Inc. Saber/Saber, BIOS Cavium reference firmware version 7.0 08/04/2018
 pstate: 60400009 (nZCv daif +PAN -UAO)
 pc : kernfs_find_ns+0x28/0x120
 lr : kernfs_find_and_get_ns+0x40/0x60
 sp : ffff00002310fb50
 x29: ffff00002310fb50 x28: ffff800a8240f800
 x27: 0000000000000000 x26: 0000000000000000
 x25: 0000000056000000 x24: ffff000009073000
 x23: ffff000008998b38 x22: 0000000000000000
 x21: ffff800ed86de820 x20: 0000000000000000
 x19: ffff00000913a1d8 x18: 0000000000000000
 x17: 0000000000000000 x16: 0000000000000000
 x15: 0000000000000000 x14: 5300737265766972
 x13: 643d4d4554535953 x12: 0000000000000030
 x11: 0000000000000030 x10: 0101010101010101
 x9 : ffff800ea06cc3f9 x8 : 0000000000000000
 x7 : 0000000000000141 x6 : ffff000009073000
 x5 : ffff800adb706b00 x4 : 0000000000000000
 x3 : 00000000ffffffff x2 : 0000000000000000
 x1 : ffff000008998b38 x0 : ffff000008356760
 Process rmmod (pid: 30266, stack limit = 0x00000000e218418d)
 Call trace:
  kernfs_find_ns+0x28/0x120
  kernfs_find_and_get_ns+0x40/0x60
  sysfs_unmerge_group+0x2c/0x6c
  dpm_sysfs_remove+0x34/0x70
  device_del+0x58/0x30c
  device_unregister+0x30/0x7c
  i2c_unregister_device+0x84/0x90 [i2c_core]
  ssif_platform_remove+0x38/0x98 [ipmi_ssif]
  platform_drv_remove+0x2c/0x6c
  device_release_driver_internal+0x168/0x1f8
  driver_detach+0x50/0xbc
  bus_remove_driver+0x74/0xe8
  driver_unregister+0x34/0x5c
  platform_driver_unregister+0x20/0x2c
  cleanup_ipmi_ssif+0x50/0xd82c [ipmi_ssif]
  __arm64_sys_delete_module+0x1b4/0x220
  el0_svc_handler+0x104/0x160
  el0_svc+0x8/0xc
 Code: aa1e03e0 aa0203f6 aa0103f7 d503201f (7940e280)
 ---[ end trace 09f0e34cce8e2d8c ]---
 Kernel panic - not syncing: Fatal exception
 SMP: stopping secondary CPUs
 Kernel Offset: disabled
 CPU features: 0x23800c38

So track the clients that the SSIF driver adds and only remove
those.

Reported-by: George Cherian <george.cherian@cavium.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Tested-by: George Cherian <george.cherian@cavium.com>
Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_ssif.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -181,6 +181,8 @@ struct ssif_addr_info {
 	struct device *dev;
 	struct i2c_client *client;
 
+	struct i2c_client *added_client;
+
 	struct mutex clients_mutex;
 	struct list_head clients;
 
@@ -1641,15 +1643,7 @@ static int ssif_probe(struct i2c_client
 
  out:
 	if (rv) {
-		/*
-		 * Note that if addr_info->client is assigned, we
-		 * leave it.  The i2c client hangs around even if we
-		 * return a failure here, and the failure here is not
-		 * propagated back to the i2c code.  This seems to be
-		 * design intent, strange as it may be.  But if we
-		 * don't leave it, ssif_platform_remove will not remove
-		 * the client like it should.
-		 */
+		addr_info->client = NULL;
 		dev_err(&client->dev, "Unable to start IPMI SSIF: %d\n", rv);
 		kfree(ssif_info);
 	}
@@ -1669,7 +1663,8 @@ static int ssif_adapter_handler(struct d
 	if (adev->type != &i2c_adapter_type)
 		return 0;
 
-	i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo);
+	addr_info->added_client = i2c_new_device(to_i2c_adapter(adev),
+						 &addr_info->binfo);
 
 	if (!addr_info->adapter_name)
 		return 1; /* Only try the first I2C adapter by default. */
@@ -1842,7 +1837,7 @@ static int ssif_platform_remove(struct p
 		return 0;
 
 	mutex_lock(&ssif_infos_mutex);
-	i2c_unregister_device(addr_info->client);
+	i2c_unregister_device(addr_info->added_client);
 
 	list_del(&addr_info->link);
 	kfree(addr_info);


