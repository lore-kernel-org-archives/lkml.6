Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C533C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D40247A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D40247A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934361AbeFVTJQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:09:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33122 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752652AbeFVTJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:09:15 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tUIZbLNJPq2v; Fri, 22 Jun 2018 21:09:14 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF3400329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:3400:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA9A11EC020C;
        Fri, 22 Jun 2018 21:09:13 +0200 (CEST)
Date:   Fri, 22 Jun 2018 21:09:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] x86/kvm: Implement MSR_HWCR support
Message-ID: <20180622190912.GG1882@zn.tnic>
References: <20180622095101.32587-1-bp@alien8.de>
 <20180622095101.32587-3-bp@alien8.de>
 <20180622185237.GC5549@flask>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180622185237.GC5549@flask>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 08:52:38PM +0200, Radim Krčmář wrote:
> msr_info->host_initiated is always going to return true, so it would be
> better to put it outside of __set_mci_status.
> 
> Maybe we could just write the whole logic inline, otherwise I'd call it
> something like mci_status_is_writeable.
> 
> >  static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >  {
> >  	u64 mcg_cap = vcpu->arch.mcg_cap;
> > @@ -2176,9 +2200,13 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >  			if ((offset & 0x3) == 0 &&
> >  			    data != 0 && (data | (1 << 10)) != ~(u64)0)
> >  				return -1;
> > -			if (!msr_info->host_initiated &&
> > -				(offset & 0x3) == 1 && data != 0)
> > -				return -1;
> > +
> > +			/* MCi_STATUS */
> > +			if ((offset & 0x3) == 1) {
> > +				if (!__set_mci_status(vcpu, msr_info))
> > +					return -1;
> > +			}
> 
> 			if (!msr_info->host_initiated &&
> 			    (offset & 0x3) == 1 && data != 0) {
> 				struct msr_data tmp = {.index = MSR_K7_HWCR};
> 
> 				if (!guest_cpuid_is_amd(vcpu) ||
> 				    !kvm_x86_ops->get_msr(vcpu, &tmp) ||
> 				    !(tmp.data & BIT_ULL(18)))
> 					return -1;

Don't you feel it is cleaner if all the MCi_STATUS checking is done in
a separate function? The indentation level and the bunch of checks in
set_msr_mce() make it hard to read while having a separate function
separates it and makes it easier to follow.

I mean, you're the maintainer but if I may give a suggestion, moving the
whole logic into a separate function would be more readable.

And then do:

	if (!msr_info->host_initiated) {
		if (check_mci_status(...))
			return -1;
	}

Something like that...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
