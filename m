Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85551ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A41220856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A41220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbeGWOgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:36:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34046 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387909AbeGWOgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:36:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68D5480D;
        Mon, 23 Jul 2018 06:35:36 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 397A33F237;
        Mon, 23 Jul 2018 06:35:36 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 90C9D1AE060B; Mon, 23 Jul 2018 14:35:35 +0100 (BST)
Date:   Mon, 23 Jul 2018 14:35:35 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Baicar, Tyler" <tbaicar@codeaurora.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Stone <al.stone@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Subject: Re: [PATCH v3.1 0/4] arm64: kexec,kdump: fix boot failures on
 acpi-only system
Message-ID: <20180723133527.GA9450@arm.com>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
 <20180712164918.GA26935@arm.com>
 <20180713003434.GZ28220@linaro.org>
 <CAKv+Gu9PT75XTXGsh1jc5roRO_d2QYKEamq42mfbsXzmerAUzA@mail.gmail.com>
 <20180717051222.GA11258@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717051222.GA11258@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 02:12:23PM +0900, AKASHI Takahiro wrote:
> On Fri, Jul 13, 2018 at 07:49:45AM +0200, Ard Biesheuvel wrote:
> > On 13 July 2018 at 02:34, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> > > On Thu, Jul 12, 2018 at 05:49:19PM +0100, Will Deacon wrote:
> > >> Hi Akashi,
> > >>
> > >> On Tue, Jul 10, 2018 at 08:42:25AM +0900, AKASHI Takahiro wrote:
> > >> > This patch series is a set of bug fixes to address kexec/kdump
> > >> > failures which are sometimes observed on ACPI-only system and reported
> > >> > in LAK-ML before.
> > >>
> > >> I tried picking this up, along with Ard's fixup, but I'm seeing a build
> > >> failure for allmodconfig:
> > >>
> > >> arch/arm64/kernel/acpi.o: In function `__acpi_get_mem_attribute':
> > >> acpi.c:(.text+0x60): undefined reference to `efi_mem_attributes'
> > >>
> > >> I didn't investigate further. Please can you fix this?
> > >
> > > Because CONFIG_ACPI is on and CONFIG_EFI is off.
> > >
> > > This can happen in allmodconfig as CONFIG_EFI depends on
> > > !CONFIG_CPU_BIG_ENDIAN, which is actually on in this case.
> > >
> > 
> > Allowing both CONFIG_ACPI and CONFIG_CPU_BIG_ENDIAN to be configured
> > makes no sense at all. Things will surely break if you start using BE
> > memory accesses while parsing ACPI tables.
> > 
> > Allowing CONFIG_ACPI without CONFIG_EFI makes no sense either, since
> > on arm64, the only way to find the ACPI tables is through a UEFI
> > configuration table.
> 
> 
> Do you agree to this?

Yes; please post a new series which resolves these dependencies and includes
Ard's fixup from before.

Thanks,

Will
