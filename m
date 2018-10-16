Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D31AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2C92089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2C92089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeJPR52 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:57:28 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:49284 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726083AbeJPR52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:57:28 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 14119058-1500050 
        for multiple; Tue, 16 Oct 2018 11:07:29 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Stephen Boyd <swboyd@chromium.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <87sh16ky9d.fsf@intel.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <20181015203410.155997-1-swboyd@chromium.org> <87sh16ky9d.fsf@intel.com>
Message-ID: <153968444736.22931.7687263957265816381@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: Silence build error with UBSAN
Date:   Tue, 16 Oct 2018 11:07:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jani Nikula (2018-10-16 10:59:42)
> On Mon, 15 Oct 2018, Stephen Boyd <swboyd@chromium.org> wrote:
> > When I enable UBSAN and compile this driver with clang I get the
> > following build error:
> >
> > drivers/gpu/drm/i915/intel_engine_cs.o: In function `intel_engine_init_execlist':
> > drivers/gpu/drm/i915/intel_engine_cs.c:411: undefined reference to `__compiletime_assert_411'
> >
> > from what I can figure out, the compiler can't optimize
> > execlists_num_ports() sufficiently enough at compile time to figure out
> > that the 'execlists->port_mask = 1' assignment one line above the
> > BUILD_BUG_ON_NOT_POWER_OF_2 check will make execlists_num_ports() return
> > 2. Most likely that's because UBSAN is going to check the load inside
> > execlists_num_ports() and that check isn't omitted so the optimizer
> > can't optimize away the whole function.
> 
> See [1] for a better explanation.
> 
> [1] http://mid.mail-archive.com/20181009171401.14980-1-natechancellor@gmail.com
> 
> > So let's just change this check to cause a build error when the maximum
> > number of ports isn't a power of two. It looks like this is similar to
> > what's being checked here so this might work well enough.
> 
> That's not the same thing. I guess I'd go with the below instead,
> similar to the check on the next line. I guess both of the checks could
> be static on gcc.
> 
> BR,
> Jani.
> 
> 
> diff --git a/drivers/gpu/drm/i915/intel_engine_cs.c b/drivers/gpu/drm/i915/intel_engine_cs.c
> index f27dbe26bcc1..897d5a557d88 100644
> --- a/drivers/gpu/drm/i915/intel_engine_cs.c
> +++ b/drivers/gpu/drm/i915/intel_engine_cs.c
> @@ -461,12 +461,14 @@ static void intel_engine_init_batch_pool(struct intel_engine_cs *engine)
>         i915_gem_batch_pool_init(&engine->batch_pool, engine);
>  }
>  
> +#define IS_POWER_OF_2(n) ((n) != 0 && ((n) & ((n) - 1)) == 0)
> +
>  static void intel_engine_init_execlist(struct intel_engine_cs *engine)
>  {
>         struct intel_engine_execlists * const execlists = &engine->execlists;
>  
>         execlists->port_mask = 1;
> -       BUILD_BUG_ON_NOT_POWER_OF_2(execlists_num_ports(execlists));
> +       GEM_BUG_ON(!IS_POWER_OF_2(execlists_num_ports(execlists)));

That should be happy with is_power_of_2() from log2.h
-Chris
