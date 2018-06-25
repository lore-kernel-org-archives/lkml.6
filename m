Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45647C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85EC2606F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eqrnWG1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85EC2606F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964908AbeFYT0a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:26:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39900 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754532AbeFYT03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:26:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5PJEXdK060381;
        Mon, 25 Jun 2018 19:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=q21WXcY1Vn43MOQufiyNVkKtmEroZEECdYU+f/2cCNk=;
 b=eqrnWG1r6YD61kOV4AAug2LC8on8+JXxTMrf4w8Gp0YwlB5Br3hUH96YCBKMUUEU5z/i
 9Tw7BNvtPz+xS0JrU95yXDmVvSiL6Zu7lXW8rMv6GjWtBDs1/jzrfWcyme1ufHSynlrb
 EmhR3pq+X3jKi1NIqbcvaXrTW0FJrExk6xIsbLb75gaUyxaGU91KIC+RoIZFLuDXqF1J
 4FdapfoaQCO9dFMS6Q9VrkL/WeyE5pAtHG6ldcqDuQAl3Y6u5QyW/XgWYOVd4Y6AmbEe
 4puWAtHyeSdIjiIF3JKBBBY534t0RQXi8F4nseiso6dM8dBj7G6zrAPpvgMnBtqHZKUi eg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2ju1wfh825-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 19:23:28 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5PJNQvP000555
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 19:23:26 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5PJNNDp004866;
        Mon, 25 Jun 2018 19:23:23 GMT
Received: from xakep.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Jun 2018 12:23:23 -0700
Date:   Mon, 25 Jun 2018 15:23:20 -0400
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v12 10/11] sched: early boot clock
Message-ID: <20180625192320.kzmqkvmfh5aeuhhx@xakep.localdomain>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-11-pasha.tatashin@oracle.com>
 <20180625085543.GT2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625085543.GT2494@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180622
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8935 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806250220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I have revisted this patch after modifying x86 sched_clock() to contigously
output tsc once it is setup early in boot, based on the latest suggestions
from Thomas.

On 18-06-25 10:55:43, Peter Zijlstra wrote:
> On Thu, Jun 21, 2018 at 05:25:17PM -0400, Pavel Tatashin wrote:
> > Allow sched_clock() to be used before schec_clock_init() and
> > sched_clock_init_late() are called. This provides us with a way to get
> > early boot timestamps on machines with unstable clocks.
> 
> There are !x86 architectures that use this code and might not expect to
> have their sched_clock() called quite that early. Please verify.
> 
> > +	local_irq_disable();
> > +	__gtod_offset = sched_clock() + __sched_clock_offset - ktime_get_ns();
> > +	local_irq_enable();
> 
> This might work in sched_clock_init(), which is pre-SMP.
> 
> >  	sched_clock_running = 2;
> >  	/*
> >  	 * Ensure that it is impossible to not do a static_key update.
> > @@ -350,8 +355,9 @@ u64 sched_clock_cpu(int cpu)
> >  	if (sched_clock_stable())
> >  		return sched_clock() + __sched_clock_offset;
> >  
> > -	if (unlikely(!sched_clock_running))
> > -		return 0ull;
> > +	/* Use early clock until sched_clock_init_late() */
> > +	if (unlikely(sched_clock_running < 2))
> > +		return sched_clock() + __sched_clock_offset;
> 
> And then this remains !sched_clock_running, except instead of 0, you
> then return sched_clock() + __sched_clock_offset;
> 
> >  	preempt_disable_notrace();
> >  	scd = cpu_sdc(cpu);

Unfortunatly the above suggestion won't work. And here is why.

We have a call sequence like this:

start_kernel
    sched_init()
        sched_clock_init()
	     In this call sched_clock_running is set to 1. Which means
	     that sched_clock_cpu() starts doing the following sequence:
	     scd = cpu_sdc(cpu);
	     clock = sched_clock_local(scd);
	     Where we try to filter the output of sched_clock() based
	     on the value of scd. But, that won't work, because to get
	     this functionality, we need to have: timer initialized
	     that wakes up and updates scd, and we need timekeeping
	     initialized, so we can call ktime_get_ns(). Both of which
	     are called later.
    ...
    timekeeping_init() After this we can call ktime_get_ns()
    time_init()  Here we configure x86_late_time_init pointer.
    ...
    late_time_init()
        x86_late_time_init()
            x86_init.timers.timer_init()
	        hpet_time_init() Only after this call we finally start
		getting clock interrupts, and can get precise output from
		sched_clock_local().

The way I solved the above, is I changed sched_clock() to keep outputing
time based on early boot sched_clock() until sched_clock_init_late(), at
whic point everything is configured and we can switch to the permanent
clock, eventhough this happens after smp init.

If you have a better solution, please let me know.

Thank you,
Pavel
