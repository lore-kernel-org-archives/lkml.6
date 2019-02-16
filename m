Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065FAC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 11:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3D2222DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 11:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfBPLTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 06:19:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbfBPLTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 06:19:11 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8040581B00B149F3FA97;
        Sat, 16 Feb 2019 19:19:09 +0800 (CST)
Received: from [127.0.0.1] (10.177.244.145) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Sat, 16 Feb 2019
 19:19:03 +0800
Subject: Re: [PATCH] tracing: fix incorrect tracer freeing when opening
 tracing pipe
To:     Steven Rostedt <rostedt@goodmis.org>
References: <1550060946-45984-1-git-send-email-yi.zhang@huawei.com>
 <20190213083635.36f4762e@gandalf.local.home>
CC:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <miaoxie@huawei.com>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <ed080680-ddac-3e99-720e-a8371fce5ab6@huawei.com>
Date:   Sat, 16 Feb 2019 19:19:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20190213083635.36f4762e@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.244.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/13 21:36, Steven Rostedt Wrote:
> On Wed, 13 Feb 2019 20:29:06 +0800
> "zhangyi (F)" <yi.zhang@huawei.com> wrote:
> 
>> Commit d716ff71dd12 ("tracing: Remove taking of trace_types_lock in
>> pipe files") use the current tracer instead of the copy in
>> tracing_open_pipe(), but it forget to remove the freeing sentence in
>> the error path.
>>
>> Fixes: d716ff71dd12 ("tracing: Remove taking of trace_types_lock in pipe files")
> 
> Thanks.
> 
> As this is harmless (frees to NULL is ok, and iter is allocated with
> kzalloc()), I'm going to just add this for the next merge window.
> 

This patch patch want to remove kfree(iter->trace) instead of kfree(iter),
which is set by tr->current_trace and probably not allocated dynamically.
So if we kfree such tracer in the error path, it will lead to BUG_ON.

Thanks，
Yi.

> 
>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
>> ---
>>  kernel/trace/trace.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index c521b73..b583ff7 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -5624,7 +5624,6 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
>>  	return ret;
>>  
>>  fail:
>> -	kfree(iter->trace);
>>  	kfree(iter);
>>  	__trace_array_put(tr);
>>  	mutex_unlock(&trace_types_lock);
> 
> 
> .
> 

