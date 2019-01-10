Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C38C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13C220874
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfAJV4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:56:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33088 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfAJV4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:56:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so5934869pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 13:56:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNJatEtIzFQXc/i2+T+jqxe/f8UoehtHSXh5aGwgVDM=;
        b=WO89H5uUXgzAKn1Zaz5IGI1INlSeM+L/j9ubkwhI3cBkk7E8KWg4d+7Oo8z7ieGvcR
         k7TvXbr8CHU++oe91WNH8E3sKeHaT4O5LbIt+W5meCYQoFsmOPxyyX1U25RzKQLxwom8
         gs5GVRYo+/BP93sJwWVnw/lQ0Wi3OZ23KqEJpwZRLxB92WqV5zMcm3atlrGXIjGko1Jf
         DfCWiyak8Vy4SjTDC0ecbTAVd5aQ8QXuUt+JW43adA6+Drrrou5lbhb+0zOObB9f2OeG
         tQhHrPr/e1Sld4iJqb6DnRlK5oTY4RFcH4xZNgTMB1fwThLqzG/nF+ko8AFSKvcFb6kZ
         62kw==
X-Gm-Message-State: AJcUuke1iXT5DXMoCJBHVhtaDJG64rRgYjRgHcuBsNSxAKGvQ8S/ncDu
        r+uex/vUtAWWbOjvUb1KC9c=
X-Google-Smtp-Source: ALg8bN4nh393c7mevETyKOqXNVLPmd9MncCpPftakD9bIiGu5erMtpflLPawAL9pvtWqqVwF1aDUfA==
X-Received: by 2002:a63:304:: with SMTP id 4mr10021052pgd.99.1547157403767;
        Thu, 10 Jan 2019 13:56:43 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id x28sm151952564pge.66.2019.01.10.13.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 13:56:42 -0800 (PST)
Message-ID: <1547157401.83374.59.camel@acm.org>
Subject: Re: [PATCH v5 07/15] locking/lockdep: Free lock classes that are no
 longer in use
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Date:   Thu, 10 Jan 2019 13:56:41 -0800
In-Reply-To: <20190110194459.GD2861@worktop.programming.kicks-ass.net>
References: <20181217213002.73776-1-bvanassche@acm.org>
         <20181217213002.73776-8-bvanassche@acm.org>
         <20190110152412.GG30894@hirez.programming.kicks-ass.net>
         <1547146287.83374.49.camel@acm.org>
         <20190110194459.GD2861@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-10 at 20:44 +-0100, Peter Zijlstra wrote:
+AD4 On Thu, Jan 10, 2019 at 10:51:27AM -0800, Bart Van Assche wrote:
+AD4 +AD4 On Thu, 2019-01-10 at 16:24 +-0100, Peter Zijlstra wrote:
+AD4 +AD4 +AD4  /+ACo
+AD4 +AD4 +AD4   +ACo A data structure for delayed freeing of data structures that may be
+AD4 +AD4 +AD4 - +ACo accessed by RCU readers at the time these were freed. The size of the array
+AD4 +AD4 +AD4 - +ACo is a compromise between minimizing the amount of memory used by this array
+AD4 +AD4 +AD4 - +ACo and minimizing the number of wait+AF8-event() calls by get+AF8-pending+AF8-free+AF8-lock().
+AD4 +AD4 +AD4 +- +ACo accessed by RCU readers at the time these were freed.
+AD4 +AD4 +AD4   +ACo-/
+AD4 +AD4 +AD4  static struct pending+AF8-free +AHs
+AD4 +AD4 +AD4 -	struct list+AF8-head zapped+AF8-classes+ADs
+AD4 +AD4 +AD4  	struct rcu+AF8-head	 rcu+AF8-head+ADs
+AD4 +AD4 +AD4 +-	int		 index+ADs
+AD4 +AD4 +AD4  	int		 pending+ADs
+AD4 +AD4 +AD4 -+AH0 pending+AF8-free+AFs-2+AF0AOw
+AD4 +AD4 +AD4 -static DECLARE+AF8-WAIT+AF8-QUEUE+AF8-HEAD(rcu+AF8-cb)+ADs
+AD4 +AD4 +AD4 +-	struct list+AF8-head zapped+AFs-2+AF0AOw
+AD4 +AD4 +AD4 +-+AH0 pending+AF8-free+ADs
+AD4 +AD4 
+AD4 +AD4 Hi Peter,
+AD4 +AD4 
+AD4 +AD4 If the zapped+AFsAXQ array only has two elements there is no guarantee that an
+AD4 +AD4 element will be free when zap+AF8-class() is called. I think we need at least
+AD4 +AD4 num+AF8-online+AF8-cpus() elements to guarantee that at least one element is free
+AD4 +AD4 when zap+AF8-class() is called. So removing the wait loop from
+AD4 +AD4 get+AF8-pending+AF8-free+AF8-lock() seems wrong to me. Have you tried to run a workload
+AD4 +AD4 that keeps all CPUs busy and that triggers get+AF8-pending+AF8-free+AF8-lock()
+AD4 +AD4 frequently?
+AD4 
+AD4 I have not ran (yet)+ADs but I do not quite follow your argument. There is
+AD4 only a single rcu+AF8-head, yes? Thereby only a single list can be pending
+AD4 at any one time, and the other list is free to be appended to during
+AD4 this time -- all is serialized by the graph lock after all.
+AD4 
+AD4 When the rcu callback happens, we flush the list we started the QS for,
+AD4 which then becomes empty and if the open list contains entries, we
+AD4 flip the lot and requeue the rcu+AF8-head for another QS.
+AD4 
+AD4 Therefore we only ever need 2 lists+ADs 1 closed with entries waiting for
+AD4 the callback, 1 open, to which we can append all newly freed entries.

Hi Peter,

Now that I had a closer look at your patch I think the approach of your patch
is fine. Sorry for the confusion.

Bart.
