Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3441C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29F02075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29F02075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJJW4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:56:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:6646 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbeJJW4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:56:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 08:34:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,364,1534834800"; 
   d="scan'208";a="98200507"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.156]) ([10.7.198.156])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2018 08:34:06 -0700
Subject: Re: [workqueue/driver-core PATCH 1/5] workqueue: Provide
 queue_work_near to queue work near a given NUMA node
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org
References: <20181005183239.8790.28631.stgit@localhost.localdomain>
 <20181005183406.8790.70621.stgit@localhost.localdomain>
 <20181010153011.GM270328@devbig004.ftw2.facebook.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <36fd7d36-ea79-bd69-4576-06ab4635f0d3@linux.intel.com>
Date:   Wed, 10 Oct 2018 08:34:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181010153011.GM270328@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2018 8:30 AM, Tejun Heo wrote:
> Hello,
> 
>> +static int workqueue_select_cpu_near(int node)
>> +{
> ...
>> +	/* Use "random" otherwise know as "first" online CPU of node */
>> +	cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);
> 
> Maybe we wanna round-robin within the node?

I had thought about it. It adds extra complexity to do it and for 
unbound work queues it doesn't really add anything since it gets 
converted back into a node anyway.

If you wanted I could look at adding extra logic that would do the 
round-robin for non-unbound workqueues. I just wasn't sure if it was 
worth the effort since the current users are all unbound workqueues.

>> +bool queue_work_near(int node, struct workqueue_struct *wq,
>> +		     struct work_struct *work)
> 
> Can we name it queue_work_node() to stay consistent with numa-aware
> memory interface?

Yes. No problem.

> Thanks.

Thanks for the review feedback.

- Alex
