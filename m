Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3F6C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794CA2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7jwAK96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794CA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeIDNps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbeIDNps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:45:48 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12C5B2077C;
        Tue,  4 Sep 2018 09:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536052892;
        bh=G8kCOpxQHCUDaQjjZVi1J2RJg9k3pp15FkhlGlMPpSo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d7jwAK967ikaRu4DyOgDhh1HB998MQ8whwMSI5Jkjq5vSvz29t+1qEaKPqpIPe33t
         l1ntsCowkvl2OIB5fj3xc0MqziMQT+81QV+wq6KhiVgD/FXjqYUBQGUKw2v1jQViJ/
         T7/vMsp5l3AFjWgq2wi270HyhB32SuJuWnnesbvQ=
Date:   Tue, 4 Sep 2018 18:21:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Greentime Hu <green.hu@gmail.com>
Cc:     greentime@andestech.com, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH] nds32: linker script: GCOV kernel may refers data in
 __exit
Message-Id: <20180904182129.910240d80961b4fd070dfa1e@kernel.org>
In-Reply-To: <20180904075419.2994-1-greentime@andestech.com>
References: <20180904075419.2994-1-greentime@andestech.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Sep 2018 15:54:19 +0800
Greentime Hu <green.hu@gmail.com> wrote:

> This patch is used to fix nds32 allmodconfig/allyesconfig build error
> because GCOV kernel embeds counters in the kernel for each line
> and a part of that embed in __exit text. So we need to keep the
> EXIT_TEXT and EXIT_DATA  if CONFIG_GCOV_KERNEL=y.

Yes, that is exactly what I did for arm.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Link: https://lkml.org/lkml/2018/9/1/125
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> ---
>  arch/nds32/kernel/vmlinux.lds.S | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/nds32/kernel/vmlinux.lds.S b/arch/nds32/kernel/vmlinux.lds.S
> index 288313b886ef..9e90f30a181d 100644
> --- a/arch/nds32/kernel/vmlinux.lds.S
> +++ b/arch/nds32/kernel/vmlinux.lds.S
> @@ -13,14 +13,26 @@ OUTPUT_ARCH(nds32)
>  ENTRY(_stext_lma)
>  jiffies = jiffies_64;
>  
> +#if defined(CONFIG_GCOV_KERNEL)
> +#define NDS32_EXIT_KEEP(x)	x
> +#else
> +#define NDS32_EXIT_KEEP(x)
> +#endif
> +
>  SECTIONS
>  {
>  	_stext_lma = TEXTADDR - LOAD_OFFSET;
>  	. = TEXTADDR;
>  	__init_begin = .;
>  	HEAD_TEXT_SECTION
> +	.exit.text : {
> +		NDS32_EXIT_KEEP(EXIT_TEXT)
> +	}
>  	INIT_TEXT_SECTION(PAGE_SIZE)
>  	INIT_DATA_SECTION(16)
> +	.exit.data : {
> +		NDS32_EXIT_KEEP(EXIT_DATA)
> +	}
>  	PERCPU_SECTION(L1_CACHE_BYTES)
>  	__init_end = .;
>  
> -- 
> 2.18.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
