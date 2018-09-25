Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C863EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898FA20833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898FA20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeIZC6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:58:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:22392 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeIZC6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:58:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 13:49:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="94756981"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.152]) ([10.7.198.152])
  by orsmga002.jf.intel.com with ESMTP; 25 Sep 2018 13:38:43 -0700
Subject: Re: [PATCH v5 2/4] mm: Provide kernel parameter to allow disabling
 page init poisoning
To:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, jglisse@redhat.com, rppt@linux.vnet.ibm.com,
        dan.j.williams@intel.com, logang@deltatee.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925201921.3576.84239.stgit@localhost.localdomain>
 <13285e05-fb90-b948-6f96-777f94079657@intel.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <8faf3acc-e47e-8ef9-a1a0-c0d6ebfafa1e@linux.intel.com>
Date:   Tue, 25 Sep 2018 13:38:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <13285e05-fb90-b948-6f96-777f94079657@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/2018 1:26 PM, Dave Hansen wrote:
> On 09/25/2018 01:20 PM, Alexander Duyck wrote:
>> +	vm_debug[=options]	[KNL] Available with CONFIG_DEBUG_VM=y.
>> +			May slow down system boot speed, especially when
>> +			enabled on systems with a large amount of memory.
>> +			All options are enabled by default, and this
>> +			interface is meant to allow for selectively
>> +			enabling or disabling specific virtual memory
>> +			debugging features.
>> +
>> +			Available options are:
>> +			  P	Enable page structure init time poisoning
>> +			  -	Disable all of the above options
> 
> Can we have vm_debug=off for turning things off, please?  That seems to
> be pretty standard.

No. The simple reason for that is that you had requested this work like 
the slub_debug. If we are going to do that then each individual letter 
represents a feature. That is why the "-" represents off. We cannot have 
letters represent flags, and letters put together into words. For 
example slub_debug=OFF would turn on sanity checks and turn off 
debugging for caches that would have causes higher minimum slab orders.

Either I can do this as a single parameter that supports on/off 
semantics, or I can support it as a slub_debug type parameter that does 
flags based on the input options. I would rather not muddy things by 
trying to do both.

> Also, we need to document the defaults.  I think the default is "all
> debug options are enabled", but it would be nice to document that.

In the description I call out "All options are enabled by default, and 
this interface is meant to allow for selectively enabling or disabling".


