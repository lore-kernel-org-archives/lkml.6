Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeBBVS3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 16:18:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56442 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbeBBVSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 16:18:21 -0500
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
To: Peter Zijlstra <peterz@infradead.org>
Cc: subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
 <20180201123335.GV2249@hirez.programming.kicks-ass.net>
 <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
 <20180202172153.GO2269@hirez.programming.kicks-ass.net>
 <ed78c502-c1f8-43b3-f3d4-e0256e4085ee@oracle.com>
 <5b9f0828-8d35-885b-3eba-d31ca46da642@oracle.com>
 <20180202200401.GS2269@hirez.programming.kicks-ass.net>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <70ff99d5-1240-69ae-63d4-773b201d8c0e@oracle.com>
Date: Fri, 2 Feb 2018 16:17:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180202200401.GS2269@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=951
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020255
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/2018 3:04 PM, Peter Zijlstra wrote:
> On Fri, Feb 02, 2018 at 01:34:58PM -0500, Steven Sistare wrote:
>> Actually, I take back my take back.  I suspect the primary benefit
>> of random selection is that it breaks up resonance states where
>> CPUs that are busy tend to stay busy, and CPUs that are idle tend
>> to stay idle, which is reinforced by starting the search at target =
>> last cpu ran.
> 
> Which, according to there here patches:
> 
>   https://lkml.kernel.org/r/20180130104555.4125-1-mgorman@techsingularity.net
> 
> is a good thing, because of power management.

Yes, but it's a bad thing if ready to run tasks pile on busy CPUs and idle 
CPUs go unused.  Stating the obvious, when the search for idle fails, the 
thread goes on a busy CPU. The existing logic that checks and uses the
initial target if it is idle reduces unnecessary spreading and is power
friendly (indeed, added in the patch you reference).  Subhra's patch does
not change that.

- Steve
