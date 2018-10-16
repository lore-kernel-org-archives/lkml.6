Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECB0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B003208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B003208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeJPXi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:38:26 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:41064 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbeJPXi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:38:26 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id BCEF220031;
        Tue, 16 Oct 2018 17:47:18 +0200 (CEST)
Date:   Tue, 16 Oct 2018 17:47:17 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Borislav Petkov <bp@suse.de>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] kbuild: provide a new place to check necessary host
 tools
Message-ID: <20181016154717.GA25717@ravnborg.org>
References: <1539681053-24388-1-git-send-email-yamada.masahiro@socionext.com>
 <1539681053-24388-2-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539681053-24388-2-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8 a=c-n4J4-pAAAA:8
        a=uDSZvXS9AlFru31wZZMA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=L0NDqeB7ZLmQzAogN4cw:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro.

Looks good, a few nits below.

	Sam

> The top Makefile is too cluttered
So true...

> This adds a new file scripts/Makefile.toolcheck to check additional
> tools depending on the kernel configuration. This check is run
> immediately after syncconfig, i.e., when a user attempts to build
> something with a new set of CONFIG options.
> 
> [1] https://patchwork.kernel.org/patch/10516049/
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
The use of toolcheck-y should be documented in Documentation/kbuild/...


> 
>  Makefile                   |  1 +
>  scripts/Makefile.toolcheck | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 scripts/Makefile.toolcheck
> 
> diff --git a/Makefile b/Makefile
> index bf3786e..23a204a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -633,6 +633,7 @@ $(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
>  # include/config/auto.conf (which mirrors .config).
>  include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
>  	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
> +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.toolcheck
>  else
>  # External modules and some install targets need include/generated/autoconf.h
>  # and include/config/auto.conf but do not care if they are up-to-date.
> diff --git a/scripts/Makefile.toolcheck b/scripts/Makefile.toolcheck
> new file mode 100644
> index 0000000..f3c165d
> --- /dev/null
> +++ b/scripts/Makefile.toolcheck
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# ===========================================================================
> +# Host tools check
> +# ===========================================================================
> +#
> +# Some additional tools might be required depending on the kernel configuration.
> +# Check if they are installed on the host machine, and if missing, error out
> +# with a user-friendly message.
> +
> +include include/config/auto.conf
> +
> +__toolcheck:
> +	@:
> +
> +PHONY += $(toolcheck-y)
> +__toolcheck: $(toolcheck-y)
> +
> +define populate_toolcheck
> +__toolcheck: check_$(1)
> +PHONY += check_$(1)
> +check_$(1):
> +	$(Q){ $(chk_$(1)); } >/dev/null 2>&1 || {	\
> +		echo "*" >&2;				\
> +		for msg in $(msg_$(1));			\
> +		do					\
> +			echo "* $$$${msg}" >&2;		\
> +		done;					\
> +		echo "*" >&2;				\
> +		/bin/false;				\
> +	}
Very dense, but usign if [ ... ] may result is somethign that
is a little more readable.

And maybe a litle hint on the usage...

> +$(foreach c, $(toolcheck-y), $(eval $(call populate_toolcheck,$(c))))
Good use of $(eval ...)
