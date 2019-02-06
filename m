Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315A1C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66B520844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+073J8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfBFScS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:32:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41440 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfBFScS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:32:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so3460321pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 10:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vHv0dONVLJNapb4A/yR3yCVDE+bcVN7lX44qcegyuEU=;
        b=S+073J8YTIEOSJ+WUZ4EDzZkyZKQLYDHl5CwESLn+I1BOaBzTXY6K14QBE6ep6670L
         CClGo5O06pLCQdO07SIdjIqIHyoNG3ZjRiOJ6A8u5mCkTWd73LcEMgent1/xMLxOVRF9
         R/BkupnSTVR6Hfb4nW7C0/eq1bUz+czKIerX20i64cJ8nev8e0b9ezBVvlA6+ko/TYeX
         6CdxMltmzYLKaSaZ0Msrq4AXdB59I82zHwgdCuWc95sahjPHTl6SBn1flXLQUf9/iXJm
         WizJm/hedBDAZL75n8/4tBP7INAJifNv4FwceCrtgmKxVBzQouPptIW+iO1SFkfyYxO+
         zwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=vHv0dONVLJNapb4A/yR3yCVDE+bcVN7lX44qcegyuEU=;
        b=aRtPL3rOtmeDye2S7uyymz/js3gT2oiQG22Dpb708vgFJsosgvWVHgNjT+Om4yDerL
         QOt0gA0ArZjkCRVhthiKfh2B+Fw3hYtY+aQtoKVfqz25hPIum+WYnydeO9Q2k04nKi0V
         90+NPgTvsURAob0wvHEuNA/MOA+VZXfj8oMJ+R4s8EpKCqUSYViG6yeesXonO5Gz4q8q
         WxvHu0TCn5HmTfHm5exqg2cu6dWS58IiU84mPW+dlMOHpeBBmaOXehYKWbI0JNRi+Rz1
         27w+Vc49qNA3hNMA0WOJl0jrrT0fNMx7D16Dn95CnDIt9kfJ4lGwhR32SgT9IkdlCnwE
         RSbA==
X-Gm-Message-State: AHQUAuabGKPWjZN2tfkBmNvJjy7HjkSjbghvNGEiI6Stme2t5gqCpvge
        nkBgEcRpZwE8DNztUpmuA8TWDYsA
X-Google-Smtp-Source: AHgI3IbcqMSlF+pE2HNNbrytGIN2RJdb5yvRq/GPu6SCjChhuA476zdL0QlNeJGu9FXYD6iJ3VnkXg==
X-Received: by 2002:a63:df13:: with SMTP id u19mr6125436pgg.294.1549477937359;
        Wed, 06 Feb 2019 10:32:17 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 85sm11064042pfw.17.2019.02.06.10.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 10:32:15 -0800 (PST)
Date:   Wed, 6 Feb 2019 10:32:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: generate uapi header and syscall table header files
Message-ID: <20190206183214.GA3562@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 01:04:14PM +1100, Firoz Khan wrote:
> Unified system call table generation script must be run to generate
> unistd_32.h and syscall_table.h files.  This patch will have changes which
> will invokes the script.
> 
> This patch will generate unistd_32.h and syscall_table.h files by the
> syscall table generation script invoked by sh/Makefile and the generated
> files against the removed files must be identical.
> 
> The generated uapi header file will be included in uapi/- asm/unistd.h and
> generated system call table header file will be included by
> kernel/syscall_32.S file.
> 

All "sh" builds in -next fail with:

make[1]: *** No rule to make target 'scripts/syscalltbl.sh', needed by
'arch/sh/include/generated/asm/syscall_table.h'.  Stop.
make: *** [archheaders] Error 2

Bisect points to this patch.

Guenter

