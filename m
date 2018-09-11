Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3519C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6834B20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6834B20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeIKWmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:42:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:46790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726782AbeIKWmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:42:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA6B1B036;
        Tue, 11 Sep 2018 17:42:00 +0000 (UTC)
Date:   Tue, 11 Sep 2018 19:41:58 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-efi@vger.kernel.org,
        x86@kernel.org
Subject: Re: Random crashes with i386 and efi boots
Message-ID: <20180911174158.7qu6f4vfnfzqqrcf@suse.de>
References: <20180910215659.GA17966@roeck-us.net>
 <D213F8BC-5C8E-44A2-810F-918B915F0804@amacapital.net>
 <877118e5-beee-4551-28d3-79e7aa52f74e@roeck-us.net>
 <90A7FF2E-F186-49CF-A028-CDE317BE13E1@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90A7FF2E-F186-49CF-A028-CDE317BE13E1@amacapital.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 09:36:51AM -0700, Andy Lutomirski wrote:
> >    save_pgd = efi_call_phys_prolog();
> >    local_irq_save(flags);
> >    status = efi_call_phys(...);
> >        local_irq_restore(flags);
> > 
> >        efi_call_phys_epilog(save_pgd);
> > 
> > So, yes, interrupts are very much enabled.
> 
> Does fixing that solve the problem?  It seems more robust.

The problem is still that in efi_call_phys_prolog() we load the gdt with
its physical address, and when we reload the %cr3 in _epilog from
initial_page_table to swapper_pg_dir again the gdt is no longer mapped.
Blocking interrupts is more robust, but we can't block NMIs that way
that would also trigger the issue, no?

So I am in favor of changing the order in efi_call_phys_epilog() too.

Regards,

	Joerg
