Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB01C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E6521873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeLRR1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:27:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:35480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726638AbeLRR1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:27:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF648AD65;
        Tue, 18 Dec 2018 17:27:22 +0000 (UTC)
Date:   Tue, 18 Dec 2018 09:27:14 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yongji Xie <elohimes@gmail.com>, mingo@redhat.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@baidu.com>, zhangyu31@baidu.com,
        liuqi16@baidu.com, yuanlinsi01@baidu.com, nixun@baidu.com,
        lilin24@baidu.com, longman@redhat.com,
        andrea.parri@amarulasolutions.com
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181218172714.fa3zpoyqndarqgd3@linux-r8p5>
References: <20181129180828.GA11650@hirez.programming.kicks-ass.net>
 <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com>
 <20181129213017.v3eljor54lfpoug2@linux-r8p5>
 <20181129213421.wwvhsjql3m3lvtv4@linux-r8p5>
 <20181129221714.GF11632@hirez.programming.kicks-ass.net>
 <CAONzpcZ_kQ0cwit+d5uL=v2SqwP=Fo0WSihdCr23uKCAFAhTbQ@mail.gmail.com>
 <20181217113718.GB4900@worktop.programming.kicks-ass.net>
 <20181217205310.pvwcryyaqlrzmaex@linux-r8p5>
 <20181218131031.GJ15430@hirez.programming.kicks-ass.net>
 <20181218131419.GD16284@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181218131419.GD16284@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018, Peter Zijlstra wrote:
>> I'd rather do it like so, except I'm still conflicted on the naming.
>
>> +void wake_q_add(struct wake_q_head *head, struct task_struct *task)
>> +{
>> +	if (__wake_q_add(head, task))
>> +		get_task_struct(task);
>> +}
>> +
>> +void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task)
>> +{
>> +	if (!__wake_a_add(head, task))
>> +		put_task_struct(task);
>>  }
>
>That is, in the one case it has internal reference counting, in the
>other case it consumes the reference counting.

Yeah I like that better for an interface. Also no concurrency in head
so delaying the get() should be ok.

Thanks,
Davidlohr
