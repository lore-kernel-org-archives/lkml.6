Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE56C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864D92087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfAGKV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:21:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:2345 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfAGKV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:21:56 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 02:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,450,1539673200"; 
   d="scan'208";a="123876940"
Received: from tiwuxiex-mobl.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.213.147])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jan 2019 02:21:52 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1ggS2a-0007Kx-83; Mon, 07 Jan 2019 18:21:52 +0800
Date:   Mon, 7 Jan 2019 18:21:52 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Yao Yuan <yuan.yao@intel.com>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Fan Du <fan.du@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH v2 11/21] kvm: allocate page table pages from DRAM
Message-ID: <20190107102152.d3infdyw3zupu2xj@wfg-t540p.sh.intel.com>
References: <20181226131446.330864849@intel.com>
 <20181226133351.703380444@intel.com>
 <b99ef113-a9c1-f580-0fee-9f258b861391@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b99ef113-a9c1-f580-0fee-9f258b861391@intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 08:47:25AM -0800, Dave Hansen wrote:
>On 12/26/18 5:14 AM, Fengguang Wu wrote:
>> +static unsigned long __get_dram_free_pages(gfp_t gfp_mask)
>> +{
>> +       struct page *page;
>> +
>> +       page = __alloc_pages(GFP_KERNEL_ACCOUNT, 0, numa_node_id());
>> +       if (!page)
>> +	       return 0;
>> +       return (unsigned long) page_address(page);
>> +}
>
>There seems to be a ton of *policy* baked into these patches.  For
>instance: thou shalt not allocate page tables pages from PMEM.  That's
>surely not a policy we want to inflict on every Linux user until the end
>of time.

Right. It's straight forward policy for users that care performance.
The project is planned by 3 steps, at this moment we are in phase (1):

1) core functionalities, easy to backport
2) upstream-able total solution
3) upstream when API stabilized

The dumb kernel interface /proc/PID/idle_pages enables doing
the majority policies in user space. However for the other smaller
parts, it looks easier to just implement an obvious policy first.
Then to consider more possibilities.

>I think the more important question is how we can have the specific
>policy that this patch implements, but also leave open room for other
>policies, such as: "I don't care how slow this VM runs, minimize the
>amount of fast memory it eats."

Agreed. I'm open for more ways. We can treat these patches as the
soliciting version. If anyone send reasonable improvements or even
totally different way of doing it, I'd be happy to incorporate.

Thanks,
Fengguang
