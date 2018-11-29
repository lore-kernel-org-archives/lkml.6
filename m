Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D842BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53D32146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53D32146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbeK3EFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:05:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44052 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeK3EFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:05:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id k8so1316794pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 08:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ntjuzxDQaoj1fqs341rXyp+TCylgYbBYTRllogcm+6s=;
        b=EP1TsAx+Mfi4tpVPHItOU+e/6AO90cXPOYEF5mxQKHiDXDE2/agTtQ/M1/MzQQvjbh
         n2vdQtw7d3GI8LhvytlMfr3G7vf7ZUH0L1ndTSZLeooDdybSu+HJlXVeUZQ9ovfWXjqb
         7rh87opTw6nd9Zdf/aONTLrrDgvjx7f+g0sN59NKP/em5mKhfux3OkaJmh6jYaI+a9p7
         TAaiTSSWne6DwFqHJkhuN0ILgmhmXeWDTXKzkRiHwatE7V5hPNWO0EzgJXfHkx5IzKXl
         I7Imzh+F2/Q0DuvDTo4+hXIBUNHrH9wsAUP/xINb+6CYuxQC0nu+BXGezcmZW44zWj4L
         9b4g==
X-Gm-Message-State: AA+aEWYYfdWEatuZ+v0mEJxR5Iz6tM5U5SLkldySk4xYWmu/uxIyfLRH
        VZYsZ6BFLEJQa94woMaaKlI=
X-Google-Smtp-Source: AFSGD/UzcZaqxlXaS1SojyT3+L9XWhRUW2/iUn52UaSqBXIGXCD3p3AW14MmgfEe9aKXTzmUmm2hKA==
X-Received: by 2002:a17:902:f20d:: with SMTP id gn13mr2118760plb.11.1543510769173;
        Thu, 29 Nov 2018 08:59:29 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id t90sm9439247pfj.23.2018.11.29.08.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 08:59:28 -0800 (PST)
Message-ID: <1543510767.185366.145.camel@acm.org>
Subject: Re: [PATCH 25/27] locking/lockdep: Add support for dynamic keys
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 29 Nov 2018 08:59:27 -0800
In-Reply-To: <20181129120418.GI2131@hirez.programming.kicks-ass.net>
References: <20181128234325.110011-1-bvanassche@acm.org>
         <20181128234325.110011-26-bvanassche@acm.org>
         <20181129120418.GI2131@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-29 at 13:04 +-0100, Peter Zijlstra wrote:
+AD4 On Wed, Nov 28, 2018 at 03:43:23PM -0800, Bart Van Assche wrote:
+AD4 +AD4 A shortcoming of the current lockdep implementation is that it requires
+AD4 +AD4 lock keys to be allocated statically. That forces certain lock objects
+AD4 +AD4 to share lock keys. Since lock dependency analysis groups lock objects
+AD4 +AD4 per key sharing lock keys can cause false positive lockdep reports.
+AD4 +AD4 Make it possible to avoid such false positive reports by allowing lock
+AD4 +AD4 keys to be allocated dynamically. Require that dynamically allocated
+AD4 +AD4 lock keys are registered before use by calling lockdep+AF8-register+AF8-key().
+AD4 +AD4 Complain about attempts to register the same lock key pointer twice
+AD4 +AD4 without calling lockdep+AF8-unregister+AF8-key() between successive
+AD4 +AD4 registration calls.
+AD4 +AD4  struct lock+AF8-class+AF8-key +AHs
+AD4 +AD4 +-	struct hlist+AF8-node		hash+AF8-entry+ADs
+AD4 +AD4  	struct lockdep+AF8-subclass+AF8-key	subkeys+AFs-MAX+AF8-LOCKDEP+AF8-SUBCLASSES+AF0AOw
+AD4 +AD4  +AH0AOw
+AD4 
+AD4 That hash+AF8-entry is purely for that double-register warning, right? I
+AD4 wonder if we can do that differently+ADs by always doing
+AD4 register+AF8-lock+AF8-class(), and checking that state.

Hi Peter,

The hash+AF8-entry serves two purposes. One purpose is to verify whether the
lockdep+AF8-register+AF8-key() and  lockdep+AF8-unregister+AF8-key() functions are used
correctly. A second purpose is to avoid that lockdep+AF8-init+AF8-map() complains
when encountering a dynamically allocated key. I'm not sure how always
doing register+AF8-lock+AF8-class() would help?

Thanks,

Bart.
