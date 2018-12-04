Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2086C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732CF2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732CF2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbeLDTId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:08:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35360 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDTIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:08:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so7812214pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:08:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oRFkMER/NxfR4LleR4odihu+6+heQYuypWJEES8aSF4=;
        b=T06y8fLQmIDdXrvE8iOWolrrK5U1heW+srkGAvhz2/IW6TEbhK5+xF5mXp6uVuvQs8
         bR7xgFKlxRenE+GcwFNF0NpuUtQ2EWj0Rb+bf+tGXL8lMvDrC5WFOQHlBfNVBQ2rBC+z
         2IT3kWyeicUhlUh4gTzXqssbD6cUb8Mz+MD/XLx2pZ1fJDNegI3DmPmNWpoZy+YjIsRA
         2Zm+CwagcNE3y37HNmoltAWYmHmkqvP4ApogUAe/FnoyjFpNcWq9O3DhVlU7vlnXe36K
         xJgWcaoIRPy2bE34xbvusUldly+5q5Evc7mABaSmskPGmeOzNyUJgnHAbsRgs6aQmvmp
         itaw==
X-Gm-Message-State: AA+aEWY3pyoVzVpHG5k7LQS20LI3HmPH95x4RBnD+WDdSrK5kTrfh9Yt
        9TqHy6zc8Z+nt8+xKFsa0+M=
X-Google-Smtp-Source: AFSGD/WSEd2dca/Th3eh4QECAXUhiqmyBIZomQQrffsTINpHM0cDoyGjjYmUmMXnVgjPvbTxpdclRQ==
X-Received: by 2002:a62:4e49:: with SMTP id c70mr20978922pfb.167.1543950511455;
        Tue, 04 Dec 2018 11:08:31 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s4sm24595923pgp.13.2018.12.04.11.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 11:08:30 -0800 (PST)
Message-ID: <1543950509.185366.197.camel@acm.org>
Subject: Re: [PATCH v2 16/24] locking/lockdep: Retain the class key and name
 while freeing a lock class
From:   Bart Van Assche <bvanassche@acm.org>
To:     Waiman Long <longman@redhat.com>, mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Date:   Tue, 04 Dec 2018 11:08:29 -0800
In-Reply-To: <4eb2d1ad-14ee-0080-7736-aefdf69b4f29@redhat.com>
References: <20181204002833.55452-1-bvanassche@acm.org>
         <20181204002833.55452-17-bvanassche@acm.org>
         <4eb2d1ad-14ee-0080-7736-aefdf69b4f29@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-04 at 13:57 -0500, Waiman Long wrote:
+AD4 On 12/03/2018 07:28 PM, Bart Van Assche wrote:
+AD4 +AD4 The next patch in this series uses the class name in code that
+AD4 +AD4 detects lock class use-after-free. Hence retain the class name for
+AD4 +AD4 lock classes that are being freed.
+AD4 +AD4 
+AD4 +AD4 Cc: Peter Zijlstra +ADw-peterz+AEA-infradead.org+AD4
+AD4 +AD4 Cc: Waiman Long +ADw-longman+AEA-redhat.com+AD4
+AD4 +AD4 Cc: Johannes Berg +ADw-johannes+AEA-sipsolutions.net+AD4
+AD4 +AD4 Signed-off-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 +AD4 ---
+AD4 +AD4  kernel/locking/lockdep.c +AHw 4 +----
+AD4 +AD4  1 file changed, 1 insertion(+-), 3 deletions(-)
+AD4 +AD4 
+AD4 +AD4 diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
+AD4 +AD4 index ecd92969674c..92bdb187987f 100644
+AD4 +AD4 --- a/kernel/locking/lockdep.c
+AD4 +AD4 +-+-+- b/kernel/locking/lockdep.c
+AD4 +AD4 +AEAAQA -4147,10 +-4147,8 +AEAAQA static void zap+AF8-class(struct lock+AF8-class +ACo-class)
+AD4 +AD4  	 +ACo Unhash the class and remove it from the all+AF8-lock+AF8-classes list:
+AD4 +AD4  	 +ACo-/
+AD4 +AD4  	hlist+AF8-del+AF8-rcu(+ACY-class-+AD4-hash+AF8-entry)+ADs
+AD4 +AD4 +-	class-+AD4-hash+AF8-entry.pprev +AD0 NULL+ADs
+AD4 +AD4  	list+AF8-del(+ACY-class-+AD4-lock+AF8-entry)+ADs
+AD4 +AD4 -page 
+AD4 +AD4 -	RCU+AF8-INIT+AF8-POINTER(class-+AD4-key, NULL)+ADs
+AD4 +AD4 -	RCU+AF8-INIT+AF8-POINTER(class-+AD4-name, NULL)+ADs
+AD4 +AD4  +AH0
+AD4 +AD4  
+AD4 +AD4  static inline int within(const void +ACo-addr, void +ACo-start, unsigned long size)
+AD4 
+AD4 Using the name after module unload can be problematic if it points to
+AD4 memory space occupied by the unloaded kernel module. The memory page may
+AD4 be invalid with the potential of crashing the kernel. You may have to
+AD4 duplicate the name if it is really from the module address space.

The class name shouldn't be used by any of the code I introduced in the
lockdep infrastructure after unloading a kernel module finished unless if
some of the kernel module code is still running after unloading the kernel
module finished. I think if that happens that the kernel module author is
to blame and not lockdep :-)

Bart.
