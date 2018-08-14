Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A03C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0AC21742
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0AC21742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732652AbeHNPuE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:50:04 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6009 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731882AbeHNPuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:50:03 -0400
Received: from DGGEMA404-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 3D5D0E4241461;
        Tue, 14 Aug 2018 21:02:55 +0800 (CST)
Received: from DGGEMA424-HUB.china.huawei.com (10.1.198.157) by
 DGGEMA404-HUB.china.huawei.com (10.3.20.45) with Microsoft SMTP Server (TLS)
 id 14.3.399.0; Tue, 14 Aug 2018 21:02:56 +0800
Received: from DGGEMA521-MBX.china.huawei.com ([169.254.6.142]) by
 dggema424-hub.china.huawei.com ([10.1.198.157]) with mapi id 14.03.0399.000;
 Tue, 14 Aug 2018 21:02:55 +0800
From:   "Yuanxiaofeng (XiAn)" <yuanxiaofeng1@huawei.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC] usercopy: optimize stack check flow when the
 page-spanning test is disabled
Thread-Topic: [PATCH RFC] usercopy: optimize stack check flow when the
 page-spanning test is disabled
Thread-Index: AQHUM88e1zQpjsq9GkWf/Rn0OvruyQ==
Date:   Tue, 14 Aug 2018 13:02:55 +0000
Message-ID: <494CFD22286B8448AF161132C5FE9A985B624E05@dggema521-mbx.china.huawei.com>
References: <1534249051-56879-1-git-send-email-yuanxiaofeng1@huawei.com>
 <20180814123454.GA25328@bombadil.infradead.org>
In-Reply-To: <20180814123454.GA25328@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.119.159.246]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1, When the THREAD_SIZE is less than PAGE_SIZE, the stack will allocate memory by kmem_cache_alloc_node(), it's slab memory and will execute __check_heap_object().
2, When CONFIG_HARDENED_USERCOPY_PAGESPAN is enabled, the multiple-pages stacks will do some check in check_page_span().

So, I set some restrictions to make sure the useful check will not be skipped.

-----Original Message-----
From: Matthew Wilcox [mailto:willy@infradead.org] 
Sent: Tuesday, August 14, 2018 8:35 PM
To: Yuanxiaofeng (XiAn)
Cc: keescook@chromium.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] usercopy: optimize stack check flow when the

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
