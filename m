Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB74C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3EB2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3EB2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeLDVHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:07:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40523 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLDVHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:07:14 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so8900537plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 13:07:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOscJnbMRSgVY/nIoZhX0nrGUR7QCsWT4vyVaYksfTM=;
        b=UUD3rGqHu/EHiXdraDUPFN6hHf5Clyqb14QseWCtXVP5uUNQ9oQi1kdHsdS9ow7hYL
         MvR15Q6JQ860C1eGD52DM2CWWm+URaKPbr+PlVhYrf1A/7Z+XLQ40ye9oSb2t5IwTnj5
         CcbKcfPEfLpTqGtfh1T0CKf9FQZnR+YWZQJAgHFD99eri0j59ujSTMVJ1843xr/L5rcD
         0/GHN5ZyQlUIQTrWKEOL2ViQXrAVDVn+h9JMv79wKHmkTWNDH2E7iajEsijkwaZCktQj
         Wko24aUtYr35nTrs/MdJaqn+Xa+vTDTq9s7WBhbuO5QOZXfOUt/h+G+f5Ns8qhcQBvcT
         YAWw==
X-Gm-Message-State: AA+aEWYolF4lZwj87oi8qwNNpMj4ncqmbaeZIs7aFhwHOEJoE/67rrMb
        siyhreoEN+WUhl+ZPS5r3dM=
X-Google-Smtp-Source: AFSGD/Xcp4Mevvz1QyCDTfpF/hnGMtZ1BMUdScZp7uCEXgPA8xMDRjNC4zEcDikngP86S3eqHxgqOQ==
X-Received: by 2002:a17:902:7201:: with SMTP id ba1mr21393210plb.105.1543957633103;
        Tue, 04 Dec 2018 13:07:13 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id x2sm39029638pfx.78.2018.12.04.13.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 13:07:12 -0800 (PST)
Message-ID: <1543957631.185366.212.camel@acm.org>
Subject: Re: [PATCH v2 16/24] locking/lockdep: Retain the class key and name
 while freeing a lock class
From:   Bart Van Assche <bvanassche@acm.org>
To:     Waiman Long <longman@redhat.com>, mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Date:   Tue, 04 Dec 2018 13:07:11 -0800
In-Reply-To: <adf9ddfe-d924-bc6c-dd62-ee3da83fb011@redhat.com>
References: <20181204002833.55452-1-bvanassche@acm.org>
         <20181204002833.55452-17-bvanassche@acm.org>
         <4eb2d1ad-14ee-0080-7736-aefdf69b4f29@redhat.com>
         <1543950509.185366.197.camel@acm.org>
         <adf9ddfe-d924-bc6c-dd62-ee3da83fb011@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-04 at 15:31 -0500, Waiman Long wrote:
+AD4 On 12/04/2018 02:08 PM, Bart Van Assche wrote:
+AD4 +AD4 On Tue, 2018-12-04 at 13:57 -0500, Waiman Long wrote:
+AD4 +AD4 +AD4 On 12/03/2018 07:28 PM, Bart Van Assche wrote:
+AD4 +AD4 +AD4 +AD4 The next patch in this series uses the class name in code that
+AD4 +AD4 +AD4 +AD4 detects lock class use-after-free. Hence retain the class name for
+AD4 +AD4 +AD4 +AD4 lock classes that are being freed.
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 Cc: Peter Zijlstra +ADw-peterz+AEA-infradead.org+AD4
+AD4 +AD4 +AD4 +AD4 Cc: Waiman Long +ADw-longman+AEA-redhat.com+AD4
+AD4 +AD4 +AD4 +AD4 Cc: Johannes Berg +ADw-johannes+AEA-sipsolutions.net+AD4
+AD4 +AD4 +AD4 +AD4 Signed-off-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 +AD4 +AD4 +AD4 ---
+AD4 +AD4 +AD4 +AD4  kernel/locking/lockdep.c +AHw 4 +----
+AD4 +AD4 +AD4 +AD4  1 file changed, 1 insertion(+-), 3 deletions(-)
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
+AD4 +AD4 +AD4 +AD4 index ecd92969674c..92bdb187987f 100644
+AD4 +AD4 +AD4 +AD4 --- a/kernel/locking/lockdep.c
+AD4 +AD4 +AD4 +AD4 +-+-+- b/kernel/locking/lockdep.c
+AD4 +AD4 +AD4 +AD4 +AEAAQA -4147,10 +-4147,8 +AEAAQA static void zap+AF8-class(struct lock+AF8-class +ACo-class)
+AD4 +AD4 +AD4 +AD4  	 +ACo Unhash the class and remove it from the all+AF8-lock+AF8-classes list:
+AD4 +AD4 +AD4 +AD4  	 +ACo-/
+AD4 +AD4 +AD4 +AD4  	hlist+AF8-del+AF8-rcu(+ACY-class-+AD4-hash+AF8-entry)+ADs
+AD4 +AD4 +AD4 +AD4 +-	class-+AD4-hash+AF8-entry.pprev +AD0 NULL+ADs
+AD4 +AD4 +AD4 +AD4  	list+AF8-del(+ACY-class-+AD4-lock+AF8-entry)+ADs
+AD4 +AD4 +AD4 +AD4 -page 
+AD4 +AD4 +AD4 +AD4 -	RCU+AF8-INIT+AF8-POINTER(class-+AD4-key, NULL)+ADs
+AD4 +AD4 +AD4 +AD4 -	RCU+AF8-INIT+AF8-POINTER(class-+AD4-name, NULL)+ADs
+AD4 +AD4 +AD4 +AD4  +AH0
+AD4 +AD4 +AD4 +AD4  
+AD4 +AD4 +AD4 +AD4  static inline int within(const void +ACo-addr, void +ACo-start, unsigned long size)
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Using the name after module unload can be problematic if it points to
+AD4 +AD4 +AD4 memory space occupied by the unloaded kernel module. The memory page may
+AD4 +AD4 +AD4 be invalid with the potential of crashing the kernel. You may have to
+AD4 +AD4 +AD4 duplicate the name if it is really from the module address space.
+AD4 +AD4 
+AD4 +AD4 The class name shouldn't be used by any of the code I introduced in the
+AD4 +AD4 lockdep infrastructure after unloading a kernel module finished unless if
+AD4 +AD4 some of the kernel module code is still running after unloading the kernel
+AD4 +AD4 module finished. I think if that happens that the kernel module author is
+AD4 +AD4 to blame and not lockdep :-)
+AD4 +AD4 
+AD4 +AD4 Bart.
+AD4 
+AD4 You do use the name once in a WARN+AF8-ON check in check+AF8-prev+AF8-add(). You
+AD4 commit log did say the class name will be used.

Hi Waiman,

I will update the commit message and I will add a comment in check+AF8-prev+AF8-add()
that explains that the newly added warning may trigger a use-after-free.

Bart.