> Link: http://lkml.kernel.org/r/1546443445-21075-3-git-send-email-firoz.khan@linaro.org
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/sh/kernel/syscalls/Makefile      | 11 +++++++++--
>  arch/sh/kernel/syscalls/syscallhdr.sh | 36 -----------------------------------
>  arch/sh/kernel/syscalls/syscalltbl.sh | 32 -------------------------------
>  3 files changed, 9 insertions(+), 70 deletions(-)
>  delete mode 100644 arch/sh/kernel/syscalls/syscallhdr.sh
>  delete mode 100644 arch/sh/kernel/syscalls/syscalltbl.sh
> 
> diff --git a/arch/sh/kernel/syscalls/Makefile b/arch/sh/kernel/syscalls/Makefile
> index 659faefdcb1d..75c742157fac 100644
> --- a/arch/sh/kernel/syscalls/Makefile
> +++ b/arch/sh/kernel/syscalls/Makefile
> @@ -6,8 +6,9 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
>  	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
>  
>  syscall := $(srctree)/$(src)/syscall.tbl
> -syshdr := $(srctree)/$(src)/syscallhdr.sh
> -systbl := $(srctree)/$(src)/syscalltbl.sh
> +syshdr := $(srctree)/scripts/syscallhdr.sh
> +sysnr := $(srctree)/scripts/syscallnr.sh
> +systbl := $(srctree)/scripts/syscalltbl.sh
>  
>  quiet_cmd_syshdr = SYSHDR  $@
>        cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
> @@ -15,6 +16,12 @@ quiet_cmd_syshdr = SYSHDR  $@
>  		   '$(syshdr_pfx_$(basetarget))'		\
>  		   '$(syshdr_offset_$(basetarget))'
>  
> +quiet_cmd_sysnr = SYSNR  $@
> +      cmd_sysnr = $(CONFIG_SHELL) '$(sysnr)' '$<' '$@'		\
> +		  '$(sysnr_abis_$(basetarget))'			\
> +		  '$(sysnr_pfx_$(basetarget))'			\
> +		  '$(sysnr_offset_$(basetarget))'
> +
>  quiet_cmd_systbl = SYSTBL  $@
>        cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'	\
>  		   '$(systbl_abis_$(basetarget))'		\
> diff --git a/arch/sh/kernel/syscalls/syscallhdr.sh b/arch/sh/kernel/syscalls/syscallhdr.sh
> deleted file mode 100644
> index 1de0334e577f..000000000000
> --- a/arch/sh/kernel/syscalls/syscallhdr.sh
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -in="$1"
> -out="$2"
> -my_abis=`echo "($3)" | tr ',' '|'`
> -prefix="$4"
> -offset="$5"
> -
> -fileguard=_UAPI_ASM_SH_`basename "$out" | sed \
> -	-e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> -	-e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> -grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> -	printf "#ifndef %s\n" "${fileguard}"
> -	printf "#define %s\n" "${fileguard}"
> -	printf "\n"
> -
> -	nxt=0
> -	while read nr abi name entry ; do
> -		if [ -z "$offset" ]; then
> -			printf "#define __NR_%s%s\t%s\n" \
> -				"${prefix}" "${name}" "${nr}"
> -		else
> -			printf "#define __NR_%s%s\t(%s + %s)\n" \
> -				"${prefix}" "${name}" "${offset}" "${nr}"
> -		fi
> -		nxt=$((nr+1))
> -	done
> -
> -	printf "\n"
> -	printf "#ifdef __KERNEL__\n"
> -	printf "#define __NR_syscalls\t%s\n" "${nxt}"
> -	printf "#endif\n"
> -	printf "\n"
> -	printf "#endif /* %s */" "${fileguard}"
> -) > "$out"
> diff --git a/arch/sh/kernel/syscalls/syscalltbl.sh b/arch/sh/kernel/syscalls/syscalltbl.sh
> deleted file mode 100644
> index 904b8e6e625d..000000000000
> --- a/arch/sh/kernel/syscalls/syscalltbl.sh
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -in="$1"
> -out="$2"
> -my_abis=`echo "($3)" | tr ',' '|'`
> -my_abi="$4"
> -offset="$5"
> -
> -emit() {
> -	t_nxt="$1"
> -	t_nr="$2"
> -	t_entry="$3"
> -
> -	while [ $t_nxt -lt $t_nr ]; do
> -		printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
> -		t_nxt=$((t_nxt+1))
> -	done
> -	printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
> -}
> -
> -grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> -	nxt=0
> -	if [ -z "$offset" ]; then
> -		offset=0
> -	fi
> -
> -	while read nr abi name entry ; do
> -		emit $((nxt+offset)) $((nr+offset)) $entry
> -		nxt=$((nr+1))
> -	done
> -) > "$out"
> -- 
> 2.7.4
