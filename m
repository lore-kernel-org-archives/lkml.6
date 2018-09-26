Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB60C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89D82154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89D82154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeI0Ee1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:34:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:18459 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725722AbeI0Ee1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:34:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 15:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="76197240"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.154]) ([10.7.198.154])
  by orsmga007.jf.intel.com with ESMTP; 26 Sep 2018 15:19:21 -0700
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
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <ba72f007-84e2-6fe0-b128-d876dadef5f5@linux.intel.com>
Date:   Wed, 26 Sep 2018 15:19:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180926220957.GB270328@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/2018 3:09 PM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 26, 2018 at 03:05:17PM -0700, Alexander Duyck wrote:
>> I am using unbound workqueues. However there isn't an interface that
>> exposes the NUMA bits of them directly. All I am doing with this
>> patch is adding "queue_work_near" which takes a NUMA node as an
>> argument and then copies the logic of "queue_work_on" with the
>> exception that I am doing a check to verify that there is an
>> intersection between wq_unbound_cpumask and the cpumask of the node,
>> and then passing a CPU from that intersection into "__queue_work".
> 
> Can it just take a cpu id and not feed that to __queue_work()?  That
> looks like a lot of extra logic.
> 
> Thanks.

I could just use queue_work_on probably, but is there any issue if I am 
passing CPU values that are not in the wq_unbound_cpumask? That was 
mostly my concern. Also for an unbound queue do I need to worry about 
the hotplug lock? I wasn't sure if that was the case or not as I know it 
is called out as something to be concerned with using queue_work_on, but 
in __queue_work the value is just used to determine which node to grab a 
work queue from.

I forgot to address your question about the advantages. They are pretty 
significant. The test system I was working with was initializing 3TB of 
nvdimm memory per node. If the node is aligned it takes something like 
24 seconds, whereas an unaligned core can take 36 seconds or more.

Thanks.

- Alex
