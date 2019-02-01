Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757BFC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEDF20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfBAJKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:10:02 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37932 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726628AbfBAJKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:10:02 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 56DCC67A0A162710358D;
        Fri,  1 Feb 2019 17:10:00 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 1 Feb 2019
 17:09:56 +0800
Date:   Fri, 1 Feb 2019 17:10:40 +0800
From:   Kenneth Lee <liguozhu@hisilicon.com>
To:     Olof Johansson <olof@lixom.net>
CC:     <linux-kernel@vger.kernel.org>, <ogabbay@habana.ai>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <jglisse@redhat.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>, <airlied@redhat.com>,
        <linux-accelerators@lists.ozlabs.org>, <nek.in.cn@gmail.com>
Subject: Re: [PATCH/RFC 0/5] HW accel subsystem
Message-ID: <20190201091040.GA159470@Turing-Arch-b>
References: <CAOesGMicf17+0x6AUCNrUYu=d4uREVCyH8F2JvUz5fN5+=jW_A@mail.gmail.com>
 <20190125181616.62609-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190125181616.62609-1-olof@lixom.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 10:16:11AM -0800, Olof Johansson wrote:
> Date: Fri, 25 Jan 2019 10:16:11 -0800
> From: Olof Johansson <olof@lixom.net>
> To: linux-kernel@vger.kernel.org
> CC: ogabbay@habana.ai, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
>  jglisse@redhat.com, Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
>  Frederic Barrat <fbarrat@linux.ibm.com>, airlied@redhat.com,
>  linux-accelerators@lists.ozlabs.org
> Subject: [PATCH/RFC 0/5] HW accel subsystem
> X-Mailer: git-send-email 2.11.0
> Message-ID: <20190125181616.62609-1-olof@lixom.net>
> 
> Per discussion in on the Habana Labs driver submission
> (https://lore.kernel.org/lkml/20190123000057.31477-1-oded.gabbay@gmail.com/),
> there seems to be time to create a separate subsystem for hw accellerators
> instead of letting them proliferate around the tree (and/or in misc).
> 
> There's difference in opinion on how stringent the requirements are for
> a fully open stack for these kind of drivers. I've documented the middle
> road approach in the first patch (requiring some sort of open low-level
> userspace for the kernel interaction, and a way to use/test it).
> 
> Comments and suggestions for better approaches are definitely welcome.

Dear Olof,

How are you? Let me introduce myself. My name is Kenenth Lee, working for
Hisilicon. Our company provide server, AI, networking and terminal SoCs to the
market. We tried to create an accelerator framework a year back and now we are
working on the branch here (There is document in Documentation/warpdrive
directory):

https://github.com/Kenneth-Lee/linux-kernel-warpdrive/tree/wdprd-v1

The user space framework is here:

https://github.com/Kenneth-Lee/warpdrive/tree/wdprd-v1

We have tried to create it on VFIO at the very beginning. The RFCv1 is here:

https://lwn.net/Articles/763990/

But it seems it is not fit. There are two major issues:

1. The VFIO framework enforces the concept of separating the resource into
   devices before using it. This is not an accelerator style. Accelerator is
   another CPU to let the others to share it.
2. The way VFIO used to pin memory in place, has some flaw. In the current
   kernel, if you fork a sub-rpcess after pin the dma memory, you may lost the
   physical pages. (You can get more detail in the threads)

So we tried RFCv2 and build the solution directly on IOMMU. We call our solution
as WarpDrive and the kernel module is called uacce. Our assumption is that:

1. Most of users of the accelerator are in user space.
2. An accelerator is always another heterogeneous processor. It is waiting and
   processing work load sent from CPU.
3. The data structure in the CPU may be complex. It is no good to wrap the data
   and send it to hardware again and again. The better way is to keep the data
   in place and give a pointer to the accelerator, leaving it to finish the job.

So we create a pipe (we called it queue) between the user process and the
hardware directly. It is presented as a file to the user space. The user process
mmap the queue file to address the mmio space of the hardware, share memory and 
so on. With the capability of IOMMU, we can share the whole or part of process
space with the hardware. This can make the software solution easier.

After the RFCv2 was sent to the lkml, we do not get much feedback. But the
Infini-band guys said they did not like it. They think the solution is
re-invention of ib-verbs.

But we do not think so. ib-verbs maintains semantics of "REMOTE memory". But
UACCE maintains semantics of "LOCAL memory". We don't need to send, or sync
memory with other parties. We share those memory with all processes who share
the local bus.

But we know we need more "complete" solution to let people understand and accept
our idea. So now we are working on it with our Compression and RSA accelerator
on Hi1620 Server SoC. We are also planning to port our AI framework on it.

Do you think we can cooperate to create an framework in Linux together? Please
feel free to ask for more information. We are happy to answer it.


Cheers
-- 
			-Kenneth(Hisilicon)

