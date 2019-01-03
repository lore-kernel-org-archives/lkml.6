Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3956C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04012176F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LQq6XMyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbfACRrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:47:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42001 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfACRrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:47:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so16996686pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 09:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xeDugg8r4opmDKgACk8iN0E+CFgdEPSlXaIMHf3G9nI=;
        b=LQq6XMyqOY+X9PXTUhngkRXOQRKxPH510MHTBGblchhQIAdPSOCjOjLPs08yX7IrcX
         4C6t0MMFW7MRGESKLRL9N/qJvT2eMdInlTpuUIjFIbB86ZxHhAmkHTr79hBjgM5jbngR
         ka2lGGfAZojk+5qe67Sk5RdmZqvmBodecGeUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xeDugg8r4opmDKgACk8iN0E+CFgdEPSlXaIMHf3G9nI=;
        b=glsrwMhi52m9/mnioD+9LSvWxxzL8QOe15xouw6cPaC0NRHX34zQ0FJqfUsCoSxZ9W
         yJ0h7GeYXGjMU/vt/ML48Bd5ehZbSFwuP4ziHH2w3qpWGIbUbYTw6KUELJzYte13ucwI
         lj8uQOCEhKTOnaYo5jGJoJdzmdP05o+c2Q2igNl1gaFs7ZIrVD0bMvT+kq80VLh1+QPo
         UDJ9q48Sp8an5acgrWHe+RGKPYbqNgepG9v2WLS/8fDS94RbIeqtZKDNXBeL78QRfF19
         YuYAs7KC3yqZp8hdUe0GahSvWgdMkGf188UZJg0e+vgxG6Gr/l1f6Yc1Jvj7fZ5RRUjh
         Fujg==
X-Gm-Message-State: AJcUukfzZARszvSzPj54pGbLB++WCsQTNfSX9Mjn9ddcQlCrUPEGZYRW
        5SDeVmpe03YyE1ZgZ9dwe3bc6w==
X-Google-Smtp-Source: ALg8bN7sCJT8DpHg9P7LDZRiRXAOPwmGmDxJHQq5/1yO6cjqZWA+74t8LyAOE6iq0CLnlA6oIwsNQw==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr17667622pgh.265.1546537619319;
        Thu, 03 Jan 2019 09:46:59 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 15sm82870997pfr.55.2019.01.03.09.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 09:46:58 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lina Iyer <ilina@codeaurora.org>,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH] soc: qcom: rpmh: Avoid accessing freed memory from batch API
Date:   Thu,  3 Jan 2019 09:46:57 -0800
Message-Id: <20190103174657.251968-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the batch API from the interconnect driver sometimes leads to a
KASAN error due to an access to freed memory. This is easier to trigger
with threadirqs on the kernel commandline.

 BUG: KASAN: use-after-free in rpmh_tx_done+0x114/0x12c
 Read of size 1 at addr fffffff51414ad84 by task irq/110-apps_rs/57

 CPU: 0 PID: 57 Comm: irq/110-apps_rs Tainted: G        W         4.19.10 #72
 Call trace:
  dump_backtrace+0x0/0x2f8
  show_stack+0x20/0x2c
  __dump_stack+0x20/0x28
  dump_stack+0xcc/0x10c
  print_address_description+0x74/0x240
  kasan_report+0x250/0x26c
  __asan_report_load1_noabort+0x20/0x2c
  rpmh_tx_done+0x114/0x12c
  tcs_tx_done+0x450/0x768
  irq_forced_thread_fn+0x58/0x9c
  irq_thread+0x120/0x1dc
  kthread+0x248/0x260
  ret_from_fork+0x10/0x18

 Allocated by task 385:
  kasan_kmalloc+0xac/0x148
  __kmalloc+0x170/0x1e4
  rpmh_write_batch+0x174/0x540
  qcom_icc_set+0x8dc/0x9ac
  icc_set+0x288/0x2e8
  a6xx_gmu_stop+0x320/0x3c0
  a6xx_pm_suspend+0x108/0x124
  adreno_suspend+0x50/0x60
  pm_generic_runtime_suspend+0x60/0x78
  __rpm_callback+0x214/0x32c
  rpm_callback+0x54/0x184
  rpm_suspend+0x3f8/0xa90
  pm_runtime_work+0xb4/0x178
  process_one_work+0x544/0xbc0
  worker_thread+0x514/0x7d0
  kthread+0x248/0x260
  ret_from_fork+0x10/0x18

 Freed by task 385:
  __kasan_slab_free+0x12c/0x1e0
  kasan_slab_free+0x10/0x1c
  kfree+0x134/0x588
  rpmh_write_batch+0x49c/0x540
  qcom_icc_set+0x8dc/0x9ac
  icc_set+0x288/0x2e8
  a6xx_gmu_stop+0x320/0x3c0
  a6xx_pm_suspend+0x108/0x124
  adreno_suspend+0x50/0x60
 cr50_spi spi5.0: SPI transfer timed out
  pm_generic_runtime_suspend+0x60/0x78
  __rpm_callback+0x214/0x32c
  rpm_callback+0x54/0x184
  rpm_suspend+0x3f8/0xa90
  pm_runtime_work+0xb4/0x178
  process_one_work+0x544/0xbc0
  worker_thread+0x514/0x7d0
  kthread+0x248/0x260
  ret_from_fork+0x10/0x18

 The buggy address belongs to the object at fffffff51414ac80
  which belongs to the cache kmalloc-512 of size 512
 The buggy address is located 260 bytes inside of
  512-byte region [fffffff51414ac80, fffffff51414ae80)
 The buggy address belongs to the page:
 page:ffffffbfd4505200 count:1 mapcount:0 mapping:fffffff51e00c680 index:0x0 compound_mapcount: 0
 flags: 0x4000000000008100(slab|head)
 raw: 4000000000008100 ffffffbfd4529008 ffffffbfd44f9208 fffffff51e00c680
 raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  fffffff51414ac80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  fffffff51414ad00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 >fffffff51414ad80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  fffffff51414ae00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  fffffff51414ae80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

