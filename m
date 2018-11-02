Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1EBC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E532920657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="P/wzKEIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E532920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeKBSvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 14:51:14 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1044 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBSvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 14:51:14 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bdc1c7a0000>; Fri, 02 Nov 2018 02:44:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 02 Nov 2018 02:44:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 02 Nov 2018 02:44:39 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 2 Nov
 2018 09:44:38 +0000
Subject: Re: [PATCH] kbuild: consolidate single targets
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-kbuild@vger.kernel.org>
CC:     Michal Marek <michal.lkml@markovi.net>,
        <linux-kernel@vger.kernel.org>
References: <1540873965-31342-1-git-send-email-yamada.masahiro@socionext.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <945484cd-50b4-74df-f091-d796264e5643@nvidia.com>
Date:   Fri, 2 Nov 2018 09:44:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540873965-31342-1-git-send-email-yamada.masahiro@socionext.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1541151866; bh=u9/6f3O1UwfUUc4aFQ1Fb7Pjm9qRsyNmbUKgFLwhevQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=P/wzKEInZqXZrXmyH/DkTa5OZDgapYwu4vx+6qMl3CUnh0FWKva0WwbNWrTY9ppur
         050gHmDLk059Z6BReaP256vG9fKfnzGzMJ5S1q0q+YFQv7THLnAr+X/0hwXUl4yx2P
         bgCkX4MjpDLFf1u+zcBo4B76nNL3ghnlxbf5z2YVJPW3c7DTm3fo15eOK6D4yirHjV
         7qZ6wytCMc2WFHqIdgigPiQ/GcSgHHplAm5JHC1Hgv7CBA4Pskkulw97dc3PedOcnu
         Cf7qS4YEFWBFvcK7csqNYb7lytAikmPojnJ5uupSsLdDYA48oZ0kLD/daaXa2ZRe3F
         +7bFZV7d42hZA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/10/2018 04:32, Masahiro Yamada wrote:
> Instead of specifying target/source pairs, let's list patterns that we
> want to handle as single targets. This slightly changes the behavior;
> the top Makefile previously checked the presence of a source file,
> now Kbuild will descend into a subdirectory anyway to find out what to
> do there.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  Makefile | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index be76e6e..7d13add 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1713,21 +1713,7 @@ else
>          target-dir = $(if $(KBUILD_EXTMOD),$(dir $<),$(dir $@))
>  endif
>  
> -%.s: %.c prepare scripts FORCE
> -	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> -%.i: %.c prepare scripts FORCE
> -	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> -%.o: %.c prepare scripts FORCE
> -	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> -%.lst: %.c prepare scripts FORCE
> -	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> -%.s: %.S prepare scripts FORCE
> -	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> -%.o: %.S prepare scripts FORCE
> -	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> -%.symtypes: %.c prepare scripts FORCE
> -	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> -%.ll: %.c prepare scripts FORCE
> +%.i %.ll %.lst %.o %.s %.symtypes: prepare scripts FORCE
>  	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
>  
>  # Modules

On one of my build machines (an older ubuntu 14.04 machine), this is
commit is causing 'make mrproper' or 'make distclean' to fail. Reverting
this commit fixes the problem.

$ make mrproper
Error: kernelrelease not valid - run 'make prepare' to update it
  CC      kernel/bounds.s
In file included from <command-line>:0:0:
././include/linux/kconfig.h:5:32: fatal error: generated/autoconf.h: No
such file or directory
 #include <generated/autoconf.h>
                                ^
compilation terminated.
make[1]: *** [kernel/bounds.s] Error 1
make: *** [prepare0] Error 2

FWIW, this machine has ...

$ make --version
GNU Make 3.81

Cheers
Jon

-- 
nvpublic
