Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E04C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10DB25C57
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10DB25C57
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964952AbeGBMGZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:06:25 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52436 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753987AbeGBMGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:06:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id E9CF829553;
        Mon,  2 Jul 2018 08:06:19 -0400 (EDT)
Date:   Mon, 2 Jul 2018 22:07:29 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Mathieu Malaterre <malat@debian.org>
cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/11] macintosh/via-pmu: Fix section mismatch
 warning
In-Reply-To: <CA+7wUsyfkC3FvbFyt9JRdBas3s+52tp7OH8h2jiJM9z+ynoyyw@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1807022143570.13@nippy.intranet>
References: <cover.1530519301.git.fthain@telegraphics.com.au> <720e9899186bed184fb9b5cce070e2dc519f9665.1530519301.git.fthain@telegraphics.com.au> <CA+7wUsyfkC3FvbFyt9JRdBas3s+52tp7OH8h2jiJM9z+ynoyyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018, Mathieu Malaterre wrote:

> On Mon, Jul 2, 2018 at 10:25 AM Finn Thain <fthain@telegraphics.com.au> 
> wrote:
> >
> > The pmu_init() function has the __init qualifier, but the ops struct 
> > that holds a pointer to it does not. This causes a build warning. The 
> > driver works fine because the pointer is only dereferenced early.
> >
> > The function is so small that there's negligible benefit from using 
> > the __init qualifier. Remove it to fix the warning, consistent with 
> > the other ADB drivers.
> 
> Would you mind copy/pasting the warning you are seeing.
> 
> Make sure you have:
> 
> 58935176ad17 powerpc/via-pmu: Fix section mismatch warning
> 
> Thanks
> 

It's true, the section mismatch warning from 'make' has disappeared since 
I wrote this patch, but that doesn't mean it is wrong.

Before this patch:

$ powerpc-linux-gnu-objdump -xda vmlinux |egrep -w "via_pmu_driver|pmu_init"
c0711c84 l     F .init.text     0000001c pmu_init
c05eb408 g     O .rodata        00000028 via_pmu_driver
c0711c84 <pmu_init>:
$ 

After:

$ powerpc-linux-gnu-objdump -xda vmlinux |egrep -w "via_pmu_driver|pmu_init"
c038e42c l     F .text  0000001c pmu_init
c05e1e58 g     O .rodata        00000028 via_pmu_driver
c038e42c <pmu_init>:
$

I gather that commit 58935176ad17 ("powerpc/via-pmu: Fix section mismatch 
warning") has moved via_pmu_driver from .data to .rodata, but I'm afraid I 
don't see the point of that change. The commit log entry doesn't explain 
it either.

If .rodata is not discarded then the dangling pointer remains, right?

-- 
