Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755315AbeEaOBL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:01:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59171 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755103AbeEaOBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:01:10 -0400
Subject: Re: [PATCH 0/2] arm64/drivers: avoid alloc memory on offline node
To: Xie XiuQi <xiexiuqi@huawei.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <bhelgaas@google.com>,
        <gregkh@linuxfoundation.org>, <rafael.j.wysocki@intel.com>,
        <jarkko.sakkinen@linux.intel.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wanghuiqiang@huawei.com>, <tnowicki@caviumnetworks.com>
References: <1527768879-88161-1-git-send-email-xiexiuqi@huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <65b32f11-6c83-3497-3cbf-3d3688195291@huawei.com>
Date: Thu, 31 May 2018 22:00:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1527768879-88161-1-git-send-email-xiexiuqi@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiuqi,

On 2018/5/31 20:14, Xie XiuQi wrote:
> A numa system may return node which is not online.
> For example, a numa node:
> 1) without memory
> 2) NR_CPUS is very small, and the cpus on the node are not brought up

I think adding detail info will be easy to be understood:
 - NUMA node will be built if CPUs and (or) memory are valid on this NUMA node;

 - But if we boot the system with memory-less node and also with CONFIG_NR_CPUS
   less than CPUs in SRAT, for example, 64 CPUs total with 4 NUMA nodes, 16 CPUs
   on each NUMA node, if we boot with CONFIG_NR_CPUS=48, then we will not built
   numa node for node 3, but with devices on that numa node, alloc memory will
   be panic because NUMA node 3 is not a valid node.

> 
> In this situation, we use NUMA_NO_NODE to avoid oops.
[snip]
> 
> Xie XiuQi (2):
>   arm64: avoid alloc memory on offline node
>   drivers: check numa node's online status in dev_to_node

I think we still missing devices like SMMU, ITS, so how about check
the numa node online in the core memory allocation such as kmalloc_node()?

Thanks
Hanjun
