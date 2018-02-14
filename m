Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033399AbeBNRTB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:19:01 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:51838 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1033317AbeBNRS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:18:59 -0500
Subject: Re: [PATCH 1/3] jump_label: Warn on failed jump_label patch
To: Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@suse.de>
References: <cover.1518626149.git.jpoimboe@redhat.com>
 <b8f1b55f17c346fba39d3f59a01251185e09e151.1518626149.git.jpoimboe@redhat.com>
 <20180214120112.43821b5e@gandalf.local.home>
From: Jason Baron <jbaron@akamai.com>
Message-ID: <a4ad6f69-8836-779b-f7e7-0e303885c7f5@akamai.com>
Date: Wed, 14 Feb 2018 12:18:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180214120112.43821b5e@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802140203
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802140204
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/14/2018 12:01 PM, Steven Rostedt wrote:
> On Wed, 14 Feb 2018 10:40:41 -0600
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
>> When the jump label code encounters an address which isn't recognized by
>> kernel_text_address(), it just silently fails.
>>
>> This can be dangerous because jump labels are used in a variety of
>> places, and are generally expected to work.  Convert the silent failure
>> to a warning.
> 
> I made ftrace function tracing work on init code, can we do the same
> with tracepoints (aka jump labels)?
> 

jump labels do work on init code, except they don't work on it after it
has been freed :)

It uses 'kernel_text_address()', which will return true for init code if
system_state < SYSTEM_RUNNING. See: core_kernel_text().

So I'm guessing that the warnings here are coming from init code that
has already been freed. Are we sure that these warnings are coming from
init code that hasn't already been freed?

Thanks,

-Jason

> But I have to say that this goes with my argument that there exists
> tracepoints in the kernel that nobody cares about ;-)
> 
> -- Steve
> 
>>
>> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
>> ---
>>  kernel/jump_label.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
>> index b4517095db6a..c71fb7cdfc41 100644
>> --- a/kernel/jump_label.c
>> +++ b/kernel/jump_label.c
>> @@ -370,8 +370,12 @@ static void __jump_label_update(struct static_key *key,
>>  		 * kernel_text_address() verifies we are not in core kernel
>>  		 * init code, see jump_label_invalidate_module_init().
>>  		 */
>> -		if (entry->code && kernel_text_address(entry->code))
>> -			arch_jump_label_transform(entry, jump_label_type(entry));
>> +		if (entry->code) {
>> +			if (kernel_text_address(entry->code))
>> +				arch_jump_label_transform(entry, jump_label_type(entry));
>> +			else
>> +				WARN_ONCE(1, "can't patch jump_label at %pS", (void *)entry->code);
>> +		}
>>  	}
>>  }
>>  
> 
