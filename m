Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ED4ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC102088F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CEr9K7dO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC102088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbeIRGhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:37:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32840 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeIRGhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:37:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8I13ioL040236;
        Tue, 18 Sep 2018 01:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=TJhoJKkJakRS6WtMTqmX60LGCMpGZbg+vbBA44rU33k=;
 b=CEr9K7dOVneUULarHDN6sGRZFirfY3PJlXRpxzOxwO2QdZ14Qk/bgJB/gIHcnsBlto8c
 e8QPllqnsEWagyQqFqk5Kj76GosXvVZuJAt1EbWyplNOOUoGq1SInW49SAik/ZBYLYSy
 DLsEzo4ljytwDVK+Ki4U56vAqmPWt/x40MIGL2J1fyIG1sB2xqg9S96u+n0eHg+A7GAn
 sBUelWx+dqDPp9CaX6n6dK8ajdNkezy11MxaRKfxRlGVueCOtNt/RjdFDgtf28WSsoSM
 /ueSidzmSsZCREN/qjNMbQOLh5oBMsXvC11zW0aN3t15F5GKgyIkqLVyYEXv4RCsOsPk hA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mgsgthfdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 01:07:38 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8I17bik005501
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 01:07:37 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8I17bnI016423;
        Tue, 18 Sep 2018 01:07:37 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Sep 2018 18:07:37 -0700
Subject: Re: [RFC PATCH 2/2] pipe: use pipe busy wait
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, dhaval.giani@oracle.com,
        steven.sistare@oracle.com
References: <20180830202458.32579-1-subhra.mazumdar@oracle.com>
 <20180830202458.32579-3-subhra.mazumdar@oracle.com>
 <20180907122557.GY24106@hirez.programming.kicks-ass.net>
 <304ffc06-1ab9-19d5-d5ca-e63e2abe2900@oracle.com>
 <20180917224344.GB3284@worktop.programming.kicks-ass.net>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <00c2fe72-0672-ea97-fe58-c7cd767c0837@oracle.com>
Date:   Mon, 17 Sep 2018 18:07:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917224344.GB3284@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9019 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=805
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809180008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/17/2018 03:43 PM, Peter Zijlstra wrote:
> On Mon, Sep 17, 2018 at 02:05:40PM -0700, Subhra Mazumdar wrote:
>> On 09/07/2018 05:25 AM, Peter Zijlstra wrote:
>>> Why not just busy wait on current->state ? A little something like:
>>>
>>> diff --git a/fs/pipe.c b/fs/pipe.c
>>> index bdc5d3c0977d..8d9f1c95ff99 100644
>>> --- a/fs/pipe.c
>>> +++ b/fs/pipe.c
>>> @@ -106,6 +106,7 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
>>>   void pipe_wait(struct pipe_inode_info *pipe)
>>>   {
>>>   	DEFINE_WAIT(wait);
>>> +	u64 start;
>>>   	/*
>>>   	 * Pipes are system-local resources, so sleeping on them
>>> @@ -113,7 +114,15 @@ void pipe_wait(struct pipe_inode_info *pipe)
>>>   	 */
>>>   	prepare_to_wait(&pipe->wait, &wait, TASK_INTERRUPTIBLE);
>>>   	pipe_unlock(pipe);
>>> -	schedule();
>>> +
>>> +	preempt_disable();
>>> +	start = local_clock();
>>> +	while (!need_resched() && current->state != TASK_RUNNING &&
>>> +			(local_clock() - start) < pipe->poll_usec)
>>> +		cpu_relax();
>>> +	schedule_preempt_disabled();
>>> +	preempt_enable();
>>> +
>>>   	finish_wait(&pipe->wait, &wait);
>>>   	pipe_lock(pipe);
>>>   }
>> This will make the current thread always spin and block as it itself does
>> the state change to TASK_RUNNING in finish_wait.
> Nah, the actual wakeup will also do that state change. The one in
> finish_wait() is for the case where the wait condition became true
> without wakeup, such that we don't 'leak' the INTERRUPTIBLE state.
Ok, it works. I see similar improvements with hackbench as the original
patch.
