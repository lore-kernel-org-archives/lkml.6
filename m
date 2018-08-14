Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4445AC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CC42170F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kXuS6usS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CC42170F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbeHNPV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:21:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732396AbeHNPVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3uTet5jZ820jJsV7crh8eqqWPnUji4A9TGfrWDwMoB4=; b=kXuS6usSTzcByj9w0vy/pLek6
        tWYHIzOWH2v0wVvoj82IpNsHQzEa7d4kW0fIu/vCCctA4kns/HcI7mmRQAeUlMEF9wn9OR+GyYSOL
        E9ClQBHd+xUMUDF0ysLeSqVLqSsISA6b2h1+GN77lISdisbi5+rc6KLIHYnsJKIvBHa49JJjNSqxl
        IstxFFaLsFPtH/CXyqP2D9mOxsCNsUkUotRTqrfF6j7uFsuGyMrLU1nVtnwhLmoKtH6rA7j2Ssrqz
        /ChHOuGLF4aWJTOAAGTgM6FU5WMYR+XxmGh4L6NxtoHdQWfEs2zhCuU9BdJA5KysTX8wFemNUkwxD
        QaUd6Ntvg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fpYXG-0004Ja-RW; Tue, 14 Aug 2018 12:34:54 +0000
Date:   Tue, 14 Aug 2018 05:34:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Xiaofeng Yuan <yuanxiaofeng1@huawei.com>
Cc:     keescook@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] usercopy: optimize stack check flow when the
Message-ID: <20180814123454.GA25328@bombadil.infradead.org>
References: <1534249051-56879-1-git-send-email-yuanxiaofeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534249051-56879-1-git-send-email-yuanxiaofeng1@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 08:17:31PM +0800, Xiaofeng Yuan wrote:
> The check_heap_object() checks the spanning multiple pages and slab.
> When the page-spanning test is disabled, the check_heap_object() is
> redundant for spanning multiple pages. However, the kernel stacks are
> multiple pages under certain conditions: CONFIG_ARCH_THREAD_STACK_ALLOCATOR
> is not defined and (THREAD_SIZE >= PAGE_SIZE). At this point, We can skip
> the check_heap_object() for kernel stacks to improve performance.
> Similarly, the virtually-mapped stack can skip check_heap_object() also,
> beacause virt_addr_valid() will return.

Why not just check_stack_object() first, then check_heap_object() second?
