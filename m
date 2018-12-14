Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD79C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450FE206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbeLNRUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:20:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34206 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbeLNRUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:20:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so3152421pfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GgG/Dnrx3e525piF+R/oGlRGGahEq+bXEqAf4dRGg6A=;
        b=Cxu+RjM5RmH+uTzN4uB38evdWuiNouMAw8Gq7d54Go93sKnmDOLmLSfUf6Mbv6C9hN
         KKSjcHgryORKU2dcpCokr+okHgzuXeNfSonpQdATIPj2d5SZZm/jup2n31i4w9MP6g01
         LpFZ+z/rFWp7YfcTcSNCq5rBENwr/EEaq/GPoz9aGOpQVx6RWenLgI6VGon8OXEXVSpu
         4jRZhe27VW6UP6X934jCf1tvuXM9FOtsWX/4XlD8qYajKEqh2MQ4Z4fL/5ktIs/DMsBB
         g6yoNpeleSDWE7+Yg1SbG7BtSwl4XJIuX2ETgPikL6mZBH6KTpevSBnjRI7UhdVyDh2f
         4BzA==
X-Gm-Message-State: AA+aEWbh/gWLHATeMxQNZRQnr955uXlSXNsh3Ks44A8W4agUPXraWhZ+
        Ra0Xz+JG5uzhSLNR0Inh/B4=
X-Google-Smtp-Source: AFSGD/Vl713MBeRU3byHFDerWxg2HC3L4fNEOt8vMMpx45Lwxeg6qYYcBgF0p7x0DYnwqFatMdOOIA==
X-Received: by 2002:a62:dbc2:: with SMTP id f185mr3551329pfg.235.1544808006882;
        Fri, 14 Dec 2018 09:20:06 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 64sm6655676pff.101.2018.12.14.09.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 09:20:04 -0800 (PST)
Message-ID: <1544808002.185366.414.camel@acm.org>
Subject: Re: [PATCH v4 13/15] locking/lockdep: Add support for dynamic keys
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Date:   Fri, 14 Dec 2018 09:20:02 -0800
In-Reply-To: <20181211221321.196536-14-bvanassche@acm.org>
References: <20181211221321.196536-1-bvanassche@acm.org>
         <20181211221321.196536-14-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-11 at 14:13 -0800, Bart Van Assche wrote:
+AD4 +-/+ACo
+AD4 +- +ACo Unregister a dynamically allocated key. Must not be called from interrupt
+AD4 +- +ACo context. The caller must ensure that freeing +AEA-key only happens after an RCU
+AD4 +- +ACo grace period.
+AD4 +- +ACo-/
+AD4 +-void lockdep+AF8-unregister+AF8-key(struct lock+AF8-class+AF8-key +ACo-key)
+AD4 +-+AHs
+AD4 +-	struct hlist+AF8-head +ACo-hash+AF8-head +AD0 keyhashentry(key)+ADs
+AD4 +-	struct lock+AF8-class+AF8-key +ACo-k+ADs
+AD4 +-	struct pending+AF8-free +ACo-pf+ADs
+AD4 +-	unsigned long flags+ADs
+AD4 +-	bool found +AD0 false+ADs
+AD4 +-
+AD4 +-	might+AF8-sleep()+ADs
+AD4 +-
+AD4 +-	if (WARN+AF8-ON+AF8-ONCE(static+AF8-obj(key)))
+AD4 +-		return+ADs
+AD4 +-
+AD4 +-	pf +AD0 get+AF8-pending+AF8-free+AF8-lock(+ACY-flags)+ADs
+AD4 +-	if (WARN+AF8-ON+AF8-ONCE(+ACE-pf))
+AD4 +-		return+ADs
+AD4 +-	hlist+AF8-for+AF8-each+AF8-entry+AF8-rcu(k, hash+AF8-head, hash+AF8-entry) +AHs
+AD4 +-		if (k +AD0APQ key) +AHs
+AD4 +-			hlist+AF8-del+AF8-rcu(+ACY-k-+AD4-hash+AF8-entry)+ADs
+AD4 +-			found +AD0 true+ADs
+AD4 +-			break+ADs
+AD4 +-		+AH0
+AD4 +-	+AH0
+AD4 +-	WARN+AF8-ON+AF8-ONCE(+ACE-found)+ADs
+AD4 +-	+AF8AXw-lockdep+AF8-free+AF8-key+AF8-range(pf, key, 1)+ADs
+AD4 +-	schedule+AF8-free+AF8-zapped+AF8-classes(pf)+ADs
+AD4 +-	graph+AF8-unlock()+ADs
+AD4 +-	raw+AF8-local+AF8-irq+AF8-restore(flags)+ADs
+AD4 +-+AH0
+AD4 +-EXPORT+AF8-SYMBOL+AF8-GPL(lockdep+AF8-unregister+AF8-key)+ADs

Since is+AF8-dynamic+AF8-key() has been modified from using locking into using RCU, a
synchronize+AF8-rcu() call needs to be added at the end of lockdep+AF8-unregister+AF8-key().
I will repost this patch series if the 0-day test infrastructure is happy with
the new version.

Bart.
