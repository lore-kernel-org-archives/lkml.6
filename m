Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9401AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CB62146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543876;
	bh=A7rPtlATfV6vf+4gGG0uRb4TvgT+XrZiGBrnw+TdlA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K1PNepO4tJPZ5i/LoPfQEi1Vwp+dEYYGWc29rg0jiGnRtdUdXjBrvBwZCr55z95MY
	 p7zT5HfyRDbfAX0lNPg0eXzeIBXNfDr2E0IxQmf0TucnVrVBAGM0hwhsLH86hB+lVC
	 5YPSkYGxAxFNFjLKgXjlq0rLPRS3VEBu13weI6Fw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CB62146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbeLKP5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:57:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730872AbeLKP5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4A8320855;
        Tue, 11 Dec 2018 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543861;
        bh=A7rPtlATfV6vf+4gGG0uRb4TvgT+XrZiGBrnw+TdlA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0zwQ6ionCj61n4wUzUnCY3FH+Tblf4aohcOWE1geHM5JRRaaxnmAnVytuQdhFDwO6
         h/D47OR2m1uPIVGw6EwQttIF7Qw1/syxKEsVPAc0va4JLFBPxjoPuOh8eUEusiw+gF
         VGrmYWbWp+2qjPyML33zbouPBnnTH2/B0QklzMiM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.19 075/118] Revert "mfd: cros_ec: Use devm_kzalloc for private data"
Date:   Tue, 11 Dec 2018 16:41:34 +0100
Message-Id: <20181211151647.284558725@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

commit 48a2ca0ee3994df53da230c7079a18a70ec914f9 upstream.

This reverts commit 3aa2177e47878f7e7616da8a2050c44f22301b6e.

That commit triggered a new WARN when unloading the module (see at the
end of the commit message). When a class_dev is embedded in a structure
then that class_dev is the thing that controls the lifetime of that
structure, for that reason device managed allocations can't be used here.
See Documentation/kobject.txt.

Revert the above patch, so the struct is allocated using kzalloc and we
have a release function for it that frees the allocated memory, otherwise
it is broken.

 ------------[ cut here ]------------
 Device 'cros_ec' does not have a release() function, it is broken and must be fixed.
 WARNING: CPU: 3 PID: 3675 at drivers/base/core.c:895 device_release+0x80/0x90
 Modules linked in: btusb btrtl btintel btbcm bluetooth ...
 CPU: 3 PID: 3675 Comm: rmmod Not tainted 4.20.0-rc4 #76
 Hardware name: Google Kevin (DT)
 pstate: 40000005 (nZcv daif -PAN -UAO)
 pc : device_release+0x80/0x90
 lr : device_release+0x80/0x90
 sp : ffff00000c47bc70
 x29: ffff00000c47bc70 x28: ffff8000e86b0d40
 x27: 0000000000000000 x26: 0000000000000000
 x25: 0000000056000000 x24: 0000000000000015
 x23: ffff8000f0bbf860 x22: ffff000000d320a0
 x21: ffff8000ee93e100 x20: ffff8000ed931428
 x19: ffff8000ed931418 x18: 0000000000000020
 x17: 0000000000000000 x16: 0000000000000000
 x15: 0000000000000400 x14: 0000000000000143
 x13: 0000000000000000 x12: 0000000000000400
 x11: 0000000000000157 x10: 0000000000000960
 x9 : ffff00000c47b9b0 x8 : ffff8000e86b1700
 x7 : 0000000000000000 x6 : ffff8000f7d520b8
 x5 : ffff8000f7d520b8 x4 : 0000000000000000
 x3 : ffff8000f7d58e68 x2 : ffff8000e86b0d40
 x1 : 37d859939c964800 x0 : 0000000000000000
 Call trace:
  device_release+0x80/0x90
  kobject_put+0x74/0xe8
  device_unregister+0x20/0x30
  ec_device_remove+0x34/0x48 [cros_ec_dev]
  platform_drv_remove+0x28/0x48
  device_release_driver_internal+0x1a8/0x240
  driver_detach+0x40/0x80
  bus_remove_driver+0x54/0xa8
  driver_unregister+0x2c/0x58
  platform_driver_unregister+0x10/0x18
  cros_ec_dev_exit+0x1c/0x2d8 [cros_ec_dev]
  __arm64_sys_delete_module+0x16c/0x1f8
  el0_svc_common+0x84/0xd8
  el0_svc_handler+0x2c/0x80
  el0_svc+0x8/0xc
 ---[ end trace a57c4625f3c60ae8 ]---

Cc: stable@vger.kernel.org
Fixes: 3aa2177e4787 ("mfd: cros_ec: Use devm_kzalloc for private data")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mfd/cros_ec_dev.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -263,6 +263,11 @@ static const struct file_operations fops
 #endif
 };
 
+static void cros_ec_class_release(struct device *dev)
+{
+	kfree(to_cros_ec_dev(dev));
+}
+
 static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 {
 	/*
@@ -395,7 +400,7 @@ static int ec_device_probe(struct platfo
 	int retval = -ENOMEM;
 	struct device *dev = &pdev->dev;
 	struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
-	struct cros_ec_dev *ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
+	struct cros_ec_dev *ec = kzalloc(sizeof(*ec), GFP_KERNEL);
 
 	if (!ec)
 		return retval;
@@ -417,6 +422,7 @@ static int ec_device_probe(struct platfo
 	ec->class_dev.devt = MKDEV(ec_major, pdev->id);
 	ec->class_dev.class = &cros_class;
 	ec->class_dev.parent = dev;
+	ec->class_dev.release = cros_ec_class_release;
 
 	retval = dev_set_name(&ec->class_dev, "%s", ec_platform->ec_name);
 	if (retval) {


