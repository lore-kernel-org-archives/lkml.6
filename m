Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D61C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF3720862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF3720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407479AbeHATTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:19:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407357AbeHATTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:19:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4E3D4023461;
        Wed,  1 Aug 2018 16:56:51 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E16E610EE6D4;
        Wed,  1 Aug 2018 16:56:45 +0000 (UTC)
Date:   Wed, 1 Aug 2018 12:56:44 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Kenneth Lee <nek.in.cn@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>, linuxarm@huawei.com
Subject: Re: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
Message-ID: <20180801165644.GA3820@redhat.com>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180801102221.5308-1-nek.in.cn@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 01 Aug 2018 16:56:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 01 Aug 2018 16:56:51 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 06:22:14PM +0800, Kenneth Lee wrote:
> From: Kenneth Lee <liguozhu@hisilicon.com>
> 
> WarpDrive is an accelerator framework to expose the hardware capabilities
> directly to the user space. It makes use of the exist vfio and vfio-mdev
> facilities. So the user application can send request and DMA to the
> hardware without interaction with the kernel. This remove the latency
> of syscall and context switch.
> 
> The patchset contains documents for the detail. Please refer to it for more
> information.
> 
> This patchset is intended to be used with Jean Philippe Brucker's SVA
> patch [1] (Which is also in RFC stage). But it is not mandatory. This
> patchset is tested in the latest mainline kernel without the SVA patches.
> So it support only one process for each accelerator.
> 
> With SVA support, WarpDrive can support multi-process in the same
> accelerator device.  We tested it in our SoC integrated Accelerator (board
> ID: D06, Chip ID: HIP08). A reference work tree can be found here: [2].

I have not fully inspected things nor do i know enough about
this Hisilicon ZIP accelerator to ascertain, but from glimpsing
at the code it seems that it is unsafe to use even with SVA due
to the doorbell. There is a comment talking about safetyness
in patch 7.

Exposing thing to userspace is always enticing, but if it is
a security risk then it should clearly say so and maybe a
kernel boot flag should be necessary to allow such device to
be use.


My more general question is do we want to grow VFIO to become
a more generic device driver API. This patchset adds a command
queue concept to it (i don't think it exist today but i have
not follow VFIO closely).

Why is that any better that existing driver model ? Where a
device create a device file (can be character device, block
device, ...). Such models also allow for direct hardware
access from userspace. For instance see the AMD KFD driver
inside drivers/gpu/drm/amd

So you can already do what you are doing with the Hisilicon
driver today without this new infrastructure. This only need
hardware that have command queue and doorbell like mechanisms.


Unlike mdev which unify a very high level concept, it seems
to me spimdev just introduce low level concept (namely command
queue) and i don't see the intrinsic value here.


Cheers,
Jérôme
