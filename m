Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED264C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE14D20672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE14D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeLCQkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:40:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34558 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeLCQkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:40:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so6747004plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 08:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SMBZOeekZb3uh8AV9mezX+bVJfI3gkOah5vXVRnPGL4=;
        b=EG/YS6Q65ZAkDkSSukLQ8B8bq4WRmxK/MqZyQgdhE+kCm1gTq/vbiRoHoUyCQse2kr
         9w25KyT68lI84B/+vCERle384WTmPiRfRJPM7YT/XKKOJSkVknr3VJOe7i2ppGFvDOoa
         QACo82cRB4+FpIEibjKh3zofS8te76+Z2Ii9iyvM9pR2ifZS0IjZFnBDKwX27BMKMpO9
         WzUXCqRbmnCvFiLz6BUv45hE7X2CDuYVjcUrYt6euDannQ/4TEsQIbGiezvrK8qyMMG+
         eGrfFqvwwCdBTc+Kk22HKumqzJ1ZQ42YV+EyaYDnUnNi8eZIixO1wsSWeLXap7a32uzN
         bOQQ==
X-Gm-Message-State: AA+aEWZhRI/R0vQhZ6YnPudz+SD9i8QpOEJCz3Uix6PYAG8IOOkC99cZ
        57PBT3NuQ0YYobnv75S5gJk=
X-Google-Smtp-Source: AFSGD/UInCKhPYmIxYsMlC8yWNwInOoI7iXbloeLHrYVgdIPj8FQ28E2/YBeMNL4ZaOHR0c9qQ0V7A==
X-Received: by 2002:a17:902:d806:: with SMTP id a6mr15993901plz.172.1543855250177;
        Mon, 03 Dec 2018 08:40:50 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id d6sm20450331pgc.89.2018.12.03.08.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 08:40:49 -0800 (PST)
Message-ID: <1543855248.185366.158.camel@acm.org>
Subject: Re: [PATCH 22/27] locking/lockdep: Reuse list entries that are no
 longer in use
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 03 Dec 2018 08:40:48 -0800
In-Reply-To: <20181201202446.GA19706@hirez.programming.kicks-ass.net>
References: <20181128234325.110011-1-bvanassche@acm.org>
         <20181128234325.110011-23-bvanassche@acm.org>
         <20181129104902.GH2131@hirez.programming.kicks-ass.net>
         <20181129120143.GG2149@hirez.programming.kicks-ass.net>
         <1543510130.185366.139.camel@acm.org>
         <20181201202446.GA19706@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-12-01 at 21:24 +-0100, Peter Zijlstra wrote:
