Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430D6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD2620881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD2620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeJPRtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:49:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:11670 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeJPRtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:49:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 03:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="99603654"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 16 Oct 2018 02:59:59 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH] drm/i915: Silence build error with UBSAN
In-Reply-To: <20181015203410.155997-1-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20181015203410.155997-1-swboyd@chromium.org>
Date:   Tue, 16 Oct 2018 12:59:42 +0300
Message-ID: <87sh16ky9d.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018, Stephen Boyd <swboyd@chromium.org> wrote:
> When I enable UBSAN and compile this driver with clang I get the
> following build error:
>
> drivers/gpu/drm/i915/intel_engine_cs.o: In function `intel_engine_init_execlist':
> drivers/gpu/drm/i915/intel_engine_cs.c:411: undefined reference to `__compiletime_assert_411'
>
> from what I can figure out, the compiler can't optimize
> execlists_num_ports() sufficiently enough at compile time to figure out
> that the 'execlists->port_mask = 1' assignment one line above the
> BUILD_BUG_ON_NOT_POWER_OF_2 check will make execlists_num_ports() return
> 2. Most likely that's because UBSAN is going to check the load inside
> execlists_num_ports() and that check isn't omitted so the optimizer
> can't optimize away the whole function.

See [1] for a better explanation.

[1] http://mid.mail-archive.com/20181009171401.14980-1-natechancellor@gmail.com

> So let's just change this check to cause a build error when the maximum
> number of ports isn't a power of two. It looks like this is similar to
> what's being checked here so this might work well enough.

That's not the same thing. I guess I'd go with the below instead,
similar to the check on the next line. I guess both of the checks could
be static on gcc.

BR,
Jani.


diff --git a/drivers/gpu/drm/i915/intel_engine_cs.c b/drivers/gpu/drm/i915/intel_engine_cs.c
index f27dbe26bcc1..897d5a557d88 100644
--- a/drivers/gpu/drm/i915/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/intel_engine_cs.c
@@ -461,12 +461,14 @@ static void intel_engine_init_batch_pool(struct intel_engine_cs *engine)
 	i915_gem_batch_pool_init(&engine->batch_pool, engine);
 }
 
+#define IS_POWER_OF_2(n) ((n) != 0 && ((n) & ((n) - 1)) == 0)
+
 static void intel_engine_init_execlist(struct intel_engine_cs *engine)
 {
 	struct intel_engine_execlists * const execlists = &engine->execlists;
 
 	execlists->port_mask = 1;
-	BUILD_BUG_ON_NOT_POWER_OF_2(execlists_num_ports(execlists));
+	GEM_BUG_ON(!IS_POWER_OF_2(execlists_num_ports(execlists)));
 	GEM_BUG_ON(execlists_num_ports(execlists) > EXECLIST_MAX_PORTS);
 
 	execlists->queue_priority = INT_MIN;

---


>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/i915/intel_engine_cs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/intel_engine_cs.c b/drivers/gpu/drm/i915/intel_engine_cs.c
> index 217ed3ee1cab..bdf75628ed83 100644
> --- a/drivers/gpu/drm/i915/intel_engine_cs.c
> +++ b/drivers/gpu/drm/i915/intel_engine_cs.c
> @@ -463,7 +463,7 @@ static void intel_engine_init_execlist(struct intel_engine_cs *engine)
>  	struct intel_engine_execlists * const execlists = &engine->execlists;
>  
>  	execlists->port_mask = 1;
> -	BUILD_BUG_ON_NOT_POWER_OF_2(execlists_num_ports(execlists));
> +	BUILD_BUG_ON_NOT_POWER_OF_2(EXECLIST_MAX_PORTS);
>  	GEM_BUG_ON(execlists_num_ports(execlists) > EXECLIST_MAX_PORTS);
>  
>  	execlists->queue_priority = INT_MIN;

-- 
Jani Nikula, Intel Open Source Graphics Center
