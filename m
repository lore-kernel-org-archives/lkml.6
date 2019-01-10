Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2418FC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D9C208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfAJSvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:51:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45697 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfAJSvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:51:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so5553613plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 10:51:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8pBzF+IVe61alvezj7crg4f957bEFuVAqpAgNOJKohk=;
        b=CDNlj9N09exYj8tynNmX6gy5bu46ykgv7xZm/7oZyEdK1rfIqeDvTNyH3SOWvAad6n
         mbreapeyEuvmdQ2Wkd3F7W4+ttYunHb+h0cfdos48n7nwKt03BOLwND0xxJYF6G22eBN
         /phCY6r6cL7iRD6S2k/LHqrQ0kVCqhKS7Zp0blOGk8QGV794XE7Y1KIemBwCeK8jSrAQ
         9+fGHP7u6IGW1ntUN8xl6sq77JCVDdAXv6zmtJqNjGZ3PyjnJWu4FPHYp4O4gYFP38n6
         /IDW1isEsfD1/yyvEUgxAO8mr986+sPOzaPh6rmYevKRQdGvavDkfZJpBuOdOSM3GJmM
         1fwQ==
X-Gm-Message-State: AJcUukfV6kH4S6FygsN/nAr6+tuzBwQ1rD9qSUrpG7GcxmJegXvqttu6
        t5rO6LKeWkKyUyvnwDOef0M=
X-Google-Smtp-Source: ALg8bN5FJ/CBwhS1hUAq4ht04vL8EW6JMx8EE4UnysxJHtKPeKDB0da1FDPG54MOCmBVBicOWXBA4A==
X-Received: by 2002:a17:902:a601:: with SMTP id u1mr11399927plq.77.1547146290930;
        Thu, 10 Jan 2019 10:51:30 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id c67sm101989907pfg.170.2019.01.10.10.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 10:51:28 -0800 (PST)
Message-ID: <1547146287.83374.49.camel@acm.org>
Subject: Re: [PATCH v5 07/15] locking/lockdep: Free lock classes that are no
 longer in use
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Date:   Thu, 10 Jan 2019 10:51:27 -0800
In-Reply-To: <20190110152412.GG30894@hirez.programming.kicks-ass.net>
References: <20181217213002.73776-1-bvanassche@acm.org>
         <20181217213002.73776-8-bvanassche@acm.org>
         <20190110152412.GG30894@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-10 at 16:24 +-0100, Peter Zijlstra wrote:
+AD4  /+ACo
+AD4   +ACo A data structure for delayed freeing of data structures that may be
+AD4 - +ACo accessed by RCU readers at the time these were freed. The size of the array
+AD4 - +ACo is a compromise between minimizing the amount of memory used by this array
+AD4 - +ACo and minimizing the number of wait+AF8-event() calls by get+AF8-pending+AF8-free+AF8-lock().
+AD4 +- +ACo accessed by RCU readers at the time these were freed.
+AD4   +ACo-/
+AD4  static struct pending+AF8-free +AHs
+AD4 -	struct list+AF8-head zapped+AF8-classes+ADs
+AD4  	struct rcu+AF8-head	 rcu+AF8-head+ADs
+AD4 +-	int		 index+ADs
+AD4  	int		 pending+ADs
+AD4 -+AH0 pending+AF8-free+AFs-2+AF0AOw
+AD4 -static DECLARE+AF8-WAIT+AF8-QUEUE+AF8-HEAD(rcu+AF8-cb)+ADs
+AD4 +-	struct list+AF8-head zapped+AFs-2+AF0AOw
+AD4 +-+AH0 pending+AF8-free+ADs

Hi Peter,

If the zapped+AFsAXQ array only has two elements there is no guarantee that an
element will be free when zap+AF8-class() is called. I think we need at least
num+AF8-online+AF8-cpus() elements to guarantee that at least one element is free
when zap+AF8-class() is called. So removing the wait loop from
get+AF8-pending+AF8-free+AF8-lock() seems wrong to me. Have you tried to run a workload
that keeps all CPUs busy and that triggers get+AF8-pending+AF8-free+AF8-lock()
frequently?

Thanks,

Bart.


