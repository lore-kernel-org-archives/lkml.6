Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E14ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9431520882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9431520882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeINUAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:00:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:50324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727749AbeINUAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:00:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF75FAEB6;
        Fri, 14 Sep 2018 14:45:24 +0000 (UTC)
Date:   Fri, 14 Sep 2018 16:45:18 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v8 1/2] x86/mm: add .bss..decrypted section to hold
 shared variables
Message-ID: <20180914144518.GB29898@zn.tnic>
References: <1536875471-17391-1-git-send-email-brijesh.singh@amd.com>
 <1536875471-17391-2-git-send-email-brijesh.singh@amd.com>
 <20180914071056.GA4747@zn.tnic>
 <3517a0db-2f64-6d09-7100-dced40561d08@amd.com>
 <alpine.DEB.2.21.1809141414390.10480@nanos.tec.linutronix.de>
 <20180914141216.GA29898@zn.tnic>
 <43895f0e-fea7-001e-d727-d962a20f7f6c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43895f0e-fea7-001e-d727-d962a20f7f6c@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 09:27:09AM -0500, Brijesh Singh wrote:
> The above code will never get executed for the SEV case.
> 
> See if (!sme_active()) check in the start of function.
> 
> If we decide to go on this patch, then we have to do something like
> this:
> 
> sme_encrypt_kernel(...)
> {
> 	if (!mem_encrypt_active())
> 		return;
> 
> 	if (sev_active())
> 		goto out;
> 
> 	/* Do kernel and initrd in-place encrypts for SME only case */
> 	.....
> 	.....
> 
> out:
> 	/* Clear the C-bit from .bss..decrypted section */
> 	...
> 	...

Or above do:

	if (sev_active()) {
		sev_map_bss_decrypted();
                return;
	}

which is a separate function you call.

So that you not have a label at the end of the function. Whatever tglx
prefers.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
