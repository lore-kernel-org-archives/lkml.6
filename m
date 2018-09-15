Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC8AECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 08:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83982083A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 08:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="G9mPef2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83982083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeIOOGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 10:06:46 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:59829 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeIOOGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 10:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1537001312; x=1568537312;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vw2DB2zcnP+gDwbbRzEWSKdSYbouUlMjD2mwAmdwVR0=;
  b=G9mPef2XqBX2WhcoRskvvJ7cMhOSAo/YzHknKwDWj7iVXlg5uKX1XPJm
   dTT7g+GiSQStDuRiPsEbvFDyj9bw8P7wwYGXf1vS8aeGmJv/zjHSv0Q8l
   kxeLFfAfHE1ycPM+kN8w7IoQPZnuo4XAg/KIznuUsr3Yd/H/DlnRp+qzW
   E=;
X-IronPort-AV: E=Sophos;i="5.53,376,1531785600"; 
   d="scan'208";a="362530902"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Sep 2018 08:48:31 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w8F8mO9K110025
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sat, 15 Sep 2018 08:48:28 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w8F8mLNn027075;
        Sat, 15 Sep 2018 10:48:21 +0200
Subject: Task group cleanups and optimizations (was: Re: [RFC 00/60]
 Coscheduling for Linux)
From:   "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180914111251.GC24106@hirez.programming.kicks-ass.net>
 <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <282230fe-b8de-01f9-c19b-6070717ba5f8@amazon.de>
Date:   Sat, 15 Sep 2018 10:48:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/2018 06:25 PM, Jan H. Schönherr wrote:
> On 09/14/2018 01:12 PM, Peter Zijlstra wrote:
>>
>> There are known scalability problems with the existing cgroup muck; you
>> just made things a ton worse. The existing cgroup overhead is
>> significant, you also made that many times worse.
>>
>> The cgroup stuff needs cleanups and optimization, not this.

[...]

> With respect to the need of cleanups and optimizations: I agree, that
> task groups are a bit messy. For example, here's my current wish list
> off the top of my head:
> 
> a) lazy scheduler operations; for example: when dequeuing a task, don't bother
>    walking up the task group hierarchy to dequeue all the SEs -- do it lazily
>    when encountering an empty CFS RQ during picking when we hold the lock anyway.
> 
> b) ability to move CFS RQs between CPUs: someone changed the affinity of
>    a cpuset? No problem, just attach the runqueue with all the tasks elsewhere.
>    No need to touch each and every task.
> 
> c) light-weight task groups: don't allocate a runqueue for every CPU in the
>    system, when it is known that tasks in the task group will only ever run
>    on at most two CPUs, or so. (And while there is of course a use case for
>    VMs in this, another class of use cases are auxiliary tasks, see eg, [1-5].)
> 
> Is this the level of optimizations, you're thinking about? Or do you want
> to throw away the whole nested CFS RQ experience in the code?

I guess, it would be possible to flatten the task group hierarchy, that is usually
created when nesting cgroups. That is, enqueue task group SEs always within the
root task group.

That should take away much of the (runtime-)overhead, no?

The calculation of shares would need to be a different kind of complex than it is
now. But that might be manageable.

CFS bandwidth control would also need to change significantly as we would now
have to dequeue/enqueue nested cgroups below a throttled/unthrottled hierarchy.
Unless *those* task groups don't participate in this flattening.

(And probably lots of other stuff, I didn't think about right now.)

Regards
Jan

