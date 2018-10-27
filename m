Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01966ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 00:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EAA2064A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 00:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="M10XEl6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EAA2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeJ0IqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 04:46:24 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:24265 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbeJ0IqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 04:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540598837; x=1572134837;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=PHPso/Udnf8JDqgcmL2PDCJe/S9nUX89w6woEDGe9TU=;
  b=M10XEl6zsm+cF6xmC3d2aN/MQlEo7hIPxK/pOutl8iwUSsAC9jL/5Oin
   rnLva3F+ppX+Nft4+lRtqScVam17db3uxW09lDYy1vnraCHfRoYxXiaZf
   DjtJcQntz6pkbbloLrmJyowhJGcA2cBys/1nkiySbvLtvokyWVFsKwnCZ
   Q=;
X-IronPort-AV: E=Sophos;i="5.54,429,1534809600"; 
   d="scan'208";a="638710279"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Oct 2018 00:07:15 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9R07Btc111328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sat, 27 Oct 2018 00:07:13 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9R07CU6004631;
        Sat, 27 Oct 2018 02:07:12 +0200
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <65abfba5-7c51-fd99-898e-f6e74969fea3@oracle.com>
From:   =?UTF-8?Q?Jan_H=2e_Sch=c3=b6nherr?= <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <3fbb5a02-1fc6-eaaf-b8b5-be8d24133747@amazon.de>
Date:   Sat, 27 Oct 2018 02:07:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <65abfba5-7c51-fd99-898e-f6e74969fea3@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2018 01.05, Subhra Mazumdar wrote:
> 
> 
>> D) What can I *not* do with this?
>> ---------------------------------
>>
>> Besides the missing load-balancing within coscheduled task-groups, this
>> implementation has the following properties, which might be considered
>> short-comings.
>>
>> This particular implementation focuses on SCHED_OTHER tasks managed by CFS
>> and allows coscheduling them. Interrupts as well as tasks in higher
>> scheduling classes are currently out-of-scope: they are assumed to be
>> negligible interruptions as far as coscheduling is concerned and they do
>> *not* cause a preemption of a whole group. This implementation could be
>> extended to cover higher scheduling classes. Interrupts, however, are an
>> orthogonal issue.
>>
>> The collective context switch from one coscheduled set of tasks to another
>> -- while fast -- is not atomic. If a use-case needs the absolute guarantee
>> that all tasks of the previous set have stopped executing before any task
>> of the next set starts executing, an additional hand-shake/barrier needs to
>> be added.
>>
> The leader doesn't kick the other cpus _immediately_ to switch to a
> different cosched group. 

It does. (Or at least, it should, in case you found evidence that it does not.)

Specifically, the logic to not preempt the currently running task before
some minimum time has passed, is without effect for a collective context
switch.

> So threads from previous cosched group will keep
> running in other HTs till their sched_slice is over (in worst case). This
> can still keep the window of L1TF vulnerability open?

No. Per the above, the window due to the collective context switch should
not be as long as "the remaining time slice" but more towards the IPI
delay. During this window, tasks of different coscheduling groups may
execute simultaneously.

In addition (as mentioned in the quoted text above), there more cases where
a task of a coscheduled group on one SMT sibling may execute simultaneously
with some other code not from the same coscheduled group: tasks in
scheduling classes higher than CFS, and interrupts -- as both of them
operate outside the scope of the coscheduler.

Regards
Jan
