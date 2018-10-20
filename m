Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F7DC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 17:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F1721533
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 17:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F1721533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeJUBxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 21:53:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36238 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbeJUBxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 21:53:15 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ghsDnHte_kZD; Sat, 20 Oct 2018 19:41:44 +0200 (CEST)
Received: from zn.tnic (p200300EC2BDE4000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bde:4000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 505631EC032D;
        Sat, 20 Oct 2018 19:41:44 +0200 (CEST)
Date:   Sat, 20 Oct 2018 19:41:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2] x86/microcode: Handle negative microcode revisions
Message-ID: <20181020174109.GE28301@zn.tnic>
References: <20181020144158.6261-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181020144158.6261-1-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dropping stable.

On Sat, Oct 20, 2018 at 07:41:58AM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The Intel microcode revision space is unsigned. Inside Intel there are special
> microcodes that have the highest bit set, and they are considered to have
> a higher revision than any microcodes that don't have this bit set.
> 
> The function comparing the microcode revision in the Linux driver compares
> u32 with int, which ends up being signed extended to long on 64bit
> systems. This results in these highest bit set microcode revision not loading
> because their revision appears negative and smaller than the
> existing microcode.
> 
> Change the comparison to unsigned. With that the loading works
> as expected.
> 
> Cc: stable@vger.kernel.org # Any supported stable
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> --
> v2: White space changes.
> ---
>  arch/x86/kernel/cpu/microcode/intel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 16936a24795c..e54d402500d3 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -93,7 +93,8 @@ static int find_matching_signature(void *mc, unsigned int csig, int cpf)
>  /*
>   * Returns 1 if update has been found, 0 otherwise.
>   */
> -static int has_newer_microcode(void *mc, unsigned int csig, int cpf, int new_rev)
> +static int has_newer_microcode(void *mc, unsigned int csig, int cpf,
> +			       unsigned new_rev)
>  {
>  	struct microcode_header_intel *mc_hdr = mc;
>  
> -- 

Please incorporate all review comments before sending a new version of
your patch.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
