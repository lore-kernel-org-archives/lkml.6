Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90737ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367072146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xbpeTQBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367072146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeIRCfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:35:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43140 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbeIRCfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:35:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8HL4J4k072181;
        Mon, 17 Sep 2018 21:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=IWKHzgQHjytR3xTEyVS8uF3QhBxCmkQl9MzyPuQArg4=;
 b=xbpeTQBbdMdrkyZCv3neQVTrcwvgKYhP3Mj7FBK3y4urd/vDbem7p3Qlm4cFIF2imhuL
 7Mc+jrmLHxXeigEr1VXJGAcDZ2eW5WknM089hgcYTrPRRLpGc60yX35z8pIm/9ikC/bp
 XMb6AnfYaMZnAhX237Cu0ylD3IFrpI3/m4Xqq2wUyFkE+pj7uuCmdYKhCZAtqgivjKJe
 tAljefS8YzBtfwQuyOa2LDEi+5lfFPofNuzG07FEHkl6M3HGKZVIFHwm1EJ1bGXCgA3a
 HGz/Tvm4boxn0TBPfk9oV7xIpstcX41Vp+v90CBHnYVOkFQqVIWwqOBsLBdaofAdbh7Y Vg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mgsgtgu6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 21:05:43 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8HL5aIa013013
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 21:05:37 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8HL5aHM005158;
        Mon, 17 Sep 2018 21:05:36 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Sep 2018 14:05:36 -0700
Subject: Re: [RFC PATCH 2/2] pipe: use pipe busy wait
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, dhaval.giani@oracle.com,
        steven.sistare@oracle.com
References: <20180830202458.32579-1-subhra.mazumdar@oracle.com>
 <20180830202458.32579-3-subhra.mazumdar@oracle.com>
 <20180907122557.GY24106@hirez.programming.kicks-ass.net>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <304ffc06-1ab9-19d5-d5ca-e63e2abe2900@oracle.com>
Date:   Mon, 17 Sep 2018 14:05:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907122557.GY24106@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9019 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809170209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/2018 05:25 AM, Peter Zijlstra wrote:
> On Thu, Aug 30, 2018 at 01:24:58PM -0700, subhra mazumdar wrote:
>> +void pipe_busy_wait(struct pipe_inode_info *pipe)
>> +{
>> +	unsigned long wait_flag = pipe->pipe_wait_flag;
>> +	unsigned long start_time = pipe_busy_loop_current_time();
>> +
>> +	pipe_unlock(pipe);
>> +	preempt_disable();
>> +	for (;;) {
>> +		if (pipe->pipe_wait_flag > wait_flag) {
>> +			preempt_enable();
>> +			pipe_lock(pipe);
>> +			return;
>> +		}
>> +		if (pipe_busy_loop_timeout(pipe, start_time))
>> +			break;
>> +		cpu_relax();
>> +	}
>> +	preempt_enable();
>> +	pipe_lock(pipe);
>> +	if (pipe->pipe_wait_flag > wait_flag)
>> +		return;
>> +	pipe_wait(pipe);
>> +}
>> +
>> +void wake_up_busy_poll(struct pipe_inode_info *pipe)
>> +{
>> +	pipe->pipe_wait_flag++;
>> +}
> Why not just busy wait on current->state ? A little something like:
>
> diff --git a/fs/pipe.c b/fs/pipe.c
> index bdc5d3c0977d..8d9f1c95ff99 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -106,6 +106,7 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
>   void pipe_wait(struct pipe_inode_info *pipe)
>   {
>   	DEFINE_WAIT(wait);
> +	u64 start;
>   
>   	/*
>   	 * Pipes are system-local resources, so sleeping on them
> @@ -113,7 +114,15 @@ void pipe_wait(struct pipe_inode_info *pipe)
>   	 */
>   	prepare_to_wait(&pipe->wait, &wait, TASK_INTERRUPTIBLE);
>   	pipe_unlock(pipe);
> -	schedule();
> +
> +	preempt_disable();
> +	start = local_clock();
> +	while (!need_resched() && current->state != TASK_RUNNING &&
> +			(local_clock() - start) < pipe->poll_usec)
> +		cpu_relax();
> +	schedule_preempt_disabled();
> +	preempt_enable();
> +
>   	finish_wait(&pipe->wait, &wait);
>   	pipe_lock(pipe);
>   }
This will make the current thread always spin and block as it itself does
the state change to TASK_RUNNING in finish_wait.
