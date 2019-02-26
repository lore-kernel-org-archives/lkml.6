Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E130FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE3F2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfBZRsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:48:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36937 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfBZRsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:48:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so6556837pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 09:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/FSmsA/f1QwcU9WmykfUtdlf6vIpFkEAGHYFfGCxhk=;
        b=YU8MDbwglJMrOIXdf0jOUBxPiB7OXL83Ff0w9+cHmhvD6xS7fre0zEFKxHKdr8n5yb
         qTloT/FukVpbgFnmMkXPS7TX+bdu13YOOjt6N/stBnU8/k3bZFhtdrEJ3N/pDJdR0Dyn
         Lj4+Az9m8Jqf0XRLbAEdWllgEdFP+XnOIOwZMBIjvNWYtI8AFrX0vf2LOtELmAEUh+4B
         fpZWCaZqaQZDYXRmxrIKCGEkbLK+7TaBclbuOPU2HasMVL28O7mNP/xGVlhaL/kbx8lT
         oyNI+ZCjky4vspO7hFGvOhfzfOpI7ugBoNzzcqkHkDI4cF39i+ebhre1PDz4V1lnDHJO
         Kmhw==
X-Gm-Message-State: AHQUAuZBe1/XwkbqrLFDxpXNl8bJjZ9qt3VFAM3IiLrC1jrjUfaMNgWC
        HYgRZ7ArH9sx6ujDVBYihho=
X-Google-Smtp-Source: AHgI3IZTypfmbiDR2AMD+mlVWRYiApNFJGSmfWACf9bA0TGbo/apexQpufSLDj8Plxs2Mzm/LAuD4A==
X-Received: by 2002:a63:112:: with SMTP id 18mr24468142pgb.139.1551203294737;
        Tue, 26 Feb 2019 09:48:14 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 4sm33882964pft.96.2019.02.26.09.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 09:48:13 -0800 (PST)
Message-ID: <1551203292.31902.174.camel@acm.org>
Subject: Re: [PATCH v7 21/23] block: Avoid that flushing triggers a lockdep
 complaint
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, Theodore Ts'o <tytso@mit.edu>
Date:   Tue, 26 Feb 2019 09:48:12 -0800
In-Reply-To: <20190226172421.GI32494@hirez.programming.kicks-ass.net>
References: <20190214230058.196511-1-bvanassche@acm.org>
         <20190214230058.196511-22-bvanassche@acm.org>
         <20190226172421.GI32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-26 at 18:24 +-0100, Peter Zijlstra wrote:
+AD4 On Thu, Feb 14, 2019 at 03:00:56PM -0800, Bart Van Assche wrote:
+AD4 +AD4 +AEAAQA -472,7 +-473,8 +AEAAQA struct blk+AF8-flush+AF8-queue +ACo-blk+AF8-alloc+AF8-flush+AF8-queue(struct request+AF8-queue +ACo-q,
+AD4 +AD4  	if (+ACE-fq)
+AD4 +AD4  		goto fail+ADs
+AD4 +AD4  
+AD4 +AD4 -	spin+AF8-lock+AF8-init(+ACY-fq-+AD4-mq+AF8-flush+AF8-lock)+ADs
+AD4 +AD4 +-	lockdep+AF8-register+AF8-key(+ACY-fq-+AD4-key)+ADs
+AD4 +AD4 +-	spin+AF8-lock+AF8-init+AF8-key(+ACY-fq-+AD4-mq+AF8-flush+AF8-lock, +ACY-fq-+AD4-key)+ADs
+AD4 
+AD4 What's wrong with:
+AD4 
+AD4 	spin+AF8-lock+AF8-init(+ACY-fq-+AD4-wq+AF8-flush+AF8-lock)+ADs
+AD4 	lockdep+AF8-register+AF8-key(+ACY-fq-+AD4-key)+ADs
+AD4 	lockdep+AF8-set+AF8-class(+ACY-fq-+AD4-wq+AF8-flush+AF8-lock, +ACY-fq-+AD4-key)+ADs
+AD4 
+AD4 ?

Hi Peter,

That's an approach that I had not yet considered. I'm fine with the
lockdep+AF8-set+AF8-class() version.

Bart.
