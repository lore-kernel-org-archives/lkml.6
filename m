Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FC7C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6802D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6802D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeIJWbE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:31:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbeIJWbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:31:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BB92400C3C0;
        Mon, 10 Sep 2018 17:35:54 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23CDE1134CC9;
        Mon, 10 Sep 2018 17:35:54 +0000 (UTC)
Subject: Re: [PATCH] locking/rwsem: Make owner store task pointer of last
 owning reader
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
References: <1536265114-10842-1-git-send-email-longman@redhat.com>
 <20180910093156.GS24082@hirez.programming.kicks-ass.net>
 <83b333ea-8ef2-84ea-6810-4ab1a67eef88@redhat.com>
 <20180910171550.GA3902@linux-r8p5>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <70273024-d40a-e7bb-740a-629089d169f8@redhat.com>
Date:   Mon, 10 Sep 2018 13:35:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180910171550.GA3902@linux-r8p5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 10 Sep 2018 17:35:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 10 Sep 2018 17:35:54 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2018 01:15 PM, Davidlohr Bueso wrote:
> On Mon, 10 Sep 2018, Waiman Long wrote:
>
>> One major issue with a combined count/owner is that we may have to use
>> cmpxchg for reader lock which will certainly impact reader-heavy
>> workloads. I have also thought about ways to compress the task pointer
>> address so that it can use fewer bits and leave the rests for reader
>> count. It is probably doable on 64-bit systems, but likely not on 32-bit
>> system given that there are less bits to play around.
>
> Yeah we've discussed this before. As a cleanup it would obviously be
> good,
> but I fear about raw performance loss when using cmpxchg instead of xadd. 

I don't think using cmpxchg for writers will be a performance issue.
However, using cmpxchg for readers will be. One thought that I have is
to use the tid of the writer on the lower half and use the upper half
for reader count. However, there is some overhead in translating tid to
task pointer. So I don't know how useful that may be. So we may still
need to keep the owner field around.

Cheers,
Longman