+AD4 On Thu, Nov 29, 2018 at 08:48:50AM -0800, Bart Van Assche wrote:
+AD4 +AD4 On Thu, 2018-11-29 at 13:01 +-0100, Peter Zijlstra wrote:
+AD4 +AD4 +AD4 On Thu, Nov 29, 2018 at 11:49:02AM +-0100, Peter Zijlstra wrote:
+AD4 +AD4 +AD4 +AD4 On Wed, Nov 28, 2018 at 03:43:20PM -0800, Bart Van Assche wrote:
+AD4 +AD4 +AD4 +AD4 +AD4  	/+ACo
+AD4 +AD4 +AD4 +AD4 +AD4  	 +ACo Remove all dependencies this lock is
+AD4 +AD4 +AD4 +AD4 +AD4  	 +ACo involved in:
+AD4 +AD4 +AD4 +AD4 +AD4  	 +ACo-/
+AD4 +AD4 +AD4 +AD4 +AD4 +-	list+AF8-for+AF8-each+AF8-entry+AF8-safe(entry, tmp, +ACY-all+AF8-list+AF8-entries, alloc+AF8-entry) +AHs
+AD4 +AD4 +AD4 +AD4 +AD4  		if (entry-+AD4-class +ACEAPQ class +ACYAJg entry-+AD4-links+AF8-to +ACEAPQ class)
+AD4 +AD4 +AD4 +AD4 +AD4  			continue+ADs
+AD4 +AD4 +AD4 +AD4 +AD4  		links+AF8-to +AD0 entry-+AD4-links+AF8-to+ADs
+AD4 +AD4 +AD4 +AD4 +AD4  		WARN+AF8-ON+AF8-ONCE(entry-+AD4-class +AD0APQ links+AF8-to)+ADs
+AD4 +AD4 +AD4 +AD4 +AD4  		list+AF8-del+AF8-rcu(+ACY-entry-+AD4-lock+AF8-order+AF8-entry)+ADs
+AD4 +AD4 +AD4 +AD4 +AD4 +-		list+AF8-move(+ACY-entry-+AD4-alloc+AF8-entry, +ACY-free+AF8-list+AF8-entries)+ADs
+AD4 +AD4 +AD4 +AD4 +AD4  		entry-+AD4-class +AD0 NULL+ADs
+AD4 +AD4 +AD4 +AD4 +AD4  		entry-+AD4-links+AF8-to +AD0 NULL+ADs
+AD4 +AD4 +AD4 +AD4 +AD4  		check+AF8-free+AF8-class(zapped+AF8-classes, class)+ADs
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 Hurm.. I'm confused here.
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 The reason you cannot re-use lock+AF8-order+AF8-entry for the free list is
+AD4 +AD4 +AD4 +AD4 because list+AF8-del+AF8-rcu(), right? But if so, then what ensures the
+AD4 +AD4 +AD4 +AD4 list+AF8-entry is not re-used before it's grace-period?
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Also+ADs if you have to grow lock+AF8-list by 16 bytes just to be able to free
+AD4 +AD4 +AD4 it, a bitmap allocator is much cheaper, space wise.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Some people seem to really care about the static image size, and
+AD4 +AD4 +AD4 lockdep's .data section does matter to them.
+AD4 +AD4 
+AD4 +AD4 How about addressing this by moving removed list entries to a +ACI-zapped+AF8-entries+ACI
+AD4 +AD4 list and only moving list entries from the zapped+AF8-entries list to the
+AD4 +AD4 free+AF8-list+AF8-entries list after an RCU grace period? I'm not sure that it is
+AD4 +AD4 possible to implement that approach without introducing a new list+AF8-head in
+AD4 +AD4 struct lock+AF8-list.
+AD4 
+AD4 I think we can do this with a free bitmap and an array of 2 pending
+AD4 bitmaps and an index. Add newly freed entries to the pending bitmap
+AD4 indicated by the current index, when complete flip the index -- such
+AD4 that further new bits go to the other pending bitmap -- and call+AF8-rcu().
+AD4 
+AD4 Then, on the call+AF8-rcu() callback, ie. after a GP has happened, OR our
+AD4 pending bitmap into the free bitmap, and when the other pending bitmap
+AD4 isn't empty, flip the index again and start it all again.
+AD4 
+AD4 This ensures there is at least one full GP between setting a bit and it
+AD4 landing in the free mask.

Hi Peter,

How about the following alternative which requires only two bitmaps instead
of three:
- Maintain two bitmaps, one for the free entries and one for the entries
  that are being freed.
- Protect all accesses to both bitmaps with the graph lock.
- zap+AF8-class() sets a bit in the +ACI-being freed+ACI bitmap for the entries that
  should be freed after a GP.
- Instead of making free+AF8-zapped+AF8-classes() wait for a grace period by calling
  synchronize+AF8-sched(), use call+AF8-rcu() and do the freeing work from inside the
  RCU callback.
- From inside the RCU callback, set a bit in the +ACI-free+ACI bitmap for all entries
  that have a bit set in the +ACI-being freed+ACI bitmap and clears the +ACI-being freed+ACI
  bitmap.

Thanks,

Bart.
