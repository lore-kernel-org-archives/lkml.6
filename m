Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1027AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 13:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D176520879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 13:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbeL1NbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 08:31:16 -0500
Received: from mga05.intel.com ([192.55.52.43]:54405 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbeL1NbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 08:31:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2018 05:31:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,409,1539673200"; 
   d="scan'208";a="113864058"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2018 05:31:12 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gcsEJ-0007g4-SO; Fri, 28 Dec 2018 21:31:11 +0800
Date:   Fri, 28 Dec 2018 21:31:11 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Fan Du <fan.du@intel.com>, Yao Yuan <yuan.yao@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH v2 00/21] PMEM NUMA node and hotness
 accounting/migration
Message-ID: <20181228133111.zromvopkfcg3m5oy@wfg-t540p.sh.intel.com>
References: <20181226131446.330864849@intel.com>
 <20181227203158.GO16738@dhcp22.suse.cz>
 <20181228050806.ewpxtwo3fpw7h3lq@wfg-t540p.sh.intel.com>
 <20181228084105.GQ16738@dhcp22.suse.cz>
 <20181228094208.7lgxhha34zpqu4db@wfg-t540p.sh.intel.com>
 <20181228121515.GS16738@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181228121515.GS16738@dhcp22.suse.cz>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I haven't looked at the implementation yet but if you are proposing a
>> > special cased zone lists then this is something CDM (Coherent Device
>> > Memory) was trying to do two years ago and there was quite some
>> > skepticism in the approach.
>>
>> It looks we are pretty different than CDM. :)
>> We creating new NUMA nodes rather than CDM's new ZONE.
>> The zonelists modification is just to make PMEM nodes more separated.
>
>Yes, this is exactly what CDM was after. Have a zone which is not
>reachable without explicit request AFAIR. So no, I do not think you are
>too different, you just use a different terminology ;)

Got it. OK.. The fall back zonelists patch does need more thoughts.

In long term POV, Linux should be prepared for multi-level memory.
Then there will arise the need to "allocate from this level memory".
So it looks good to have separated zonelists for each level of memory.  

On the other hand, there will also be page allocations that don't care
about the exact memory level. So it looks reasonable to expect
different kind of fallback zonelists that can be selected by NUMA policy.

Thanks,
Fengguang
