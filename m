Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB297C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2552086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2552086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeIDM1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:27:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33662 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbeIDM1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:27:03 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Me9uG4xAbQBY; Tue,  4 Sep 2018 10:02:47 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC9A500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:a500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CACB71EC0424;
        Tue,  4 Sep 2018 10:02:46 +0200 (CEST)
Date:   Tue, 4 Sep 2018 10:02:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 03/16] x86/mtrr: get MTRR number and support TOP_MEM2
Message-ID: <20180904080241.GB32615@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <36ea05160d886ebf8d4a645c0fe8efdc9d6760c3.1535459013.git.puwen@hygon.cn>
 <20180903190438.GF10249@zn.tnic>
 <946157a5-fdb2-a45a-63aa-97e9d602e6f0@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <946157a5-fdb2-a45a-63aa-97e9d602e6f0@hygon.cn>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 11:02:41AM +0800, Pu Wen wrote:
> > > -	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
> > > -	      (boot_cpu_data.x86 >= 0x0f)))
> > > +	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> > > +	       boot_cpu_data.x86 >= 0x0f) ||
> > > +	       boot_cpu_data.x86_vendor == X86_VENDOR_HYGON))
> > 
> > Why are you even touching this statement? The function returns early on
> > !X86_VENDOR_AMD.
> 
> The statement is briefly equal to !(X86_VENDOR_AMD || X86_VENDOR_HYGON).
> So the function will not return early on !X86_VENDOR_AMD. :-)

I meant the *original* version - not yours!

My question is why are you even touching a K8-old BIOS workaround?! Your
commit message says:

    The MtrrFixDramModEn bit on Hygon platform should also be set to 1
    during BIOS initialization of the fixed MTRRs, then cleared to 0 for
    operation.

Is your BIOS already broken?

Searching the net for

                pr_err(FW_WARN "MTRR: CPU %u: SYSCFG[MtrrFixDramModEn]"
                       " not cleared by BIOS, clearing this bit\n",

shows only old mails so I'm going to assume this got fixed, finally! And
you probably have received a *fixed* BIOS even, allegedly.

So what's up?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
