Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B2BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F417821479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dNIo0tN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfBSWzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:55:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44320 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbfBSWzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:55:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id w2so9171092wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 14:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s4hPtNIW+4JpE4krGVUXkCHrfjClFqO96IlJ54/CCjE=;
        b=dNIo0tN55G1gOruc7lEOLHA0LlbAk8TSo7vTYj02grU4RHevrmvV6PI2iixRZ0v7sX
         y9MagNvvYBMTzlgVKBFGYOasxGJnFL+tvQfgFeqYxZKYg1Xus8KZ3BgsNiMYZk2Tc0uM
         W786sA2PL7yAKzaQvG0edaQt6f+OLVNSienpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s4hPtNIW+4JpE4krGVUXkCHrfjClFqO96IlJ54/CCjE=;
        b=hdTZFuqCxi19t9kI94uvgjEFmQiy0NdxahxSYBA2AlrQH3tRbqcT4+9+hi/MeTUM6x
         OQiZSS7pLGFPF8cJm3/WSoTwrJ++xfhHMru/AuKC0ULrkVYhBwa2sWrIVfLKhXyXdvgy
         fwCUCVJOHL6/bBOLB/eFYOGNQ6bP/uBxKcczGTmtuZ5w8NI/BDPIQMdERsnGRTWtFO94
         2onicIhjk2c0taAvttnEue+R4w7QvAAAxsIdJAW8gZQyroxmFKW3VMvF0CzmdlzaqBH6
         Z+BgURtvzTOncA82+zKK6ElWt6+63dn4TwIVpAxa25flWT5TS/C/7MMncN8lA+x8tauG
         GjQg==
X-Gm-Message-State: AHQUAuZUECOenIsRxXfgqBMUIjDMgK1qoZyCN/CEB0J/cKTHjoDTN6IS
        a1TkdLEsdznW2ZzUfTxUJ6Z5a0dlqz40Ow==
X-Google-Smtp-Source: AHgI3IZiGD2rUaPzTIE+OKDDw3SMpOcyYY+mwi+sj7tn/fhEOW8eVXBwbzVcxhP4WWcHgBbojTwDuw==
X-Received: by 2002:adf:c7c6:: with SMTP id y6mr21798453wrg.217.1550616941215;
        Tue, 19 Feb 2019 14:55:41 -0800 (PST)
Received: from localhost.localdomain ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id b3sm7073951wme.27.2019.02.19.14.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Feb 2019 14:55:40 -0800 (PST)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: [PATCH 1/2] tools/memory-model: Fix comment in MP+poonceonces.litmus
Date:   Tue, 19 Feb 2019 23:55:22 +0100
Message-Id: <1550616923-4795-2-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550616923-4795-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1550616923-4795-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment should say "Sometimes" for the result.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
---
 tools/memory-model/litmus-tests/MP+poonceonces.litmus | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
index b2b60b84fb9dc..172f0145301c5 100644
--- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
@@ -1,7 +1,7 @@
 C MP+poonceonces
 
 (*
- * Result: Maybe
+ * Result: Sometimes
  *
  * Can the counter-intuitive message-passing outcome be prevented with
  * no ordering at all?
-- 
2.7.4

