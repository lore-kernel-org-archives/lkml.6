Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E702C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CF02054F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CF02054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbeLGQXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:23:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44118 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGQXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:23:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id k8so2038753pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:23:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SVBKPU+WLIZANXgrY25SC+Zc5gKtdZ20GD7dij/o7o=;
        b=G64HFNNarSj/YElg2PlOeVhh9AfsmuWXpNdZhvVmLIZTTxL9dSAOVJrchAPXXahPSr
         4+CLGOonaONvdRFZc5ohIc3hHp2zDw5mzOt5rObEsN8E1FXCzsWgTW6udzJNo6Dm0nNa
         xmOj6ya2sZvhVG8G88JLB5YeKP/ZDYAGKYw4p4B1udrKm4anWHxYe6GSAgQqQ5zm5ufV
         PVuNS4aZaOBbyvX3RbAvm4+52eCRvRiFPOo2ZYezmo1OaTPZILHA1oDCqg8OK4GVHkuG
         2Y1ou5RE/guOdYNMaD9NqqTJUWt+lULvGInptVGaMXLGI0aHlRVTPmBQkd9kRoQgHLWa
         Vazw==
X-Gm-Message-State: AA+aEWZHM3NMzYd921yROFaO3ThWXEBMQVq0npn1QBEzihUBa8B6adLR
        f+XpBiLvVHH2Mq88OdPlOrwRnaNmHQo=
X-Google-Smtp-Source: AFSGD/WGHwhdHyCJYHYnwsX3S/JvE0ZFAdWWLlVzGC70KGvLFq1ijqs7vfaC3MQEIra1Qu/iSlTcQw==
X-Received: by 2002:a17:902:27e6:: with SMTP id i35mr2689457plg.222.1544199825915;
        Fri, 07 Dec 2018 08:23:45 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id c81sm7331620pfb.107.2018.12.07.08.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 08:23:45 -0800 (PST)
Message-ID: <1544199824.185366.304.camel@acm.org>
Subject: Re: [PATCH v3 16/24] locking/lockdep: Retain the class key and name
 while freeing a lock class
From:   Bart Van Assche <bvanassche@acm.org>
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Date:   Fri, 07 Dec 2018 08:23:44 -0800
In-Reply-To: <a681e9d4-7bf8-d919-f0ce-f4990f34d3af@redhat.com>
References: <20181207011148.251812-1-bvanassche@acm.org>
         <20181207011148.251812-17-bvanassche@acm.org>
         <20181207102143.GH2237@hirez.programming.kicks-ass.net>
         <a681e9d4-7bf8-d919-f0ce-f4990f34d3af@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-07 at 09:50 -0500, Waiman Long wrote:
+AD4 On 12/07/2018 05:21 AM, Peter Zijlstra wrote:
+AD4 +AD4 On Thu, Dec 06, 2018 at 05:11:40PM -0800, Bart Van Assche wrote:
+AD4 +AD4 +AD4 The next patch in this series uses the class name in code that
+AD4 +AD4 +AD4 detects calls to lock+AF8-acquire() while a class key is being freed. Hence
+AD4 +AD4 +AD4 retain the class name for lock classes that are being freed.
+AD4 +AD4 
+AD4 +AD4 From readin the discussion with v2+ADs you meant to say: 'uses the class
+AD4 +AD4 name pointer', right? You're not actually ever going to dereference it,
+AD4 +AD4 since that would be a UaF.
+AD4 +AD4 
+AD4 +AD4 +AD4 Cc: Peter Zijlstra +ADw-peterz+AEA-infradead.org+AD4
+AD4 +AD4 +AD4 Cc: Waiman Long +ADw-longman+AEA-redhat.com+AD4
+AD4 +AD4 +AD4 Cc: Johannes Berg +ADw-johannes+AEA-sipsolutions.net+AD4
+AD4 +AD4 +AD4 Signed-off-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 +AD4 +AD4 ---
+AD4 +AD4 +AD4  kernel/locking/lockdep.c +AHw 4 +----
+AD4 +AD4 +AD4  1 file changed, 1 insertion(+-), 3 deletions(-)
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
+AD4 +AD4 +AD4 index ecd92969674c..92bdb187987f 100644
+AD4 +AD4 +AD4 --- a/kernel/locking/lockdep.c
+AD4 +AD4 +AD4 +-+-+- b/kernel/locking/lockdep.c
+AD4 +AD4 +AD4 +AEAAQA -4147,10 +-4147,8 +AEAAQA static void zap+AF8-class(struct lock+AF8-class +ACo-class)
+AD4 +AD4 +AD4  	 +ACo Unhash the class and remove it from the all+AF8-lock+AF8-classes list:
+AD4 +AD4 +AD4  	 +ACo-/
+AD4 +AD4 +AD4  	hlist+AF8-del+AF8-rcu(+ACY-class-+AD4-hash+AF8-entry)+ADs
+AD4 +AD4 +AD4 +-	class-+AD4-hash+AF8-entry.pprev +AD0 NULL+ADs
+AD4 +AD4 +AD4  	list+AF8-del(+ACY-class-+AD4-lock+AF8-entry)+ADs
+AD4 +AD4 +AD4 -
+AD4 +AD4 +AD4 -	RCU+AF8-INIT+AF8-POINTER(class-+AD4-key, NULL)+ADs
+AD4 +AD4 +AD4 -	RCU+AF8-INIT+AF8-POINTER(class-+AD4-name, NULL)+ADs
+AD4 +AD4 +AD4  +AH0
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4  static inline int within(const void +ACo-addr, void +ACo-start, unsigned long size)
+AD4 +AD4 +AD4 -- 
+AD4 +AD4 +AD4 2.20.0.rc2.403.gdbc3b29805-goog
+AD4 +AD4 +AD4 
+AD4 
+AD4 I still prefer keeping the clearing statements. Leaving key behind
+AD4 should be OK as it is just a long value to be compared against. The
+AD4 variable name is a different story as it is a pointer that will
+AD4 reference bytes that it points to unless you save the name in a safe
+AD4 storage area and change the pointer to point there.

I will drop this patch and update later patches accordingly.

Bart.
