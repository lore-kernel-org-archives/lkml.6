Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F59C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3A5207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfBVImr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:42:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:54828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbfBVImq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:42:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51335AE28;
        Fri, 22 Feb 2019 08:42:45 +0000 (UTC)
Date:   Fri, 22 Feb 2019 09:42:41 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, bhe@redhat.com,
        Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pingfan Liu <kernelfans@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org,
        vgoyal@redhat.com, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190222084241.GC8380@suse.de>
References: <20190204223016.GB11986@anatevka>
 <20190205081552.GG21801@zn.tnic>
 <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
 <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 10:11:01AM +0800, Dave Young wrote:
> In case people have a lot of devices need more swiotlb, then he manually
> set the ,high with ,low together.

The option to specify the high and low values for the crashkernel are
important for certain machines. The point is that swiotlb already
allocates 64MB of low memory by default. But that memory is only used
for 32bit DMA-mask devices that want to DMA into high memory. There are
drivers just allocating GFP_DMA32 memory, which also ends up in the low
region (but not swiotlb), that is why the previous default of 72MB low
memory was not enough, it only left 8MB of GFP_DMA32 memory. The current
default of 256MB was found by experiments on a bigger number of
machines, to create a reasonable default that is at least likely to be
sufficient of an average machine.

There is no way today for the kernel to find an optimum value for the
amount of low memory required to successfully create a crash dump. It
depends on the amount of devices in the system and how the drivers
for them are written. The drivers have no way to report back their
requirements, and even if they had, at the time the allocation happens
no driver is loaded yet.

So it is up to the system administrator to find workable values for the
high and low memory requirements, even using experiments as a last
resort.

Regards,

	Joerg
