Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B1EC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A816217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfAJOun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:50:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbfAJOuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:50:40 -0500
Received: from home.goodmis.org (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B15920660;
        Thu, 10 Jan 2019 14:50:38 +0000 (UTC)
Date:   Thu, 10 Jan 2019 09:50:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] x86/trace: set TRACE_INCLUDE_PATH correctly instead
 of header search path
Message-ID: <20190110145031.2dh53wot2urcjah5@home.goodmis.org>
References: <1546183405-8931-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546183405-8931-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 12:23:25AM +0900, Masahiro Yamada wrote:
> ---
> 
> Changes in v2:
>   - Rebase
> 
>  arch/x86/include/asm/trace/exceptions.h  | 2 +-
>  arch/x86/include/asm/trace/irq_vectors.h | 2 +-
>  arch/x86/kernel/Makefile                 | 2 --
>  arch/x86/mm/Makefile                     | 2 --
>  4 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/trace/exceptions.h b/arch/x86/include/asm/trace/exceptions.h
> index e0e6d7f..00c1d1b 100644
> --- a/arch/x86/include/asm/trace/exceptions.h
> +++ b/arch/x86/include/asm/trace/exceptions.h
> @@ -46,7 +46,7 @@ DEFINE_PAGE_FAULT_EVENT(page_fault_kernel);
>  
>  #undef TRACE_INCLUDE_PATH
>  #undef TRACE_INCLUDE_FILE
> -#define TRACE_INCLUDE_PATH .
> +#define TRACE_INCLUDE_PATH asm/trace/

As I replied in another thread:

Note, the reason why I did not show this method in the samples/trace_events/
is that there's one "gotcha" that you need to be careful about. It may not be
an issue here, but please be aware of it.

The words in TRACE_INCLUDE_PATH can be updated by C preprocessor defines. For
example, if for some reason you had:

#define asm special_asm

The above would turn into:

#define TRACE_INCLUDE_PATH special_asm/trace

 and it wont build, and you will be left scratching your head wondering why.

Again, it most likely wont be an issue, but perhaps a comment or something
should be noted to warn about it?

-- Steve


>  #define TRACE_INCLUDE_FILE exceptions
>  #endif /*  _TRACE_PAGE_FAULT_H */
