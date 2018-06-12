Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8BEDDC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32673208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fsGLItQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32673208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934604AbeFLQ3z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:29:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934016AbeFLQ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kBj5hFsNXN7Au0JROc14HhA5XkRjT84tybSeElJFAjw=; b=fsGLItQvZwc6qNucVUN6BNpy7
        AyLWSdVviHjwa+wzK+hf5epSIKAlQEdi0/8rUgtUv3hKOhe9QGk0A5otWdF3vxAFzndobq7ip8NOl
        m9SBmVH81a2NOngCM/icmpcfTSbeA08uIH4zgZWXA0HgKV02R9+Pellfz/xe6oCU2viahMkITUoBj
        KpOew16THgRIRi9S7NiulgE75jl9r7T/3Mp6LxBNhmQENtwtNvEwX7y00AQS86QaQx+9s16vQmUFp
        YbPnHRwyl+yZUYkjis/pHZ1LFSbuYwPgUPHpItirZ2Z9lYJFeVOmemjBUw3/bFPupKSPjjd0z+3Z4
        aO+Uu+1HQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSmAz-00035P-Uh; Tue, 12 Jun 2018 16:29:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C8126201EA7C9; Tue, 12 Jun 2018 18:29:43 +0200 (CEST)
Message-Id: <20180612161225.693133662@infradead.org>
User-Agent: quilt/0.63-1
Date:   Tue, 12 Jun 2018 18:12:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, oleg@redhat.com, gkohli@codeaurora.org
Cc:     tglx@linutronix.de, mpe@ellerman.id.au, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org
Subject: [PATCH v2 0/4] kthread/smpboot: More fixes...
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Changes since last time:

 - folded the smp_call_on_cpu() fix
 - re-add missing softlockup_threads_initialized check
 - rewrote changelog for completion revert


