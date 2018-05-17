Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeEQVF6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 17:05:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34824 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQVF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 17:05:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3839260209
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] mm/dmapool: localize page allocations
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, timur@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
References: <1526578581-7658-1-git-send-email-okaya@codeaurora.org>
 <20180517181815.GC26718@bombadil.infradead.org>
 <9844a638-bc4e-46bd-133e-0c82a3e9d6ea@codeaurora.org>
 <20180517194612.GG26718@bombadil.infradead.org>
 <d49e594a-c18a-160f-ca4c-91520ff3b293@codeaurora.org>
 <20180517204103.GJ26718@bombadil.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <bbd1c867-7ca8-1364-cedb-39f52bb586d9@codeaurora.org>
Date: Thu, 17 May 2018 17:05:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517204103.GJ26718@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/2018 4:41 PM, Matthew Wilcox wrote:
> Let's try a different example.  I have a four-socket system with one
> NVMe device with lots of hardware queues.  Each CPU has its own queue
> assigned to it.  If I allocate all the PRP metadata on the socket with
> the NVMe device attached to it, I'm sending a lot of coherency traffic
> in the direction of that socket, in addition to the actual data.  If the
> PRP lists are allocated randomly on the various sockets, the traffic
> is heading all over the fabric.  If the PRP lists are allocated on the
> local socket, the only time those lists move off this node is when the
> device requests them.

So.., your reasoning is that you actually want to keep the memory as close
as possible to the CPU rather than the device itself. CPU would do
frequent updates the buffer until the point where it hands off the buffer
to the hardware. Device would fetch the memory via coherency when it needs
to consume the data but this would be a one time penalty.

It sounds logical to me. I was always told that you want to keep buffers
as close as possible to the device.

Maybe, it makes sense for things that device needs frequent access like
receive buffers.

If the majority user is CPU, then the buffer needs to be kept closer to
the CPU. 

dma_alloc_coherent() is generally used for receiver buffer allocation in
network adapters in general. People allocate a chunk and then create a
queue that hardware owns for dumping events and data.

Since DMA pool is a generic API, we should maybe request where we want
to keep the buffers closer to and allocate buffers from the appropriate
NUMA node based on that.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
