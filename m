Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8EE22C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BD120693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R8FpeeKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BD120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933865AbeFLIjj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:39:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933363AbeFLIjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FktaZlZuMCbz+LHDjiRLJcHbvpmQDD3LtjTUiAcU4kc=; b=R8FpeeKieRTY3U4DJE4u3Nl1I
        gZ1sP7nmytU5PBGU4/9aif4OmgNhgth6WJ2SMWWMvDleJzSmHvAgvfwTcbun0fbBNkkHF2IdCRzVM
        mVJNwhf6QV9Z7PfS6Vxfwo1K73kH/ZLVI1aVAJDuMi+v2QdvPPiz3TVkTSYTJRNHsitTdHEXXKeN5
        MvUa5NuU1Bt3OxPWHlfJqS6fqAsGct+CSsWm+kVKBRhmUCgYPmO0e+tNf8tonxPswhncz/OmWXuZU
        hJaGQltXbVxawv0YAzXsNv88BfXs+dz1NiakKMyFGO1OkwspY92Av1rNngA53l5YOR3q6ozwq8AkS
        13o9QyMqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSepu-0001z3-VI; Tue, 12 Jun 2018 08:39:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7398C201EA7CB; Tue, 12 Jun 2018 10:39:28 +0200 (CEST)
Message-Id: <20180612083449.100099222@infradead.org>
User-Agent: quilt/0.63-1
Date:   Tue, 12 Jun 2018 10:34:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, bigeasy@linutronix.de, oleg@redhat.com,
        paulmck@linux.vnet.ibm.com, pbonzini@redhat.com
Subject: [PATCH 0/3] sched/swait: Convert to full exclusive mode
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned by Linus, swait is exclusive mode and had better behave like it
and be named like it.

Make it so.

---
 arch/mips/kvm/mips.c         |  4 ++--
 arch/powerpc/kvm/book3s_hv.c |  6 +++---
 arch/s390/kvm/interrupt.c    |  2 +-
 arch/x86/kernel/kvm.c        |  4 ++--
 arch/x86/kvm/lapic.c         |  2 +-
 include/linux/swait.h        | 36 ++++++++++++++++++------------------
 kernel/power/suspend.c       |  4 ++--
 kernel/rcu/srcutiny.c        |  4 ++--
 kernel/rcu/tree.c            |  8 ++++----
 kernel/rcu/tree_exp.h        |  4 ++--
 kernel/rcu/tree_plugin.h     | 12 ++++++------
 kernel/sched/swait.c         | 32 ++++++++++++++++++++++----------
 virt/kvm/arm/arm.c           |  4 ++--
 virt/kvm/arm/psci.c          |  2 +-
 virt/kvm/async_pf.c          |  2 +-
 virt/kvm/kvm_main.c          |  4 ++--
 16 files changed, 71 insertions(+), 59 deletions(-)


