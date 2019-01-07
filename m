Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DB3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D8220665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g3scBpS6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a+3HNQZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfAGVXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:23:25 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53744 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfAGVXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:23:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C10A0601B4; Mon,  7 Jan 2019 21:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546896203;
        bh=nV1tcWbjYFqz8Zyhq3IKVpXVwWw3Db8UBIbeOfKimm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g3scBpS6fkrotFsZkIYytD1J5jYrrkcDgsfZE2AHN0fJd5/E5XWoH3NHNoKreGYoZ
         ptXFpkAx8blkZABw24EroA6kgi12d1Hve2wmaGQ1baUZX0q9XurF5HU3dikhehK9xA
         32wxj7gijJqUEA2dDzKdtBlMB7mpIYQbxwDOfJ0s=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D96C6029B;
        Mon,  7 Jan 2019 21:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546896202;
        bh=nV1tcWbjYFqz8Zyhq3IKVpXVwWw3Db8UBIbeOfKimm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+3HNQZrUbg11p4tqQPZu2iUawF2wBfqmBxsJiUNUtsF7l2EusUC1IbE794B3H15p
         rfaqVoiQrFoE/eR6cSNf4rclkWPCn61BoAZkTsEFDF5Suc9v1GNXRj+Xarr0ZugBud
         JEOOgURyozUwMPLvKprFZnr3xmP7Zmyf/CelHpFE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D96C6029B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 7 Jan 2019 14:23:21 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] soc: qcom: rpmh: Avoid accessing freed memory from batch
 API
Message-ID: <20190107212321.GK14960@codeaurora.org>
References: <20190103174657.251968-1-swboyd@chromium.org>
 <CAE=gft6M7aaPjS0KRg7dyfLOGtgXdU1qaT7oNeRHeNFQpRouWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAE=gft6M7aaPjS0KRg7dyfLOGtgXdU1qaT7oNeRHeNFQpRouWA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04 2019 at 14:02 -0700, Evan Green wrote:
