Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B639C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAEC20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544710223;
	bh=SSWtJydgAT1VIU1V2HZUv33F7SJctJF2ncli7OfWFOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=In5p+XldoMYVA8ecUYSBNDGzgrpkPRJ74WrTvKBH9WC2vWlkrFKfP4zsx13vZ430w
	 4wX4M9CsELlkBlUxbQkIF593S1fGIDJUxLNw0CyLb/LG9NLfumqvVZ3ubnxtzMweLW
	 +6SUop2aXg33+3l1RpTdYo6s0pJfbbXQEiXihs+g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAEC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbeLMOKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:10:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbeLMOKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:10:22 -0500
Received: from linux-8ccs (p5DE45A67.dip0.t-ipconnect.de [93.228.90.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91FDA2086D;
        Thu, 13 Dec 2018 14:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544710220;
        bh=SSWtJydgAT1VIU1V2HZUv33F7SJctJF2ncli7OfWFOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZOuhypgqy+brjCnFoNs8MojU6a/Cdy++6vjYA4O+gsdTIVA3QVy+arpdsjE8Iv7fi
         IsMsa6H3WjdgvhGiUa2KDhzu7H65oNgpc0p4DaOkqr3gdTglYeaT889xP3tlydk5kD
         8baQXkUowvIEmcLwHDGRpyie7Ui+h0GmJkHjMRAc=
Date:   Thu, 13 Dec 2018 15:10:13 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH v7 13/14] module: Do not set nx for module memory before
 freeing
Message-ID: <20181213141013.GA16819@linux-8ccs>
References: <20181205013408.47725-1-namit@vmware.com>
 <20181205013408.47725-14-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181205013408.47725-14-namit@vmware.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.22-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Nadav Amit [04/12/18 17:34 -0800]:
>When module memory is about to be freed, there is no apparent reason to
>make it (and its data) executable, but that's exactly what is done
>today. This is not efficient and not secure.
>
>There are various theories why it was done, but none of them seem as
>something that really require it today. nios2 uses kmalloc for module
>memory, but anyhow it does not change the PTEs of the module memory.  In
>x86, changing vmalloc'd memory mappings also modifies the direct mapping
>alias, but the NX-bit is not modified in such way.
>
>So let's remove it. Andy suggested that the changes of the PTEs can be
>avoided (excluding the direct-mapping alias), which is true. However,
>in x86 it requires some cleanup of the contiguous page allocator, which
>is outside of the scope of this patch-set.
>
>Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>
>Cc: Will Deacon <will.deacon@arm.com>
>Cc: Andy Lutomirski <luto@kernel.org>
>Signed-off-by: Nadav Amit <namit@vmware.com>

[ Thanks Andrea Parri for the cc ]

Regarding the patch subject, don't you mean "Do not make module
memory executable" or "Do not unset nx" instead of "Do not set nx"?
Hm, these double negatives are confusing :-)

I think this also needs to be done in the load_module() error path.
See the bug_cleanup label. There, module_disable_{ro,nx}() are called
before module deallocation.

I am not sure why all this was made executable before freeing in the
first place.  Tried to dig through the commit history and the first
commit that introduced this behavior was 448694a1d50 ("module: undo
module RONX protection correctly"). There, the behavior was changed
from W+NX to W+X before releasing the module. But AFAIK from the
changelog, there was no real technical reason behind it, it stemmed
out of the complaint of code asymmetry :-/

Jessica

>---
> kernel/module.c | 35 ++++++++++++++++++++++-------------
> 1 file changed, 22 insertions(+), 13 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 7cb207249437..57c5b23746e7 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2027,20 +2027,29 @@ void set_all_modules_text_ro(void)
> 	mutex_unlock(&module_mutex);
> }
>
>-static void disable_ro_nx(const struct module_layout *layout)
>+static void module_restore_mappings(const struct module_layout *layout)
> {
>-	if (rodata_enabled) {
>-		frob_text(layout, set_memory_rw);
>-		frob_rodata(layout, set_memory_rw);
>-		frob_ro_after_init(layout, set_memory_rw);
>-	}
>-	frob_rodata(layout, set_memory_x);
>-	frob_ro_after_init(layout, set_memory_x);
>-	frob_writable_data(layout, set_memory_x);
>+	/*
>+	 * First, make the mappings of the code non-executable to prevent
>+	 * transient W+X mappings from being set when the text is set as RW.
>+	 */
>+	frob_text(layout, set_memory_nx);
>+
>+	if (!rodata_enabled)
>+		return;
>+
>+	/*
>+	 * Second, set the memory as writable. Although the module memory is
>+	 * about to be freed, these calls are required (at least on x86) to
>+	 * restore the direct map to its "correct" state.
>+	 */
>+	frob_text(layout, set_memory_rw);
>+	frob_rodata(layout, set_memory_rw);
>+	frob_ro_after_init(layout, set_memory_rw);
> }
>
> #else
>-static void disable_ro_nx(const struct module_layout *layout) { }
>+static void module_restore_mappings(const struct module_layout *layout) { }
> static void module_enable_nx(const struct module *mod) { }
> static void module_disable_nx(const struct module *mod) { }
> #endif
>@@ -2173,7 +2182,7 @@ static void free_module(struct module *mod)
> 	mutex_unlock(&module_mutex);
>
> 	/* This may be empty, but that's OK */
>-	disable_ro_nx(&mod->init_layout);
>+	module_restore_mappings(&mod->init_layout);
> 	module_arch_freeing_init(mod);
> 	module_memfree(mod->init_layout.base);
> 	kfree(mod->args);
>@@ -2183,7 +2192,7 @@ static void free_module(struct module *mod)
> 	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
>
> 	/* Finally, free the core (containing the module structure) */
>-	disable_ro_nx(&mod->core_layout);
>+	module_restore_mappings(&mod->core_layout);
> 	module_memfree(mod->core_layout.base);
> }
>
>@@ -3507,7 +3516,7 @@ static noinline int do_init_module(struct module *mod)
> #endif
> 	module_enable_ro(mod, true);
> 	mod_tree_remove_init(mod);
>-	disable_ro_nx(&mod->init_layout);
>+	module_restore_mappings(&mod->init_layout);
> 	module_arch_freeing_init(mod);
> 	mod->init_layout.base = NULL;
> 	mod->init_layout.size = 0;
>-- 
>2.17.1
>
