Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0360C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588B92145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588B92145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeJRWo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:44:56 -0400
Received: from foss.arm.com ([217.140.101.70]:39082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeJRWo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:44:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63FDEA78;
        Thu, 18 Oct 2018 07:43:36 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 313873F71A;
        Thu, 18 Oct 2018 07:43:35 -0700 (PDT)
Date:   Thu, 18 Oct 2018 15:43:32 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     peng.hao2@zte.com.cn
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH]  arm64/pvpanic-mmio : add pvpanic mmio device
Message-ID: <20181018144332.dfiukokzcbtxe573@lakrids.cambridge.arm.com>
References: <20181017113816.6kub42pii5hev6fh@lakrids.cambridge.arm.com>
 <201810180956117739833@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810180956117739833@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 09:56:11AM +0800, peng.hao2@zte.com.cn wrote:
> >Hi,
> >
> >[adding devicetree]
> >
> >On Wed, Oct 17, 2018 at 06:08:23PM +0800, Peng Hao wrote:

[...]

> >> +#define PVPANIC_MMIO_CRASHED    (1 << 0)
> >
> >This looks like it's identical to PVPANIC_PANICKED in the existing ACPI
> >IO pvpanic driver.
> >
> >I suspect on the QEMU side, there's one device, and the distinction is
> >only in how this is described.
> >
> in qemu:
> Firstly pvpanic(x86) use ioport, but arm don't support ioport.
> secondly pvpanic device is emulated as a isa bus device, but arm don't support
> isa bus.

I am aware of arm platforms with an ISA bus (well, LPC, at least).

> thirdly the realization of pvpanic device is depends on ACPI in linux
> kernel driver and in qemu the port info is passed through ACPI , but
> It is not necessary to configure ACPI for arm guest.

There are many people using ACPI with arm64 under QEMU, so while it's
not *necessary* to use ACPI, it is a common use case that we cannot rule
out.

> in linux : I don't want to depends on ACPI .

I'm not saying that you must depend on ACPI for your specific use-case.

> ARM virt machine  in qemu uses FDT, and I can easily 
> use FDT to get mmio information from QEMU. 
> >Can't one driver support both?
> Just like  virtio-mmio driver, It is mainly used for non x86 architecture.

So? I can build virtio-mmio for x86, too.

My concern is that other than the initial probing, the vast majority of
this is *identical* to the existing pvpanic driver (ignoring cosmetic
differences like the naming of variables).

I'm worried that there could be additions to the pvpanic device in
future (e.g. passing a pointer to some crash context), which would then
have to be duplicated across two drivers.

IMO we should:

a) Move the existing pvpanic driver to a neutral location (e.g.
   drivers/virt/qemu_pvpanic.c).

b) Teach the existing pvpanic driver to handle MMIO, even for ACPI.

c) Teach the existing pvpanic driver to handle DT, even if that DT
   binding only caters for MMIO.

Thanks,
Mark.
