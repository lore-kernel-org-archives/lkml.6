Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A88C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E8A20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E8A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeLCRHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:07:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42324 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbeLCRHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:07:08 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so5982978pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFJkM5XBvi3wb2HxvmOMvG0u+beYGog/eGkVjGSe4PQ=;
        b=EO2kjQ1w1qk6qYSyFsjvE182nUPWSHqGYBb94vvbG6Ttv4PPP5Noe22HKkt8zLRS4b
         zyl0HtsfaVuQrUwQfuSboRKDQXHCSfTo/cLnsiR9MFNEC9UJd8GnWKjp+ZcffuZunf9Y
         2hBeX2vnYN1/3SEF7HYZL8cIfzG6BO2p8g6Ijy6c4Nqei70RADJ8tDxdqfibig1GMHYP
         gTRSsEu8jGfjFjVTEe7u9YmIjv0x7o+g9LKiLgvQNCIYafkNba7OajLWRO5nLUcDlf6f
         gRkFaotLhxCifJMq5563W9ajwI9zQ3YBgkErBi7i8PSNmgbzjnImnMXEu8airNuFx/fX
         GsjQ==
X-Gm-Message-State: AA+aEWbg1irbCCH+4DZZgyLVtqeP4l98lFkyqBbLaiamLzIGmkra83UU
        xCL97Y9jODCZLpynkAnIgj0=
X-Google-Smtp-Source: AFSGD/W8Z130Y14fmgISnscmbBCZMXHuClgvMkoIKhZDt23TR+sDLgXVxkLCwkkrFySDtq+K5kJNVg==
X-Received: by 2002:a63:9e0a:: with SMTP id s10mr14028888pgd.239.1543856822790;
        Mon, 03 Dec 2018 09:07:02 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id l19sm30623477pfi.71.2018.12.03.09.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 09:07:02 -0800 (PST)
Message-ID: <1543856820.185366.159.camel@acm.org>
Subject: Re: [PATCH 25/27] locking/lockdep: Add support for dynamic keys
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 03 Dec 2018 09:07:00 -0800
In-Reply-To: <20181129101000.GF2131@hirez.programming.kicks-ass.net>
References: <20181128234325.110011-1-bvanassche@acm.org>
         <20181128234325.110011-26-bvanassche@acm.org>
         <20181129101000.GF2131@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-29 at 11:10 +-0100, Peter Zijlstra wrote:
+AD4 On Wed, Nov 28, 2018 at 03:43:23PM -0800, Bart Van Assche wrote:
+AD4 +AD4 +-/+ACo hash+AF8-entry is used to keep track of dynamically allocated keys. +ACo-/
+AD4 +AD4  struct lock+AF8-class+AF8-key +AHs
+AD4 +AD4 +-	struct hlist+AF8-node		hash+AF8-entry+ADs
+AD4 +AD4  	struct lockdep+AF8-subclass+AF8-key	subkeys+AFs-MAX+AF8-LOCKDEP+AF8-SUBCLASSES+AF0AOw
+AD4 +AD4  +AH0AOw
+AD4 
+AD4 One consideration+ADs and maybe we should have a BUILD+AF8-BUG for that, is
+AD4 that this object should be no larger than the smallest lock primitive.
+AD4 
+AD4 That typically is raw+AF8-spinlock+AF8-t, which normally is 4 bytes, but with
+AD4 lockdep on that at least also includes struct lockdep+AF8-map.
+AD4 
+AD4 So what we want is:
+AD4 
+AD4 	sizeof(lock+AF8-class+AF8-key) +ADwAPQ sizeof(raw+AF8-spinlock+AF8-t)
+AD4 
+AD4 Otherwise, two consecutive spinlocks could end up with key overlap in
+AD4 their subclass range.
+AD4 
+AD4 Now, I think that is still valid after this patch, but it is something
+AD4 that gave me pause.

How about adding this as an additional patch before patch 25/27?

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 9a7cca6dc3d4..ce05b9b419f4 100644
--- a/kernel/locking/lockdep.c
+-+-+- b/kernel/locking/lockdep.c
+AEAAQA -725,6 +-725,15 +AEAAQA static bool assign+AF8-lock+AF8-key(struct lockdep+AF8-map +ACo-lock)
 +AHs
 	unsigned long can+AF8-addr, addr +AD0 (unsigned long)lock+ADs
 
+-	/+ACo
+-	 +ACo lockdep+AF8-free+AF8-key+AF8-range() assumes that struct lock+AF8-class+AF8-key
+-	 +ACo objects do not overlap. Since we use the address of lock
+-	 +ACo objects as class key for static objects, check whether the
+-	 +ACo size of lock+AF8-class+AF8-key objects does not exceed the size of
+-	 +ACo the smallest lock object.
+-	 +ACo-/
+-	BUILD+AF8-BUG+AF8-ON(sizeof(struct lock+AF8-class+AF8-key) +AD4 sizeof(raw+AF8-spinlock+AF8-t))+ADs
+-
 	if (+AF8AXw-is+AF8-kernel+AF8-percpu+AF8-address(addr, +ACY-can+AF8-addr))
 		lock-+AD4-key +AD0 (void +ACo)can+AF8-addr+ADs
 	else if (+AF8AXw-is+AF8-module+AF8-percpu+AF8-address(addr, +ACY-can+AF8-addr))

Thanks,

Bart.
