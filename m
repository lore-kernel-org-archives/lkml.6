Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2D7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6752148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6752148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbeKTIUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:20:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47066 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731286AbeKTIUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:20:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so14400624pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 13:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vRH0G4d2svT35SadVTfW/F6JFbG59SEiS8zKIIQR1w8=;
        b=kbpTm43BotrOKxc8n9/9hEafvI3/1ki/5+VVvQoZzva30vP9M91TQlP+HOaHQx6Ihb
         5ovr+mnoiF5Fs18TCcH3vlBBe3fTNcP/QwZh2fSEnxMCBIUiLC65P3JVwoNqyf3jy/ym
         qk1NIO0JpWHbAR1QVfF+vQSuD3I72ap0cfT/vXFKZW4u45JIxhxxRLipLsrbmB7BUCA0
         o9m/TtHCa4QvuJQXm1N95nAxtWsvYJ3zkil9l3iiORAUi3iSTmunJqVgTv80GsKc+vws
         UljYugmrrEpymAfPLHvPFI/H38uv2vTh0Z7VdJCmhak9rlBdSemMDdTvEOX2Wefc9ufk
         Hf9A==
X-Gm-Message-State: AGRZ1gLiYgtwtIPGExef0ev3W3wMtOvlt2UYyq80d+LCafHHDP/gyen7
        mkoyq0ESfgC3jtFeRyujmk4=
X-Google-Smtp-Source: AJdET5esgxM9g7fc5YXKiqFlcXU7CqEgbycnH+W43cEmkpRakHAy5UbBPMx9Ur932fxvXB2EW38y9A==
X-Received: by 2002:a63:d34a:: with SMTP id u10mr22066759pgi.301.1542664508492;
        Mon, 19 Nov 2018 13:55:08 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id l187-v6sm46870861pfc.79.2018.11.19.13.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 13:55:07 -0800 (PST)
Message-ID: <1542664506.185366.64.camel@acm.org>
Subject: Re: [PATCH 1/2] locking/lockdep: Add support for dynamic depmaps
 and keys
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>, Tejun Heo <tj@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Date:   Mon, 19 Nov 2018 13:55:06 -0800
In-Reply-To: <20181110135524.GC3339@worktop.programming.kicks-ass.net>
References: <20181109234645.10530-1-bvanassche@acm.org>
         <20181109234645.10530-2-bvanassche@acm.org>
         <20181110135524.GC3339@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-11-10 at 14:55 +-0100, Peter Zijlstra wrote:
+AD4 On Fri, Nov 09, 2018 at 03:46:44PM -0800, Bart Van Assche wrote:
+AD4 +AD4 The lock validator forces to categorize multiple instances of a lock object
+AD4 +AD4 as the same lock class because it requires that struct lockdep+AF8-map and struct
+AD4 +AD4 lock+AF8-class+AF8-key instances are static objects. This can result in false
+AD4 +AD4 positive lockdep reports that are hard to suppress in an elegant way. Hence
+AD4 +AD4 add support for allocating instances of these objects dynamically.
+AD4 
+AD4 Yeah, I think not. You completely fail to explain how what you propose
+AD4 is correct.
+AD4 
+AD4 The thing is+ADs we rely on static objects because they provide
+AD4 persistence. Their address will never be re-used.
+AD4 
+AD4 Dynamic objects do not provide this same guarantee. And when you re-use
+AD4 the key address for something else, you'll mix the chains and things
+AD4 come unstuck.

Hi Peter,

Thanks for having taken a look. I will rework this patch taking your feedback
into account and will post the new version when it's ready.

Bart.

