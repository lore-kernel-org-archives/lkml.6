Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904DCC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5569920866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5569920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbeIJQ02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:26:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:60602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727646AbeIJQ02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:26:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67785AFEA;
        Mon, 10 Sep 2018 11:32:49 +0000 (UTC)
Date:   Mon, 10 Sep 2018 13:32:42 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v6 1/5] x86/mm: Restructure sme_encrypt_kernel()
Message-ID: <20180910113242.GA21815@zn.tnic>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
 <1536343050-18532-2-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536343050-18532-2-git-send-email-brijesh.singh@amd.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:57:26PM -0500, Brijesh Singh wrote:
> Re-arrange the sme_encrypt_kernel() by moving the workarea map/unmap
> logic in a separate static function. There are no logical changes in this
> patch. The restructuring will allow us to expand the sme_encrypt_kernel
> in future.

...

> -	/* Perform the encryption */
> -	sme_encrypt_execute(kernel_start, kernel_start + decrypted_base,
> -			    kernel_len, workarea_start, (unsigned long)ppd.pgd);
> +	wa->kernel_start = kernel_start;
> +	wa->kernel_end = kernel_end;
> +	wa->kernel_len = kernel_len;
>  
> -	if (initrd_len)
> -		sme_encrypt_execute(initrd_start, initrd_start + decrypted_base,
> -				    initrd_len, workarea_start,
> -				    (unsigned long)ppd.pgd);
> +	wa->initrd_start = initrd_start;
> +	wa->initrd_end = initrd_end;
> +	wa->initrd_len = initrd_len;
> +
> +	wa->workarea_start = workarea_start;
> +	wa->workarea_end = workarea_end;
> +	wa->workarea_len = workarea_len;
> +
> +	wa->decrypted_base = decrypted_base;
> +}
>  
> +static void __init teardown_workarea_map(struct sme_workarea_data *wa,
> +				         struct sme_populate_pgd_data *ppd)

ERROR: code indent should use tabs where possible
#214: FILE: arch/x86/mm/mem_encrypt_identity.c:469:
+^I^I^I^I         struct sme_populate_pgd_data *ppd)$

I think I've already said that to you but here it is again:

Please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense.

Otherwise:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
