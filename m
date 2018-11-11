Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F6FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE26214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE26214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbeKLDMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 22:12:49 -0500
Received: from foss.arm.com ([217.140.101.70]:51196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729222AbeKLDMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 22:12:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F2D680D;
        Sun, 11 Nov 2018 09:23:43 -0800 (PST)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 130FE3F5BD;
        Sun, 11 Nov 2018 09:23:40 -0800 (PST)
Date:   Sun, 11 Nov 2018 17:23:33 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Zhizhou Zhang <zhizhouzhang@asrmicro.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, mpatocka@redhat.com,
        alex.popov@linux.com, labbott@redhat.com, panand@redhat.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zhizhouzh@gmail.com
Subject: Re: [PATCH] arm64: disable KASAN for save_trace()
Message-ID: <20181111172333.ov25gdmlsmhc6ysp@salmiak>
References: <1541938036-29498-1-git-send-email-zhizhouzhang@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541938036-29498-1-git-send-email-zhizhouzhang@asrmicro.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 08:07:16PM +0800, Zhizhou Zhang wrote:
> save_trace() which is called from walk_stackframe() always try to
> read/write caller's stack. This results KASAN stack-out-of-bounds
> warning. So mute it.

The save_trace() function should never perform an out-of-bounds access on the
caller's stack, so this is papering over a bug elsewhere.

Can you please given an example report from KASAN?

Thanks,
Mark.

> 
> Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
> ---
>  arch/arm64/kernel/stacktrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 4989f7e..e93ca67 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -107,7 +107,7 @@ struct stack_trace_data {
>  	unsigned int skip;
>  };
>  
> -static int save_trace(struct stackframe *frame, void *d)
> +static int __no_sanitize_address save_trace(struct stackframe *frame, void *d)
>  {
>  	struct stack_trace_data *data = d;
>  	struct stack_trace *trace = data->trace;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
