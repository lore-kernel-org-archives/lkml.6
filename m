Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xePmAqFWGVvZZAAAmS7hNA
	; Thu, 07 Jun 2018 16:00:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 62B0B607E7; Thu,  7 Jun 2018 16:00:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9F215601D2;
	Thu,  7 Jun 2018 16:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F215601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935701AbeFGQAp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:00:45 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39289 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933026AbeFGOJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:05 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0005Zv-ID; Thu, 07 Jun 2018 15:09:02 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0002pR-Ek; Thu, 07 Jun 2018 15:08:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Felipe Balbi" <felipe.balbi@linux.intel.com>,
        "Baolin Wang" <baolin.wang@linaro.org>,
        "Michal Nazarewicz" <mina86@mina86.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.879884148@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 102/410] usb: gadget: f_fs: Fix possibe deadlock
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Baolin Wang <baolin.wang@linaro.org>

commit b3ce3ce02d146841af012d08506b4071db8ffde3 upstream.

When system try to close /dev/usb-ffs/adb/ep0 on one core, at the same
time another core try to attach new UDC, which will cause deadlock as
below scenario. Thus we should release ffs lock before issuing
unregister_gadget_item().

[   52.642225] c1 ======================================================
[   52.642228] c1 [ INFO: possible circular locking dependency detected ]
[   52.642236] c1 4.4.6+ #1 Tainted: G        W  O
[   52.642241] c1 -------------------------------------------------------
[   52.642245] c1 usb ffs open/2808 is trying to acquire lock:
[   52.642270] c0  (udc_lock){+.+.+.}, at: [<ffffffc00065aeec>]
		usb_gadget_unregister_driver+0x3c/0xc8
[   52.642272] c1  but task is already holding lock:
[   52.642283] c0  (ffs_lock){+.+.+.}, at: [<ffffffc00066b244>]
		ffs_data_clear+0x30/0x140
[   52.642285] c1 which lock already depends on the new lock.
[   52.642287] c1
               the existing dependency chain (in reverse order) is:
[   52.642295] c0
	       -> #1 (ffs_lock){+.+.+.}:
[   52.642307] c0        [<ffffffc00012340c>] __lock_acquire+0x20f0/0x2238
[   52.642314] c0        [<ffffffc000123b54>] lock_acquire+0xe4/0x298
[   52.642322] c0        [<ffffffc000aaf6e8>] mutex_lock_nested+0x7c/0x3cc
[   52.642328] c0        [<ffffffc00066f7bc>] ffs_func_bind+0x504/0x6e8
[   52.642334] c0        [<ffffffc000654004>] usb_add_function+0x84/0x184
[   52.642340] c0        [<ffffffc000658ca4>] configfs_composite_bind+0x264/0x39c
[   52.642346] c0        [<ffffffc00065b348>] udc_bind_to_driver+0x58/0x11c
[   52.642352] c0        [<ffffffc00065b49c>] usb_udc_attach_driver+0x90/0xc8
[   52.642358] c0        [<ffffffc0006598e0>] gadget_dev_desc_UDC_store+0xd4/0x128
[   52.642369] c0        [<ffffffc0002c14e8>] configfs_write_file+0xd0/0x13c
[   52.642376] c0        [<ffffffc00023c054>] vfs_write+0xb8/0x214
[   52.642381] c0        [<ffffffc00023cad4>] SyS_write+0x54/0xb0
[   52.642388] c0        [<ffffffc000085ff0>] el0_svc_naked+0x24/0x28
[   52.642395] c0
              -> #0 (udc_lock){+.+.+.}:
[   52.642401] c0        [<ffffffc00011e3d0>] print_circular_bug+0x84/0x2e4
[   52.642407] c0        [<ffffffc000123454>] __lock_acquire+0x2138/0x2238
[   52.642412] c0        [<ffffffc000123b54>] lock_acquire+0xe4/0x298
[   52.642420] c0        [<ffffffc000aaf6e8>] mutex_lock_nested+0x7c/0x3cc
[   52.642427] c0        [<ffffffc00065aeec>] usb_gadget_unregister_driver+0x3c/0xc8
[   52.642432] c0        [<ffffffc00065995c>] unregister_gadget_item+0x28/0x44
[   52.642439] c0        [<ffffffc00066b34c>] ffs_data_clear+0x138/0x140
[   52.642444] c0        [<ffffffc00066b374>] ffs_data_reset+0x20/0x6c
[   52.642450] c0        [<ffffffc00066efd0>] ffs_data_closed+0xac/0x12c
[   52.642454] c0        [<ffffffc00066f070>] ffs_ep0_release+0x20/0x2c
[   52.642460] c0        [<ffffffc00023dbe4>] __fput+0xb0/0x1f4
[   52.642466] c0        [<ffffffc00023dd9c>] ____fput+0x20/0x2c
[   52.642473] c0        [<ffffffc0000ee944>] task_work_run+0xb4/0xe8
[   52.642482] c0        [<ffffffc0000cd45c>] do_exit+0x360/0xb9c
[   52.642487] c0        [<ffffffc0000cf228>] do_group_exit+0x4c/0xb0
[   52.642494] c0        [<ffffffc0000dd3c8>] get_signal+0x380/0x89c
[   52.642501] c0        [<ffffffc00008a8f0>] do_signal+0x154/0x518
[   52.642507] c0        [<ffffffc00008af00>] do_notify_resume+0x70/0x78
[   52.642512] c0        [<ffffffc000085ee8>] work_pending+0x1c/0x20
[   52.642514] c1
              other info that might help us debug this:
