Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDF9C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86FD20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86FD20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeLDVjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:39:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38757 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeLDVjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:39:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so8870438pfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 13:39:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uc1/0TDJORSzB8hIZZ+khrzCaKBg9pfjHabSJk5l1K8=;
        b=JVGrM/p1aJUqln28dKEXLxYgqs2gLuU32vNXDpDhr39CY27UiLSB7hZaAko915/s5d
         TyR7TZ1HNb8CL4CS5asID0nnb37oMkqdiShRJW2doyElckvdQS/4ItTli8VcHGClld6+
         Qx5IK3rQQMhBqnkOUpwPKi6JLDsvway53qjjINJpOxqMM8uItqVgg7yMxxpFszxY5sm9
         PCtKwTHKCtK3CaIg6FtgrGqGT8Fmk6XXnjhVkMjcZAbt7WKpXpodb/z5iJi+0gJ+5hXW
         YuhEuUI0RfwtgPh97FjWnpcClpVKsli4U+y3zFmB1e5q6fxRVgSceyoqUvObA7jLiTz8
         bTuw==
X-Gm-Message-State: AA+aEWZKFd0VrFy4e0QONpLeRnq0f2DkmCDgIiDM4GNgZ0sfNj7IYbvl
        ml2qsZMn3qqyFW4aAmhV9pw=
X-Google-Smtp-Source: AFSGD/VQ+hjRQ3anujZWG0KSQLUr1jir9Kv1M54CaP7OXeqvoCpcZlwXCSznG6G3Jy2tO6ARPNs3zQ==
X-Received: by 2002:a65:520a:: with SMTP id o10mr18774665pgp.276.1543959555798;
        Tue, 04 Dec 2018 13:39:15 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id n21sm7249811pfg.84.2018.12.04.13.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 13:39:15 -0800 (PST)
Message-ID: <1543959553.185366.213.camel@acm.org>
Subject: Re: [PATCH v2 21/24] locking/lockdep: Verify whether lock objects
 are small enough to be used as class keys
From:   Bart Van Assche <bvanassche@acm.org>
To:     Waiman Long <longman@redhat.com>, mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Date:   Tue, 04 Dec 2018 13:39:13 -0800
In-Reply-To: <8ae6bb3f-ab75-e6f2-adfa-8003366b7410@redhat.com>
References: <20181204002833.55452-1-bvanassche@acm.org>
         <20181204002833.55452-22-bvanassche@acm.org>
         <8ae6bb3f-ab75-e6f2-adfa-8003366b7410@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-04 at 16:08 -0500, Waiman Long wrote:
+AD4 On 12/03/2018 07:28 PM, Bart Van Assche wrote:
+AD4 +AD4 Cc: Peter Zijlstra +ADw-peterz+AEA-infradead.org+AD4
+AD4 +AD4 Cc: Waiman Long +ADw-longman+AEA-redhat.com+AD4
+AD4 +AD4 Cc: Johannes Berg +ADw-johannes+AEA-sipsolutions.net+AD4
+AD4 +AD4 Signed-off-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 +AD4 ---
+AD4 +AD4  kernel/locking/lockdep.c +AHw 9 +-+-+-+-+-+-+-+-+-
+AD4 +AD4  1 file changed, 9 insertions(+-)
+AD4 +AD4 
+AD4 +AD4 diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
+AD4 +AD4 index c936fce5b9d7..b4772e5fc176 100644
+AD4 +AD4 --- a/kernel/locking/lockdep.c
+AD4 +AD4 +-+-+- b/kernel/locking/lockdep.c
+AD4 +AD4 +AEAAQA -727,6 +-727,15 +AEAAQA static bool assign+AF8-lock+AF8-key(struct lockdep+AF8-map +ACo-lock)
+AD4 +AD4  +AHs
+AD4 +AD4  	unsigned long can+AF8-addr, addr +AD0 (unsigned long)lock+ADs
+AD4 +AD4  
+AD4 +AD4 +-	/+ACo
+AD4 +AD4 +-	 +ACo lockdep+AF8-free+AF8-key+AF8-range() assumes that struct lock+AF8-class+AF8-key
+AD4 +AD4 +-	 +ACo objects do not overlap. Since we use the address of lock
+AD4 +AD4 +-	 +ACo objects as class key for static objects, check whether the
+AD4 +AD4 +-	 +ACo size of lock+AF8-class+AF8-key objects does not exceed the size of
+AD4 +AD4 +-	 +ACo the smallest lock object.
+AD4 +AD4 +-	 +ACo-/
+AD4 +AD4 +-	BUILD+AF8-BUG+AF8-ON(sizeof(struct lock+AF8-class+AF8-key) +AD4 sizeof(raw+AF8-spinlock+AF8-t))+ADs
+AD4 +AD4 +-
+AD4 +AD4  	if (+AF8AXw-is+AF8-kernel+AF8-percpu+AF8-address(addr, +ACY-can+AF8-addr))
+AD4 +AD4  		lock-+AD4-key +AD0 (void +ACo)can+AF8-addr+ADs
+AD4 +AD4  	else if (+AF8AXw-is+AF8-module+AF8-percpu+AF8-address(addr, +ACY-can+AF8-addr))
+AD4 
+AD4 I don't understand what this check is for. lock+AF8-class+AF8-key and spinlock
+AD4 are different objects. Their relative size shouldn't matter.

Hi Waiman,

Peter asked me to add this check.

Bart.
