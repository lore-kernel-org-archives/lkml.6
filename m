Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6316C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A66320867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ImCJAzEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A66320867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeIYWfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:35:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeIYWfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KnpYBxNAh061QW52EVkyYMXjgF83hGim+6fQGH4NYlg=; b=ImCJAzEb15quG2qNOO0kH9GwG
        Ljdbt6fNZRe/3j9pGg/bYdXiYa23+B8z73kinhIX50YyzEYii75+HpX+fJX/zyH/POxJypLuEjH5B
        MTEUrZzg999iv/ywBnt3JRhdOxDMvZwTIazWREJ5QQSoQQctmRgdTCYCz4OIIT47Gle7REnoBljt+
        AOvnusMmb1pZDzYYS/ukWZmP7WtF7T7PYQ+TOpF0rYnykdrRzpuQlywuNr+UPW2OYPTYc+pDK2KM3
        n2ho0IP0f8x1mvtVSKvHhbLXZ9G46myLtfUQyVvF4tbF2w5w1rGuTjZvxZSXvZPWmA5OdKqFL7iNa
        kkKA+y1CA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4qB0-0002S2-U1; Tue, 25 Sep 2018 16:27:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D09E20289D14; Tue, 25 Sep 2018 18:27:05 +0200 (CEST)
Date:   Tue, 25 Sep 2018 18:27:05 +0200
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
Subject: Re: [RFC PATCH v4 01/27] x86/cpufeatures: Add CPUIDs for
 Control-flow Enforcement Technology (CET)
Message-ID: <20180925162705.GB30146@hirez.programming.kicks-ass.net>
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
 <20180921150351.20898-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921150351.20898-2-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 08:03:25AM -0700, Yu-cheng Yu wrote:

> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index 772c219b6889..63cbb4d9938e 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -21,6 +21,7 @@ struct cpuid_bit {
>  static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_APERFMPERF,       CPUID_ECX,  0, 0x00000006, 0 },
>  	{ X86_FEATURE_EPB,		CPUID_ECX,  3, 0x00000006, 0 },
> +	{ X86_FEATURE_IBT,		CPUID_EDX, 20, 0x00000007, 0},
                                                                   ^^
missing white space at the end there.

>  	{ X86_FEATURE_CAT_L3,		CPUID_EBX,  1, 0x00000010, 0 },
>  	{ X86_FEATURE_CAT_L2,		CPUID_EBX,  2, 0x00000010, 0 },
>  	{ X86_FEATURE_CDP_L3,		CPUID_ECX,  2, 0x00000010, 1 },
> -- 
> 2.17.1
> 
