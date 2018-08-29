Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC8DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D503020856
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D503020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbeH2RKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:10:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:59434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727204AbeH2RKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:10:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 980F3AEB0;
        Wed, 29 Aug 2018 13:13:08 +0000 (UTC)
Date:   Wed, 29 Aug 2018 15:13:31 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v2 1/3] x86/mm: Restructure sme_encrypt_kernel()
Message-ID: <20180829131331.GE6337@nazgul.tnic>
References: <1535494377-25600-1-git-send-email-brijesh.singh@amd.com>
 <1535494377-25600-2-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1535494377-25600-2-git-send-email-brijesh.singh@amd.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 05:12:55PM -0500, Brijesh Singh wrote:
> Re-arrange the sme_encrypt_kernel() by moving the workarea map/unmap
> logic in a separate static function. There are no logical changes in this
> patch. The restructuring will allow us to expand the sme_encrypt_kernel
> in future.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Cc: stable@vger.kernel.org

This patch is going to be a prerequisite for the actual fix so you
probably should write here:

Cc: stable@vger.kernel.org # prerequisite for <patch name>

or better yet do a separate backport/submission to stable@ once those
have been upstreamed.

...

> +void __init sme_encrypt_kernel(struct boot_params *bp)
> +{
> +	struct sme_populate_pgd_data ppd;
> +	struct sme_workarea_data wa;
> +
> +	if (!sme_active())
> +		return;
> +
> +	build_workarea_map(bp, &wa, &ppd);
> +
> +	/* When SEV is active, encrypt kernel and initrd */
> +	sme_encrypt_execute(wa.kernel_start,
> +			    wa.kernel_start + wa.decrypted_base,
> +			    wa.kernel_len, wa.workarea_start,
> +			    (unsigned long)ppd.pgd);
> +
> +	if (wa.initrd_len)
> +		sme_encrypt_execute(wa.initrd_start,
> +				    wa.initrd_start + wa.decrypted_base,
> +				    wa.initrd_len, wa.workarea_start,
> +				    (unsigned long)ppd.pgd);
> +
> +	remove_workarea_map(&wa, &ppd);

teardown_workarea_map() is a better naming counterpart to
build_workarea_map().

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
