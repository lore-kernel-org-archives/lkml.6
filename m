Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C78C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A9B2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A9B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeLDQIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:08:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44559 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeLDQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:08:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so8425309pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pRzUg/Mu6cnX5iqJGgWinZP7+5KKYMSLhToDVlT88w8=;
        b=G5/gSvZF4rygKffaN+fA1PE6dKEu6WUV7lrJUQGax30URHUxVc0M2d76n5cH4Vtxok
         THIBJVnUJf+nXCiIFLNC1otZXtepJkL4xRH1JTr2Fw9X4pWJOh3l3+Ul6GisCgZLRjXI
         QpJeWlRCLuVIkX70lf6Z02/HTH0jcyUaL7IVAXrK5pIw6R6bGTs3a08Z4x74EFtEVT9H
         b1LxUrNK5G5NMqh4PSsveSTcBlteN0m80+XUdSHiAYiJRWCIMFUc8/FPBDQTs9BmdKMq
         v3zi3yQ9fbRbFctbOxwzWTSY7gia7oFc8O3g1VVaG4C+cqlgPRLQDBO1mqy5uYg/Tpls
         itww==
X-Gm-Message-State: AA+aEWZO4G0AGU7ClQNeU1RLzVs2p/gRbmRkY4pEId6gaMCxRj/+gE+Z
        84x4AOazP72Usej/xUxky+Q=
X-Google-Smtp-Source: AFSGD/XZJfeTJoSvOftANlg0ekXeUgUuj3P4C0sdHo8h7cYq1XLIOcIo+Ufz7I5ZZE9uBmQ8MmIhQg==
X-Received: by 2002:a62:1043:: with SMTP id y64mr20926666pfi.78.1543939703759;
        Tue, 04 Dec 2018 08:08:23 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 196sm49310908pfc.77.2018.12.04.08.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 08:08:21 -0800 (PST)
Message-ID: <1543939700.185366.187.camel@acm.org>
Subject: Re: [PATCH 22/27] locking/lockdep: Reuse list entries that are no
 longer in use
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 04 Dec 2018 08:08:20 -0800
In-Reply-To: <20181204081436.GL11614@hirez.programming.kicks-ass.net>
References: <20181128234325.110011-1-bvanassche@acm.org>
         <20181128234325.110011-23-bvanassche@acm.org>
         <20181129104902.GH2131@hirez.programming.kicks-ass.net>
         <20181129120143.GG2149@hirez.programming.kicks-ass.net>
         <1543510130.185366.139.camel@acm.org>
         <20181201202446.GA19706@hirez.programming.kicks-ass.net>
         <1543855248.185366.158.camel@acm.org>
         <20181203173258.GK11614@hirez.programming.kicks-ass.net>
         <1543861019.185366.167.camel@acm.org>
         <20181204081436.GL11614@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-04 at 09:14 +-0100, Peter Zijlstra wrote:
+AD4 On Mon, Dec 03, 2018 at 10:16:59AM -0800, Bart Van Assche wrote:
+AD4 +AD4 On Mon, 2018-12-03 at 18:32 +-0100, Peter Zijlstra wrote:
+AD4 +AD4 +AD4 On Mon, Dec 03, 2018 at 08:40:48AM -0800, Bart Van Assche wrote:
+AD4 +AD4 +AD4 +AD4 How about the following alternative which requires only two bitmaps instead
+AD4 +AD4 +AD4 +AD4 of three:
+AD4 +AD4 +AD4 +AD4 - Maintain two bitmaps, one for the free entries and one for the entries
+AD4 +AD4 +AD4 +AD4   that are being freed.
+AD4 +AD4 +AD4 +AD4 - Protect all accesses to both bitmaps with the graph lock.
+AD4 +AD4 +AD4 +AD4 - zap+AF8-class() sets a bit in the +ACI-being freed+ACI bitmap for the entries that
+AD4 +AD4 +AD4 +AD4   should be freed after a GP.
+AD4 +AD4 +AD4 +AD4 - Instead of making free+AF8-zapped+AF8-classes() wait for a grace period by calling
+AD4 +AD4 +AD4 +AD4   synchronize+AF8-sched(), use call+AF8-rcu() and do the freeing work from inside the
+AD4 +AD4 +AD4 +AD4   RCU callback.
+AD4 +AD4 +AD4 +AD4 - From inside the RCU callback, set a bit in the +ACI-free+ACI bitmap for all entries
+AD4 +AD4 +AD4 +AD4   that have a bit set in the +ACI-being freed+ACI bitmap and clears the +ACI-being freed+ACI
+AD4 +AD4 +AD4 +AD4   bitmap.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 What happens when another unreg happens while the rcu+AF8-call thing is
+AD4 +AD4 +AD4 still pending?
+AD4 +AD4 
+AD4 +AD4 A new flag will have to keep track of whether or not an RCU callback has
+AD4 +AD4 already been scheduled via rcu+AF8-call() but not yet executed to avoid double
+AD4 +AD4 RCU call complaints.
+AD4
+AD4 That's not the only problem there. You either then have to synchronously
+AD4 wait for that flag / rcu+AF8-call to complete, or, if you modify the bitmap,
+AD4 ensure it re-queues itself for another GP before committing, which is
+AD4 starvation prone.

Can you have a look at free+AF8-zapped+AF8-classes() and schedule+AF8-free+AF8-zapped+AF8-classes()
in v2 of this patch series? In v2 the call+AF8-rcu(), manipulation of the boolean
and processing of the bitmaps are all protected by the graph
lock to avoid the issues that you described. See also
+ACo +AFs-PATCH v2 17/24+AF0 locking/lockdep: Free lock classes that are no longer in use
  (https://lore.kernel.org/lkml/20181204002833.55452-18-bvanassche+AEA-acm.org/).
+ACo +AFs-PATCH v2 18/24+AF0 locking/lockdep: Reuse list entries that are no longer in use
  (https://lore.kernel.org/lkml/20181204002833.55452-19-bvanassche+AEA-acm.org/).

Thanks,

Bart.
