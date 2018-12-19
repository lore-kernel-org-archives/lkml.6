Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20E9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E64214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbeLSQyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:54:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbeLSQye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:54:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC2A8C070E19;
        Wed, 19 Dec 2018 16:54:33 +0000 (UTC)
Received: from treble (ovpn-120-179.rdu2.redhat.com [10.10.120.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EBD55D6A9;
        Wed, 19 Dec 2018 16:54:30 +0000 (UTC)
Date:   Wed, 19 Dec 2018 10:54:28 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        jeyu@kernel.org, jikos@kernel.org, pmladek@suse.com,
        linux-kbuild@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: use -flive-patching when CONFIG_LIVEPATCH is
 enabled
Message-ID: <20181219165428.5udrppedpdvf2u7k@treble>
References: <20181219141744.32392-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181219141744.32392-1-mbenes@suse.cz>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 19 Dec 2018 16:54:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 03:17:44PM +0100, Miroslav Benes wrote:
> GCC 9 introduces a new option, -flive-patching. It disables certain
> optimizations which could make a compilation unsafe for later live
> patching of the running kernel.
> 
> The option is used only if CONFIG_LIVEPATCH is enabled and $(CC)
> supports it.
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> ---
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index a0650bf79606..53f5ab810efe 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -778,6 +778,10 @@ KBUILD_CFLAGS_KERNEL	+= $(call cc-option,-ffunction-sections,)
>  KBUILD_CFLAGS_KERNEL	+= $(call cc-option,-fdata-sections,)
>  endif
>  
> +ifdef CONFIG_LIVEPATCH
> +KBUILD_CFLAGS += $(call cc-option, -flive-patching=inline-clone)
> +endif
> +
>  # arch Makefile may override CC so keep this after arch Makefile is included
>  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)


This option only makes sense for source-based patch generation, so isn't
it a bit premature to make this change without proper source-based patch
tooling?

Also the commit message needs an analysis of the performance impacts.

-- 
Josh
