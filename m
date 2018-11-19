Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FCBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C69213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XMphKTs/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C69213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404284AbeKTD4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:56:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38662 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403859AbeKTD4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:56:35 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAJHTTxN181076;
        Mon, 19 Nov 2018 17:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ISOLRNcBoUoVy9+rxqBohqfsgwIqRjXX8cZVbVxbCMM=;
 b=XMphKTs/84pOTGLGjayfcuhbUBBY8CiG9tKu4rmaKuzPfysNI0qb16SmZh/0cZMGFCwK
 MBDQubc08AUXHGnrjFTohMPgHmjFAQW13ePIcKtpeLHPv67tyKM9i+uSPd4pVSWJusFH
 jrVygIqeBARYnKe4b0jcayVKwclrH6HD7aRR6k24QIG0tNZSmgUj32HeoyerMY4jiAdI
 afN/oJxse9boeVazyqanJWWVrmEu5djzzOsrbvM6/0hmP2YYDGzl35TDR+mMi+5PVivg
 nmhShpbUDwJgYFuCS059RsNhzvMs4nodDEo//hpQ/7Mxj98ybjirEvQ/cJO5YzV3nXyr pg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2ntbmqfbvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Nov 2018 17:31:39 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAJHVcJ2022071
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Nov 2018 17:31:39 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAJHVbpC032483;
        Mon, 19 Nov 2018 17:31:37 GMT
Received: from [10.152.35.100] (/10.152.35.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Nov 2018 09:31:37 -0800
Subject: Re: [PATCH v3 05/10] sched/fair: Hoist idle_stamp up from
 idle_balance
To:     Valentin Schneider <valentin.schneider@arm.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
 <1541767840-93588-6-git-send-email-steven.sistare@oracle.com>
 <9ad62a6f-0269-a5d9-9757-ba5419f9cc1d@arm.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <0d8ceaff-6368-2dff-9e2c-e5928ab39bab@oracle.com>
Date:   Mon, 19 Nov 2018 12:31:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <9ad62a6f-0269-a5d9-9757-ba5419f9cc1d@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9082 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811190160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/2018 2:07 PM, Valentin Schneider wrote:
> Hi Steve,
> 
> On 09/11/2018 12:50, Steve Sistare wrote:
>> Move the update of idle_stamp from idle_balance to the call site in
>> pick_next_task_fair, to prepare for a future patch that adds work to
>> pick_next_task_fair which must be included in the idle_stamp interval.
>> No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  kernel/sched/fair.c | 23 ++++++++++++++---------
>>  1 file changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 9031d39..da368ed 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3725,6 +3725,8 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>>  	rq->misfit_task_load = task_h_load(p);
>>  }
>>  
>> +#define IF_SMP(statement)	statement
>> +
> 
> I'm not too hot on those IF_SMP() macros. Since you're not introducing
> any other user for them, what about an inline function for rq->idle_stamp
> setting ? When it's mapped to an empty statement (!CONFIG_SMP) GCC is
> smart enough to remove the rq_clock() that would be passed to it on
> CONFIG_SMP:

That may be true now, but I worry that rq_clock or its subroutines may gain
side effects in the future that prevent the compiler from removing it.  However,
I could push rq_clock into the inline function:

  static inline void rq_idle_stamp_set(rq)    { rq->idle_stamp = rq_clock(rq); }
  static inline void rq_idle_stamp_clear(rq)  { rq->idle_stamp = 0; }

I like that better, do you?

- Steve
 
> ----->8-----
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c11adf3..34d9864 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3725,7 +3725,10 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>         rq->misfit_task_load = task_h_load(p);
>  }
>  
> -#define IF_SMP(statement)      statement
> +static inline void set_rq_idle_stamp(struct rq *rq, u64 value)
> +{
> +       rq->idle_stamp = value;
> +}
>  
>  static void overload_clear(struct rq *rq)
>  {
> @@ -3772,7 +3775,7 @@ static inline int idle_balance(struct rq *rq, struct rq_flags *rf)
>         return 0;
>  }
>  
> -#define IF_SMP(statement)      /* empty */
> +static inline void set_rq_idle_stamp(struct rq *rq, u64 value) {}
>  
>  static inline void overload_clear(struct rq *rq) {}
>  static inline void overload_set(struct rq *rq) {}
> @@ -6773,12 +6776,12 @@ done: __maybe_unused;
>          * We must set idle_stamp _before_ calling idle_balance(), such that we
>          * measure the duration of idle_balance() as idle time.
>          */
> -       IF_SMP(rq->idle_stamp = rq_clock(rq);)
> +       set_rq_idle_stamp(rq, rq_clock(rq));
>  
>         new_tasks = idle_balance(rq, rf);
>  
>         if (new_tasks)
> -               IF_SMP(rq->idle_stamp = 0;)
> +               set_rq_idle_stamp(rq, 0);
>  
>         /*
>          * Because idle_balance() releases (and re-acquires) rq->lock, it is
> 
