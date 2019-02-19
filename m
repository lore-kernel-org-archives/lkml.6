Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89927C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB6821479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dx+MhJkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfBSW6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:58:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44483 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbfBSW6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:58:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id w2so9175204wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 14:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qRZ7DgFO9hdvIFmo7GeMUf0dMxviGLl4hf9sqcm7NaA=;
        b=dx+MhJkt2qvxUfZs65EwGAVsnLZlI3oLgrBK+6IeVzZMjVZ+pdoJI5G7cQJYGUX2VD
         8yQ7e4cvYulL6OiqqBq5pJA8IVZFyt/ltKeKRDgjx1HcHtgH5bXD0e/+tOJ3KSQIDhJY
         LLZcSHxfIrslTp03qx8Qr3b0CSaX/71DoNGzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qRZ7DgFO9hdvIFmo7GeMUf0dMxviGLl4hf9sqcm7NaA=;
        b=Xd19AoECI1ZE4A51O/IwIN71yMljK2jequStStL/RR8174XdrPbqKfm4pR5GSqhsqc
         /bEQii+L1aYS0FUTQ8lspSuNm6UUjvx2JvACLVfXWzQ/0N/yHn93dYlH6X9QAfffWg//
         q02iwk8VvSBMRbsN9yocHdKkloqmIOv7oAaZivnz2UwKCC00Ew6uJ7y9NrMjPMgfeKvQ
         xJzCX/QIMZb6j+RBmqn98gvjdKdOGTAjZKuM16sTTXX+WuL8mtZkzP8XxmoCOB6BYp1j
         iBSyDbuA1mM+nbCiIDo/iwazCjAaTNoaoApH/ZRdEc7bVZvyRCANy8YPhQhzgJqnqE5E
         r5VA==
X-Gm-Message-State: AHQUAub59XcfT2C/nCOT5M6oBnInsNpIbggoXxAJ8xHUYk4tnDfRE0c9
        YBOc5Vrwr+TVhfRl+MPxFdm6t/irgeQI0A==
X-Google-Smtp-Source: AHgI3Ib5FAy830v9vC8zdvfpAEkC+GlCMVxca/ldYTn2paXiTnaZTe8fzlGVWxJH2Ark5CzkIpFD8g==
X-Received: by 2002:a5d:690d:: with SMTP id t13mr21387094wru.135.1550617078404;
        Tue, 19 Feb 2019 14:57:58 -0800 (PST)
Received: from localhost.localdomain ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id j5sm12335470wrw.59.2019.02.19.14.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Feb 2019 14:57:56 -0800 (PST)
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
Subject: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Date:   Tue, 19 Feb 2019 23:57:37 +0100
Message-Id: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove this subtle (and, AFAICT, unused) ordering: we can add it back,
if necessary, but let us not encourage people to rely on this thing.

For example, the following "exists" clause can be satisfied with this
change:

C dep-rfi

{ }

P0(int *x, int *y)
{
	WRITE_ONCE(*x, 1);
	smp_store_release(y, 1);
}

P1(int *x, int *y, int *z)
{
	int r0;
	int r1;
	int r2;

	r0 = READ_ONCE(*y);
	WRITE_ONCE(*z, r0);
	r1 = smp_load_acquire(z);
	r2 = READ_ONCE(*x);
}

exists (1:r0=1 /\ 1:r2=0)

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
 tools/memory-model/Documentation/explanation.txt | 28 ------------------------
 tools/memory-model/linux-kernel.cat              |  2 +-
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 68caa9a976d0c..965e11744d090 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1019,34 +1019,6 @@ section for more details).  The kernel includes a workaround for this
 problem when the loads come from READ_ONCE(), and therefore the LKMM
 includes address dependencies to loads in the ppo relation.
 
-On the other hand, dependencies can indirectly affect the ordering of
-two loads.  This happens when there is a dependency from a load to a
-store and a second, po-later load reads from that store:
-
-	R ->dep W ->rfi R',
-
-where the dep link can be either an address or a data dependency.  In
-this situation we know it is possible for the CPU to execute R' before
-W, because it can forward the value that W will store to R'.  But it
-cannot execute R' before R, because it cannot forward the value before
-it knows what that value is, or that W and R' do access the same
-location.  However, if there is merely a control dependency between R
-and W then the CPU can speculatively forward W to R' before executing
-R; if the speculation turns out to be wrong then the CPU merely has to
-restart or abandon R'.
-
-(In theory, a CPU might forward a store to a load when it runs across
-an address dependency like this:
-
-	r1 = READ_ONCE(ptr);
-	WRITE_ONCE(*r1, 17);
-	r2 = READ_ONCE(*r1);
-
-because it could tell that the store and the second load access the
-same location even before it knows what the location's address is.
-However, none of the architectures supported by the Linux kernel do
-this.)
-
 Two memory accesses of the same location must always be executed in
 program order if the second access is a store.  Thus, if we have
 
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 8dcb37835b613..6b9e3bb4e397f 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -62,7 +62,7 @@ let dep = addr | data
 let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int)
-let to-r = addr | (dep ; rfi)
+let to-r = addr ; [R]
 let fence = strong-fence | wmb | po-rel | rmb | acq-po
 let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
 
-- 
2.7.4

