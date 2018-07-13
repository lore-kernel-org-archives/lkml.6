Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE13ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5A32084E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5A32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbeGMSsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:48:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730028AbeGMSsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:48:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6D6540583DB;
        Fri, 13 Jul 2018 18:32:45 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C37623140;
        Fri, 13 Jul 2018 18:32:45 +0000 (UTC)
Subject: Re: [PATCH] locking/rwsem: Take read lock immediate if empty queue
 with no writer
To:     Will Deacon <will.deacon@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mark Ray <mark.ray@hpe.com>, Joe Mario <jmario@redhat.com>,
        Scott Norton <scott.norton@hpe.com>
References: <1531247490-26852-1-git-send-email-longman@redhat.com>
 <20180713100257.GE32020@arm.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <c575a0ab-419b-c0ea-f550-7c5daebbba25@redhat.com>
Date:   Fri, 13 Jul 2018 14:32:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180713100257.GE32020@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 13 Jul 2018 18:32:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 13 Jul 2018 18:32:45 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/2018 06:02 AM, Will Deacon wrote:
> On Tue, Jul 10, 2018 at 02:31:30PM -0400, Waiman Long wrote:
>> It was found that a constant stream of readers might cause the count to
>> go negative most of the time after an initial trigger by a writer even
>> if no writer was present afterward. As a result, most of the readers
>> would have to go through the slowpath reducing their performance.
>>
>> To avoid that from happening, an additional check is added to detect
>> the special case that the reader in the critical section is the only
>> one in the wait queue and no writer is present. When that happens, it
>> can just have the lock and return immediately without further action.
>> Other incoming readers won't see a waiter is present and be forced
>> into the slowpath.
>>
>> After the list_empty() calls, the CPU should have the lock cacheline
>> anyway, so an additional semaphore count check shouldn't have any
>> performance impact.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  kernel/locking/rwsem-xadd.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
> This looks ok to me, but it would be nice to include some performance
> figures in the commit log. Do you have any? Phrases such as "shouldn't have
> any performance impact" and "probably generate better code" don't fill me
> with good feelings ;)
>
> Will
I just got the customer testing results back. I had posted a v2 patch
with the customer data. I also remove wordings that may cause confusion.

Cheers,
Longman
