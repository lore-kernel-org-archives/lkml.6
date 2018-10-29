Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA42C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D2F2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D2F2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeJ3FPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:15:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43696 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbeJ3FPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:15:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id n10-v6so4442420pgv.10;
        Mon, 29 Oct 2018 13:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rrqyoCrZfskPg6mPnpOQaOugbRjG9DnnO5gBVrJbevY=;
        b=PP59U+SbPC9nZPhM99386a9hJwTbvXtMyKTkXENL8cVHihuZJoHUVB531iTl1LhrdC
         Q1YdHBmx+nhKFW9nVEylJHCaUiY/kkluMFo0ZZCqI7zsOFNmIBTH40R68yP6ogikQnIL
         z+IXnVBj7e3/yhfppL37Yi0SEP/BRRrRw00Dzsl4sl7n7GmCfdDHXf328Bp1LEkGcN/+
         2Uj+VVgnu3k+PrAkjiN87Uw5WYBwOUT8xQDGXuSIG4i8h/7sbf56QP1Q0pOO48Ay+62G
         wsR5a70d71BBC+hEbd1uXoI2mxmPKQLCFLA0mFk33rbD32do4pAyqSHpyrQWMFn+sEeW
         9yBA==
X-Gm-Message-State: AGRZ1gKslyTkkZ9AC/C3Qor2zfSJ+bsL9Bh1D6xc8qsPAKthoWBUAf7a
        Pkm3Dm9FLgJXa7sHgj+u1ko=
X-Google-Smtp-Source: AJdET5fR1njXKCJgXLzeqmJy1V1g5mNuDdPsS2SUIeLOasEhNXRoPpzN4QcIXPNpMqNO2R/qG4pEnA==
X-Received: by 2002:a62:6203:: with SMTP id w3-v6mr16673210pfb.175.1540844733213;
        Mon, 29 Oct 2018 13:25:33 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id m1-v6sm23660542pgl.33.2018.10.29.13.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 13:25:32 -0700 (PDT)
Message-ID: <1540844730.196084.95.camel@acm.org>
Subject: Re: [PATCH 10/14] blk-mq: initial support for multiple queue maps
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Oct 2018 13:25:30 -0700
In-Reply-To: <867d3e60-3edf-39e7-2bcb-02d7f1092f82@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
         <20181029163738.10172-11-axboe@kernel.dk>
         <1540842034.196084.89.camel@acm.org>
         <ac755067-1432-54ce-6a4f-c7383f1ecc9d@kernel.dk>
         <1540843250.196084.93.camel@acm.org>
         <867d3e60-3edf-39e7-2bcb-02d7f1092f82@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 14:09 -0600, Jens Axboe wrote:
+AD4 hctx-+AD4-type will be set to the value of the first type. This is all driver
+AD4 private, blk-mq could not care less what the value of the type means.
+AD4 
+AD4 As to the other question, it works just fine since that is the queue
+AD4 that is being accessed. There's no confusion there. I think you're
+AD4 misunderstanding how it's seutp. To use nvme as the example, type 0
+AD4 would be reads, 1 writes, and 2 pollable queues. If reads and writes
+AD4 share the same set of hardware queues, then type 1 simply doesn't
+AD4 exist in terms of -+AD4-flags+AF8-to+AF8-type() return value. This is purely
+AD4 driven by the driver. That hook is the only decider of where something
+AD4 will go. If we share hctx sets, we share the same hardware queue as
+AD4 well. There is just the one set for that case.

How about adding a comment in blk-mq.h that explains that hardware queues can
be shared among different hardware queue types? I think this is nontrivial and
deserves a comment.

Thanks,

Bart.
