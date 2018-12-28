Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDA1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41E620879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbeL1CcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 21:32:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:23041 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbeL1CcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 21:32:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2018 18:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,407,1539673200"; 
   d="scan'208";a="113763810"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by orsmga003.jf.intel.com with ESMTP; 27 Dec 2018 18:31:59 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gchwM-0004JH-Ea; Fri, 28 Dec 2018 10:31:58 +0800
Date:   Fri, 28 Dec 2018 10:31:58 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Fan Du <fan.du@intel.com>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Yao Yuan <yuan.yao@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH v2 08/21] mm: introduce and export pgdat peer_node
Message-ID: <20181228023158.v3zvbp3k7coodctv@wfg-t540p.sh.intel.com>
References: <20181226131446.330864849@intel.com>
 <20181226133351.521151384@intel.com>
 <01000167f14761d6-b1564081-0d5f-4752-86be-2e99c8375866-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <01000167f14761d6-b1564081-0d5f-4752-86be-2e99c8375866-000000@email.amazonses.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 08:07:26PM +0000, Christopher Lameter wrote:
>On Wed, 26 Dec 2018, Fengguang Wu wrote:
>
>> Each CPU socket can have 1 DRAM and 1 PMEM node, we call them "peer nodes".
>> Migration between DRAM and PMEM will by default happen between peer nodes.
>
>Which one does numa_node_id() point to? I guess that is the DRAM node and

Yes. In our test machine, PMEM nodes show up as memory-only nodes, so
numa_node_id() points to DRAM node.

Here is numactl --hardware output on a 2S test machine.

available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77
node 0 size: 257712 MB
node 0 free: 178251 MB
node 1 cpus: 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102
103
node 1 size: 258038 MB
node 1 free: 174796 MB
node 2 cpus:
node 2 size: 503999 MB
node 2 free: 438349 MB
node 3 cpus:
node 3 size: 503999 MB
node 3 free: 438349 MB
node distances:
node   0   1   2   3
  0:  10  21  20  20
  1:  21  10  20  20
  2:  20  20  10  20
  3:  20  20  20  10

>then we fall back to the PMEM node?

Fall back is possible but not the scope of this patchset. We modified
fallback zonelists in patch 10 to simplify PMEM usage. With that
patch, page allocations on DRAM nodes won't fallback to PMEM nodes.
Instead, PMEM nodes will mainly be used by explicit numactl placement
and as migration target. When there is memory pressure in DRAM node,
LRU cold pages there will be demote migrated to its peer PMEM node on
the same socket by patch 20.

Thanks,
Fengguang
