Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DA0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFA420675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfBWNm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:42:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:29496 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfBWNm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:42:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2019 05:42:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,403,1544515200"; 
   d="scan'208";a="135739557"
Received: from xiaqing-mobl.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.208.151])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Feb 2019 05:42:27 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gxXZS-00010q-Pu; Sat, 23 Feb 2019 21:42:26 +0800
Date:   Sat, 23 Feb 2019 21:42:26 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM ATTEND ] memory reclaim with NUMA rebalancing
Message-ID: <20190223134226.spesmpw6qnnfyvrr@wfg-t540p.sh.intel.com>
References: <20190130174847.GD18811@dhcp22.suse.cz>
 <87h8dpnwxg.fsf@linux.ibm.com>
 <20190223132748.awedzeybi6bjz3c5@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190223132748.awedzeybi6bjz3c5@wfg-t540p.sh.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 09:27:48PM +0800, Fengguang Wu wrote:
>On Thu, Jan 31, 2019 at 12:19:47PM +0530, Aneesh Kumar K.V wrote:
>>Michal Hocko <mhocko@kernel.org> writes:
>>
>>> Hi,
>>> I would like to propose the following topic for the MM track. Different
>>> group of people would like to use NVIDMMs as a low cost & slower memory
>>> which is presented to the system as a NUMA node. We do have a NUMA API
>>> but it doesn't really fit to "balance the memory between nodes" needs.
>>> People would like to have hot pages in the regular RAM while cold pages
>>> might be at lower speed NUMA nodes. We do have NUMA balancing for
>>> promotion path but there is notIhing for the other direction. Can we
>>> start considering memory reclaim to move pages to more distant and idle
>>> NUMA nodes rather than reclaim them? There are certainly details that
>>> will get quite complicated but I guess it is time to start discussing
>>> this at least.
>>
>>I would be interested in this topic too. I would like to understand
>
>So do me. I'd be glad to take in the discussions if can attend the slot.
>
>>the API and how it can help exploit the different type of devices we
>>have on OpenCAPI.
>>
>>IMHO there are few proposals related to this which we could discuss together
>>
>>1. HMAT series which want to expose these devices as Numa nodes
>>2. The patch series from Dave Hansen which just uses Pmem as Numa node.
>>3. The patch series from Fengguang Wu which does prevent default
>>allocation from these numa nodes by excluding them from zone list.
>>4. The patch series from Jerome Glisse which doesn't expose these as
>>numa nodes.
>>
>>IMHO (3) is suggesting that we really don't want them as numa nodes. But
>>since Numa is the only interface we currently have to present them as
>>memory and control the allocation and migration we are forcing
>>ourselves to Numa nodes and then excluding them from default allocation.
>
>Regarding (3), we actually made a default policy choice for
>"separating fallback zonelists for PMEM/DRAM nodes" for the
>typical use scenarios.
>
>In long term, it's better to not build such assumption into kernel.
>There may well be workloads that are cost sensitive rather than
>performance sensitive. Suppose people buy a machine with tiny DRAM
>and large PMEM. In which case the suitable policy may be to
>
>1) prefer (but not bind) slab etc. kernel pages in DRAM
>2) allocate LRU etc. pages from either DRAM or PMEM node

The point is not separating fallback zonelists for DRAM and PMEM in
this case.

>In summary, kernel may offer flexibility for different policies for
>use by different users. PMEM has different characteristics comparing
>to DRAM, users may or may not be treated differently than DRAM through
>policies.
>
>Thanks,
>Fengguang
