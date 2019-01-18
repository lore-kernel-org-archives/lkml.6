Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C72C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D7920823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G9CudibN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KlKzqTu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfARRet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:34:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfARRet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:34:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C587961A15; Fri, 18 Jan 2019 17:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547832888;
        bh=csk9lMI20H/9EjY013M/D6j1KCtzf/U20mpr1piFoD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9CudibN3fHL2btDcKPXJRoQg+64y5DHZwagQxpaJPoP1Obxr+MM+075/lkHNtqb+
         djjBfLA/4F/daNWb7Iy/U0UzVNp3SkDALJHasYXqRS2jDRMQ6q+weChG6uicYyhg3B
         NsNsf8SIC3vFeSNcKOBVvxauk+05B3zjcNU1iQkk=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0177560FF4;
        Fri, 18 Jan 2019 17:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547832884;
        bh=csk9lMI20H/9EjY013M/D6j1KCtzf/U20mpr1piFoD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KlKzqTu6RSf8qpNQmfzRhsXMHKmpFAp/5PU2fJ+ZL2Vb1pziLbE4KgAML+xZ/sANh
         gKAV4CGE+MhbRjVz04peHEtUW1VCkY2ggq8K6rgsQVbhcIBfCIkLhTwJ56mx0q1r9U
         A3dFXpULTt0C9siS8CJYZV5TGgz4cAqPlPohhbDE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0177560FF4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 18 Jan 2019 10:34:42 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v2] soc: qcom: rpmh: Avoid accessing freed memory from
 batch API
Message-ID: <20190118173442.GB20369@codeaurora.org>
References: <20190115225447.75212-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190115225447.75212-1-swboyd@chromium.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15 2019 at 15:54 -0700, Stephen Boyd wrote:
>Using the batch API from the interconnect driver sometimes leads to a
>KASAN error due to an access to freed memory. This is easier to trigger
>with threadirqs on the kernel commandline.
>
> BUG: KASAN: use-after-free in rpmh_tx_done+0x114/0x12c
> Read of size 1 at addr fffffff51414ad84 by task irq/110-apps_rs/57
>
> CPU: 0 PID: 57 Comm: irq/110-apps_rs Tainted: G        W         4.19.10 #72
> Call trace:
>  dump_backtrace+0x0/0x2f8
>  show_stack+0x20/0x2c
>  __dump_stack+0x20/0x28
>  dump_stack+0xcc/0x10c
>  print_address_description+0x74/0x240
>  kasan_report+0x250/0x26c
>  __asan_report_load1_noabort+0x20/0x2c
>  rpmh_tx_done+0x114/0x12c
>  tcs_tx_done+0x450/0x768
>  irq_forced_thread_fn+0x58/0x9c
>  irq_thread+0x120/0x1dc
>  kthread+0x248/0x260
>  ret_from_fork+0x10/0x18
>
> Allocated by task 385:
>  kasan_kmalloc+0xac/0x148
>  __kmalloc+0x170/0x1e4
>  rpmh_write_batch+0x174/0x540
>  qcom_icc_set+0x8dc/0x9ac
>  icc_set+0x288/0x2e8
>  a6xx_gmu_stop+0x320/0x3c0
>  a6xx_pm_suspend+0x108/0x124
>  adreno_suspend+0x50/0x60
>  pm_generic_runtime_suspend+0x60/0x78
>  __rpm_callback+0x214/0x32c
>  rpm_callback+0x54/0x184
>  rpm_suspend+0x3f8/0xa90
>  pm_runtime_work+0xb4/0x178
>  process_one_work+0x544/0xbc0
>  worker_thread+0x514/0x7d0
>  kthread+0x248/0x260
>  ret_from_fork+0x10/0x18
>
> Freed by task 385:
>  __kasan_slab_free+0x12c/0x1e0
>  kasan_slab_free+0x10/0x1c
>  kfree+0x134/0x588
>  rpmh_write_batch+0x49c/0x540
>  qcom_icc_set+0x8dc/0x9ac
>  icc_set+0x288/0x2e8
>  a6xx_gmu_stop+0x320/0x3c0
>  a6xx_pm_suspend+0x108/0x124
>  adreno_suspend+0x50/0x60
> cr50_spi spi5.0: SPI transfer timed out
>  pm_generic_runtime_suspend+0x60/0x78
>  __rpm_callback+0x214/0x32c
>  rpm_callback+0x54/0x184
>  rpm_suspend+0x3f8/0xa90
>  pm_runtime_work+0xb4/0x178
>  process_one_work+0x544/0xbc0
>  worker_thread+0x514/0x7d0
>  kthread+0x248/0x260
>  ret_from_fork+0x10/0x18
>
> The buggy address belongs to the object at fffffff51414ac80
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 260 bytes inside of
>  512-byte region [fffffff51414ac80, fffffff51414ae80)
> The buggy address belongs to the page:
> page:ffffffbfd4505200 count:1 mapcount:0 mapping:fffffff51e00c680 index:0x0 compound_mapcount: 0
> flags: 0x4000000000008100(slab|head)
> raw: 4000000000008100 ffffffbfd4529008 ffffffbfd44f9208 fffffff51e00c680
> raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  fffffff51414ac80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  fffffff51414ad00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >fffffff51414ad80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                    ^
>  fffffff51414ae00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  fffffff51414ae80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>
>The batch API sets the same completion for each rpmh message that's sent
>and then loops through all the messages and waits for that single
>completion declared on the stack to be completed before returning from
>the function and freeing the message structures. Unfortunately, some
>messages may still be in process and 'stuck' in the TCS. At some later
>point, the tcs_tx_done() interrupt will run and try to process messages
>that have already been freed at the end of rpmh_write_batch(). This will
>in turn access the 'needs_free' member of the rpmh_request structure and
>cause KASAN to complain. Furthermore, if there's a message that's
>completed in rpmh_tx_done() and freed immediately after the complete()
>call is made we'll be racing with potentially freed memory when
>accessing the 'needs_free' member:
>
>	CPU0                         CPU1
>	----                         ----
>	rpmh_tx_done()
>	 complete(&compl)
>	                             wait_for_completion(&compl)
>	                             kfree(rpm_msg)
>	 if (rpm_msg->needs_free)
>	 <KASAN warning splat>
>
>Let's fix this by allocating a chunk of completions for each message and
>waiting for all of them to be completed before returning from the batch
>API. Alternatively, we could wait for the last message in the batch, but
>that may be a more complicated change because it looks like
>tcs_tx_done() just iterates through the indices of the queue and
>completes each message instead of tracking the last inserted message and
>completing that first.
>
>Cc: Lina Iyer <ilina@codeaurora.org>
>Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
>Cc: Matthias Kaehlcke <mka@chromium.org>
>Cc: Evan Green <evgreen@chromium.org>
>Fixes: c8790cb6da58 ("drivers: qcom: rpmh: add support for batch RPMH request")
>Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Lina Iyer <ilina@codeaurora.org>

