Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58E5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 04:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC402086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 04:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC402086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeKSOgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 09:36:23 -0500
Received: from foss.arm.com ([217.140.101.70]:50372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbeKSOgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 09:36:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AACE91596;
        Sun, 18 Nov 2018 20:14:03 -0800 (PST)
Received: from [10.162.0.72] (unknown [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 657F43F5A0;
        Sun, 18 Nov 2018 20:14:01 -0800 (PST)
Subject: Re: [PATCH 4/7] node: Add memory caching attributes
To:     Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181114224921.12123-5-keith.busch@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <91698cef-cdcd-5143-884f-3da5536e156f@arm.com>
Date:   Mon, 19 Nov 2018 09:44:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181114224921.12123-5-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2018 04:19 AM, Keith Busch wrote:
> System memory may have side caches to help improve access speed. While
> the system provided cache is transparent to the software accessing
> these memory ranges, applications can optimize their own access based
> on cache attributes.

Cache is not a separate memory attribute. It impacts how the real attributes
like bandwidth, latency e.g which are already captured in the previous patch.
What is the purpose of adding this as a separate attribute ? Can you explain
how this is going to help the user space apart from the hints it has already
received with bandwidth, latency etc properties.

> 
> In preparation for such systems, provide a new API for the kernel to
> register these memory side caches under the memory node that provides it.

Under target memory node interface /sys/devices/system/node/nodeY/target* ?

> 
> The kernel's sysfs representation is modeled from the cpu cacheinfo
> attributes, as seen from /sys/devices/system/cpu/cpuX/cache/. Unlike CPU
> cacheinfo, though, a higher node's memory cache level is nearer to the
> CPU, while lower levels are closer to the backing memory. Also unlike
> CPU cache, the system handles flushing any dirty cached memory to the
> last level the memory on a power failure if the range is persistent.

Lets assume that a CPU has got four levels of caches L1, L2, L3, L4 before
reaching memory. L4 is the backing cache for the memory and L1-L3 is from
CPU till the system bus. Hence some of them will be represented as CPU
caches and some of them will be represented as memory caches ?

/sys/devices/system/cpu/cpuX/cache/ --> L1, L2, L3
/sys/devices/system/node/nodeY/target --> L4 

L4 will be listed even if the node is memory only ?
