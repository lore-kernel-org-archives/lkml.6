Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA51C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74706213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74706213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeK3Dyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:54:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32774 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbeK3Dyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:54:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so1324037plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 08:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3EKCWltQp9WsqHmasV3Xe4kRFXx9NhN8dwAF4P7BjE=;
        b=HJyDpPD2DuctSpz23tWIoXozpK5USAVQSzoH8QqoRReBfryiz0fkdjx1viSVCs0gn4
         2gLg/QM3bWcBfL7QM1bzJYlCz79tMOja5JRzPXnUA6U1vzeNRnNWEUBiATlhqPbUh8iM
         Q6DMo7SgdujJsGs3tbOfDJvo5MzeF92b6vhl1rBS7go1BxeR6f5WDk8n9nuHNy54iVr2
         KsX/8GECNbylF9+xibGx//1c5uIFzmGlKKoyialOU9SY44JDtmXsU1FYKlVkVT36A0nS
         NzNMkLtShpl+rWUNdIbouVDJIkzuJjclhk60utBLe9uC3JGs0YQQ60/21P3EJDQYC1tz
         +63Q==
X-Gm-Message-State: AA+aEWbc8qxrfQnGVazWMjHZfDwAppESDw/DNgXiQQ+TB6jGckt2emxV
        XHMSS5KP5aXJFUUME+mHIkg=
X-Google-Smtp-Source: AFSGD/WGIycoGoFeV6RdLvgdQ6ATapgg1m4AD+3NzLACoUPn8uHQrvyD2CGZbs0H9vX7lJRibplxsQ==
X-Received: by 2002:a17:902:2cc1:: with SMTP id n59-v6mr2227382plb.26.1543510132158;
        Thu, 29 Nov 2018 08:48:52 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id d3sm3162312pgl.64.2018.11.29.08.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 08:48:51 -0800 (PST)
Message-ID: <1543510130.185366.139.camel@acm.org>
Subject: Re: [PATCH 22/27] locking/lockdep: Reuse list entries that are no
 longer in use
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 29 Nov 2018 08:48:50 -0800
In-Reply-To: <20181129120143.GG2149@hirez.programming.kicks-ass.net>
References: <20181128234325.110011-1-bvanassche@acm.org>
         <20181128234325.110011-23-bvanassche@acm.org>
         <20181129104902.GH2131@hirez.programming.kicks-ass.net>
         <20181129120143.GG2149@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-29 at 13:01 +-0100, Peter Zijlstra wrote:
+AD4 On Thu, Nov 29, 2018 at 11:49:02AM +-0100, Peter Zijlstra wrote:
+AD4 +AD4 On Wed, Nov 28, 2018 at 03:43:20PM -0800, Bart Van Assche wrote:
+AD4 +AD4 +AD4  	/+ACo
+AD4 +AD4 +AD4  	 +ACo Remove all dependencies this lock is
+AD4 +AD4 +AD4  	 +ACo involved in:
+AD4 +AD4 +AD4  	 +ACo-/
+AD4 +AD4 +AD4 +-	list+AF8-for+AF8-each+AF8-entry+AF8-safe(entry, tmp, +ACY-all+AF8-list+AF8-entries, alloc+AF8-entry) +AHs
+AD4 +AD4 +AD4  		if (entry-+AD4-class +ACEAPQ class +ACYAJg entry-+AD4-links+AF8-to +ACEAPQ class)
+AD4 +AD4 +AD4  			continue+ADs
+AD4 +AD4 +AD4  		links+AF8-to +AD0 entry-+AD4-links+AF8-to+ADs
+AD4 +AD4 +AD4  		WARN+AF8-ON+AF8-ONCE(entry-+AD4-class +AD0APQ links+AF8-to)+ADs
+AD4 +AD4 +AD4  		list+AF8-del+AF8-rcu(+ACY-entry-+AD4-lock+AF8-order+AF8-entry)+ADs
+AD4 +AD4 +AD4 +-		list+AF8-move(+ACY-entry-+AD4-alloc+AF8-entry, +ACY-free+AF8-list+AF8-entries)+ADs
+AD4 +AD4 +AD4  		entry-+AD4-class +AD0 NULL+ADs
+AD4 +AD4 +AD4  		entry-+AD4-links+AF8-to +AD0 NULL+ADs
+AD4 +AD4 +AD4  		check+AF8-free+AF8-class(zapped+AF8-classes, class)+ADs
+AD4 +AD4 
+AD4 +AD4 Hurm.. I'm confused here.
+AD4 +AD4 
+AD4 +AD4 The reason you cannot re-use lock+AF8-order+AF8-entry for the free list is
+AD4 +AD4 because list+AF8-del+AF8-rcu(), right? But if so, then what ensures the
+AD4 +AD4 list+AF8-entry is not re-used before it's grace-period?
+AD4 
+AD4 Also+ADs if you have to grow lock+AF8-list by 16 bytes just to be able to free
+AD4 it, a bitmap allocator is much cheaper, space wise.
+AD4 
+AD4 Some people seem to really care about the static image size, and
+AD4 lockdep's .data section does matter to them.

How about addressing this by moving removed list entries to a +ACI-zapped+AF8-entries+ACI
list and only moving list entries from the zapped+AF8-entries list to the
free+AF8-list+AF8-entries list after an RCU grace period? I'm not sure that it is
possible to implement that approach without introducing a new list+AF8-head in
struct lock+AF8-list.

Thanks,

Bart.


