Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D01C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCEA21D05
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCEA21D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbeHILhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:37:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727579AbeHILhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:37:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 57097818B123;
        Thu,  9 Aug 2018 09:13:42 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-178.pek2.redhat.com [10.72.12.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1371510AF9D5;
        Thu,  9 Aug 2018 09:13:37 +0000 (UTC)
Date:   Thu, 9 Aug 2018 17:13:33 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Baoquan He <bhe@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, ard.biesheuvel@linaro.org
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
Message-ID: <20180809091333.GA8008@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
 <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
 <1533800010.5087.71.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533800010.5087.71.camel@gmx.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 09 Aug 2018 09:13:42 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 09 Aug 2018 09:13:42 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dyoung@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/18 at 09:33am, Mike Galbraith wrote:
> On Thu, 2018-08-09 at 12:21 +0800, Dave Young wrote:
> > Hi Mike,
> > 
> > Thanks for the patch!
> > On 08/08/18 at 04:03pm, Mike Galbraith wrote:
> > > When booting with efi=noruntime, we call efi_runtime_map_copy() while
> > > loading the kdump kernel, and trip over a NULL efi.memmap.map.  Avoid
> > > that and a useless allocation when the only mapping we can use (1:1)
> > > is not available.
> > 
> > At first glance, efi_get_runtime_map_size should return 0 in case
> > noruntime.
> 
> What efi does internally at unmap time is to leave everything except
> efi.mmap.map untouched, setting it to NULL and turning off EFI_MEMMAP,
> rendering efi.mmap.map accessors useless/unsafe without first checking
> EFI_MEMMAP.

Probably the x86 efi_init should reset nr_map to zero in case runtime is
disabled.  But let's see how Ard thinks about this and cc linux-efi.

As for efi_get_runtime_map_size, it was introduced for x86 kexec use.
for copying runtime maps,  so I think it is reasonable this function
return zero in case no runtime.

Thanks
Dave
