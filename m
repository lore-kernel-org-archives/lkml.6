Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23591C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4D32086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4D32086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeIYW5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:57:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39092 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbeIYW5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:57:12 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Jaqwt54nZjnL; Tue, 25 Sep 2018 18:48:51 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC69500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:9500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D74CC1EC0311;
        Tue, 25 Sep 2018 18:48:50 +0200 (CEST)
Date:   Tue, 25 Sep 2018 18:48:54 +0200
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
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 04/19] x86/cpufeatures: Add SGX feature bits
Message-ID: <20180925164854.GF23986@zn.tnic>
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
 <20180925130845.9962-5-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180925130845.9962-5-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 04:06:41PM +0300, Jarkko Sakkinen wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Add SGX feature bits as part of the Linux defined leaf 8, which
> currently contains virtualization flags.  There are currently four
> documented SGX feature bits, with more expected in the not-too-distant
> future.

...

> +static void detect_sgx(struct cpuinfo_x86 *c)
> +{
> +#define _X86_FEATURE_SGX1		BIT(0)
> +#define _X86_FEATURE_SGX2		BIT(1)
> +#define _X86_FEATURE_SGX_ENCLV		BIT(5)
> +#define _X86_FEATURE_SGX_ENCLS_C	BIT(6)
> +
> +	unsigned int eax;
> +
> +	clear_cpu_cap(c, X86_FEATURE_SGX1);
> +	clear_cpu_cap(c, X86_FEATURE_SGX2);
> +	clear_cpu_cap(c, X86_FEATURE_SGX_ENCLV);
> +	clear_cpu_cap(c, X86_FEATURE_SGX_ENCLS_C);
> +
> +	if (c->cpuid_level < SGX_CPUID) {
> +		pr_err_once("x86/sgx: cannot enumerate CPUID leaf (0x%x)\n",
> +			    SGX_CPUID);
> +		clear_cpu_cap(c, X86_FEATURE_SGX);
> +		return;
> +	}
> +
> +	eax = cpuid_eax(SGX_CPUID);
> +
> +	if (eax & _X86_FEATURE_SGX1)
> +		set_cpu_cap(c, X86_FEATURE_SGX1);
> +
> +	if (eax & _X86_FEATURE_SGX2)
> +		set_cpu_cap(c, X86_FEATURE_SGX2);
> +
> +	if (eax & _X86_FEATURE_SGX_ENCLV)
> +		set_cpu_cap(c, X86_FEATURE_SGX_ENCLV);
> +
> +	if (eax & _X86_FEATURE_SGX_ENCLS_C)
> +		set_cpu_cap(c, X86_FEATURE_SGX_ENCLS_C);


Look at arch/x86/kernel/cpu/scattered.c for how to do this properly.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
