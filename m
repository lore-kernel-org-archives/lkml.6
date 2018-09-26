Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52091C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F7721533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F7721533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeI0EVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:21:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:23797 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbeI0EVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:21:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 15:06:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="76195370"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.154]) ([10.7.198.154])
  by orsmga007.jf.intel.com with ESMTP; 26 Sep 2018 15:05:18 -0700
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
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <9b002bbb-3e6d-9e99-d8f9-36df4306093e@linux.intel.com>
Date:   Wed, 26 Sep 2018 15:05:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180926215307.GA270328@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/2018 2:53 PM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 26, 2018 at 02:51:38PM -0700, Alexander Duyck wrote:
>> This patch provides a new function queue_work_near which is meant to
>> schedule work on the nearest unbound CPU to the requested NUMA node. The
>> main motivation for this is to help assist asynchronous init to better
>> improve boot times for devices that are local to a specific node.
>>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Why not just use unbound workqueues, which are NUMA-affine by default?
> Are there big enough advantages?
> 
> Thanks.

I am using unbound workqueues. However there isn't an interface that 
exposes the NUMA bits of them directly. All I am doing with this patch 
is adding "queue_work_near" which takes a NUMA node as an argument and 
then copies the logic of "queue_work_on" with the exception that I am 
doing a check to verify that there is an intersection between 
wq_unbound_cpumask and the cpumask of the node, and then passing a CPU 
from that intersection into "__queue_work".

Thanks.

- Alex
