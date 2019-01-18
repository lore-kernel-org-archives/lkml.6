Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB8CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3BB20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfARLsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:48:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:4949 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfARLsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:48:51 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 03:48:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,491,1539673200"; 
   d="scan'208";a="126844876"
Received: from zhujianq-mobl.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.252])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jan 2019 03:48:47 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gkSdi-0002Ut-Nk; Fri, 18 Jan 2019 19:48:46 +0800
Date:   Fri, 18 Jan 2019 19:48:46 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        thomas.lendacky@amd.com, dave@sr71.net, linux-nvdimm@lists.01.org,
        tiwai@suse.de, zwisler@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com,
        baiyaowei@cmss.chinamobile.com, ying.huang@intel.com,
        bhelgaas@google.com, akpm@linux-foundation.org, bp@suse.de
Subject: Re: [PATCH 0/4] Allow persistent memory to be used like normal RAM
Message-ID: <20190118114846.hmmcagscyjeycyfy@wfg-t540p.sh.intel.com>
References: <20190116181859.D1504459@viggo.jf.intel.com>
 <x49sgxr9rjd.fsf@segfault.boston.devel.redhat.com>
 <20190117164736.GC31543@localhost.localdomain>
 <x49pnsv8am1.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <x49pnsv8am1.fsf@segfault.boston.devel.redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>With this patch set, an unmodified application would either use:
>
>1) whatever memory it happened to get
>2) only the faster dram (via numactl --membind=)
>3) only the slower pmem (again, via numactl --membind1)
>4) preferentially one or the other (numactl --preferred=)

Yet another option:

MemoryOptimizer -- hot page accounting and migration daemon
https://github.com/intel/memory-optimizer

Once PMEM NUMA nodes are available, we may run a user space daemon to
walk page tables of virtual machines (EPT) or processes, collect the
"accessed" bits to find out hot pages, and finally migrate hot pages
to DRAM and cold pages to PMEM.

In that scenario, only kernel and the migrate daemon need to be aware
of the PMEM nodes. Unmodified virtual machines and processes can enjoy
the added memory space w/o knowing whether it's using DRAM or PMEM.

Thanks,
Fengguang
