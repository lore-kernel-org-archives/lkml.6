Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353EBC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E5720843
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E5720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeIBGfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 02:35:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:13094 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbeIBGfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 02:35:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Sep 2018 19:21:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,318,1531810800"; 
   d="scan'208";a="80211542"
Received: from dbxu-mobl.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.212.218])
  by orsmga003.jf.intel.com with ESMTP; 01 Sep 2018 19:20:58 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1fwI0X-0003ZX-4h; Sun, 02 Sep 2018 10:20:57 +0800
Message-Id: <20180901112818.126790961@intel.com>
User-Agent: quilt/0.63-1
Date:   Sat, 01 Sep 2018 19:28:18 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linux Memory Management List <linux-mm@kvack.org>
cc:     kvm@vger.kernel.org
cc:     Peng DongX <dongx.peng@intel.com>
cc:     Liu Jingqi <jingqi.liu@intel.com>
cc:     Dong Eddie <eddie.dong@intel.com>
CC:     Dave Hansen <dave.hansen@intel.com>
cc:     Huang Ying <ying.huang@intel.com>
CC:     Brendan Gregg <bgregg@netflix.com>
Cc:     Fengguang Wu <fengguang.wu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH 0/5] introduce /proc/PID/idle_bitmap
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new /proc/PID/idle_bitmap interface aims to complement the current global
/sys/kernel/mm/page_idle/bitmap. To enable efficient user space driven migrations.

The pros and cons will be discussed in changelog of "[PATCH] proc: introduce
/proc/PID/idle_bitmap". The driving force is to improve efficiency by 10+
times, so that hot/cold page tracking can be done in some regular intervals in
user space w/o too much overheads. Making it possible for some user space
daemon to do regular page migration between NUMA nodes of different speeds.

Note it's not about NUMA migration between local and remote nodes -- we already
have NUMA balancing for that. This interface and user space migration daemon
targets for NUMA nodes made of different mediums -- ie. DIMM and NVDIMM(*) --
with larger performance gaps. Basic policy will be "move hot pages to DIMM;
cold pages to NVDIMM".

Since NVDIMMs size can easily reach several Terabytes, working set tracking
efficiency will matter and be challeging.

(*) Here we use persistent memory (PMEM) w/o using its persistence.
Persistence is good to have, however it requires modifying applications.
Upcoming NVDIMM products like Intel Apache Pass (AEP) will be more cost and energy
effective than DRAM, but slower. Merely using it in form of NUMA memory node
could immediately benefit many workloads. For example, warm but not hot apps,
workloads with sharp hot/cold page distribution (good for migration), or relies
more on memory size than latency and bandwidth, and do more reads than writes.

This is an early RFC version to collect feedbacks. It's complete enough to demo
the basic ideas and performance, however not usable yet.

Regards,
Fengguang

