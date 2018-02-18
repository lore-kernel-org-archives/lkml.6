Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeBRXgf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 18:36:35 -0500
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:33521 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbeBRXge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 18:36:34 -0500
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.184
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [PATCH] srcu: Fix incorrect condition in srcu_funnel_exp_start()
To: paulmck@linux.vnet.ibm.com
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
References: <1518598794-26752-1-git-send-email-byungchul.park@lge.com>
 <20180214214245.GS3617@linux.vnet.ibm.com>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <f9abfde2-ad0d-edab-0a2a-a62515ffe870@lge.com>
Date: Mon, 19 Feb 2018 08:36:30 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180214214245.GS3617@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/2018 6:42 AM, Paul E. McKenney wrote:
> On Wed, Feb 14, 2018 at 05:59:54PM +0900, Byungchul Park wrote:
>> We should've kept sp->srcu_gp_seq_needed_exp the furthest. But
>> it probably fails because of the incorrect condition. Fix it.
>>
>> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> 
> Good catch, and thank you for reviewing the SRCU code, but Ildar Ismagilov
> beat you to this one.  Please see 574428dee1f3 ("rcu: Fix misprint in
> srcu_funnel_exp_start") in -rcu.

Hi Paul,

I'm sorry I'm late. It's been Lunar New Year holiday since last
thursday.

Do you mean:

git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

Is this rcu's main dev-tree?

Thanks for replying anyway, and happy new year~

> 
> 							Thanx, Paul
> 
>> ---
>>   kernel/rcu/srcutree.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>> index d5cea81..44bc0fa 100644
>> --- a/kernel/rcu/srcutree.c
>> +++ b/kernel/rcu/srcutree.c
>> @@ -626,7 +626,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *sp, struct srcu_node *snp,
>>   		spin_unlock_irqrestore_rcu_node(snp, flags);
>>   	}
>>   	spin_lock_irqsave_rcu_node(sp, flags);
>> -	if (!ULONG_CMP_LT(sp->srcu_gp_seq_needed_exp, s))
>> +	if (ULONG_CMP_LT(sp->srcu_gp_seq_needed_exp, s))
>>   		sp->srcu_gp_seq_needed_exp = s;
>>   	spin_unlock_irqrestore_rcu_node(sp, flags);
>>   }
>> -- 
>> 1.9.1
>>
> 
> 

-- 
Thanks,
Byungchul
