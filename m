Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CFCECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFBE21476
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFBE21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeINUKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:10:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50292 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeINUKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:10:53 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0pVf-000144-KM; Fri, 14 Sep 2018 16:55:51 +0200
Date:   Fri, 14 Sep 2018 16:55:51 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
cc:     Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v8 1/2] x86/mm: add .bss..decrypted section to hold shared
 variables
In-Reply-To: <07c76a33-7883-f407-5b1c-b6de7dda37b1@amd.com>
Message-ID: <alpine.DEB.2.21.1809141655030.10480@nanos.tec.linutronix.de>
References: <1536875471-17391-1-git-send-email-brijesh.singh@amd.com> <1536875471-17391-2-git-send-email-brijesh.singh@amd.com> <20180914071056.GA4747@zn.tnic> <3517a0db-2f64-6d09-7100-dced40561d08@amd.com> <alpine.DEB.2.21.1809141414390.10480@nanos.tec.linutronix.de>
 <20180914141216.GA29898@zn.tnic> <07c76a33-7883-f407-5b1c-b6de7dda37b1@amd.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1449710060-1536936951=:10480"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1449710060-1536936951=:10480
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 14 Sep 2018, Tom Lendacky wrote:

> On 09/14/2018 09:12 AM, Borislav Petkov wrote:
> > On Fri, Sep 14, 2018 at 02:17:05PM +0200, Thomas Gleixner wrote:
> >>> The sme_encrypt_kernel() does not have access to pmd (after pointer
> >>> fixup is applied). You can extend the sme_encrypt_kernel() to pass an
> >>> additional arguments but then we start getting in include hell. The pmd
> >>> is defined as "pmdval_t". If we extend the sme_encrypt_kernel() then 
> >>> asm/mem_encrypt.h need to include the header file which defines
> >>> "pmdval_t". Adding the 'asm/pgtable_type.h' was causing all kind of
> >>> compilation errors. I didn't spend much time on it. IMO, we really don't
> >>> need to go in this path unless we see some value from doing this.
> >>
> >> Keep it here then.
> > 
> > *For what is worth*, a simple forward declaration works. I've taken the
> > 64-bit forward declaration of pmdval_t as SME is 64-bit only anyway.
> 
> Just my 2 cents, but I'd prefer it to be in head64.c.  This is where
> the future pagetable entries are all updated to set the encryption
> mask by applying sme_get_me_mask() to load_delta.  So, to me, it makes
> sense to keep the clearing of the encryption mask for the bss_decrypted
> section here.

Yes, at least for now, I just keep it there and we can sort that out after
we fixed the problem at hand.

Thanks,

	tglx
--8323329-1449710060-1536936951=:10480--
