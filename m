Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211F4ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22F22146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22F22146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeINRb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:31:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49484 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbeINRb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:31:28 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0n24-0005VW-0I; Fri, 14 Sep 2018 14:17:08 +0200
Date:   Fri, 14 Sep 2018 14:17:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v8 1/2] x86/mm: add .bss..decrypted section to hold shared
 variables
In-Reply-To: <3517a0db-2f64-6d09-7100-dced40561d08@amd.com>
Message-ID: <alpine.DEB.2.21.1809141414390.10480@nanos.tec.linutronix.de>
References: <1536875471-17391-1-git-send-email-brijesh.singh@amd.com> <1536875471-17391-2-git-send-email-brijesh.singh@amd.com> <20180914071056.GA4747@zn.tnic> <3517a0db-2f64-6d09-7100-dced40561d08@amd.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-358965675-1536927428=:10480"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-358965675-1536927428=:10480
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 14 Sep 2018, Brijesh Singh wrote:
> On 9/14/18 2:10 AM, Borislav Petkov wrote:
> >>  	/*
> >> +	 * Clear the memory encryption mask from the .bss..decrypted section.
> >> +	 * The bss section will be memset to zero later in the initialization so
> >> +	 * there is no need to zero it after changing the memory encryption
> >> +	 * attribute.
> >> +	 */
> >> +	if (mem_encrypt_active()) {
> >> +		vaddr = (unsigned long)__start_bss_decrypted;
> >> +		vaddr_end = (unsigned long)__end_bss_decrypted;
> >> +		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
> >> +			i = pmd_index(vaddr);
> >> +			pmd[i] -= sme_get_me_mask();
> >> +		}
> >> +	}
> > Why isn't this chunk at the end of sme_encrypt_kernel() instead of here?
> 
> The sme_encrypt_kernel() does not have access to pmd (after pointer
> fixup is applied). You can extend the sme_encrypt_kernel() to pass an
> additional arguments but then we start getting in include hell. The pmd
> is defined as "pmdval_t". If we extend the sme_encrypt_kernel() then 
> asm/mem_encrypt.h need to include the header file which defines
> "pmdval_t". Adding the 'asm/pgtable_type.h' was causing all kind of
> compilation errors. I didn't spend much time on it. IMO, we really don't
> need to go in this path unless we see some value from doing this.

Keep it here then.

> >> @@ -345,6 +363,7 @@ SECTIONS
> >>  		__bss_start = .;
> >>  		*(.bss..page_aligned)
> >>  		*(.bss)
> >> +		BSS_DECRYPTED
> >>  		. = ALIGN(PAGE_SIZE);
> >>  		__bss_stop = .;
> > Putting it in the BSS would need a bit of care in the future as it poses
> > a certain ordering on the calls in x86_64_start_kernel() (not that there
> > isn't any now :)):
> 
> 
> Hmm, I thought since we are explicitly saying that attribute will add
> the variables in the bss section so caller should not be using the
> variable before bss is ready. If you are concerns that clear_bss() may
> get called after the variable is used then we could memset(0) when while
> clearing the C-bit. I did try to add some comments when we are clearing
> the C-bit. I can include some verbatim in BSS_DECRYPTED section as well.

Nah. It's clearly marked __bss_decrypted and anything which stores data in
a BSS location is busted whether thats .bss or .bss..decrypted. If someone
is not aware about the BSS constraints in general, i.e. don't use it before
clear_bss(), then I really can't help it.

Thanks,

	tglx


--8323329-358965675-1536927428=:10480--
