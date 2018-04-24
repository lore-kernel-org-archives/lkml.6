Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbeDXWhS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:37:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45880 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbeDXWhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:37:14 -0400
Subject: Re: [PATCH 2/3] sched: introduce per-cpu var next_cpu to track search
 limit
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-3-subhra.mazumdar@oracle.com>
 <20180424124712.GR4082@hirez.programming.kicks-ass.net>
From: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <991291cf-68e8-24ef-f3a2-ee8a45f58b6a@oracle.com>
Date: Tue, 24 Apr 2018 15:39:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180424124712.GR4082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8873 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=981
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240212
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 05:47 AM, Peter Zijlstra wrote:
> On Mon, Apr 23, 2018 at 05:41:15PM -0700, subhra mazumdar wrote:
>> @@ -17,6 +17,7 @@
>>   #include <trace/events/sched.h>
>>   
>>   DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>> +DEFINE_PER_CPU_SHARED_ALIGNED(int, next_cpu);
>>   
>>   #if defined(CONFIG_SCHED_DEBUG) && defined(HAVE_JUMP_LABEL)
>>   /*
>> @@ -6018,6 +6019,7 @@ void __init sched_init(void)
>>   		struct rq *rq;
>>   
>>   		rq = cpu_rq(i);
>> +		per_cpu(next_cpu, i) = -1;
> If you leave it uninitialized it'll be 0, and we can avoid that extra
> branch in the next patch, no?
0 can be a valid cpu id. I wanted to distinguish the first time. The branch
predictor will be fully trained so will not have any cost.
