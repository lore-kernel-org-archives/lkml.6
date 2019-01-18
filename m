Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5131C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EB020850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfARHrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:47:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:48229 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbfARHrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:47:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2019 23:47:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,489,1539673200"; 
   d="scan'208";a="109214309"
Received: from ymzhang.sh.intel.com (HELO [10.239.154.104]) ([10.239.154.104])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2019 23:47:06 -0800
Subject: Re: [PATCH 4/4] dax: "Hotplug" persistent memory for use like normal
 RAM
To:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, dave@sr71.net
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ying.huang@intel.com, fengguang.wu@intel.com,
        bp@suse.de, bhelgaas@google.com, baiyaowei@cmss.chinamobile.com,
        tiwai@suse.de
References: <20190116181859.D1504459@viggo.jf.intel.com>
 <20190116181905.12E102B4@viggo.jf.intel.com>
 <5ef5d5e9-9d35-fb84-b69e-7456dcf4c241@linux.intel.com>
 <1e9377c6-11a0-3bbd-763d-d9347bd556cf@intel.com>
From:   Yanmin Zhang <yanmin_zhang@linux.intel.com>
Message-ID: <74c01a55-1a47-d649-a32a-ea597c24ab4a@linux.intel.com>
Date:   Fri, 18 Jan 2019 15:47:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1e9377c6-11a0-3bbd-763d-d9347bd556cf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/17 下午11:17, Dave Hansen wrote:
> On 1/17/19 12:19 AM, Yanmin Zhang wrote:
>>>
>> I didn't try pmem and I am wondering it's slower than DRAM.
>> Should a flag, such like _GFP_PMEM, be added to distinguish it from
>> DRAM?
> 
> Absolutely not. :)
Agree.

> 
> We already have performance-differentiated memory, and lots of ways to
> enumerate and select it in the kernel (all of our NUMA infrastructure).
Kernel does manage memory like what you say.
My question is: with your patch, PMEM becomes normal RAM, then there is
a chance for kernel to allocate PMEM as DMA buffer.
Some super speed devices like 10Giga NIC, USB (SSIC connecting modem), 
might not work well if DMA buffer is in PMEM as it's slower than DRAM.

Should your patchset consider it?



> 
> PMEM is also just the first of many "kinds" of memory that folks want to
> build in systems and use a "RAM".  We literally don't have space to put
> a flag in for each type.
> 
> 
