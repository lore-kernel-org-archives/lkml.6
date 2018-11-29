Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0A3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35C620673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35C620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbeK3B2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:28:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732242AbeK3B2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:28:46 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC5517F6C8;
        Thu, 29 Nov 2018 14:23:15 +0000 (UTC)
Received: from treble (ovpn-123-4.rdu2.redhat.com [10.10.123.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EC661019637;
        Thu, 29 Nov 2018 14:23:14 +0000 (UTC)
Date:   Thu, 29 Nov 2018 08:23:12 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tools/relocs: fix big section header tables
Message-ID: <20181129142312.kz2l5gm33yeaglnn@treble>
References: <20181129135133.31369-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181129135133.31369-1-asavkov@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 29 Nov 2018 14:23:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 02:51:33PM +0100, Artem Savkov wrote:
> In case when the number of entries in the section header table is larger
> then or equal to SHN_LORESERVE the size of the table is held in the sh_size
> member of the initial entry in section header table instead of e_shnum.
> Same with the string table index which is located in sh_link instead of
> e_shstrndx.
> 
> This case is easily reproducible with KCFLAGS="-ffunction-sections",
> bzImage build fails with "String table index out of bounds" error.
> 
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  arch/x86/tools/relocs.c | 58 +++++++++++++++++++++++++++++------------
>  1 file changed, 41 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index b629f6992d9f..5275ea0a0d13 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -11,7 +11,9 @@
>  #define Elf_Shdr		ElfW(Shdr)
>  #define Elf_Sym			ElfW(Sym)
>  
> -static Elf_Ehdr ehdr;
> +static Elf_Ehdr	ehdr;

I think there's a tab missing here, it doesn't line up with the other
variables.

> +static unsigned long	shnum;
> +static unsigned int	shstrndx;

Otherwise the patch looks good to me.

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
