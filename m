Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E21BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22582082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IGnNzq0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22582082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeIEFSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 01:18:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59226 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbeIEFSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 01:18:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w850oKMo177468;
        Wed, 5 Sep 2018 00:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=tf4HsFc1+QQncoGJ98uUp0Se6wuMhX+N8BV2Thy0lBs=;
 b=IGnNzq0zL+h+3mwnb3euR3G2UlxonKxA2Bmgu7llNaIh5hqD3rNn+6LpWFV0t7Q/XioZ
 U0LNCCWBT5GgUBbjgb7kTD63LAJyWXyxWxe7pRvYYl9nyQ8OqJWvFsJLFCQSXqVtH/68
 1lOmys9UJrd47GluOP1EMInilFtt63H7lrGoH2K80cIDYuUJq85R5fgDPcpqHC/eunmN
 yfrxh5c4FwkvFf7ZvDvFttHD7yzQnj/SBbuhZK2bs6N9U0hgDp2RuUKUK9liN2dBqWp1
 CY142NrGFROjg/EKBbqueGoHuP4Tocg8/yNxKwvxX4fmFcXODx+eGQATgxQ651XcBwmt Lw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2m7j6tgfwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Sep 2018 00:50:32 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w850oV6C022800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Sep 2018 00:50:31 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w850oVkR020541;
        Wed, 5 Sep 2018 00:50:31 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Sep 2018 17:50:30 -0700
Subject: Re: [RFC PATCH 1/2] pipe: introduce busy wait for pipe
To:     Steven Sistare <steven.sistare@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, dhaval.giani@oracle.com
References: <20180830202458.32579-1-subhra.mazumdar@oracle.com>
 <20180830202458.32579-2-subhra.mazumdar@oracle.com>
 <db00b844-055e-2024-2334-8e4b0e0ac5c5@oracle.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <575e7d13-98e2-b5bf-e241-3f72a28b8c8a@oracle.com>
Date:   Tue, 4 Sep 2018 17:50:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <db00b844-055e-2024-2334-8e4b0e0ac5c5@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9006 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809050007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/31/2018 09:09 AM, Steven Sistare wrote:
> On 8/30/2018 4:24 PM, subhra mazumdar wrote:
>> Introduce pipe_ll_usec field for pipes that indicates the amount of micro
>> seconds a thread should spin if pipe is empty or full before sleeping. This
>> is similar to network sockets. Workloads like hackbench in pipe mode
>> benefits significantly from this by avoiding the sleep and wakeup overhead.
>> Other similar usecases can benefit. pipe_wait_flag is used to signal any
>> thread busy waiting. pipe_busy_loop_timeout checks if spin time is over.
>>
>> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
>> ---
>>   include/linux/pipe_fs_i.h | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
>> index e7497c9..fdfd2a2 100644
>> --- a/include/linux/pipe_fs_i.h
>> +++ b/include/linux/pipe_fs_i.h
>> @@ -1,6 +1,8 @@
>>   #ifndef _LINUX_PIPE_FS_I_H
>>   #define _LINUX_PIPE_FS_I_H
>>   
>> +#include <linux/sched/clock.h>
>> +
>>   #define PIPE_DEF_BUFFERS	16
>>   
>>   #define PIPE_BUF_FLAG_LRU	0x01	/* page is on the LRU */
>> @@ -54,6 +56,8 @@ struct pipe_inode_info {
>>   	unsigned int waiting_writers;
>>   	unsigned int r_counter;
>>   	unsigned int w_counter;
>> +	unsigned int pipe_ll_usec;
>> +	unsigned long pipe_wait_flag;
>>   	struct page *tmp_page;
>>   	struct fasync_struct *fasync_readers;
>>   	struct fasync_struct *fasync_writers;
>> @@ -157,6 +161,21 @@ static inline int pipe_buf_steal(struct pipe_inode_info *pipe,
>>   	return buf->ops->steal(pipe, buf);
>>   }
>>   
>> +static inline unsigned long pipe_busy_loop_current_time(void)
>> +{
>> +	return (unsigned long)(local_clock() >> 10);
> Why ">> 10" ? local_lock() has nanosec units, and you compare to the tunable
> pipe_llc_sec which has microsec units.  Should be ">> 3".  Better yet, redefine
> the tunable to have nanosec units.  I suspect you will need very large values
> of the tunable to show similar results.
It's 2^10. I don't think using nanosec units is necessary. It is unlikely
data will be read or written in nano seconds. sk_busy_loop_timeout for
sockets uses micro seconds too.
>
> Also, since this type of optimization consumes CPU extra cycles that could
> be used by other tasks, show the overall CPU utilization before and after
> the optimization, such as by using "time hackbench ...".
OK.

Thanks,
Subhra
>
> - Steve
>
>> +}
>> +
>> +static inline bool pipe_busy_loop_timeout(struct pipe_inode_info *pipe,
>> +					  unsigned long start_time)
>> +{
>> +	unsigned long bp_usec = READ_ONCE(pipe->pipe_ll_usec);
>> +	unsigned long end_time = start_time + bp_usec;
>> +	unsigned long now = pipe_busy_loop_current_time();
>> +
>> +	return time_after(now, end_time);
>> +}
>> +
>>   /* Differs from PIPE_BUF in that PIPE_SIZE is the length of the actual
>>      memory allocation, whereas PIPE_BUF makes atomicity guarantees.  */
>>   #define PIPE_SIZE		PAGE_SIZE
>>