>---
>
>Changes from v1:
> * Incorporated needs_free check earlier
> * Simplified logic to no longer flush everything out on failure
>
> drivers/soc/qcom/rpmh.c | 34 +++++++++++++++++++++-------------
> 1 file changed, 21 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
>index c7beb6841289..ab8f731a3426 100644
>--- a/drivers/soc/qcom/rpmh.c
>+++ b/drivers/soc/qcom/rpmh.c
>@@ -80,6 +80,7 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
> 	struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
> 						    msg);
> 	struct completion *compl = rpm_msg->completion;
>+	bool free = rpm_msg->needs_free;
>
> 	rpm_msg->err = r;
>
>@@ -94,7 +95,7 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
> 	complete(compl);
>
> exit:
>-	if (rpm_msg->needs_free)
>+	if (free)
> 		kfree(rpm_msg);
> }
>
>@@ -348,11 +349,12 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
> {
> 	struct batch_cache_req *req;
> 	struct rpmh_request *rpm_msgs;
>-	DECLARE_COMPLETION_ONSTACK(compl);
>+	struct completion *compls;
> 	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
> 	unsigned long time_left;
> 	int count = 0;
>-	int ret, i, j;
>+	int ret, i;
>+	void *ptr;
>
> 	if (!cmd || !n)
> 		return -EINVAL;
>@@ -362,10 +364,15 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
> 	if (!count)
> 		return -EINVAL;
>
>-	req = kzalloc(sizeof(*req) + count * sizeof(req->rpm_msgs[0]),
>+	ptr = kzalloc(sizeof(*req) +
>+		      count * (sizeof(req->rpm_msgs[0]) + sizeof(*compls)),
> 		      GFP_ATOMIC);
>-	if (!req)
>+	if (!ptr)
> 		return -ENOMEM;
>+
>+	req = ptr;
>+	compls = ptr + sizeof(*req) + count * sizeof(*rpm_msgs);
>+
> 	req->count = count;
> 	rpm_msgs = req->rpm_msgs;
>
>@@ -380,25 +387,26 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
> 	}
>
> 	for (i = 0; i < count; i++) {
>-		rpm_msgs[i].completion = &compl;
>+		struct completion *compl = &compls[i];
>+
>+		init_completion(compl);
>+		rpm_msgs[i].completion = compl;
> 		ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msgs[i].msg);
> 		if (ret) {
> 			pr_err("Error(%d) sending RPMH message addr=%#x\n",
> 			       ret, rpm_msgs[i].msg.cmds[0].addr);
>-			for (j = i; j < count; j++)
>-				rpmh_tx_done(&rpm_msgs[j].msg, ret);
> 			break;
> 		}
> 	}
>
> 	time_left = RPMH_TIMEOUT_MS;
>-	for (i = 0; i < count; i++) {
>-		time_left = wait_for_completion_timeout(&compl, time_left);
>+	while (i--) {
>+		time_left = wait_for_completion_timeout(&compls[i], time_left);
> 		if (!time_left) {
> 			/*
> 			 * Better hope they never finish because they'll signal
>-			 * the completion on our stack and that's bad once
>-			 * we've returned from the function.
>+			 * the completion that we're going to free once
>+			 * we've returned from this function.
> 			 */
> 			WARN_ON(1);
> 			ret = -ETIMEDOUT;
>@@ -407,7 +415,7 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
> 	}
>
> exit:
>-	kfree(req);
>+	kfree(ptr);
>
> 	return ret;
> }
>-- 
>Sent by a computer through tubes
>
