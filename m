Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6549EECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244BB2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244BB2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeIYC6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:58:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43542 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeIYC6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:58:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so9610521pfi.10;
        Mon, 24 Sep 2018 13:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W3ideLNVvTX97Hv/3TjbdSG+oprxrFF7U3IyPN5LlQA=;
        b=MZrMhSzdZ1s/fBiI2LYzcLrxBP50ZccSXljlZtEVf3WIsF5FMhHhmuXkGyIF50e6k+
         2t7fUGYuS4WkJTgsy08FyrOl9+vzo7sb/Q0+VQKilsVgweigRqJ6EF6yDEkn1LERdCSP
         BTPMpTpNOqATdv6fYvwi9ac6yBUn3Dgn51TjXE2RvLXXOqjZ6QyKx+n5NylAYyqT9lCn
         4VF2NKzix+3UQSmlkY3k2pHvd43ZjisQM/I/M4cKqD+F2tfM7EL3ckSyoXPfkRuyXE7c
         Ia/LsmqE2e1Y//LyNDvoqcb1DfsNFTY4itYd2rKzUHKdXyv6axjZ87UBGqihuJSozxCs
         hIWg==
X-Gm-Message-State: ABuFfojH3AlSw/bX6I9HDeH8Ljuq2K5mHXwAiKkNfjrXyEYE6Kfs3KFv
        ApOALadICB6gxZQ1dFrAHlA=
X-Google-Smtp-Source: ACcGV62MM8cxOdF4NK4exsBNkUrvBezsfSY9YlZ32pW6ZBoaY/IFK1CwJSSEbFHZakCym/JM3QfdkQ==
X-Received: by 2002:a63:b104:: with SMTP id r4-v6mr448158pgf.442.1537822443828;
        Mon, 24 Sep 2018 13:54:03 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id n83-v6sm318808pfk.19.2018.09.24.13.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 13:54:03 -0700 (PDT)
Message-ID: <1537822441.195115.32.camel@acm.org>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
From:   Bart Van Assche <bvanassche@acm.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ming Lei <ming.lei@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Lameter <cl@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Mon, 24 Sep 2018 13:54:01 -0700
In-Reply-To: <20180924204148.GA2542@bombadil.infradead.org>
References: <38c03920-0fd0-0a39-2a6e-70cd8cb4ef34@virtuozzo.com>
         <20a20568-5089-541d-3cee-546e549a0bc8@acm.org>
         <12eee877-affa-c822-c9d5-fda3aa0a50da@virtuozzo.com>
         <1537801706.195115.7.camel@acm.org>
         <c844c598-be1d-bef4-fb99-09cf99571fd7@virtuozzo.com>
         <1537804720.195115.9.camel@acm.org>
         <10c706fd-2252-f11b-312e-ae0d97d9a538@virtuozzo.com>
         <1537805984.195115.14.camel@acm.org>
         <20180924185753.GA32269@bombadil.infradead.org>
         <1537818978.195115.25.camel@acm.org>
         <20180924204148.GA2542@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-24 at 13:41 -0700, Matthew Wilcox wrote:
+AD4 On Mon, Sep 24, 2018 at 12:56:18PM -0700, Bart Van Assche wrote:
+AD4 +AD4 On Mon, 2018-09-24 at 11:57 -0700, Matthew Wilcox wrote:
+AD4 +AD4 +AD4 You're not supposed to use kmalloc memory for DMA.  This is why we have
+AD4 +AD4 +AD4 dma+AF8-alloc+AF8-coherent() and friends.
+AD4 +AD4 
+AD4 +AD4 Are you claiming that all drivers that use DMA should use coherent DMA only? If
+AD4 +AD4 coherent DMA is the only DMA style that should be used, why do the following
+AD4 +AD4 function pointers exist in struct dma+AF8-map+AF8-ops?
+AD4 
+AD4 Good job snipping the part of my reply which addressed this.  Go read
+AD4 DMA-API.txt yourself.  Carefully.

The snipped part did not contradict your claim that +ACI-You're not supposed to use
kmalloc memory for DMA.+ACI In the DMA-API.txt document however there are multiple
explicit statements that support allocating memory for DMA with kmalloc(). Here
is one example from the DMA-API.txt section about dma+AF8-map+AF8-single():

	Not all memory regions in a machine can be mapped by this API.
	Further, contiguous kernel virtual space may not be contiguous as
	physical memory.  Since this API does not provide any scatter/gather
	capability, it will fail if the user tries to map a non-physically
	contiguous piece of memory.  For this reason, memory to be mapped by
	this API should be obtained from sources which guarantee it to be
	physically contiguous (like kmalloc).

Bart.

