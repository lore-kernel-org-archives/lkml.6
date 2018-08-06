Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A468AC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCE3208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCE3208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbeHFOga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:36:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36777 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbeHFOga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:36:30 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5D0C8806AF; Mon,  6 Aug 2018 14:27:34 +0200 (CEST)
Date:   Mon, 6 Aug 2018 14:27:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
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
Subject: Re: [RFC PATCH 1/7] vfio/spimdev: Add documents for WarpDrive
 framework
Message-ID: <20180806122733.GA17232@xo-6d-61-c0.localdomain>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801102221.5308-2-nek.in.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801102221.5308-2-nek.in.cn@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> WarpDrive is a common user space accelerator framework.  Its main component
> in Kernel is called spimdev, Share Parent IOMMU Mediated Device. It exposes

spimdev is really unfortunate name. It looks like it has something to do with SPI, but
it does not.

> +++ b/Documentation/warpdrive/warpdrive.rst
> @@ -0,0 +1,153 @@
> +Introduction of WarpDrive
> +=========================
> +
> +*WarpDrive* is a general accelerator framework built on top of vfio.
> +It can be taken as a light weight virtual function, which you can use without
> +*SR-IOV* like facility and can be shared among multiple processes.
> +
> +It can be used as the quick channel for accelerators, network adaptors or
> +other hardware in user space. It can make some implementation simpler.  E.g.
> +you can reuse most of the *netdev* driver and just share some ring buffer to
> +the user space driver for *DPDK* or *ODP*. Or you can combine the RSA
> +accelerator with the *netdev* in the user space as a Web reversed proxy, etc.

What is DPDK? ODP?

> +How does it work
> +================
> +
> +*WarpDrive* takes the Hardware Accelerator as a heterogeneous processor which
> +can share some load for the CPU:
> +
> +.. image:: wd.svg
> +        :alt: This is a .svg image, if your browser cannot show it,
> +                try to download and view it locally
> +
> +So it provides the capability to the user application to:
> +
> +1. Send request to the hardware
> +2. Share memory with the application and other accelerators
> +
> +These requirements can be fulfilled by VFIO if the accelerator can serve each
> +application with a separated Virtual Function. But a *SR-IOV* like VF (we will
> +call it *HVF* hereinafter) design is too heavy for the accelerator which
> +service thousands of processes.

VFIO? VF? HVF?

Also "gup" might be worth spelling out.

> +References
> +==========
> +.. [1] Accroding to the comment in in mm/gup.c, The *gup* is only safe within
> +       a syscall.  Because it can only keep the physical memory in place
> +       without making sure the VMA will always point to it. Maybe we should
> +       raise the VM_PINNED patchset (see
> +       https://lists.gt.net/linux/kernel/1931993) again to solve this probl


I went through the docs, but I still don't know what it does.
											Pavel
