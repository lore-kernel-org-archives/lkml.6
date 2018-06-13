Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 10B31C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D82208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D82208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935755AbeFMUvk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:51:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39816 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935497AbeFMUvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:51:35 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WGD23EABBIgY; Wed, 13 Jun 2018 22:51:33 +0200 (CEST)
Received: from zn.tnic (p200300EC2BD12400329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:2400:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 499801EC0346;
        Wed, 13 Jun 2018 22:51:33 +0200 (CEST)
Date:   Wed, 13 Jun 2018 22:51:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, peterz@infradead.org,
        tony.luck@intel.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net,
        lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org,
        trenn@suse.com, shuah@kernel.org, zhangpanyong@hygon.cn,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-x86_64@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 00/11] Add support for Hygon's Dhyana Family 18h processor
Message-ID: <20180613205129.GD26375@zn.tnic>
References: <1528550410-28080-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1528550410-28080-1-git-send-email-puwen@hygon.cn>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 09:20:10PM +0800, Pu Wen wrote:
> As a new x86 CPU Vendor, Chengdu Haiguang IC Design Co., Ltd (Hygon)
> is a Joint Venture between AMD and Haiguang Information Technology Co.,
> Ltd., and aims at providing high performance x86 processor for China
> server market.
> 
> The first generation Hygon's processor(Dhyana) originates from AMD
> technology and shares most of the architecture with AMD's family 17h,
> but with different CPU Vendor ID("HygonGenuine")/PCIE Device Vendor ID
> (0x1D94)/Family series number(Family 18h).
> 
> To enable the support of Linux kernel to Hygon's CPU, we added a new
> vendor type (X86_VENDOR_HYGON, with value of 9) in arch/x86/include/
> asm/processor.h, and shared most of kernel support codes with AMD
> family 17h.
> 
> These patches have been applied and tested successfully in Hygon's
> Dhyana SoC silicon. Also tested on AMD's EPYC (Family 17h) processor
> works fine and makes no harm to existing codes.

Well, I don't like this diffstat:

 37 files changed, 183 insertions(+), 56 deletions(-)

which adds a lot of code checking this new vendor. But then it adds in
the AMD paths and I don't see it being any different from an AMD CPU. So
it does the same a Zen does but then it is Hygon.

So I'd prefer to *not* sprinkle those X86_VENDOR_HYGON checks everywhere
but simply have the vendor be X86_VENDOR_AMD and only the user-visible
reporting to show that it is Hygon. Because to the kernel it is an AMD
CPU - only the superficial attributes are something else. Oh well, and
PCI device IDs but that's like another CPU revision.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
