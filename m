Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D496DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB9220883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB9220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbeIXWBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:01:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38675 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbeIXWBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:01:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id r77-v6so4220789pgr.5;
        Mon, 24 Sep 2018 08:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mw36CrvfVrpxzIqWOBQZfvvkpequs5zfefy49OeARZ4=;
        b=ctQkeY/lrPnK1tVBhY6SC9UZUVOn2COWn6LsMxu3DEmBHV/nvlxsFtCxxJCi82Biry
         H1yLzZ4CAGrtYrtXx4usLo/ykBTkHFaS7+S4vdAIEqEBQ42aLWeDTY/nvfWRhOwlmFsL
         ORx8K3kMTlFszRLBtkcvVGChgU7rsIaydHbFqH2nz0kw9itsNokUHgwiNK/0gAPrZzA+
         ZCKXjRPv7fddF8VRjq8CoONiF7OCF1dlHEdDdZzHfWzy78DOjQRi7mM9X+aAq+pXUvVA
         dQN5v0s/V30eb0T/NO2pGyqxwfPwh00Wv1phUirZH+KBuIpARcUa65kWc4ZhKLNZEaQx
         8y8w==
X-Gm-Message-State: ABuFfogkU3BLnqejVfzRokbndGQRCWpxPZGzz8Rr45ViWJMByeR+KT3n
        4cXo71x+KjWLydksIzrH6R4=
X-Google-Smtp-Source: ACcGV61eeotsNE97O6u9qYBCZdAZB8q0HP2yuUnXqihmrReseS3H/c32dI6QsT836BLCBTOCZuAptw==
X-Received: by 2002:a63:9809:: with SMTP id q9-v6mr9996689pgd.58.1537804722899;
        Mon, 24 Sep 2018 08:58:42 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id w12-v6sm55026294pfd.110.2018.09.24.08.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 08:58:42 -0700 (PDT)
Message-ID: <1537804720.195115.9.camel@acm.org>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
From:   Bart Van Assche <bvanassche@acm.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ming Lei <ming.lei@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Lameter <cl@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Mon, 24 Sep 2018 08:58:40 -0700
In-Reply-To: <c844c598-be1d-bef4-fb99-09cf99571fd7@virtuozzo.com>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
         <20180920063129.GB12913@lst.de> <87h8ij0zot.fsf@vitty.brq.redhat.com>
         <20180923224206.GA13618@ming.t460p>
         <38c03920-0fd0-0a39-2a6e-70cd8cb4ef34@virtuozzo.com>
         <20a20568-5089-541d-3cee-546e549a0bc8@acm.org>
         <12eee877-affa-c822-c9d5-fda3aa0a50da@virtuozzo.com>
         <1537801706.195115.7.camel@acm.org>
         <c844c598-be1d-bef4-fb99-09cf99571fd7@virtuozzo.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-24 at 18:52 +-0300, Andrey Ryabinin wrote:
+AD4 Yes, with CONFIG+AF8-DEBUG+AF8-SLAB+AD0-y, CONFIG+AF8-SLUB+AF8-DEBUG+AF8-ON+AD0-y kmalloc() guarantees
+AD4 that result is aligned on ARCH+AF8-KMALLOC+AF8-MINALIGN boundary.

Had you noticed that Vitaly Kuznetsov showed that this is not the case? See
also https://lore.kernel.org/lkml/87h8ij0zot.fsf+AEA-vitty.brq.redhat.com/.

Thanks,

Bart.

