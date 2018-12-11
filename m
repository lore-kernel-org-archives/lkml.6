Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95828C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4A120870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A2/8aka3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4A120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeLKSvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:51:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38512 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbeLKSvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eV2mEzIcygscaGeKJNUPFqHJIQ+n0eYuHekdmYP67r4=; b=A2/8aka3Htk0p1oGKl3IOOueQ
        P1Lkx+2fmncbv/Pe3nePx4h6Phbj5bLnG0yrmrDanCmJMjUScO3HzZ9Fc5RCCjV2KzE/AnJDKp0TZ
        +2a8+8V6NVdLwDpsIEBAOep99MFWu+8Aoh4aGw9hVpM9Kn7fcROCerx63izJ2xBriCvcsEB/5FZhv
        jSYKsDFSmPtk2nNaZ8/LQsehR+TH6WhvWJ3iPu5niyZDlMS70bI+g1mi4iYjxE3UocHjpUA2ebCSV
        pT/VsDf5ZUFf1V+isOtp2Mx//+hMI+Wx7ZThUbo2PKsviMqAEs5pw3Rk0GxT/UbJ4vZpiVloT9/hw
        t5GdcvgCA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWn7Z-0000oV-W8; Tue, 11 Dec 2018 18:51:05 +0000
Date:   Tue, 11 Dec 2018 10:51:05 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kent.overstreet@gmail.com
Subject: Re: [PATCH] aio: Convert ioctx_table to XArray
Message-ID: <20181211185105.GI6830@bombadil.infradead.org>
References: <20181128183531.5139-1-willy@infradead.org>
 <x49va46e1p0.fsf@segfault.boston.devel.redhat.com>
 <x49pnuee1gm.fsf@segfault.boston.devel.redhat.com>
 <x49mupcm11r.fsf@segfault.boston.devel.redhat.com>
 <20181211175156.GF6830@bombadil.infradead.org>
 <x495zw0lz68.fsf@segfault.boston.devel.redhat.com>
 <0f77a532-0d88-78bc-b9cc-06bb203a0405@kernel.dk>
 <6b9a45c4-47a2-4c44-aa7e-6e5e90eff9df@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b9a45c4-47a2-4c44-aa7e-6e5e90eff9df@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:32:54AM -0700, Jens Axboe wrote:
> Don't see any regressions. But if we're fiddling with it anyway, can't
> we do something smarter? Make the fast path just index a table, and put
> all the big hammers in setup/destroy. We're spending a non-substantial
> amount of time doing lookups, that's really no different before and
> after the patch.

Thanks for checking it out.

I think the fast path does just index a table.  Until you have more than
64 pointers in the XArray, it's just xa->head->slots[i].  And then up
to 4096 pointers, it's xa->head->slots[i >> 6]->slots[i].  It has the
advantage that if you only have one kioctx (which is surely many programs
using AIO), it's just xa->head, so even better than a table lookup.

It'll start to deteriorate after 4096 kioctxs, with one extra indirection
for every 6 bits, but by that point, we'd've been straining the memory
allocator to allocate a large table anyway.
