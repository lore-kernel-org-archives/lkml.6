Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6AD47C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B48B208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B48B208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754338AbeFLNLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:11:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754289AbeFLNLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:11:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37D0D77885;
        Tue, 12 Jun 2018 13:11:41 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.36.118.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B3897C42;
        Tue, 12 Jun 2018 13:11:35 +0000 (UTC)
Subject: Re: Restartable Sequences system call merged into Linux
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com>
 <31fc101a-295b-067b-1a82-7e9e509fc92f@redhat.com>
 <305409897.10888.1528747473727.JavaMail.zimbra@efficios.com>
From:   Florian Weimer <fweimer@redhat.com>
Message-ID: <091061df-3482-8762-30e4-feaf3417be11@redhat.com>
Date:   Tue, 12 Jun 2018 15:11:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <305409897.10888.1528747473727.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 12 Jun 2018 13:11:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 12 Jun 2018 13:11:41 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'fweimer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 10:04 PM, Mathieu Desnoyers wrote:
> ----- On Jun 11, 2018, at 3:55 PM, Florian Weimer fweimer@redhat.com wrote:
> 
>> On 06/11/2018 09:49 PM, Mathieu Desnoyers wrote:
>>> It should be noted that there can be only one rseq TLS area registered per
>>> thread,
>>> which can then be used by many libraries and by the executable, so this is a
>>> process-wide (per-thread) resource that we need to manage carefully.
>>
>> Is it possible to resize the area after thread creation, perhaps even
>> from other threads?
> 
> I'm not sure why we would want to resize it. The per-thread area is fixed-size.
> Its layout is here: include/uapi/linux/rseq.h: struct rseq

Looks I was mistaken and this is very similar to the robust mutex list.

Should we treat it the same way?  Always allocate it for each new thread 
and register it with the kernel?

> The ABI is designed so that all users (program and libraries) can interact
> through this per-thread TLS area.

Then the user code needs just the address of the structure.

How much coordination is needed between different users of this 
interface?  Looking at the the section hacks, I don't think we want to 
put this into glibc at this stage.  It looks more like something for 
which we traditionally require compiler support.

Thanks,
Florian
