Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3388CC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0813820685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0813820685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbeKFAAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:00:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:26293 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbeKFAAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:00:33 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 06:40:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="83466415"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 05 Nov 2018 06:40:29 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gJg3H-0005nj-VE; Mon, 05 Nov 2018 16:40:27 +0200
Date:   Mon, 5 Nov 2018 16:40:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Maninder Singh <maninder1.s@samsung.com>,
        Matteo Croce <mcroce@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bloat-o-meter: ignore __addressable_ symbols
Message-ID: <20181105144027.GM10650@smile.fi.intel.com>
References: <20181102210030.8383-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102210030.8383-1-linux@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 10:00:25PM +0100, Rasmus Villemoes wrote:
> Since __LINE__ is part of the symbol created by __ADDRESSABLE, almost
> any change causes those symbols to disappear and get reincarnated, e.g.
> 
> add/remove: 4/4 grow/shrink: 0/3 up/down: 32/-171 (-139)
> Function                                     old     new   delta
> __addressable_tracing_set_default_clock8649       -       8      +8
> __addressable_tracer_init_tracefs8631          -       8      +8
> __addressable_ftrace_dump8383                  -       8      +8
> __addressable_clear_boot_tracer8632            -       8      +8
> __addressable_tracing_set_default_clock8650       8       -      -8
> __addressable_tracer_init_tracefs8632          8       -      -8
> __addressable_ftrace_dump8384                  8       -      -8
> __addressable_clear_boot_tracer8633            8       -      -8
> trace_default_header                         663     642     -21
> tracing_mark_raw_write                       406     355     -51
> tracing_mark_write                           624     557     -67
> Total: Before=63889, After=63750, chg -0.22%
> 
> They're small and in .discard, so ignore them, leading to more useful
> 
> add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-139 (-139)
> Function                                     old     new   delta
> trace_default_header                         663     642     -21
> tracing_mark_raw_write                       406     355     -51
> tracing_mark_write                           624     557     -67
> Total: Before=63721, After=63582, chg -0.22%

Useful!

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  scripts/bloat-o-meter | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/bloat-o-meter b/scripts/bloat-o-meter
> index a923f05edb36..8c965f6a9881 100755
> --- a/scripts/bloat-o-meter
> +++ b/scripts/bloat-o-meter
> @@ -32,6 +32,7 @@ def getsizes(file, format):
>                  if name.startswith("__mod_"): continue
>                  if name.startswith("__se_sys"): continue
>                  if name.startswith("__se_compat_sys"): continue
> +                if name.startswith("__addressable_"): continue
>                  if name == "linux_banner": continue
>                  # statics and some other optimizations adds random .NUMBER
>                  name = re_NUMBER.sub('', name)
> -- 
> 2.19.1.6.gbde171bbf5
> 

-- 
With Best Regards,
Andy Shevchenko


