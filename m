Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604C8ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A612214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4sr8rQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A612214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbeISOw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:52:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39637 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbeISOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:52:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id q8-v6so6023761wmq.4;
        Wed, 19 Sep 2018 02:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=bQnwIJ31XljuuH+lyaxBQEx9HBGqzyKsFYmfFbFifQw=;
        b=B4sr8rQgRApaUKumB+8XoK3LOk/JU3MZF+3/rR1iigOz8MH/nebxq492OfdjnOhzh9
         jae0UEYzRijLcvXyIRCI9CmfwinTbtVA2+UG6lbIiCU2NEkcMBLUquo/0aPNbRq1RbzR
         IfG4kDdCbauiaFpKxkb4Gr46fvNPgXXuRRnWH55R+zjmNyWIfZJMwEp+/Efokr6IZcGy
         G7MeXBYxsxWBgA35nJ+1tKFTLGIYRV3QiEZFLiXrHLCVMbbL+dGzlEFSBBQ9+WL2/cNF
         hGOJjBPSj1rGW720twIwz0doODos1VH2/M7LWsJbszKHKax1brqB5eXrAC5+bDIuAHPc
         30NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bQnwIJ31XljuuH+lyaxBQEx9HBGqzyKsFYmfFbFifQw=;
        b=KgWCqH9f0zMQDudzA4qXG2AuIPKFcpm35VyZFj/IR48yA6OPd9+FfCOD/AWUOVHKYa
         idZXTgZBu72RwBzNsM9UNUhhg9AXUm5ekKWY3xEZOT/LXjvDBFvo4YzsOTm2CUFkTfAx
         oKnk0tigR+wc+yNAuOaAM9Gi02iS23rsc98dOFZ6/GfHvo0uDqObtk1xyQCyTrWcTohH
         AaexCwtmnxUblPqMfaC92oa7RS1aVAArb/qVkuHUOu8Lj1IXtPDCCF2imi011EdYhc5n
         Rw1iISVAnu8ZCcYFAQRYDbdOwFZ1DmNohWe5KHhqWoWvPG57oInsx0po3eDMJJCPnyvD
         emxw==
X-Gm-Message-State: APzg51CJp0rY1UUDbS65pFTBcxA6Zan0ERToP3O+NwSxN+xoSwDz5vSk
        Lf9v2jTk0gNjLcR1MLlFeUELHOGB3JJx2jwhY2jGOQlQ
X-Google-Smtp-Source: ANB0VdaYVgbnQzwGuon1xIz3FdYow9vdParOlLJmnyLqGlgpM58900IsCNzv+gDmhpxt2JxJEbFFMeJ7DNFuggVU2t0=
X-Received: by 2002:a1c:e286:: with SMTP id z128-v6mr18716269wmg.30.1537348555040;
 Wed, 19 Sep 2018 02:15:55 -0700 (PDT)
MIME-Version: 1.0
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 19 Sep 2018 17:15:43 +0800
Message-ID: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
Subject: block: DMA alignment of IO buffer allocated from slab
To:     linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

Some storage controllers have DMA alignment limit, which is often set via
blk_queue_dma_alignment(), such as 512-byte alignment for IO buffer.

Block layer now only checks if this limit is respected for buffer of
pass-through request,
see blk_rq_map_user_iov(), bio_map_user_iov().

The userspace buffer for direct IO is checked in dio path, see
do_blockdev_direct_IO().
IO buffer from page cache should be fine wrt. this limit too.

However, some file systems, such as XFS, may allocate single sector IO buffer
via slab. Usually I guess kmalloc-512 should be fine to return
512-aligned buffer.
But once KASAN or other slab debug options are enabled, looks this
isn't true any
more, kmalloc-512 may not return 512-aligned buffer. Then data corruption
can be observed because the IO buffer from fs layer doesn't respect the DMA
alignment limit any more.

Follows several related questions:

1) does kmalloc-N slab guarantee to return N-byte aligned buffer?  If
yes, is it a stable rule?

2) If it is a rule for kmalloc-N slab to return N-byte aligned buffer,
seems KASAN violates this
rule?

3) If slab can't guarantee to return 512-aligned buffer, how to fix
this data corruption issue?

Thanks,
Ming Lei
