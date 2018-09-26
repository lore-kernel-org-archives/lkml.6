Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987ADC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB0E214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB0E214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeIZRso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:48:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49164 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeIZRso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:48:44 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jCKH_iKQPgvF; Wed, 26 Sep 2018 13:36:09 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA1F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:1f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D0741EC01FA;
        Wed, 26 Sep 2018 13:36:09 +0200 (CEST)
Date:   Wed, 26 Sep 2018 13:36:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        David Wang <davidwang@zhaoxin.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, He Chen <he.chen@linux.intel.com>,
        Luwei Kang <luwei.kang@intel.com>, kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Piotr Luc <Piotr.Luc@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v14 04/19] x86/cpufeatures: Add SGX feature bits
Message-ID: <20180926113617.GD5584@zn.tnic>
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
 <20180925130845.9962-5-jarkko.sakkinen@linux.intel.com>
 <20180925164854.GF23986@zn.tnic>
 <20180926111139.GA12037@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180926111139.GA12037@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 02:11:39PM +0300, Jarkko Sakkinen wrote:
> Thank you. I guess I understand what you want me to do i.e.
> 
> +       { X86_FEATURE_SGX1,             CPUID_EAX,  0, 0x00000012, 0 },
> +       { X86_FEATURE_SGX2,             CPUID_EAX,  1, 0x00000012, 0 },
> +       { X86_FEATURE_ENCLV,            CPUID_EAX,  5, 0x00000012, 0 },
> +       { X86_FEATURE_ENCLS_C,          CPUID_EAX,  6, 0x00000012, 0 },

Yap.

> What puzzles me is that I cannot find any call site for
> get_scattered_cpuid_leaf():
> 
> $ git grep get_scattered
> arch/x86/kernel/cpu/cpu.h:extern u32 get_scattered_cpuid_leaf(unsigned int level,
> arch/x86/kernel/cpu/scattered.c:u32 get_scattered_cpuid_leaf(unsigned int level, unsigned int sub_leaf,
> arch/x86/kernel/cpu/scattered.c:EXPORT_SYMBOL_GPL(get_scattered_cpuid_leaf);

That used to be used in kvm last, see b7b27aa011a1df42728d1768fc181d9ce69e6911,
which removed it.

And it got added by

  47bdf3378d62 ("x86/cpuid: Provide get_scattered_cpuid_leaf()")

Lemme add those people to CC.

If no one wants it, feel free to decomission it.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
