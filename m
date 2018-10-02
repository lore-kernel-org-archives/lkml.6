Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D536C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BA32064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BA32064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJCBNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:13:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:24825 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbeJCBNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:13:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 11:28:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,332,1534834800"; 
   d="scan'208";a="88588346"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.165]) ([10.7.198.165])
  by orsmga003.jf.intel.com with ESMTP; 02 Oct 2018 11:23:27 -0700
Subject: Re: [RFC workqueue/driver-core PATCH 1/5] workqueue: Provide
 queue_work_near to queue work near a given NUMA node
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-nvdimm@lists.01.org, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, len.brown@intel.com,
        dave.jiang@intel.com, rafael@kernel.org, vishal.l.verma@intel.com,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org,
        dan.j.williams@intel.com
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
 <20180926215138.13512.33146.stgit@localhost.localdomain>
 <20180926215307.GA270328@devbig004.ftw2.facebook.com>
 <9b002bbb-3e6d-9e99-d8f9-36df4306093e@linux.intel.com>
 <20180926220957.GB270328@devbig004.ftw2.facebook.com>
 <ba72f007-84e2-6fe0-b128-d876dadef5f5@linux.intel.com>
 <20181001160142.GE270328@devbig004.ftw2.facebook.com>
 <4eebc017-23a2-a26e-095c-66433061a141@linux.intel.com>
 <20181002174116.GG270328@devbig004.ftw2.facebook.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <be9081de-f186-b265-934d-78cec2a8792f@linux.intel.com>
Date:   Tue, 2 Oct 2018 11:23:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181002174116.GG270328@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/2018 10:41 AM, Tejun Heo wrote:
> Hello,
> 
> On Mon, Oct 01, 2018 at 02:54:39PM -0700, Alexander Duyck wrote:
>>> It might be better to leave queue_work_on() to be used for per-cpu
>>> workqueues and introduce queue_work_near() as you suggseted.  I just
>>> don't want it to duplicate the node selection code in it.  Would that
>>> work?
>>
>> So if I understand what you are saying correctly we default to
>> round-robin on a given node has no CPUs attached to it. I could
>> probably work with that if that is the default behavior instead of
>> adding much of the complexity I already have.
> 
> Yeah, it's all in wq_select_unbound_cpu().  Right now, if the
> requested cpu isn't in wq_unbound_cpumask, it falls back to dumb
> round-robin.  We can probably do better there and find the nearest
> node considering topology.

Well if we could get wq_select_unbound_cpu doing the right thing based 
on node topology that would be most of my work solved right there. 
Basically I could just pass WQ_CPU_UNBOUND with the correct node and it 
would take care of getting to the right CPU.

>> The question I have then is what should I do about workqueues that
>> aren't WQ_UNBOUND if they attempt to use queue_work_near? In that
> 
> Hmm... yeah, let's just use queue_work_on() for now.  We can sort it
> out later and users could already do that anyway.
> 
> Thanks.

So are you saying I should just return an error for now if somebody 
tries to use something other than an unbound workqueue with 
queue_work_near, and expect everyone else to just use queue_work_on for 
the other workqueue types?

Thanks.

- Alex
