Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B53C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EFF20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FXwGrfj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EFF20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbeGKJYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:24:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbeGKJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H70pVgx2XwMMXmR3NCG1O1+R/QAQuNipe1JTYez1Esk=; b=FXwGrfj1snrBQaYHVYjyAgdOS
        I33bnxtGqUiYxaO1GZXOmZW6NLFt+t4CCfhC1t9vhmoc1D5tEw7nbYWaBc+WnnMHk3a2zcC7/SDM+
        LkJZqIPg5jdvwREDD5ol7VVvyCylY/PF+xyjwErQqAon/8uHLdpzJ4AnZ9jqJlLZUP6s6nULRtLxi
        GzYatCPJnEQBPq/1scaHF7XPdhGJ2j+Dr3VQv4gc0jNO0XOhn7LNPNRoW9YBb8MsQ1i/NWWkPxxro
        LP0Tk94VGWAdcyCrLl8m4Ayp8y/+hXiPDYagoEcmLwrIP8vl4fbLMKUraXgko+HT0l30MXkL3OFdS
        dDVnUjv/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdBJH-0001nL-GB; Wed, 11 Jul 2018 09:21:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC97820291063; Wed, 11 Jul 2018 11:21:17 +0200 (CEST)
Date:   Wed, 11 Jul 2018 11:21:17 +0200
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
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v2 10/27] x86/mm: Introduce _PAGE_DIRTY_SW
Message-ID: <20180711092117.GV2476@hirez.programming.kicks-ass.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-11-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710222639.8241-11-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 03:26:22PM -0700, Yu-cheng Yu wrote:
> +static inline bool is_shstk_pte(pte_t pte)
> +{
> +	pteval_t val;
> +
> +	val = pte_flags(pte) & (_PAGE_RW | _PAGE_DIRTY_HW);
> +	return (val == _PAGE_DIRTY_HW);
> +}

That's against naming convention here.

static inline bool pte_shstk(pte_t pte)
{
	return pte_flags(pte) & (_PAGE_RW | _PAGE_DIRTY_HW) == _PAGE_DIRTY_HW;
}

would be more in style with the rest of this code.
