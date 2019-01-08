Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E183C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2742070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ClkO9XVS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j9Ll7uuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfAHRtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:49:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36516 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfAHRtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:49:41 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3545B60247; Tue,  8 Jan 2019 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546969780;
        bh=EMJHAzM74ccB/MMhceeTznZDqTAeyMSNcQ5HeOyd3qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ClkO9XVS420yh6dTfXjoq9hIfzplBb8cogkQrO52GD8v4xbCpnXz9aqOoZwh+ypk8
         mEWMrQFaMadKYARqUQaofLfW/VejpWcdszDARPCMYG/Xu9P+duWuajPZjjo8PH6KHi
         b9Pqrz3A1KVnS5r4Hl2ZTmxhM8E0bGB7vX3o+YA8=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BFFAF601D7;
        Tue,  8 Jan 2019 17:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546969778;
        bh=EMJHAzM74ccB/MMhceeTznZDqTAeyMSNcQ5HeOyd3qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9Ll7uuz6zRnFUK84bVvQLbAVc/uPomthpwH//HMbAi0jVlnux66Y3KvJavHXeUXQ
         Gf1H0IAZS/2Z3sjeQaWyFq7vOX+xDDiiDvPXrQkiVmvQii4wpQr90oTEftYSJWgvBN
         P8jByJjJ9aDXweQ3KISgi5xaeTuxRXfc6rQWtr38=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFFAF601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 8 Jan 2019 10:49:38 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH] soc: qcom: rpmh: Avoid accessing freed memory from batch
 API
Message-ID: <20190108174938.GA22547@codeaurora.org>
References: <20190103174657.251968-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190103174657.251968-1-swboyd@chromium.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03 2019 at 10:47 -0700, Stephen Boyd wrote:
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
>cause KASAN to complain.
>
Raju and I were discussing this solution and we think the issue may be
because of a race condition between the thread calling the completion
and the thread waiting for completion. Completion releases the waiting
thread and then we try to read rpm_msg->needs_free after that. But, if
we could read in the rpm_msg->needs_free before calling completion, we
would not see the problem. How about this instead?

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index c7beb6841289..0303a2971d4a 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -80,6 +80,7 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
        struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
                                                    msg);
        struct completion *compl = rpm_msg->completion;
+       bool free = rpm_msg->needs_free;

        rpm_msg->err = r;

@@ -94,7 +95,7 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
        complete(compl);

 exit:
-       if (rpm_msg->needs_free)
+       if (free)
                kfree(rpm_msg);
 }



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
>---
> drivers/soc/qcom/rpmh.c | 25 +++++++++++++++++--------
> 1 file changed, 17 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
>index c7beb6841289..3b3e8b0b2d95 100644
>--- a/drivers/soc/qcom/rpmh.c
>+++ b/drivers/soc/qcom/rpmh.c
>@@ -348,11 +348,12 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
> {
> 	struct batch_cache_req *req;
> 	struct rpmh_request *rpm_msgs;
>-	DECLARE_COMPLETION_ONSTACK(compl);
>+	struct completion *compls;
> 	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
> 	unsigned long time_left;
> 	int count = 0;
> 	int ret, i, j;
>+	void *ptr;
>
> 	if (!cmd || !n)
> 		return -EINVAL;
>@@ -362,10 +363,15 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
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
>@@ -380,7 +386,10 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
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
>@@ -393,12 +402,12 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>
> 	time_left = RPMH_TIMEOUT_MS;
> 	for (i = 0; i < count; i++) {
>-		time_left = wait_for_completion_timeout(&compl, time_left);
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
>@@ -407,7 +416,7 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
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
