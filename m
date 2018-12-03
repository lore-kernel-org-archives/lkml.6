Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B66C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C7A20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C7A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeLCSRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:17:07 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44418 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeLCSRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:17:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so6062390pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:17:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gTwHjlnUwENPTmWAwgejIC0hSbwaNBIeEIizQkjHv5c=;
        b=mQbxqQ0/eSqz8c1jinNXUhDO6HYXFq0dxo+qj0z2+oLGMRPqNAQ9aYtEx9UTv0ud0Q
         ZecW+MNGBbmbaN9fLUXetzu5KO0RFkou9FKcKgTCpwqIUYKH7eNXgWNuLvXaDD0jAWxU
         m2zwuGWCOxDMZAcVWAccxmIx+cFFrslSOFTzR+UqfvGJNxhfdDwXOcsQp/fxbAN0ATh0
         CfsWXVrcAXEgRPxResBtxjCMQImdpgWESLxy1EI+sEKwk60UkxauowmXWhTvGJNffRzZ
         t8txB8DyWStfwzTQMP15KojJYkPxNzed1Ku8wkc8ZY5JlmuEptUQEHsztdS3oEQBIzlj
         b3mg==
X-Gm-Message-State: AA+aEWYOJilKsyxFxq4zQJKcvLiAapF01lE0B6/3W+MzO9v4L7d9m8h9
        RZtkRY8u2vpDwvo9jREVNhaD+rOQ
X-Google-Smtp-Source: AFSGD/V0w9UB45w3M++zhSqXy30hKjdLkxOWA+4Eo1XD79BWaRNR+eTUTeDYz6npb7Hxzpw2qTcE+g==
X-Received: by 2002:a63:c24c:: with SMTP id l12mr14181740pgg.146.1543861022080;
        Mon, 03 Dec 2018 10:17:02 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id g185sm11485082pfc.174.2018.12.03.10.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 10:17:01 -0800 (PST)
Message-ID: <1543861019.185366.167.camel@acm.org>
Subject: Re: [PATCH 22/27] locking/lockdep: Reuse list entries that are no
 longer in use
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 03 Dec 2018 10:16:59 -0800
In-Reply-To: <20181203173258.GK11614@hirez.programming.kicks-ass.net>
References: <20181128234325.110011-1-bvanassche@acm.org>
         <20181128234325.110011-23-bvanassche@acm.org>
         <20181129104902.GH2131@hirez.programming.kicks-ass.net>
         <20181129120143.GG2149@hirez.programming.kicks-ass.net>
         <1543510130.185366.139.camel@acm.org>
         <20181201202446.GA19706@hirez.programming.kicks-ass.net>
         <1543855248.185366.158.camel@acm.org>
         <20181203173258.GK11614@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-03 at 18:32 +-0100, Peter Zijlstra wrote:
+AD4 On Mon, Dec 03, 2018 at 08:40:48AM -0800, Bart Van Assche wrote:
+AD4 
+AD4 +AD4 +AD4 I think we can do this with a free bitmap and an array of 2 pending
+AD4 +AD4 +AD4 bitmaps and an index. Add newly freed entries to the pending bitmap
+AD4 +AD4 +AD4 indicated by the current index, when complete flip the index -- such
+AD4 +AD4 +AD4 that further new bits go to the other pending bitmap -- and call+AF8-rcu().
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Then, on the call+AF8-rcu() callback, ie. after a GP has happened, OR our
+AD4 +AD4 +AD4 pending bitmap into the free bitmap, and when the other pending bitmap
+AD4 +AD4 +AD4 isn't empty, flip the index again and start it all again.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 This ensures there is at least one full GP between setting a bit and it
+AD4 +AD4 +AD4 landing in the free mask.
+AD4 +AD4 
+AD4 +AD4 Hi Peter,
+AD4 +AD4 
+AD4 +AD4 How about the following alternative which requires only two bitmaps instead
+AD4 +AD4 of three:
+AD4 +AD4 - Maintain two bitmaps, one for the free entries and one for the entries
+AD4 +AD4   that are being freed.
+AD4 +AD4 - Protect all accesses to both bitmaps with the graph lock.
+AD4 +AD4 - zap+AF8-class() sets a bit in the +ACI-being freed+ACI bitmap for the entries that
+AD4 +AD4   should be freed after a GP.
+AD4 +AD4 - Instead of making free+AF8-zapped+AF8-classes() wait for a grace period by calling
+AD4 +AD4   synchronize+AF8-sched(), use call+AF8-rcu() and do the freeing work from inside the
+AD4 +AD4   RCU callback.
+AD4 +AD4 - From inside the RCU callback, set a bit in the +ACI-free+ACI bitmap for all entries
+AD4 +AD4   that have a bit set in the +ACI-being freed+ACI bitmap and clears the +ACI-being freed+ACI
+AD4 +AD4   bitmap.
+AD4 
+AD4 What happens when another unreg happens while the rcu+AF8-call thing is
+AD4 still pending?

A new flag will have to keep track of whether or not an RCU callback has
already been scheduled via rcu+AF8-call() but not yet executed to avoid double
RCU call complaints. In other code a possible alternative would be to
allocate the RCU head data structure dynamically. However, I don't think
that alternative is appropriate inside the lockdep code - I don't want to
introduce a circular dependency between the lockdep code and the memory
allocator.

Bart.
