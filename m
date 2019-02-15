Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633A6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C90921927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391648AbfBOQIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:08:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45643 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391570AbfBOQIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:08:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so4995280pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DOsyty2+OJstNQRdrfPljxsFGHtCrntus5lIvmnjay4=;
        b=AFmg6bM/kqsyFp2tQWbnvCU3zYxDkqAZzS9h4FZtqaabQU1qgDA0zAx1BnW6BJkLu9
         hpXyKm/uFiWG1/en4lSmKFTnQ/1aQbDyMU6iMXgsNgvh+EbiXFwO1KkNdOvZXZp0XppX
         KrX02aFU3e5zmL21VLHmbQ2jFEYst3DRU010D9jNNmm+NpHc8PGJL1JBmqay1yaMiIGl
         mDk1631kb0VJV8po71WZfniDi7M2ZEVNHbYr5Trw/HwfE/L/nh9VIZg1Vf0KdHBAuSkF
         0adPumhOFDowvFGaPEz1TZ7/bh4lqqkKQOHxJSh8YBPEJmoVhYtLWNZFH+J891sAYyog
         rp7w==
X-Gm-Message-State: AHQUAubmN2cFUWmMMHUgVyZIjW2dDJTAz3puav4Oosk8yvxwMp/t0wGM
        //oXzWVoJESOQG85ksDu9Kk=
X-Google-Smtp-Source: AHgI3IaUA3KEF2p5FsgRjDvguCCa5pNttb+PJpWXNvOHHsrof7zx+LtB0SkKV3GfOVrGp15kfrooXg==
X-Received: by 2002:a63:ef47:: with SMTP id c7mr6132697pgk.386.1550246891016;
        Fri, 15 Feb 2019 08:08:11 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s71sm13776257pfa.122.2019.02.15.08.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 08:08:09 -0800 (PST)
Message-ID: <1550246888.31902.97.camel@acm.org>
Subject: Re: [PATCH v7 21/23] block: Avoid that flushing triggers a lockdep
 complaint
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        tj@kernel.org, longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>
Date:   Fri, 15 Feb 2019 08:08:08 -0800
In-Reply-To: <20190215022658.GB21045@ming.t460p>
References: <20190214230058.196511-1-bvanassche@acm.org>
         <20190214230058.196511-22-bvanassche@acm.org>
         <20190215022658.GB21045@ming.t460p>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-15 at 10:26 +-0800, Ming Lei wrote:
+AD4 There might be lots of blk+AF8-flush+AF8-queue instance which is allocated
+AD4 for each hctx, then lots of class key slot may be wasted.
+AD4 
+AD4 So I suggest to use one nvmet+AF8-loop+AF8-flush+AF8-lock+AF8-key for this particular issue,
+AD4 something like the following patch:
+AD4 
+AD4 diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
+AD4 index 4aac1b4a8112..ec4248c12ed9 100644
+AD4 --- a/drivers/nvme/target/loop.c
+AD4 +-+-+- b/drivers/nvme/target/loop.c
+AD4 +AEAAQA -524,7 +-524,9 +AEAAQA static const struct nvme+AF8-ctrl+AF8-ops nvme+AF8-loop+AF8-ctrl+AF8-ops +AD0 +AHs
+AD4  
+AD4  static int nvme+AF8-loop+AF8-create+AF8-io+AF8-queues(struct nvme+AF8-loop+AF8-ctrl +ACo-ctrl)
+AD4  +AHs
+AD4 -	int ret+ADs
+AD4 +-	static struct lock+AF8-class+AF8-key  nvme+AF8-loop+AF8-flush+AF8-lock+AF8-key+ADs
+AD4 +-	int ret, i+ADs
+AD4 +-	struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx+ADs
+AD4  
+AD4  	ret +AD0 nvme+AF8-loop+AF8-init+AF8-io+AF8-queues(ctrl)+ADs
+AD4  	if (ret)
+AD4 +AEAAQA -553,6 +-555,10 +AEAAQA static int nvme+AF8-loop+AF8-create+AF8-io+AF8-queues(struct nvme+AF8-loop+AF8-ctrl +ACo-ctrl)
+AD4  		goto out+AF8-free+AF8-tagset+ADs
+AD4  	+AH0
+AD4  
+AD4 +-	queue+AF8-for+AF8-each+AF8-hw+AF8-ctx(ctrl-+AD4-ctrl.connect+AF8-q, hctx, i)
+AD4 +-		lockdep+AF8-set+AF8-class(+ACY-hctx-+AD4-fq-+AD4-mq+AF8-flush+AF8-lock,
+AD4 +-				+ACY-nvme+AF8-loop+AF8-flush+AF8-lock+AF8-key)+ADs
+AD4 +-
+AD4  	ret +AD0 nvme+AF8-loop+AF8-connect+AF8-io+AF8-queues(ctrl)+ADs
+AD4  	if (ret)
+AD4  		goto out+AF8-cleanup+AF8-connect+AF8-q+ADs

Hi Ming,

Thanks for your feedback.

Are you aware that sizeof(struct lock+AF8-class+AF8-key) is zero if lockdep is
disabled? Does this alleviate your concern?

I'm not enthusiast about your patch. I don't think that block layer users
should touch the lock class key of the flush queue. That's a key that should
be set by the block layer core.

Anyway, let's drop patches 20/23 and 21/23 from this series and let's
continue this discussion on the linux-block mailing list after agreement has
been reached about the +ACI-dynamic lockdep key+ACI approach.

Bart.
