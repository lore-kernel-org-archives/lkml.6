Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EB6C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4612E20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4612E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeJZB42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:56:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41518 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbeJZB41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:56:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id a19-v6so4513935pfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 10:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nb6vETvNsAzFRnepdlFWVnzaZqt/YLpdCH26yR/CTeU=;
        b=DOQQdETf5ssb2RQcv4V7ovgauL0wgZIA1NX+liFChr5fkZf7qePxvmm+waV98QwR4D
         17WKBP25MV/vn1+jIqWqiNbu+tdgVHeHVMmgQH31UyjesCs6mj9AQrtypLhf0lL97zaD
         7ceJqheAiG/1SVmGp7VHfiTEGvHae1/XuvpH9L6I4E13rLniDyROaSax4p3q9YXUNykQ
         aTh9rhyu7pICeLLTYRZXXqvPH4lfPtMj2MjzHC6EtP20SSCeI8A76KsXixximudvdcur
         idqk8joIYnVVnY2o+mRC1G1AbPI5h0Hqu0KC9FyeSjR5xVmxgwhxhTA/w2q7/a5tRuVq
         k8dg==
X-Gm-Message-State: AGRZ1gLqpBeuIPYAHP0k32KrQRTfCM7pJyJ63osTmRMQrQsr/7b9YZqY
        J1ibJwdKYRGy//cR0LoCOV8=
X-Google-Smtp-Source: AJdET5fmfZqB0nogyx+JASHE27b1uTRCm4aKuesBN49FiCKRVxG9K/Wng3ckl5CNaUZobw9h4SLsRA==
X-Received: by 2002:a62:9702:: with SMTP id n2-v6mr111183pfe.222.1540488164502;
        Thu, 25 Oct 2018 10:22:44 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id a14-v6sm9314172pgi.75.2018.10.25.10.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 10:22:43 -0700 (PDT)
Message-ID: <1540488162.66186.35.camel@acm.org>
Subject: Re: [PATCH 2/3] kernel/workqueue: Surround work execution with
 shared lock annotations
From:   Bart Van Assche <bvanassche@acm.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "tytso@mit.edu" <tytso@mit.edu>
Date:   Thu, 25 Oct 2018 10:22:42 -0700
In-Reply-To: <256720b373cf539052d79ce3051214140820d696.camel@sipsolutions.net>
References: <20181025150540.259281-1-bvanassche@acm.org>
         <20181025150540.259281-3-bvanassche@acm.org>
         <256720b373cf539052d79ce3051214140820d696.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 18:53 +-0200, Johannes Berg wrote:
+AD4 On Thu, 2018-10-25 at 15:05 +-0000, Bart Van Assche wrote:
+AD4 +AD4 Surround execution of work with a shared lockdep annotation because multiple
+AD4 +AD4 work items associated with a work queue may execute concurrently.
+AD4 
+AD4 Hmm. So, I'm not really entirely sure of the semantics here, but I fail
+AD4 to see how +ACI-may execute concurrently+ACI means +ACI-can be taken recursively+ACI?
+AD4 
+AD4 After all, if they execute concurrently, that's in a different thread,
+AD4 right? So each thread is really just doing something with this work. It
+AD4 may not match mutex semantics in how mutexes would lock each other out
+AD4 and prevent concurrency, but I don't think that matters to lockdep at
+AD4 all.
+AD4 
+AD4 In fact, I'm not sure this actually changes anything, since you can't
+AD4 really execute a work struct while executing one already?
+AD4 
+AD4 What's this intended to change? I currently don't see how lockdep's
+AD4 behaviour would differ with read+AD0APQ-1, unless you actually tried to do
+AD4 recursive locking, which isn't really possible?
+AD4 
+AD4 Or perhaps this is actually the right change for the issue described in
+AD4 patch 1, where a work struct flushes another work on the same wq, and
+AD4 that causes recursion of sorts? But that recursion should only happen if
+AD4 the workqueues is actually marked as ordered, in which case it +ACo-is+ACo in
+AD4 fact wrong?

How about modifying the wq-+AD4-lockdep+AF8-map annotations only and not touching the
work-+AD4-lockdep+AF8-map annotations? My comment about concurrency in the patch
description refers to a multithreaded workqueue executing multiple different
work items concurrently. I am aware that great care has been taken in the
workqueue implementation to ensure that each work item is executed by exactly
one worker.

Bart.
