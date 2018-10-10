Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6C8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911F12087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911F12087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJJWDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:03:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:38622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727094AbeJJWDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:03:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A95C9B0E7;
        Wed, 10 Oct 2018 14:40:36 +0000 (UTC)
Date:   Wed, 10 Oct 2018 16:40:26 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lianbo Jiang <lijiang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] kdump, proc/vmcore: fix building without
 CONFIG_ARCH_HAS_MEM_ENCRYPT
Message-ID: <20181010144026.GB5924@zn.tnic>
References: <20181010143306.2051406-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181010143306.2051406-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 04:32:45PM +0200, Arnd Bergmann wrote:
> We get a link failure when calling copy_oldmem_page_encrypted()
> when the compiler fails to do constant-propagation of the
> sme_active() result into read_from_oldmem:
> 
> fs/proc/vmcore.o: In function `read_from_oldmem.part.0':
> vmcore.c:(.text+0xb7): undefined reference to `copy_oldmem_page_encrypted'
> 
> Adding an IS_ENABLED() check means the compiler will always
> know when it cannot be enabled.
> 
> Fixes: 992b649a3f01 ("kdump, proc/vmcore: Enable kdumping encrypted memory with SME enabled")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> There may be a better way of doing this, not sure what kinds
> of assumptions we want to make here.
> ---
>  fs/proc/vmcore.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index d469ce9d8c0c..92e1e520a52d 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -123,7 +123,9 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
>  		if (pfn_is_ram(pfn) == 0)
>  			memset(buf, 0, nr_bytes);
>  		else {
> -			if (encrypted)
> +			if (IS_ENABLED(CONFIG_X86_64) &&
> +			    IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT) &&
> +			    encrypted)
>  				tmp = copy_oldmem_page_encrypted(pfn, buf,
>  								 nr_bytes,
>  								 offset,
> -- 

Doesn't that fix it?

https://git.kernel.org/tip/cf089611f4c446285046fcd426d90c18f37d2905

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
