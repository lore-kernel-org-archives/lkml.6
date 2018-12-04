Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF21BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976192081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="D/c6l9b8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976192081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbeLDNXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:23:49 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:20436 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbeLDNXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1543929828; x=1575465828;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=1p/Eim5pnFRbUZD4qPcV+RGM/ETPQdicBLu/APe9LiM=;
  b=D/c6l9b8GW04rAMDF41f0Q+6LbLW/36RTlXMbqGXMEXpBLYtYZYPUoyE
   AW2lTTj4vTxBHc9eCZFUjZOkT2WrSw2D6CxZwDAIvlbD+LaLZS/XGwTFu
   msbKJWGEOJsx39SbTkFxDFAW5NsfJi+n3gQuwOfUELBY4yX1E+ZXsbtol
   Q=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="376130486"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Dec 2018 13:23:47 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id wB4DNe5W107292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 4 Dec 2018 13:23:41 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wB4DNbm7020648;
        Tue, 4 Dec 2018 14:23:37 +0100
Subject: Re: Task group cleanups and optimizations (was: Re: [RFC 00/60]
 Coscheduling for Linux)
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180914111251.GC24106@hirez.programming.kicks-ass.net>
 <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
 <282230fe-b8de-01f9-c19b-6070717ba5f8@amazon.de>
 <20180917094844.GR24124@hirez.programming.kicks-ass.net>
 <08b930d9-7ffe-7df3-ab35-e7b58073e489@amazon.de>
 <20181123165102.GB4855@lerouge>
From:   =?UTF-8?Q?Jan_H=2e_Sch=c3=b6nherr?= <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <0f025121-d3b2-36c9-5c0c-7db1d118f317@amazon.de>
Date:   Tue, 4 Dec 2018 14:23:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181123165102.GB4855@lerouge>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2018 17.51, Frederic Weisbecker wrote:
> On Tue, Sep 18, 2018 at 03:22:13PM +0200, Jan H. Schönherr wrote:
>> On 09/17/2018 11:48 AM, Peter Zijlstra wrote:
>>> Right, so the whole bandwidth thing becomes a pain; the simplest
>>> solution is to detect the throttle at task-pick time, dequeue and try
>>> again. But that is indeed quite horrible.
>>>
>>> I'm not quite sure how this will play out.
>>>
>>> Anyway, if we pull off this flattening feat, then you can no longer use
>>> the hierarchy for this co-scheduling stuff.
>>
>> Yeah. I might be a bit biased towards keeping or at least not fully throwing away
>> the nesting of CFS runqueues. ;)
> 
> One detail here, is that hierarchical task group a strong requirement for cosched
> or could you live with it flattened in the end?

Currently, it is a strong requirement.

As mentioned at the bottom of https://lkml.org/lkml/2018/10/19/859 it should be
possible to pull the hierarchical aspect out of CFS and implement it one level
higher. But that would be a major re-design of everything.

I use the hierarchical aspect to a) keep coscheduled groups in separate sets of runqeues,
so that it is easy to select/balance tasks within a particular group; and b) to implement
per-core, per-node, per-system runqueues that represent larger fractions of the system,
which then fan out into per-CPU runqueues (eventually).

Regards
Jan
