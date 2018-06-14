Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CFFC1C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AB8208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90AB8208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965329AbeFNOlv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:41:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964868AbeFNOlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:41:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B90424070484;
        Thu, 14 Jun 2018 14:41:48 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-117-97.ams2.redhat.com [10.36.117.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 815F92166BB2;
        Thu, 14 Jun 2018 14:41:47 +0000 (UTC)
Subject: Re: Restartable Sequences system call merged into Linux
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Pavel Machek <pavel@ucw.cz>, carlos <carlos@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com>
 <417742741.11550.1528821084084.JavaMail.zimbra@efficios.com>
 <20180614122759.GB8798@amd>
 <894222691.12973.1528981314012.JavaMail.zimbra@efficios.com>
 <20180614132557.GA15201@amd>
 <956816108.13001.1528983496098.JavaMail.zimbra@efficios.com>
 <20180614134959.GA4084@amd> <48a0d905-2568-51b8-80c9-a20ecaa25f9b@redhat.com>
 <263666353.13077.1528986978282.JavaMail.zimbra@efficios.com>
From:   Florian Weimer <fweimer@redhat.com>
Message-ID: <21eae301-50ff-e95a-f3c7-dedcf2f66842@redhat.com>
Date:   Thu, 14 Jun 2018 16:41:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <263666353.13077.1528986978282.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 14 Jun 2018 14:41:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 14 Jun 2018 14:41:48 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'fweimer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 04:36 PM, Mathieu Desnoyers wrote:
> ----- On Jun 14, 2018, at 10:00 AM, Florian Weimer fweimer@redhat.com wrote:
> 
>> On 06/14/2018 03:49 PM, Pavel Machek wrote:
>>> Hi!
>>>
>>>>>> - rseq_preempt(): on preemption, the scheduler sets the TIF_NOTIFY_RESUME thread
>>>>>>     flag, so rseq_handle_notify_resume() can check whether it's in a rseq critical
>>>>>>     section when returning to user-space,
>>>>>> - rseq_signal_deliver(): on signal delivery, rseq_handle_notify_resume() checks
>>>>>>     whether it's in a rseq critical section,
>>>>>> - rseq_migrate: on migration, the scheduler sets TIF_NOTIFY_RESUME as well,
>>>>>
>>>>> Yes, this is not likely to be noticeable.
>>>>>
>>>>> But the proposal wanted to add a syscall to thread creation, right?
>>>>> And I believe that may be noticeable.
>>>>
>>>> Fair point! Do we have a standard benchmark that would stress this ?
>>>
>>> Web server performance benchmarks basically test clone() performance
>>> in many cases.
>>
>> Isn't that fork?  I expect that the rseq arena is inherited on fork and
>> fork-type clone, otherwise it's going to be painful.
> 
> On fork or clone creating a new process, the rseq tls area is inherited
> from the thread that does the fork syscall.
> 
> On creation of a new thread with clone, there is no such inheritance.

Makes sense.  So fork-based (web) servers will not be impacted by the 
additional system call, and thread-based servers likely use a thread 
pool anyway.  I'm not really concerned about the additional system call 
here.

Thanks,
Florian
