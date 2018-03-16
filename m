Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932673AbeCPCcZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 22:32:25 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:37594 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbeCPCcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:32:24 -0400
X-Google-Smtp-Source: AG47ELvpcB5eV9KoABPGqSBNpb6CMFIF3tcJWowOSSI091ZOmY4SlHjbFtFsGg7Wgvt7Xc8VYQPtfA==
Date: Thu, 15 Mar 2018 22:32:22 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
cc: linux-kbuild@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] kbuild: link vmlinux only once for
 CONFIG_TRIM_UNUSED_KSYMS
In-Reply-To: <1521166725-24157-8-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <nycvar.YSQ.7.76.1803152229070.28583@knanqh.ubzr>
References: <1521166725-24157-1-git-send-email-yamada.masahiro@socionext.com> <1521166725-24157-8-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018, Masahiro Yamada wrote:

> +# Recurse until adjust_autoksyms.sh is satisfied
> +PHONY += autoksyms_recursive
> +autoksyms_recursive: $(vmlinux-deps)
> +	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh  \
>  	  "$(MAKE) -f $(srctree)/Makefile vmlinux"
> -endif
>  
>  # For the kernel to actually contain only the needed exported symbols,
>  # we have to build modules as well to determine what those symbols are.
> @@ -1034,7 +1024,13 @@ cmd_link-vmlinux =                                                 \
>  	$(CONFIG_SHELL) $< $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) ;    \
>  	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>  
> -vmlinux: scripts/link-vmlinux.sh vmlinux_prereq $(vmlinux-deps) FORCE
> +vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FORCE

Don't you have to make the autoksyms_recursive dependency conditional on 
CONFIG_TRIM_UNUSED_KSYMS?


Nicolas
