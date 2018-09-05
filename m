Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5F9C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAA5206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAA5206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeIERgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:36:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59531 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeIERgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:36:21 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxXVW-0004Gp-Is; Wed, 05 Sep 2018 15:06:06 +0200
Date:   Wed, 5 Sep 2018 15:06:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>
Subject: Re: [PATCH V3 3/5] x86/efi: Permanently save the EFI_MEMORY_MAP
 passed by the firmware
In-Reply-To: <CAKv+Gu_DC=+7_YmDGGJ9fYJkGSNbUK-eXOAGMuZ2B7XXPWvZ9g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809051505030.1416@nanos.tec.linutronix.de>
References: <1536099149-12564-1-git-send-email-sai.praneeth.prakhya@intel.com> <1536099149-12564-4-git-send-email-sai.praneeth.prakhya@intel.com> <CAKv+Gu9mfWYww49OmBETutSsaTDfE6VFJjbf+LWAoXF=mNmDBA@mail.gmail.com> <20180905125645.GX24082@hirez.programming.kicks-ass.net>
 <CAKv+Gu_DC=+7_YmDGGJ9fYJkGSNbUK-eXOAGMuZ2B7XXPWvZ9g@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, Ard Biesheuvel wrote:
> On 5 September 2018 at 14:56, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Wed, Sep 05, 2018 at 02:27:49PM +0200, Ard Biesheuvel wrote:
> >> Would we still need to preserve the old memory map in that case?
> >
> > I thought the reason for having this was being able to know the fault is
> > in an EFI area. But of course, I'm not wel versed in this whole EFI
> > crapola.
> 
> I'm not entirely sure whether that really matters. The EFI services
> access the stack and can access byref/pointer arguments which are not
> covered by the EFI memory map as runtime services code/data, and so
> they can trigger page faults by running off the vmapped stack or
> writing to const byref arguments.
> 
> EFI runtime services using boot services regions after they are no
> longer available are a known source of headaches, but I don't see why
> we should restrict ourselves to such cases if we bother to wire up
> fault handling specifically for EFI services calls.
> 
> So any page or permission fault occurring in the context of a EFI
> runtime services invocation should be treated the same, I think.

I agree. Keep it simple. If the EFI crap fails, then assist with the reboot
and otherwise just kill it.

Thanks,

	tglx

