Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B80C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55936218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfB0Baj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:30:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbfB0Baj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:30:39 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1919E30BEE2F;
        Wed, 27 Feb 2019 01:30:38 +0000 (UTC)
Received: from localhost (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D8486A96A;
        Wed, 27 Feb 2019 01:30:36 +0000 (UTC)
Date:   Wed, 27 Feb 2019 09:30:34 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Pingfan Liu <kernelfans@gmail.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/boot/KASLR: skip the specified crashkernel reserved
 region
Message-ID: <20190227013034.GP14858@MiWiFi-R3L-srv>
References: <1551081596-2856-1-git-send-email-kernelfans@gmail.com>
 <20190225094522.GC26145@zn.tnic>
 <CAFgQCTtYp5mV0xmt4ZJbS0igBFe8S1ZbUnuTWE1-wj8CuHPJew@mail.gmail.com>
 <20190226104653.GB14836@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226104653.GB14836@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 27 Feb 2019 01:30:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/19 at 11:46am, Borislav Petkov wrote:
> On Tue, Feb 26, 2019 at 11:08:42AM +0800, Pingfan Liu wrote:
> > I follow Baoquan's opinion. Due to the randomness caused by KASLR, a
> > user may be surprised to find crashkernel=x@y not working sometime.
> 
> And she/he will get told in dmesg that the allocation failed.
> 
> > If kernel can help them out of this corner automatically, then no
> > need to bother them with the message to use alternative method
> > crashkernel=M. Anyway it is a cheap method already used by other
> > options like hugepages and memmap in handle_mem_options().
> > If commitment, then do it without failure. Or just removing
> > crashkernel=x@y option on x86.
> 
> I can't parse what you're trying to say here but let me repeat myself:
> specifying a crashkernel region should not have an influence on KASLR
> because this way you limit the kernel where it selects the offset. It
> should be other other way around: KASLR offset should be selected and
> *then* crashkernel region.

Agree that 'crashkernel=x' should be encouraged to use as the first
choice when reserve crashkernel. If we decide to not obsolete
'crashkernel=x@y', it will leave a unstable kernel parameter. Another
worry is that KASLR won't always fail 'crashkernel=x@y', customer may
set and check in testing stage, then later in production environment one
time of neglect to not check may cause carashed kernel uncaptured.

IMHO, 'crashkernel=x@y' is similar to those specified memmap=ss[#$!]nn
which have been avoided in boot stage KASLR.

And in kernel life cycle, we specify kernel parameter before kernel boot,
later KASLR lives to choose position. So KASLR can avoid firstly
specified regions which are being reserved for usage, 'crashkernel=x@y'
have no way to compromise with KASLR if it's still allowed to exist in
kernel.

Personal thought.

Thanks
Baoquan
