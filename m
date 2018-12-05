Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5B6C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03F42082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03F42082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeLEAGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:06:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36314 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLEAGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:06:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so8132077pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 16:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=opGOlGP3sGlUeufh899+PHdY0JQ4ek0ZzaceATUaKT0=;
        b=HRp0Amv01du82FCgnXyC45NTk8eN5glUsy/x4f+KXsitXRFN8UEpNN2+3QgPNjCLDp
         dt1pCYOkYKoVbqg82UyWYx48tIojm8ub884ZJW4k8uwoJN5e7sgzNpx9JcuxnvbGbwrf
         tBSBuEPyFEfXaROStJDGK+foshZqDyUzt0T4IbMzNwEAbK4KKPvwiVw/sNcDkLG01kY/
         5bg+HCjwP2ivG6aSN/G0/KgILxS4uOlU6YV6UH3OdwVRWLPTosRv7WLMemIkBK1Tm/zh
         ePYv96Cda6iQikJj+QlH4W9T5+V3LLyofcD5awJvZdgogx4tno87RQ7NpaXYlePwILnL
         sEmA==
X-Gm-Message-State: AA+aEWY17k0jeGc4IB/FiQgTknFZUFXXl1xOaD+6A12Ydwq4o2a4X+qz
        Ogpk08AhxVPuPWWoTTlNjyc=
X-Google-Smtp-Source: AFSGD/U4t/HXtqXa8dfDHu3SeMl8j9dWKsDxkyHTEu6oPiNIJXGHSHOV2mh9S8GizEDNcYXc/5J/Yg==
X-Received: by 2002:a63:134f:: with SMTP id 15mr18422225pgt.19.1543968375206;
        Tue, 04 Dec 2018 16:06:15 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id k38sm29396400pgb.33.2018.12.04.16.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 16:06:14 -0800 (PST)
Message-ID: <1543968373.185366.222.camel@acm.org>
Subject: Re: [PATCH v2 21/24] locking/lockdep: Verify whether lock objects
 are small enough to be used as class keys
From:   Bart Van Assche <bvanassche@acm.org>
To:     Waiman Long <longman@redhat.com>, mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Date:   Tue, 04 Dec 2018 16:06:13 -0800
In-Reply-To: <0fbedd8d-6eec-051d-b2fd-5246dc47b477@redhat.com>
References: <20181204002833.55452-1-bvanassche@acm.org>
         <20181204002833.55452-22-bvanassche@acm.org>
         <8ae6bb3f-ab75-e6f2-adfa-8003366b7410@redhat.com>
         <1543959553.185366.213.camel@acm.org>
         <0fbedd8d-6eec-051d-b2fd-5246dc47b477@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-04 at 16:50 -0500, Waiman Long wrote:
+AD4 On 12/04/2018 04:39 PM, Bart Van Assche wrote:
+AD4 +AD4 On Tue, 2018-12-04 at 16:08 -0500, Waiman Long wrote:
+AD4 +AD4 +AD4 On 12/03/2018 07:28 PM, Bart Van Assche wrote:
+AD4 +AD4 +AD4 +AD4 Cc: Peter Zijlstra +ADw-peterz+AEA-infradead.org+AD4
+AD4 +AD4 +AD4 +AD4 Cc: Waiman Long +ADw-longman+AEA-redhat.com+AD4
+AD4 +AD4 +AD4 +AD4 Cc: Johannes Berg +ADw-johannes+AEA-sipsolutions.net+AD4
+AD4 +AD4 +AD4 +AD4 Signed-off-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 +AD4 +AD4 +AD4 ---
+AD4 +AD4 +AD4 +AD4  kernel/locking/lockdep.c +AHw 9 +-+-+-+-+-+-+-+-+-
+AD4 +AD4 +AD4 +AD4  1 file changed, 9 insertions(+-)
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
+AD4 +AD4 +AD4 +AD4 index c936fce5b9d7..b4772e5fc176 100644
+AD4 +AD4 +AD4 +AD4 --- a/kernel/locking/lockdep.c
+AD4 +AD4 +AD4 +AD4 +-+-+- b/kernel/locking/lockdep.c
+AD4 +AD4 +AD4 +AD4 +AEAAQA -727,6 +-727,15 +AEAAQA static bool assign+AF8-lock+AF8-key(struct lockdep+AF8-map +ACo-lock)
+AD4 +AD4 +AD4 +AD4  +AHs
+AD4 +AD4 +AD4 +AD4  	unsigned long can+AF8-addr, addr +AD0 (unsigned long)lock+ADs
+AD4 +AD4 +AD4 +AD4  
+AD4 +AD4 +AD4 +AD4 +-	/+ACo
+AD4 +AD4 +AD4 +AD4 +-	 +ACo lockdep+AF8-free+AF8-key+AF8-range() assumes that struct lock+AF8-class+AF8-key
+AD4 +AD4 +AD4 +AD4 +-	 +ACo objects do not overlap. Since we use the address of lock
+AD4 +AD4 +AD4 +AD4 +-	 +ACo objects as class key for static objects, check whether the
+AD4 +AD4 +AD4 +AD4 +-	 +ACo size of lock+AF8-class+AF8-key objects does not exceed the size of
+AD4 +AD4 +AD4 +AD4 +-	 +ACo the smallest lock object.
+AD4 +AD4 +AD4 +AD4 +-	 +ACo-/
+AD4 +AD4 +AD4 +AD4 +-	BUILD+AF8-BUG+AF8-ON(sizeof(struct lock+AF8-class+AF8-key) +AD4 sizeof(raw+AF8-spinlock+AF8-t))+ADs
+AD4 +AD4 +AD4 +AD4 +-
+AD4 +AD4 +AD4 +AD4  	if (+AF8AXw-is+AF8-kernel+AF8-percpu+AF8-address(addr, +ACY-can+AF8-addr))
+AD4 +AD4 +AD4 +AD4  		lock-+AD4-key +AD0 (void +ACo)can+AF8-addr+ADs
+AD4 +AD4 +AD4 +AD4  	else if (+AF8AXw-is+AF8-module+AF8-percpu+AF8-address(addr, +ACY-can+AF8-addr))
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 I don't understand what this check is for. lock+AF8-class+AF8-key and spinlock
+AD4 +AD4 +AD4 are different objects. Their relative size shouldn't matter.
+AD4 +AD4 
+AD4 +AD4 Peter asked me to add this check.
+AD4 
+AD4 I haven't finished reviewing all your patches yet. Maybe one of the
+AD4 subsequent patches requires this. If that is the case, you should move
+AD4 this patch after that.

Hi Waiman,

The existing (v4.20-rc5) code and the comment I added should be sufficient to
understand this patch.

Bart.
