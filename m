Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66100ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034C8214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034C8214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbeIXWWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:22:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39036 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbeIXWWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:22:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85-v6so6302386pge.6;
        Mon, 24 Sep 2018 09:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iPmyPmJL7TCOYkEbDuM0iAYZx60w7EPMEzHCSAkwPyk=;
        b=rfSuNZkBTGUqqxSn0HAbeFKFawxBcdmzpKn4z6tw1g2ietcQwhlbHpkeNbQnYv1VNR
         fcwKwcEyALfjphcjEmybt3W940Ax2ErJ/PwrG4+osVV1d9eMaC6qKq3FnuPSXMtdKbYG
         ZnmykPngsBlmHCXNOl4oa+OOrljt5SPO1OMa8rFzscuy6d5YKoPvJi33EDj9ZzUxAVBo
         cLdTOkxvv4XYvhV0g683AYjIaZ85pWz1aMyuDZezREXDhLM1Ee8RK4GDDO0MccnyTWCW
         +wBC+l1djParM7VoQacyg5SJogaJ2yhmNygpHmzdYR1F5NudC0G6gctQwc94L2bHs6EB
         u9dg==
X-Gm-Message-State: APzg51CjQM13/gC27eAejzXZn5TRMRN7Uw9PlP+i1XWtBXdooqeyy8c9
        FyE2dFvISGGUHiLYVNYDkNY=
X-Google-Smtp-Source: ACcGV62tvuUeTpzkgGI40qoa8pU2FLCNuxLnaom6SkWPnqbtsHVGtuENwgSEAoELneZF/5AZCvwKnQ==
X-Received: by 2002:a62:2a48:: with SMTP id q69-v6mr11056094pfq.86.1537805986574;
        Mon, 24 Sep 2018 09:19:46 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id x9-v6sm57204032pfd.31.2018.09.24.09.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 09:19:45 -0700 (PDT)
Message-ID: <1537805984.195115.14.camel@acm.org>
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
Date:   Mon, 24 Sep 2018 09:19:44 -0700
In-Reply-To: <10c706fd-2252-f11b-312e-ae0d97d9a538@virtuozzo.com>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
         <20180920063129.GB12913@lst.de> <87h8ij0zot.fsf@vitty.brq.redhat.com>
         <20180923224206.GA13618@ming.t460p>
         <38c03920-0fd0-0a39-2a6e-70cd8cb4ef34@virtuozzo.com>
         <20a20568-5089-541d-3cee-546e549a0bc8@acm.org>
         <12eee877-affa-c822-c9d5-fda3aa0a50da@virtuozzo.com>
         <1537801706.195115.7.camel@acm.org>
         <c844c598-be1d-bef4-fb99-09cf99571fd7@virtuozzo.com>
         <1537804720.195115.9.camel@acm.org>
         <10c706fd-2252-f11b-312e-ae0d97d9a538@virtuozzo.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-24 at 19:07 +-0300, Andrey Ryabinin wrote:
+AD4 On 09/24/2018 06:58 PM, Bart Van Assche wrote:
+AD4 +AD4 On Mon, 2018-09-24 at 18:52 +-0300, Andrey Ryabinin wrote:
+AD4 +AD4 +AD4 Yes, with CONFIG+AF8-DEBUG+AF8-SLAB+AD0-y, CONFIG+AF8-SLUB+AF8-DEBUG+AF8-ON+AD0-y kmalloc() guarantees
+AD4 +AD4 +AD4 that result is aligned on ARCH+AF8-KMALLOC+AF8-MINALIGN boundary.
+AD4 +AD4 
+AD4 +AD4 Had you noticed that Vitaly Kuznetsov showed that this is not the case? See
+AD4 +AD4 also https://lore.kernel.org/lkml/87h8ij0zot.fsf+AEA-vitty.brq.redhat.com/.
+AD4 
+AD4 I'm not following. On x86-64 ARCH+AF8-KMALLOC+AF8-MINALIGN is 8, all pointers that
+AD4 Vitaly Kuznetsov showed are 8-byte aligned.

Hi Andrey,

That means that two buffers allocated with kmalloc() may share a cache line on
x86-64. Since it is allowed to use a buffer allocated by kmalloc() for DMA, can
this lead to data corruption, e.g. if the CPU writes into one buffer allocated
with kmalloc() and a device performs a DMA write to another kmalloc() buffer and
both write operations affect the same cache line?

Thanks,

Bart.
