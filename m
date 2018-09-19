Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552E1ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAB1214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="FadSqIQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAB1214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbeISPAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:00:35 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:53886 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeISPAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1537349014; x=1568885014;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mc/do7kRgrPVycZMQlIfIAg6pRqidsaus1azdPvilJo=;
  b=FadSqIQIUmimDFi4tXsEPYRT5yBA7qd9nKIMdIL+gp7nqec6HW71PJq6
   LYspym0rbDj8zF0pQn60ysqlMMwCuyAq4Im1OVFFVN5SU7bGc0jpjPDFQ
   i4kSkWErUu9Nzwh3D7/vG7os+Ug7G5SzsRsprsGfIX9N+pGXvAA0oMK0F
   s=;
X-IronPort-AV: E=Sophos;i="5.53,393,1531785600"; 
   d="scan'208";a="698134040"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Sep 2018 09:23:33 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w8J9NQ7O069181
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 19 Sep 2018 09:23:29 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w8J9NMxi005781;
        Wed, 19 Sep 2018 11:23:23 +0200
From:   "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
Subject: Re: Task group cleanups and optimizations (was: Re: [RFC 00/60]
 Coscheduling for Linux)
To:     Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180914111251.GC24106@hirez.programming.kicks-ass.net>
 <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
 <282230fe-b8de-01f9-c19b-6070717ba5f8@amazon.de>
 <20180917094844.GR24124@hirez.programming.kicks-ass.net>
 <08b930d9-7ffe-7df3-ab35-e7b58073e489@amazon.de>
 <bf7db07c6e8bb5600262612cd55f37668ed495e5.camel@surriel.com>
Openpgp: preference=signencrypt
Message-ID: <da011fa3-6021-5012-4ef7-7c99c4c65c5b@amazon.de>
Date:   Wed, 19 Sep 2018 11:23:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bf7db07c6e8bb5600262612cd55f37668ed495e5.camel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 04:35 PM, Rik van Riel wrote:
> On Tue, 2018-09-18 at 15:22 +0200, Jan H. Schönherr wrote:
[...]
> Task priorities in a flat runqueue are relatively straightforward, with
> vruntime scaling just like done for nice levels, but I have to admit
> that throttled groups provide a challenge.

Do you know/have an idea how the flat approach would further skew the
approximations currently done in calc_group_shares()/calc_group_runnable()?

With the nested hierarchy the (shared) task group SE is updated
whenever something changes. With the flat approach, you'd only be
able to update a task SE, when you have to touch the task anyway.
Just from thinking briefly about it, it feels like values would be
out of date for longer periods of time.


>> However, the only efficient way that I can currently think of, is a
>> hybrid model between the "full nesting" that is currently there, and
>> the "no nesting" you were describing above.
>> 
>> It would flatten all task groups that do not actively contribute some
>> function, which would be all task groups purely for accounting
>> purposes and those for *unthrottled* CFS hierarchies (and those for
>> coscheduling that contain exactly one SE in a runqueue). The nesting
>> would still be kept for *throttled* hierarchies (and the coscheduling 
>> stuff). (And if you wouldn't have mentioned a way to get rid of
>> nesting completely, I would have kept a single level of nesting for
>> accounting purposes as well.)
>> 
>> This would allow us to lazily dequeue SEs that have run out of
>> bandwidth when we encounter them, and already enqueue them in the
>> nested task group (whose SE is not enqueued at the moment). That way,
>> it's still a O(1) operation to re-enable all tasks, once runtime is
>> available again. And O(1) to throttle a repeat offender.
> 
> I suspect most systems will have a number of runnable tasks no larger
> than the number of CPUs most of the time.
> 
> That makes "re-enable all the tasks" often equivalent to "re-enable one
> task".
>
> Can we handle the re-enabling (or waking up!) of one task almost as fast
> as we can without the cpu controller?

We could start by transparently special-casing the "just one SE in a
runqueue" case, where that single SE is enqueued directly into the next
parent, and everything falls back to nesting, the moment a second SE pops
up.

That might allow reaping the benefits for many cases without hurting
other cases. It's also more a gradual conversion of code.

Regards
Jan
