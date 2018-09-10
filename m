Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A41C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184FE2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184FE2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeIJOnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:43:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54184 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbeIJOnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:43:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B71A618A;
        Mon, 10 Sep 2018 02:49:53 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8825B3F557;
        Mon, 10 Sep 2018 02:49:53 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id A7B1E1AE33B8; Mon, 10 Sep 2018 10:50:09 +0100 (BST)
Date:   Mon, 10 Sep 2018 10:50:09 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/arm64/include/asm/jump_label.h: use
 asm_volatile_goto
Message-ID: <20180910095008.GB31531@arm.com>
References: <20180909154731.GA20381@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180909154731.GA20381@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2018 at 05:47:31PM +0200, Miguel Ojeda wrote:
> All other uses of "asm goto" go through asm_volatile_goto
> (including the arm version of the same file). For consistency,
> use it here as well.
> 
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  arch/arm64/include/asm/jump_label.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, I'll pick this up as a fix.

Will

> diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> index 1b5e0e843c3a..7e2b3e360086 100644
> --- a/arch/arm64/include/asm/jump_label.h
> +++ b/arch/arm64/include/asm/jump_label.h
> @@ -28,7 +28,7 @@
>  
>  static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
>  {
> -	asm goto("1: nop\n\t"
> +	asm_volatile_goto("1: nop\n\t"
>  		 ".pushsection __jump_table,  \"aw\"\n\t"
>  		 ".align 3\n\t"
>  		 ".quad 1b, %l[l_yes], %c0\n\t"
> @@ -42,7 +42,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
>  
>  static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
>  {
> -	asm goto("1: b %l[l_yes]\n\t"
> +	asm_volatile_goto("1: b %l[l_yes]\n\t"
>  		 ".pushsection __jump_table,  \"aw\"\n\t"
>  		 ".align 3\n\t"
>  		 ".quad 1b, %l[l_yes], %c0\n\t"
> -- 
> 2.17.1
> 
