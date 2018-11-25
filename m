Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7ECC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9062084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kpk+Yw0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9062084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeKZG1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 01:27:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeKZG1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 01:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y2dX7+DhhKUJKK7NUbF5UpFejnzCwSyU7lyRUT0Qu4w=; b=kpk+Yw0KZYvUCBAOkMNRaOw8C
        houC1B/vCer87cvvWMVa8NViNJ0LO4VBnmg+01Xf0avrcMx8ykKocKuQVSvrF42o25glz9MiL5Zt3
        z0wqoC5/cYv5549bMLbNgyx0u7Yc+0cpsqckZd3taMRj4XY2Q83t1xYPL5vJ4IoaiN5VmAgSx7CkZ
        xepGezfV4YQR7583nFGVAqF8M8YdoNYLKXKBlR01UU0uVsWDYjsOKoIQKfPoXUlusAodE1okB9ayr
        Cyql1HA+P6vCfcr82BOjskxAyO0p+IWEiqjeGZwyIX01X4Lp19ElqVhpl8np72zDuifHayLABHpZQ
        4U8Ju98GA==;
Received: from [66.118.103.209] (helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gR0Bv-0000OW-IJ; Sun, 25 Nov 2018 19:35:39 +0000
Subject: Re: [patch V2 27/28] x86/speculation: Add seccomp Spectre v2 user
 space protection mode
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
References: <20181125183328.318175777@linutronix.de>
 <20181125185006.051663132@linutronix.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6b6f1cdc-6751-a286-3c52-740efc90192f@infradead.org>
Date:   Sun, 25 Nov 2018 11:35:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181125185006.051663132@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can you alter this without publishing a v3?
(see below)

On 11/25/18 10:33 AM, Thomas Gleixner wrote:
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4241,9 +4241,16 @@
>  				  per thread.  The mitigation control state
>  				  is inherited on fork.
>  
> +			seccomp
> +				- Same as "prctl" above, but all seccomp
> +				  threads will enable the mitigation unless
> +				  they explicitly opt out.
> +
>  			auto    - Kernel selects the mitigation depending on
>  				  the available CPU features and vulnerability.
> -				  Default is prctl.
> +
> +			Default mitigation:
> +			If CONFIG_SECCOMP=y "seccomp", otherwise "prctl"

			If CONFIG_SECCOMP=y then "seccomp", otherwise "prctl".

>  
>  			Not specifying this option is equivalent to
>  			spectre_v2_user=auto.

g'day.
-- 
~Randy
