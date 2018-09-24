Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D03DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E891D21480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E891D21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeIYCAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:00:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37193 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbeIYCAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:00:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id c10-v6so2706660pgq.4;
        Mon, 24 Sep 2018 12:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hfccSvRB2jAYzcBVIfQvRkCBoauJpD5SNhv4o8gGxao=;
        b=A8t4S8r44DlFRsZ7ImTA6mqIM9adFXsYjSF9McxHy+kkc3GJTV2yZ6gq1T+0A1thIk
         PbYVcXwlciAkJHRRWMVM57IBwiNXai+flQytTSVeKtRK4DkbgWKJtfSmRfpYJ4Fw4/AR
         wKBGV1v3tQmE8MlLvorkF9FuBiiXEtob82uxNOf97utmKIIMjup0TSxRCmafqh2TzR5G
         Kv7w3lpdVLonrLALW+CDPWvLZBZptqcXtehEOQ3qpAyiDNvtCKZcb1cAQIoq+zXq6cRZ
         4Dc2LW/ucSwKULXUcE7lXJli11zzArVa+K2HsJJAT2HweR6gEwPJR+LTTNzLKO9hYgi5
         0LJw==
X-Gm-Message-State: ABuFfohyKziltHPuxy91m391uq4qIvzqeat9cvGHVJpB16m7FXi8gCmF
        rznUGwT40xrFNMPNtncCyss=
X-Google-Smtp-Source: ACcGV61mOD/932rOEb0/NFqaeXU/LXXuRYbHCx+Ycbytfgg0X1DdsGb53yFh+SZ1vQOFuqf23R/MbA==
X-Received: by 2002:a17:902:820a:: with SMTP id x10-v6mr277808pln.261.1537818980126;
        Mon, 24 Sep 2018 12:56:20 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p4-v6sm171119pfd.65.2018.09.24.12.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 12:56:19 -0700 (PDT)
Message-ID: <1537818978.195115.25.camel@acm.org>
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
Date:   Mon, 24 Sep 2018 12:56:18 -0700
In-Reply-To: <20180924185753.GA32269@bombadil.infradead.org>
References: <87h8ij0zot.fsf@vitty.brq.redhat.com>
         <20180923224206.GA13618@ming.t460p>
         <38c03920-0fd0-0a39-2a6e-70cd8cb4ef34@virtuozzo.com>
         <20a20568-5089-541d-3cee-546e549a0bc8@acm.org>
         <12eee877-affa-c822-c9d5-fda3aa0a50da@virtuozzo.com>
         <1537801706.195115.7.camel@acm.org>
         <c844c598-be1d-bef4-fb99-09cf99571fd7@virtuozzo.com>
         <1537804720.195115.9.camel@acm.org>
         <10c706fd-2252-f11b-312e-ae0d97d9a538@virtuozzo.com>
         <1537805984.195115.14.camel@acm.org>
         <20180924185753.GA32269@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-24 at 11:57 -0700, Matthew Wilcox wrote:
+AD4 On Mon, Sep 24, 2018 at 09:19:44AM -0700, Bart Van Assche wrote:
+AD4 +AD4 That means that two buffers allocated with kmalloc() may share a cache line on
+AD4 +AD4 x86-64. Since it is allowed to use a buffer allocated by kmalloc() for DMA, can
+AD4 +AD4 this lead to data corruption, e.g. if the CPU writes into one buffer allocated
+AD4 +AD4 with kmalloc() and a device performs a DMA write to another kmalloc() buffer and
+AD4 +AD4 both write operations affect the same cache line?
+AD4 
+AD4 You're not supposed to use kmalloc memory for DMA.  This is why we have
+AD4 dma+AF8-alloc+AF8-coherent() and friends.

Are you claiming that all drivers that use DMA should use coherent DMA only? If
coherent DMA is the only DMA style that should be used, why do the following
function pointers exist in struct dma+AF8-map+AF8-ops?

	void (+ACo-sync+AF8-single+AF8-for+AF8-cpu)(struct device +ACo-dev,
				    dma+AF8-addr+AF8-t dma+AF8-handle, size+AF8-t size,
				    enum dma+AF8-data+AF8-direction dir)+ADs
	void (+ACo-sync+AF8-single+AF8-for+AF8-device)(struct device +ACo-dev,
				       dma+AF8-addr+AF8-t dma+AF8-handle, size+AF8-t size,
				       enum dma+AF8-data+AF8-direction dir)+ADs
	void (+ACo-sync+AF8-sg+AF8-for+AF8-cpu)(struct device +ACo-dev,
				struct scatterlist +ACo-sg, int nents,
				enum dma+AF8-data+AF8-direction dir)+ADs
	void (+ACo-sync+AF8-sg+AF8-for+AF8-device)(struct device +ACo-dev,
				   struct scatterlist +ACo-sg, int nents,
				   enum dma+AF8-data+AF8-direction dir)+ADs

Thanks,

Bart.