>On Thu, Jan 3, 2019 at 9:47 AM Stephen Boyd <swboyd@chromium.org> wrote:
>>
>> Using the batch API from the interconnect driver sometimes leads to a
>> KASAN error due to an access to freed memory. This is easier to trigger
>> with threadirqs on the kernel commandline.
>>
>>  BUG: KASAN: use-after-free in rpmh_tx_done+0x114/0x12c
>>  Read of size 1 at addr fffffff51414ad84 by task irq/110-apps_rs/57
>>
>>  CPU: 0 PID: 57 Comm: irq/110-apps_rs Tainted: G        W         4.19.10 #72
>>  Call trace:
>>   dump_backtrace+0x0/0x2f8
>>   show_stack+0x20/0x2c
>>   __dump_stack+0x20/0x28
>>   dump_stack+0xcc/0x10c
>>   print_address_description+0x74/0x240
>>   kasan_report+0x250/0x26c
>>   __asan_report_load1_noabort+0x20/0x2c
>>   rpmh_tx_done+0x114/0x12c
>>   tcs_tx_done+0x450/0x768
>>   irq_forced_thread_fn+0x58/0x9c
>>   irq_thread+0x120/0x1dc
>>   kthread+0x248/0x260
>>   ret_from_fork+0x10/0x18
>>
>>  Allocated by task 385:
>>   kasan_kmalloc+0xac/0x148
>>   __kmalloc+0x170/0x1e4
>>   rpmh_write_batch+0x174/0x540
>>   qcom_icc_set+0x8dc/0x9ac
>>   icc_set+0x288/0x2e8
>>   a6xx_gmu_stop+0x320/0x3c0
>>   a6xx_pm_suspend+0x108/0x124
>>   adreno_suspend+0x50/0x60
>>   pm_generic_runtime_suspend+0x60/0x78
>>   __rpm_callback+0x214/0x32c
>>   rpm_callback+0x54/0x184
>>   rpm_suspend+0x3f8/0xa90
>>   pm_runtime_work+0xb4/0x178
>>   process_one_work+0x544/0xbc0
>>   worker_thread+0x514/0x7d0
>>   kthread+0x248/0x260
>>   ret_from_fork+0x10/0x18
>>
>>  Freed by task 385:
>>   __kasan_slab_free+0x12c/0x1e0
>>   kasan_slab_free+0x10/0x1c
>>   kfree+0x134/0x588
>>   rpmh_write_batch+0x49c/0x540
>>   qcom_icc_set+0x8dc/0x9ac
>>   icc_set+0x288/0x2e8
>>   a6xx_gmu_stop+0x320/0x3c0
>>   a6xx_pm_suspend+0x108/0x124
>>   adreno_suspend+0x50/0x60
>>  cr50_spi spi5.0: SPI transfer timed out
>>   pm_generic_runtime_suspend+0x60/0x78
>>   __rpm_callback+0x214/0x32c
>>   rpm_callback+0x54/0x184
>>   rpm_suspend+0x3f8/0xa90
>>   pm_runtime_work+0xb4/0x178
>>   process_one_work+0x544/0xbc0
>>   worker_thread+0x514/0x7d0
>>   kthread+0x248/0x260
>>   ret_from_fork+0x10/0x18
>>
>>  The buggy address belongs to the object at fffffff51414ac80
>>   which belongs to the cache kmalloc-512 of size 512
>>  The buggy address is located 260 bytes inside of
>>   512-byte region [fffffff51414ac80, fffffff51414ae80)
>>  The buggy address belongs to the page:
>>  page:ffffffbfd4505200 count:1 mapcount:0 mapping:fffffff51e00c680 index:0x0 compound_mapcount: 0
>>  flags: 0x4000000000008100(slab|head)
>>  raw: 4000000000008100 ffffffbfd4529008 ffffffbfd44f9208 fffffff51e00c680
>>  raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
>>  page dumped because: kasan: bad access detected
>>
>>  Memory state around the buggy address:
>>   fffffff51414ac80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>   fffffff51414ad00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  >fffffff51414ad80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                     ^
>>   fffffff51414ae00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>   fffffff51414ae80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>
>> The batch API sets the same completion for each rpmh message that's sent
>> and then loops through all the messages and waits for that single
>> completion declared on the stack to be completed before returning from
>> the function and freeing the message structures. Unfortunately, some
>> messages may still be in process and 'stuck' in the TCS. At some later
>> point, the tcs_tx_done() interrupt will run and try to process messages
>> that have already been freed at the end of rpmh_write_batch(). This will
>> in turn access the 'needs_free' member of the rpmh_request structure and
>> cause KASAN to complain.
>>
>> Let's fix this by allocating a chunk of completions for each message and
>> waiting for all of them to be completed before returning from the batch
>> API. Alternatively, we could wait for the last message in the batch, but
>> that may be a more complicated change because it looks like
>> tcs_tx_done() just iterates through the indices of the queue and
>> completes each message instead of tracking the last inserted message and
>> completing that first.
>>
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
>> Cc: Matthias Kaehlcke <mka@chromium.org>
>> Cc: Evan Green <evgreen@chromium.org>
>> Fixes: c8790cb6da58 ("drivers: qcom: rpmh: add support for batch RPMH request")
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>>  drivers/soc/qcom/rpmh.c | 25 +++++++++++++++++--------
>>  1 file changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
>> index c7beb6841289..3b3e8b0b2d95 100644
>> --- a/drivers/soc/qcom/rpmh.c
>> +++ b/drivers/soc/qcom/rpmh.c
>> @@ -348,11 +348,12 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>>  {
>>         struct batch_cache_req *req;
>>         struct rpmh_request *rpm_msgs;
>> -       DECLARE_COMPLETION_ONSTACK(compl);
>> +       struct completion *compls;
>>         struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
>>         unsigned long time_left;
>>         int count = 0;
>>         int ret, i, j;
>> +       void *ptr;
>>
>>         if (!cmd || !n)
>>                 return -EINVAL;
>> @@ -362,10 +363,15 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>>         if (!count)
>>                 return -EINVAL;
>>
>> -       req = kzalloc(sizeof(*req) + count * sizeof(req->rpm_msgs[0]),
>> +       ptr = kzalloc(sizeof(*req) +
>> +                     count * (sizeof(req->rpm_msgs[0]) + sizeof(*compls)),
>>                       GFP_ATOMIC);
>> -       if (!req)
>> +       if (!ptr)
>>                 return -ENOMEM;
>> +
>> +       req = ptr;
>> +       compls = ptr + sizeof(*req) + count * sizeof(*rpm_msgs);
>> +
>>         req->count = count;
>>         rpm_msgs = req->rpm_msgs;
>>
>> @@ -380,7 +386,10 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>>         }
>>
>>         for (i = 0; i < count; i++) {
>> -               rpm_msgs[i].completion = &compl;
>> +               struct completion *compl = &compls[i];
>> +
>> +               init_completion(compl);
>> +               rpm_msgs[i].completion = compl;
>>                 ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msgs[i].msg);
>>                 if (ret) {
>>                         pr_err("Error(%d) sending RPMH message addr=%#x\n",
>
>It's a little weird that we call rpmh_tx_done on a bunch of transfers
>we never submitted, just so the completion will get signaled so we can
>wait on it in the next loop. We could just do count = i; break; here
>instead.
>
It seems like it was carried over from my earlier submissions, where I
was reference counting the number of completions for a batch. I beleive,
with what we are doing here, we don't need to call tx_done with this
approach.

>> @@ -393,12 +402,12 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>>
>>         time_left = RPMH_TIMEOUT_MS;
>>         for (i = 0; i < count; i++) {
>> -               time_left = wait_for_completion_timeout(&compl, time_left);
>> +               time_left = wait_for_completion_timeout(&compls[i], time_left);
>
>So we give RPMH_TIMEOUT_MS for all the completions to finish. I wonder
>if it would be better to have that as RPMH_TIMEOUT_MS per completion.
>
That would work too. RPMH_TIMEOUT_MS is a large number that it should
not be a problem with this approach either.

Thanks,
Lina
