Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A838C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352A020666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352A020666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeJBEew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:34:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:39193 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbeJBEew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:34:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 14:54:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,329,1534834800"; 
   d="scan'208";a="262015182"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.166]) ([10.7.198.166])
  by orsmga005.jf.intel.com with ESMTP; 01 Oct 2018 14:54:40 -0700
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
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <4eebc017-23a2-a26e-095c-66433061a141@linux.intel.com>
Date:   Mon, 1 Oct 2018 14:54:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181001160142.GE270328@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/2018 9:01 AM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 26, 2018 at 03:19:21PM -0700, Alexander Duyck wrote:
>> On 9/26/2018 3:09 PM, Tejun Heo wrote:
>> I could just use queue_work_on probably, but is there any issue if I
>> am passing CPU values that are not in the wq_unbound_cpumask? That
> 
> That should be fine.  If it can't find any available cpu, it'll fall
> back to round-robin.  We probably can improve it so that it can
> consider the numa distance when falling back.
> 
>> was mostly my concern. Also for an unbound queue do I need to worry
>> about the hotplug lock? I wasn't sure if that was the case or not as
> 
> Issuers don't need to worry about them.
> 
>> I know it is called out as something to be concerned with using
>> queue_work_on, but in __queue_work the value is just used to
>> determine which node to grab a work queue from.
> 
> It might be better to leave queue_work_on() to be used for per-cpu
> workqueues and introduce queue_work_near() as you suggseted.  I just
> don't want it to duplicate the node selection code in it.  Would that
> work?

So if I understand what you are saying correctly we default to 
round-robin on a given node has no CPUs attached to it. I could probably 
work with that if that is the default behavior instead of adding much of 
the complexity I already have.

The question I have then is what should I do about workqueues that 
aren't WQ_UNBOUND if they attempt to use queue_work_near? In that case I 
should be looking for some way to go from a node to a CPU shouldn't I? 
If so should I look at doing something like wq_select_unbound_cpu that 
uses the node cpumask instead of the wq_unbound_cpumask?

- Alex


