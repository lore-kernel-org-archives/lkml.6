Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25454C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 08:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAFC2150C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 08:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAFC2150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeJTQrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 12:47:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49670 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbeJTQrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 12:47:49 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BIrXYzGXXK2E; Sat, 20 Oct 2018 10:37:51 +0200 (CEST)
Received: from zn.tnic (p200300EC2BDE4000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bde:4000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D4C561EC0266;
        Sat, 20 Oct 2018 10:37:50 +0200 (CEST)
Date:   Sat, 20 Oct 2018 10:37:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1] x86/microcode: Handle negative microcode revisions
Message-ID: <20181020083742.GA28301@zn.tnic>
References: <20181020001137.31461-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181020001137.31461-1-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 05:11:37PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The Intel ucode revision space is unsigned. Inside Intel there are special

s/ucode/microcode/g

> microcodes that have the highest bit set, and they are considered to have

s/microcodes/microcode revisions/g

> a higher revision than any microcodes that don't have this bit set.
> 
> The function comparing the microcodes in the Linux driver compares
> u32 with int, which ends up being signed extended to long on 64bit
> systems. This results in these highest bit set microcodes not loading
> because their revision appears negative and smaller than the
> existing microcode.
> 
> Change the comparison to unsigned. With that the loading works
> as expected.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/microcode/intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 16936a24795c..e95cebdd5993 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -93,7 +93,7 @@ static int find_matching_signature(void *mc, unsigned int csig, int cpf)
>  /*
>   * Returns 1 if update has been found, 0 otherwise.
>   */
> -static int has_newer_microcode(void *mc, unsigned int csig, int cpf, int new_rev)
> +static int has_newer_microcode(void *mc, unsigned int csig, int cpf, unsigned new_rev)

I'm gonna let you run checkpatch yourself to find out what the problem
here is.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
