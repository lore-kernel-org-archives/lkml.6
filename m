Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B860C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A142146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ton1IpYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfBTVDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:03:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBTVDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nmbRDXdT50ITWrkNYUhHuegzkM5FDZwPlBIvVUFrslE=; b=Ton1IpYURLOmkhW0iltcfuoEs
        TvcRQC2lQL47Lx3v6rP7SPfFAGEjMCkjN8kuO2Bu9Lb+40RBfqjRCr4ghjJ23Z0c7OsgkeoDP6nvK
        7YnhMV1/pGtymXwtR5TRX6l8oyVBtjI9q4uHNADrjueVgDn/hKuQPshdaqZoBydRBCLY44HdPD24a
        RZ+z9FgfM2DjXNq3M8uBszkQGFjFTLeiy3sovOnTuugz6MGJJa9s6FpiX9aGcef4xZlKnmqAj/SVp
        sH7xlZuPIeQqgQv+ZYIldCsDubHWXJ/6xw2Qnvev0CMzmaPFWiYSCtxOrNBwbM/bk2JQhaMPlou7A
        0tn7c8GSg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwZ1P-0005my-Oh; Wed, 20 Feb 2019 21:03:15 +0000
Date:   Wed, 20 Feb 2019 13:03:15 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Message-ID: <20190220210315.GM12668@bombadil.infradead.org>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
 <20190219053205.GA124985@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219053205.GA124985@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 10:32:05PM -0700, Yu Zhao wrote:
> pgtable_pmd_page_ctor() must be used on user pmd. For kernel pmd,
> it's okay to use pgtable_page_ctor() instead only because kernel
> doesn't have thp.

I'm not sure that's true.  I think you can create THPs in vmalloc
these days.  See HAVE_ARCH_HUGE_VMAP which is supported by arm64.