The batch API sets the same completion for each rpmh message that's sent
and then loops through all the messages and waits for that single
completion declared on the stack to be completed before returning from
the function and freeing the message structures. Unfortunately, some
messages may still be in process and 'stuck' in the TCS. At some later
point, the tcs_tx_done() interrupt will run and try to process messages
that have already been freed at the end of rpmh_write_batch(). This will
in turn access the 'needs_free' member of the rpmh_request structure and
cause KASAN to complain.

Let's fix this by allocating a chunk of completions for each message and
waiting for all of them to be completed before returning from the batch
API. Alternatively, we could wait for the last message in the batch, but
that may be a more complicated change because it looks like
tcs_tx_done() just iterates through the indices of the queue and
completes each message instead of tracking the last inserted message and
completing that first.

Cc: Lina Iyer <ilina@codeaurora.org>
Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Fixes: c8790cb6da58 ("drivers: qcom: rpmh: add support for batch RPMH request")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/rpmh.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index c7beb6841289..3b3e8b0b2d95 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -348,11 +348,12 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 {
 	struct batch_cache_req *req;
 	struct rpmh_request *rpm_msgs;
-	DECLARE_COMPLETION_ONSTACK(compl);
+	struct completion *compls;
 	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
 	unsigned long time_left;
 	int count = 0;
 	int ret, i, j;
+	void *ptr;
 
 	if (!cmd || !n)
 		return -EINVAL;
@@ -362,10 +363,15 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 	if (!count)
 		return -EINVAL;
 
-	req = kzalloc(sizeof(*req) + count * sizeof(req->rpm_msgs[0]),
+	ptr = kzalloc(sizeof(*req) +
+		      count * (sizeof(req->rpm_msgs[0]) + sizeof(*compls)),
 		      GFP_ATOMIC);
-	if (!req)
+	if (!ptr)
 		return -ENOMEM;
+
+	req = ptr;
+	compls = ptr + sizeof(*req) + count * sizeof(*rpm_msgs);
+
 	req->count = count;
 	rpm_msgs = req->rpm_msgs;
 
@@ -380,7 +386,10 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 	}
 
 	for (i = 0; i < count; i++) {
-		rpm_msgs[i].completion = &compl;
+		struct completion *compl = &compls[i];
+
+		init_completion(compl);
+		rpm_msgs[i].completion = compl;
 		ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msgs[i].msg);
 		if (ret) {
 			pr_err("Error(%d) sending RPMH message addr=%#x\n",
@@ -393,12 +402,12 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 
 	time_left = RPMH_TIMEOUT_MS;
 	for (i = 0; i < count; i++) {
-		time_left = wait_for_completion_timeout(&compl, time_left);
+		time_left = wait_for_completion_timeout(&compls[i], time_left);
 		if (!time_left) {
 			/*
 			 * Better hope they never finish because they'll signal
-			 * the completion on our stack and that's bad once
-			 * we've returned from the function.
+			 * the completion that we're going to free once
+			 * we've returned from this function.
 			 */
 			WARN_ON(1);
 			ret = -ETIMEDOUT;
@@ -407,7 +416,7 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 	}
 
 exit:
-	kfree(req);
+	kfree(ptr);
 
 	return ret;
 }
-- 
Sent by a computer through tubes

