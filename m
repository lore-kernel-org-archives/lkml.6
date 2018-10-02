Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73D6C64EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FC82089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FC82089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJCD3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:29:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbeJCD3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:29:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 902F7C025D20;
        Tue,  2 Oct 2018 20:44:27 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6543D648AB;
        Tue,  2 Oct 2018 20:44:23 +0000 (UTC)
Subject: Re: [PATCH v12 9/9] cpuset: Support forced turning off of partition
 flag
To:     Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <1535380884-31308-1-git-send-email-longman@redhat.com>
 <1535380884-31308-10-git-send-email-longman@redhat.com>
 <20180827164004.GE3978217@devbig004.ftw2.facebook.com>
 <0daf1f43-2292-0281-3ab8-aef20d0475dc@redhat.com>
 <20181002200627.GI270328@devbig004.ftw2.facebook.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9d356cf9-0256-338c-0854-cf52c5d0f8fe@redhat.com>
Date:   Tue, 2 Oct 2018 16:44:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181002200627.GI270328@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 02 Oct 2018 20:44:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2018 04:06 PM, Tejun Heo wrote:
> Hello, Waiman.
>
> My apologies for the delay.
>
> On Mon, Aug 27, 2018 at 01:50:18PM -0400, Waiman Long wrote:
>> My current code has explicitly assumed the following relationship for
>> partition root.
>>
>>     cpus_allowed = effective_cpus + reserved_cpus
>>
>> Also effective_cpus cannot be empty. Specifically, cpus_allowed has to
>> be equal to effective_cpus before a cpuset can be made a partition root.
>>
>> Any changes that break the above conditions will turn off the partition
>> flag forcefully. The only exception is cpu offlining where cpus_allowed
>>> effective_cpus + reserved_cpus can happen.
>> One reason for doing so is because reserved_cpus is hidden. So the main
>> way to infer that is to do cpus_allowed - effective_cpus.
>>
>> It is probably doable to make cpus_allowed >= effective_cpus +
>> reserved_cpus in general, but we may need to expose reserved_cpus as a
>> read-only file, for instance. There may also be other complications that
>> we will need to take care of if this is supported. My current preference
>> is to not doing that unless there is compelling reason to do so.
> So, if we're gonna make this hierarchical, I think it probably would
> be better to go in all the way.  It's kinda weird to mix the two
> approaches - the normal cpuset operation following the usual
> convention (it'd be really great to fix the removal part too) and
> parition code doing something else.
>
> I think adding another interface file should be fine here.
>
> Thanks.
>
OK, I will revise the patch to make it work without the removal part.

Thanks,
Longman

