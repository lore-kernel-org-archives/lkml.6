Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA65DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A23F213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ypnd8Pqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBYMxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:53:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39428 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfBYMxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PRswsRkkODz5hjbqO9yT9YXrBykXNq9Oiz0pisqRrqE=; b=ypnd8PqmTUB0pEdlbkhTldSQPz
        QtKQWSOzO+ugjmZE2/nuhT9CbU1+HXOG/F/sbrxKV4TO3ZgBQ2su0kiIdP5TDXe+RDOmuywnmkeNS
        FqOYLUejgo9epDbaKzkFFtwrcl6okQkQgtpYGF2LUGJrzbi8iqkBettJZz/vqWh+0lr5HC4aOnC6r
        5CBVcBAV7KbZ+6E7Iz82OAx3WhtFelkAATgAcIOYFyo79Y+23p+WBKFOMxt2Knv8zdUlBLQOVIA9w
        7pvCYNCyIxNuA6wIlO0VINyGfL4kSNlNRlGsotUfz4lYnk07TPR4V9Oep5yxTYKNQcXd3kCOvNSCJ
        MvSZOPSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyFkm-0006MN-5B; Mon, 25 Feb 2019 12:53:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 992F220277F83; Mon, 25 Feb 2019 13:53:02 +0100 (CET)
Message-Id: <20190225125231.845656645@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 25 Feb 2019 13:43:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 1/6] x86/uaccess: Dont evaluate argument inside AC region
References: <20190225124330.613028745@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AC regions are special, make sure we don't do possibly complex
evaluations there.

Probably-Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/uaccess.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -431,8 +431,10 @@ do {									\
 ({								\
 	__label__ __pu_label;					\
 	int __pu_err = -EFAULT;					\
+	__typeof__(*(ptr)) __pu_val;				\
+	__pu_val = x;						\
 	__uaccess_begin();					\
-	__put_user_size((x), (ptr), (size), __pu_label);	\
+	__put_user_size(__pu_val, (ptr), (size), __pu_label);	\
 	__pu_err = 0;						\
 __pu_label:							\
 	__uaccess_end();					\


