Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeEQThZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 15:37:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43404 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQThY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 15:37:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A5EE7602B6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] mm/dmapool: localize page allocations
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, timur@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
References: <1526578581-7658-1-git-send-email-okaya@codeaurora.org>
 <20180517181815.GC26718@bombadil.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <9844a638-bc4e-46bd-133e-0c82a3e9d6ea@codeaurora.org>
Date: Thu, 17 May 2018 15:37:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517181815.GC26718@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/2018 2:18 PM, Matthew Wilcox wrote:
> On Thu, May 17, 2018 at 01:36:19PM -0400, Sinan Kaya wrote:
>> Try to keep the pool closer to the device's NUMA node by changing kmalloc()
>> to kmalloc_node() and devres_alloc() to devres_alloc_node().
> Have you measured any performance gains by doing this?  The thing is that
> these allocations are for the metadata about the page, and the page is
> going to be used by CPUs in every node.  So it's not clear to me that
> allocating it on the node nearest to the device is going to be any sort
> of a win.
> 

It is true that this is metadata but it is one of the things that is most
frequently used in spite of its small size.

I don't think it makes any sense to cross a chip boundary for accessing a
pointer location on every single pool allocation. 

Remember that the CPU core that is running this driver is most probably on
the same NUMA node as the device itself.

Also, if it was a one time init kind of thing, I'd say "yeah, leave it alone". 
DMA pool is used by a wide range of drivers and it is used to allocate
fixed size buffers at runtime. 

Performance impact changes depending on the driver in use. This particular
code is in use by network adapters as well as the NVMe driver. It does
have a wide range of impact.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
