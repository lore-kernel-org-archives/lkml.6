Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750997AbeDYAIR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 20:08:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43684 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeDYAIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 20:08:16 -0400
Subject: Re: [PATCH 3/3] sched: limit cpu search and rotate search window for
 scalability
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-4-subhra.mazumdar@oracle.com>
 <20180424125349.GU4082@hirez.programming.kicks-ass.net>
From: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <d7efc4d3-7c50-752e-a1ae-a164d991dbcc@oracle.com>
Date: Tue, 24 Apr 2018 17:10:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180424125349.GU4082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8873 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240226
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 05:53 AM, Peter Zijlstra wrote:
> On Mon, Apr 23, 2018 at 05:41:16PM -0700, subhra mazumdar wrote:
>> Lower the lower limit of idle cpu search in select_idle_cpu() and also put
>> an upper limit. This helps in scalability of the search by restricting the
>> search window.
>> @@ -6297,15 +6297,24 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>   
>>   	if (sched_feat(SIS_PROP)) {
>>   		u64 span_avg = sd->span_weight * avg_idle;
>> -		if (span_avg > 4*avg_cost)
>> +		if (span_avg > 2*avg_cost) {
>>   			nr = div_u64(span_avg, avg_cost);
>> -		else
>> -			nr = 4;
>> +			if (nr > 4)
>> +				nr = 4;
>> +		} else {
>> +			nr = 2;
>> +		}
>>   	}
> Why do you need to put a max on? Why isn't the proportional thing
> working as is? (is the average no good because of big variance or what)
Firstly the choosing of 512 seems arbitrary. Secondly the logic here is
that the enqueuing cpu should search up to time it can get work itself.
Why is that the optimal amount to search?
>
> Again, why do you need to lower the min; what's wrong with 4?
>
> The reason I picked 4 is that many laptops have 4 CPUs and desktops
> really want to avoid queueing if at all possible.
To find the optimum upper and lower limit I varied them over many
combinations. 4 and 2 gave the best results across most benchmarks.
