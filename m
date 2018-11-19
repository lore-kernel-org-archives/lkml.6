Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B1EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D80B20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D80B20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbeKTJfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:35:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:37762 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730860AbeKTJfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:35:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 15:09:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,254,1539673200"; 
   d="scan'208";a="97554814"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Nov 2018 15:09:16 -0800
Date:   Mon, 19 Nov 2018 16:06:00 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 4/7] node: Add memory caching attributes
Message-ID: <20181119230600.GC26707@localhost.localdomain>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181114224921.12123-5-keith.busch@intel.com>
 <91698cef-cdcd-5143-884f-3da5536e156f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91698cef-cdcd-5143-884f-3da5536e156f@arm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 09:44:00AM +0530, Anshuman Khandual wrote:
> On 11/15/2018 04:19 AM, Keith Busch wrote:
> > System memory may have side caches to help improve access speed. While
> > the system provided cache is transparent to the software accessing
> > these memory ranges, applications can optimize their own access based
> > on cache attributes.
> 
> Cache is not a separate memory attribute. It impacts how the real attributes
> like bandwidth, latency e.g which are already captured in the previous patch.
> What is the purpose of adding this as a separate attribute ? Can you explain
> how this is going to help the user space apart from the hints it has already
> received with bandwidth, latency etc properties.

I am not sure I understand the question here. Access bandwidth and latency
are entirely attributes different than what this patch provides. If the
system side-caches memory, the associativity, line size, and total size
can optionally be used by software to improve performance.
 
> > In preparation for such systems, provide a new API for the kernel to
> > register these memory side caches under the memory node that provides it.
> 
> Under target memory node interface /sys/devices/system/node/nodeY/target* ?

Yes.
 
> > 
> > The kernel's sysfs representation is modeled from the cpu cacheinfo
> > attributes, as seen from /sys/devices/system/cpu/cpuX/cache/. Unlike CPU
> > cacheinfo, though, a higher node's memory cache level is nearer to the
> > CPU, while lower levels are closer to the backing memory. Also unlike
> > CPU cache, the system handles flushing any dirty cached memory to the
> > last level the memory on a power failure if the range is persistent.
> 
> Lets assume that a CPU has got four levels of caches L1, L2, L3, L4 before
> reaching memory. L4 is the backing cache for the memory 

I don't quite understand this question either. The cache doesn't back
the memory; the system side caches access to memory.

> and L1-L3 is from
> CPU till the system bus. Hence some of them will be represented as CPU
> caches and some of them will be represented as memory caches ?
>
> /sys/devices/system/cpu/cpuX/cache/ --> L1, L2, L3
> /sys/devices/system/node/nodeY/target --> L4 
> 
> L4 will be listed even if the node is memory only ?

The system provided memory side caches are independent of the
CPU. I'm just providing the CPU caches as a more familiar example to
compare/contrast system memory cache attributes.
