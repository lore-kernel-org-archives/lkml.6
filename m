Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B050EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D6720820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D6720820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504544AbeKXAID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:08:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:30414 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394528AbeKXAID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:08:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Nov 2018 05:23:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,269,1539673200"; 
   d="scan'208";a="283559131"
Received: from unknown (HELO [10.251.85.254]) ([10.251.85.254])
  by fmsmga006.fm.intel.com with ESMTP; 23 Nov 2018 05:23:48 -0800
Subject: Re: [Intel-gfx] [PATCH 2/3] mm, notifier: Catch sleeping/blocking for
 !blockable
To:     Daniel Vetter <daniel@ffwll.ch>, Michal Hocko <mhocko@kernel.org>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
 <20181122165106.18238-3-daniel.vetter@ffwll.ch>
 <20181123111237.GE8625@dhcp22.suse.cz>
 <20181123123838.GL4266@phenom.ffwll.local>
 <20181123124643.GK8625@dhcp22.suse.cz>
 <CAKMK7uGv7dHqE4_Gmsum=uhfbVo=ymq-QhsR5cHLOC4ZTq4MxA@mail.gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <50923341-d759-2621-7166-695df4cd88fb@linux.intel.com>
Date:   Fri, 23 Nov 2018 13:23:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKMK7uGv7dHqE4_Gmsum=uhfbVo=ymq-QhsR5cHLOC4ZTq4MxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/11/2018 13:12, Daniel Vetter wrote:
> On Fri, Nov 23, 2018 at 1:46 PM Michal Hocko <mhocko@kernel.org> wrote:
>>
>> On Fri 23-11-18 13:38:38, Daniel Vetter wrote:
>>> On Fri, Nov 23, 2018 at 12:12:37PM +0100, Michal Hocko wrote:
>>>> On Thu 22-11-18 17:51:05, Daniel Vetter wrote:
>>>>> We need to make sure implementations don't cheat and don't have a
>>>>> possible schedule/blocking point deeply burried where review can't
>>>>> catch it.
>>>>>
>>>>> I'm not sure whether this is the best way to make sure all the
>>>>> might_sleep() callsites trigger, and it's a bit ugly in the code flow.
>>>>> But it gets the job done.
>>>>
>>>> Yeah, it is quite ugly. Especially because it makes DEBUG config
>>>> bahavior much different. So is this really worth it? Has this already
>>>> discovered any existing bug?
>>>
>>> Given that we need an oom trigger to hit this we're not hitting this in CI
>>> (oom is just way to unpredictable to even try). I'd kinda like to also add
>>> some debug interface so I can provoke an oom kill of a specially prepared
>>> process, to make sure we can reliably exercise this path without killing
>>> the kernel accidentally. We do similar tricks for our shrinker already.
>>
>> Create a task with oom_score_adj = 1000 and trigger the oom killer via
>> sysrq and you should get a predictable oom invocation and execution.
> 
> Ah right. We kinda do that already in an attempt to get the tests
> killed without the runner, for accidental oom. Just didn't think about
> this in the context of intentionally firing the oom. I'll try whether
> I can bake up some new subtest in our userptr/mmu-notifier testcases.

Very handy trick - I think I will think of applying it in the shrinker 
area as well.

Regards,

Tvrtko
