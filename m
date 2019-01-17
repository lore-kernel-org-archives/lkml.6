Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F22C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB97D20856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547711671;
	bh=cLP9keXKzq/STJJ9tRlQcp79axKCXQ+ZALqsEKW8f/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tX6sVPl9E4oTVGjhWkESfBViLru7SFBo0ESfsWfh87YEkdpbRYOgX8OxfDo3HmsGK
	 bcXt9TxLoIcu8hcvshx0NY/nu3RLfOkDCC92Xq1Uxn4j6RgpU1ROODt1UtjgTxtGnD
	 X8Ah4zrghYTlZcoWkrnaCh2grsgsXQAUB/rRZh+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfAQHy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:54:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbfAQHy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:54:28 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50D1420851;
        Thu, 17 Jan 2019 07:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547711667;
        bh=cLP9keXKzq/STJJ9tRlQcp79axKCXQ+ZALqsEKW8f/s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JXwnKx5QBw8EpzdBL49P38f8BWGU3Wf5+pKVZ/yfrILgpobZtHIUuPodUl9Pfjxpu
         C1Y2/iRtNlPDcSm6flBGNvYOyhVPaPtV3gbcXv7KcJJI4opgn1r3Ty3Y57Vxut/Q4n
         6eGzscFlphc0FInZg2RxLKwpltZxF6TGXjv2pKVY=
Date:   Thu, 17 Jan 2019 16:54:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH 17/17] module: Prevent module removal racing with
 text_poke()
Message-Id: <20190117165422.d33d1af83db8716e24960a3c@kernel.org>
In-Reply-To: <20190117003259.23141-18-rick.p.edgecombe@intel.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
        <20190117003259.23141-18-rick.p.edgecombe@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 16:32:59 -0800
Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:

> From: Nadav Amit <namit@vmware.com>
> 
> It seems dangerous to allow code modifications to take place
> concurrently with module unloading. So take the text_mutex while the
> memory of the module is freed.

At that point, since the module itself is removed from module list,
it seems no actual harm. Or would you have any concern?

Thank you,

> 
> Signed-off-by: Nadav Amit <namit@vmware.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  kernel/module.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 1af5c8e19086..90cfc4988d98 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -64,6 +64,7 @@
>  #include <linux/bsearch.h>
>  #include <linux/dynamic_debug.h>
>  #include <linux/audit.h>
> +#include <linux/memory.h>
>  #include <uapi/linux/module.h>
>  #include "module-internal.h"
>  
> @@ -2157,6 +2158,9 @@ static void free_module(struct module *mod)
>  	synchronize_rcu();
>  	mutex_unlock(&module_mutex);
>  
> +	/* Protect against patching of the module while it is being removed */
> +	mutex_lock(&text_mutex);
> +
>  	/* This may be empty, but that's OK */
>  	module_arch_freeing_init(mod);
>  	module_memfree(mod->init_layout.base);
> @@ -2168,6 +2172,7 @@ static void free_module(struct module *mod)
>  
>  	/* Finally, free the core (containing the module structure) */
>  	module_memfree(mod->core_layout.base);
> +	mutex_unlock(&text_mutex);
>  }
>  
>  void *__symbol_get(const char *symbol)
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
