Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737F1C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB502170A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qdi6E/LN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB502170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbeHNP4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:56:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbeHNP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mzZR+K/aDrjatwRtCqxctlYSdaYShrAVtHEccbhXsCE=; b=qdi6E/LNmQKikg0+Lk/YBuKah
        1zUoppu0+eUy6TRNOmOAFx8GoDC3b79hs577DZ2Cc/rQuxfwu6klUi75KiIaWm8YGg0XhCOdxIS+U
        8ClqF93z9hraV+9fIB6YE0Z6qbWNkSFnPf0yS/XT/xJ51Rg8ER3UmKK5JiascqnVO4g54zqEKoO9j
        J9QTysxn+1lB1jHVxnZvs9+Jk1ii+JeFaWdQ9wrcX0Hmajk3HdsyMzw0dRKnV037ioz1qxLvmyc1d
        EgzDthxRauq+nFSzYDwITx7bSHDtaNC5muaDxiGB4cIz1ZUerEOlbjXme76fGl7Dmqr0eU/RNveMW
        KWGPd3tGA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fpZ4i-0000US-NE; Tue, 14 Aug 2018 13:09:28 +0000
Date:   Tue, 14 Aug 2018 06:09:28 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Yuanxiaofeng (XiAn)" <yuanxiaofeng1@huawei.com>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] usercopy: optimize stack check flow when the
 page-spanning test is disabled
Message-ID: <20180814130928.GB25328@bombadil.infradead.org>
References: <1534249051-56879-1-git-send-email-yuanxiaofeng1@huawei.com>
 <20180814123454.GA25328@bombadil.infradead.org>
 <494CFD22286B8448AF161132C5FE9A985B624E05@dggema521-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <494CFD22286B8448AF161132C5FE9A985B624E05@dggema521-mbx.china.huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 01:02:55PM +0000, Yuanxiaofeng (XiAn) wrote:
> 1, When the THREAD_SIZE is less than PAGE_SIZE, the stack will allocate memory by kmem_cache_alloc_node(), it's slab memory and will execute __check_heap_object().
> 2, When CONFIG_HARDENED_USERCOPY_PAGESPAN is enabled, the multiple-pages stacks will do some check in check_page_span().

I understand the checks will still do something useful, but I do not see the
scenario in which an object would satisfy the stack checks but fail the heap
checks.

> So, I set some restrictions to make sure the useful check will not be skipped.
> 
> -----Original Message-----
> From: Matthew Wilcox [mailto:willy@infradead.org] 
> Sent: Tuesday, August 14, 2018 8:35 PM
> To: Yuanxiaofeng (XiAn)
> Cc: keescook@chromium.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH RFC] usercopy: optimize stack check flow when the
> 
> On Tue, Aug 14, 2018 at 08:17:31PM +0800, Xiaofeng Yuan wrote:
> > The check_heap_object() checks the spanning multiple pages and slab.
> > When the page-spanning test is disabled, the check_heap_object() is
> > redundant for spanning multiple pages. However, the kernel stacks are
> > multiple pages under certain conditions: CONFIG_ARCH_THREAD_STACK_ALLOCATOR
> > is not defined and (THREAD_SIZE >= PAGE_SIZE). At this point, We can skip
> > the check_heap_object() for kernel stacks to improve performance.
> > Similarly, the virtually-mapped stack can skip check_heap_object() also,
> > beacause virt_addr_valid() will return.
> 
> Why not just check_stack_object() first, then check_heap_object() second?
> 
