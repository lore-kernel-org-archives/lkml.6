Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF10C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76550206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jreFG2MW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76550206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeIYXM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:12:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbeIYXM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XsmIVRHdh3Wn1iEaJpNxeLAZHl9WUmDC2Sfg61xGq3w=; b=jreFG2MWGnTgYSaN9+coo8mG9
        ZdiZdiF9twVfcfX/8GJlt9YhLFHoXFv/raa20GuInpD75t0HhduTzJ7R+p01fGk8oae0Xs9Bst7Az
        Yq/9vGqh4pwsmBP+W/MMbrsv5ipDgAzyz9r6qS2x18GAasDEpe7FfUiAYmqoiP8zeZA2Ir7mY6Hvk
        HLrHcwj4B5+k6H1/8uK0MgKLrmlpuoWnjWjUlWcDO7o7SlWq6231btOYBXi0rE2mp9YbZZsPoPEwE
        bMPE4++AcN4qgJOdj2hDZ+Rn5d6VbDgvNIWxkpu/gIFAWeWbJRd6rB8xa+z8KNPETjXPDxP1qIzmR
        Y/1bvc7Mw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4qkh-0005oV-9w; Tue, 25 Sep 2018 17:04:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 380FC2025445D; Tue, 25 Sep 2018 19:03:55 +0200 (CEST)
Date:   Tue, 25 Sep 2018 19:03:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v4 03/27] x86/fpu/xstate: Enable XSAVES system states
Message-ID: <20180925170355.GD30146@hirez.programming.kicks-ass.net>
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
 <20180921150351.20898-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921150351.20898-4-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 08:03:27AM -0700, Yu-cheng Yu wrote:
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 4bd56079048f..9f51b0e1da25 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -365,8 +365,13 @@ void fpu__drop(struct fpu *fpu)
>   */
>  static inline void copy_init_user_fpstate_to_fpregs(void)
>  {
> +	/*
> +	 * Only XSAVES user states are copied.
> +	 * System states are preserved.
> +	 */
>  	if (use_xsave())
> -		copy_kernel_to_xregs(&init_fpstate.xsave, -1);
> +		copy_kernel_to_xregs(&init_fpstate.xsave,
> +				     xfeatures_mask_user);

By my counting, that doesn't qualify for a line-break, it hits 80.

If you were to do this line-break, coding style would have you liberally
sprinkle {} around.

>  	else if (static_cpu_has(X86_FEATURE_FXSR))
>  		copy_kernel_to_fxregs(&init_fpstate.fxsave);
>  	else