[   52.642517] c1  Possible unsafe locking scenario:
[   52.642518] c1        CPU0                    CPU1
[   52.642520] c1        ----                    ----
[   52.642525] c0   lock(ffs_lock);
[   52.642529] c0                                lock(udc_lock);
[   52.642533] c0                                lock(ffs_lock);
[   52.642537] c0   lock(udc_lock);
[   52.642539] c1
                      *** DEADLOCK ***
[   52.642543] c1 1 lock held by usb ffs open/2808:
[   52.642555] c0  #0:  (ffs_lock){+.+.+.}, at: [<ffffffc00066b244>]
		ffs_data_clear+0x30/0x140
[   52.642557] c1 stack backtrace:
[   52.642563] c1 CPU: 1 PID: 2808 Comm: usb ffs open Tainted: G
[   52.642565] c1 Hardware name: Spreadtrum SP9860g Board (DT)
[   52.642568] c1 Call trace:
[   52.642573] c1 [<ffffffc00008b430>] dump_backtrace+0x0/0x170
[   52.642577] c1 [<ffffffc00008b5c0>] show_stack+0x20/0x28
[   52.642583] c1 [<ffffffc000422694>] dump_stack+0xa8/0xe0
[   52.642587] c1 [<ffffffc00011e548>] print_circular_bug+0x1fc/0x2e4
[   52.642591] c1 [<ffffffc000123454>] __lock_acquire+0x2138/0x2238
[   52.642595] c1 [<ffffffc000123b54>] lock_acquire+0xe4/0x298
[   52.642599] c1 [<ffffffc000aaf6e8>] mutex_lock_nested+0x7c/0x3cc
[   52.642604] c1 [<ffffffc00065aeec>] usb_gadget_unregister_driver+0x3c/0xc8
[   52.642608] c1 [<ffffffc00065995c>] unregister_gadget_item+0x28/0x44
[   52.642613] c1 [<ffffffc00066b34c>] ffs_data_clear+0x138/0x140
[   52.642618] c1 [<ffffffc00066b374>] ffs_data_reset+0x20/0x6c
[   52.642621] c1 [<ffffffc00066efd0>] ffs_data_closed+0xac/0x12c
[   52.642625] c1 [<ffffffc00066f070>] ffs_ep0_release+0x20/0x2c
[   52.642629] c1 [<ffffffc00023dbe4>] __fput+0xb0/0x1f4
[   52.642633] c1 [<ffffffc00023dd9c>] ____fput+0x20/0x2c
[   52.642636] c1 [<ffffffc0000ee944>] task_work_run+0xb4/0xe8
[   52.642640] c1 [<ffffffc0000cd45c>] do_exit+0x360/0xb9c
[   52.642644] c1 [<ffffffc0000cf228>] do_group_exit+0x4c/0xb0
[   52.642647] c1 [<ffffffc0000dd3c8>] get_signal+0x380/0x89c
[   52.642651] c1 [<ffffffc00008a8f0>] do_signal+0x154/0x518
[   52.642656] c1 [<ffffffc00008af00>] do_notify_resume+0x70/0x78
[   52.642659] c1 [<ffffffc000085ee8>] work_pending+0x1c/0x20

Acked-by: Michal Nazarewicz <mina86@mina86.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/gadget/f_fs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/f_fs.c
+++ b/drivers/usb/gadget/f_fs.c
@@ -2998,6 +2998,7 @@ done:
 static void ffs_closed(struct ffs_data *ffs)
 {
 	struct ffs_dev *ffs_obj;
+	struct config_item *ci;
 
 	ENTER();
 	ffs_dev_lock();
@@ -3015,8 +3016,11 @@ static void ffs_closed(struct ffs_data *
 	    || !ffs_obj->opts->func_inst.group.cg_item.ci_parent)
 		goto done;
 
-	unregister_gadget_item(ffs_obj->opts->
-			       func_inst.group.cg_item.ci_parent->ci_parent);
+	ci = ffs_obj->opts->func_inst.group.cg_item.ci_parent->ci_parent;
+	ffs_dev_unlock();
+
+	unregister_gadget_item(ci);
+	return;
 done:
 	ffs_dev_unlock();
 }
