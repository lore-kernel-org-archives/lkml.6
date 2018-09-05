Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CCFC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F4C2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1dHN4exA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F4C2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeIER1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:27:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33032 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeIER1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o9aj9M8BdTTNfVXHGRUfY/CO1PKCOMGHtmuuB8wWbYI=; b=1dHN4exACR1bk2z/R1LGpZNxq
        GGaBdMS4IMqBNT5BZ9P4d9+PYRmRL+dr2OHcKtMZHzTYdZJtLLcDMtrYkidA1jFDhDXyHAW5153t3
        4j1izYb9scAqrqfkNqgI2f9taPlAMWELpEx2FiIBKUD72w7WqZeXiWo40ndwVML+3O9JpcyqiqxAM
        GljaYzl4fPJZtKd3mFjIrlcjBR0LGC4FPauk209sqllmVuv9q0R+BAuu7dtJX4u7vojSHUOvKdhiN
        ydZjggQEFita6H8OCBRlx1fKIvl0tR0GkUudczVLoZF2v7XZ+ZGzkt6p2cwd/6hE8AyNpSI1r9SoQ
        X+zF9C6hQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxXMV-0005Q9-VU; Wed, 05 Sep 2018 12:56:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 78D9B202F5BAA; Wed,  5 Sep 2018 14:56:45 +0200 (CEST)
Date:   Wed, 5 Sep 2018 14:56:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V3 3/5] x86/efi: Permanently save the EFI_MEMORY_MAP
 passed by the firmware
Message-ID: <20180905125645.GX24082@hirez.programming.kicks-ass.net>
References: <1536099149-12564-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1536099149-12564-4-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu9mfWYww49OmBETutSsaTDfE6VFJjbf+LWAoXF=mNmDBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9mfWYww49OmBETutSsaTDfE6VFJjbf+LWAoXF=mNmDBA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 02:27:49PM +0200, Ard Biesheuvel wrote:
> On 5 September 2018 at 00:12, Sai Praneeth Prakhya
> <sai.praneeth.prakhya@intel.com> wrote:
> > From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
> >
> > The efi page fault handler that recovers from page faults caused by the
> > firmware needs the original memory map passed by the firmware. It looks
> > up this memory map to find the type of the memory region at which the
> > page fault occurred. Presently, EFI subsystem discards the original
> > memory map passed by the firmware and replaces it with a new memory map
> > that has only EFI_RUNTIME_SERVICES_<CODE/DATA> regions. But illegal
> > accesses by firmware can occur at any region. Hence, _only_ if
> > CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS is defined, create a backup of the
> > original memory map passed by the firmware, so that efi page fault
> > handler could detect/recover from illegal accesses to *any* efi region.
> >
> 
> Why do we care about the memory map at all when a fault occurs during
> the invocation of a EFI runtime service?
> 
> I think reasoning about what went wrong and why, and distinguishing
> between allowable and non-allowable faults is a slippery slope, so
> [taking Thomas's feedback into account], I think we can simplify this
> series further and just block all subsequent EFI runtime services
> calls if any permission or page fault occurs while executing them.
> 
> Would we still need to preserve the old memory map in that case?

I thought the reason for having this was being able to know the fault is
in an EFI area. But of course, I'm not wel versed in this whole EFI
crapola.
