Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F638C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FF82147A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfBRKoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:44:04 -0500
Received: from foss.arm.com ([217.140.101.70]:55932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbfBRKoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:44:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0717C80D;
        Mon, 18 Feb 2019 02:44:04 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D2B73F720;
        Mon, 18 Feb 2019 02:44:02 -0800 (PST)
Date:   Mon, 18 Feb 2019 10:43:59 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        andreyknvl@google.com, aryabinin@virtuozzo.com,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: skip hwasan
Message-ID: <20190218104359.GB10743@fuggles.cambridge.arm.com>
References: <20190217043434.46233-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217043434.46233-1-cai@lca.pw>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 11:34:34PM -0500, Qian Cai wrote:
> Enabling function tracer with CONFIG_KASAN_SW_TAGS=y (hwasan) tracer
> causes the whole system frozen on ThunderX2 systems with 256 CPUs,
> because there is a burst of too much pointer access, and then KASAN will
> dereference each byte of the shadow address for the tag checking which
> will kill all the CPUs.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/trace/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index c2b2148bb1d2..fdd547a68385 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -28,6 +28,11 @@ ifdef CONFIG_GCOV_PROFILE_FTRACE
>  GCOV_PROFILE := y
>  endif
>  
> +# Too much pointer access will kill hwasan.
> +ifdef CONFIG_KASAN_SW_TAGS
> +KASAN_SANITIZE := n
> +endif

I don't maintain this file, but I think that my comments on your related
patch are relevant here as well:

https://lkml.org/lkml/2019/2/18/223

Will
