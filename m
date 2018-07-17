Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C772ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F36208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F6ohhIOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F36208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeGQFlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 01:41:55 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37007 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbeGQFly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 01:41:54 -0400
Received: by mail-pf0-f196.google.com with SMTP id a26-v6so5352094pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 22:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=auqBgfbX5mWSeF8fWlFxDwN+/ULQbGDp7E9uqIWsiMw=;
        b=F6ohhIOKlOlFu4IEVS/ACRBEreBmyHVO3YoqRGxacPtmOigh2lztgDtNyTCkVao4kj
         CdKROa7sZHUAxAMXce3Aa40Lpp1KDghMR14056R6SihR3+fFtORSvMpn90UEjDJloUCz
         NVYKLzCzrrg7/YOACqoGfopwd7Lg1+hPMWyN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=auqBgfbX5mWSeF8fWlFxDwN+/ULQbGDp7E9uqIWsiMw=;
        b=hJK1jhMYyGQULXpctIsl/IsgpOv1iEK4kGqJu9hbMB9Vgf8oWSPeqrHLB9JhrwBtus
         kzdPshy+Jb6e7Ashl8H3lSrMQGP+2fFE4JHR8YfIxVL5+I4s7pS8q8ZNd+Weov5kHj1D
         HiE1u77LW55HCwkmiPoGrc1HTm6vVl8dud7J9kghRKfHMjIM9cuZN3aT0F9KHlHf9bta
         XHaI2s2y+VU3U7TKOgzwwRYtU8eWQLIzjkz0uN+Tz6O55Cq0GGDMRuhJgf0E5wmi1+AT
         e1uzDgQ/oOuKjl7VpNPs5bShlCZJhW85hlZ2xUvHw1AJ+fK4dKwl6sQ8ZsyXdw/d+VqC
         847A==
X-Gm-Message-State: AOUpUlHmm69ApXH4vcdMMzT52+tRpel4kiZ5CvVwG+1VbVYLmoMp6B2a
        c44OqnuQr6clNNt/ZEHN8M2iBg==
X-Google-Smtp-Source: AAOMgpfd+2hUgYIdBR3sYS6sAjqg/LsSTfUbPaG0755F/kegWQRjeZyTe5Nof0lWmnclBOFAUY7v/g==
X-Received: by 2002:a63:e452:: with SMTP id i18-v6mr117799pgk.185.1531804270781;
        Mon, 16 Jul 2018 22:11:10 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id k128-v6sm124647pgk.4.2018.07.16.22.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 22:11:10 -0700 (PDT)
Date:   Tue, 17 Jul 2018 14:12:23 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
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
Message-ID: <20180717051222.GA11258@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Baicar, Tyler" <tbaicar@codeaurora.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>, James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Al Stone <al.stone@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
 <20180712164918.GA26935@arm.com>
 <20180713003434.GZ28220@linaro.org>
 <CAKv+Gu9PT75XTXGsh1jc5roRO_d2QYKEamq42mfbsXzmerAUzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9PT75XTXGsh1jc5roRO_d2QYKEamq42mfbsXzmerAUzA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will,

On Fri, Jul 13, 2018 at 07:49:45AM +0200, Ard Biesheuvel wrote:
> On 13 July 2018 at 02:34, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> > On Thu, Jul 12, 2018 at 05:49:19PM +0100, Will Deacon wrote:
> >> Hi Akashi,
> >>
> >> On Tue, Jul 10, 2018 at 08:42:25AM +0900, AKASHI Takahiro wrote:
> >> > This patch series is a set of bug fixes to address kexec/kdump
> >> > failures which are sometimes observed on ACPI-only system and reported
> >> > in LAK-ML before.
> >>
> >> I tried picking this up, along with Ard's fixup, but I'm seeing a build
> >> failure for allmodconfig:
> >>
> >> arch/arm64/kernel/acpi.o: In function `__acpi_get_mem_attribute':
> >> acpi.c:(.text+0x60): undefined reference to `efi_mem_attributes'
> >>
> >> I didn't investigate further. Please can you fix this?
> >
> > Because CONFIG_ACPI is on and CONFIG_EFI is off.
> >
> > This can happen in allmodconfig as CONFIG_EFI depends on
> > !CONFIG_CPU_BIG_ENDIAN, which is actually on in this case.
> >
> 
> Allowing both CONFIG_ACPI and CONFIG_CPU_BIG_ENDIAN to be configured
> makes no sense at all. Things will surely break if you start using BE
> memory accesses while parsing ACPI tables.
> 
> Allowing CONFIG_ACPI without CONFIG_EFI makes no sense either, since
> on arm64, the only way to find the ACPI tables is through a UEFI
> configuration table.


Do you agree to this?

-Takahiro AKASHI

> > Looking at __acpi_get_mem_attributes(), since there is no information
> > available on memory attributes, what we can do at best is
> >   * return PAGE_KERNEL (= cacheable) for mapped memory,
> >   * return DEVICE_nGnRnE (= non-cacheable) otherwise
> > (See a hunk to be applied on top of my patch#4.)
> >
> > I think that, after applying, acpi_os_ioremap() would work almost
> > in the same way as the original before my patchset given that
> > MAP memblock attribute is used only under CONFIG_EFI for now.
> >
> > Make sense?
> >
> 
> Let's keep your code as is but fix the Kconfig dependencies instead.
