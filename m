Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13F8C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3AE20882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C6hGXh5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3AE20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754526AbeGILr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:47:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754451AbeGILrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LLdq7Ocvwnb3CyWPAWj4U7DBytjDO1SdMwBJh8bZHBA=; b=C6hGXh5NKzne3qute+DAOX/A8
        tASqK1GMEpM8F//yziagg4ClbKb+6a1ps9nXtQZ3DpaHuvFUhjl+B5Q15S3A/B7mFkEjejnkH+mF8
        mHBUW8+GWcB6XBppMywfuXK9XS1HQMK8zg74F1nfjhJNZwU26UDZtsyWhugb0y6M+IOFqsaeZWaIM
        8i8/5qc3yAkbI4zC6fRv3vUuByMzeA71VQDQ8rnI0iyNF9lbgEApaNdhUM8iIq5LsUXgF0zRMoxn6
        MZnwqLRFomU7vrTGpm8pdUT/jTy2upomdtLV00Vhsy5S1ORwY6iOSAxeQPqTMECzxPJyBDGgB2fGg
        jPcWqyGnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcUdS-0006Q6-R8; Mon, 09 Jul 2018 11:47:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7D6420297EAB; Mon,  9 Jul 2018 13:47:16 +0200 (CEST)
Date:   Mon, 9 Jul 2018 13:47:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-next <linux-next@vger.kernel.org>,
        stephen Rothwell <sfr@canb.auug.org.au>,
        mpe <mpe@ellerman.id.au>, sachinp <sachinp@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [next-20180709][bisected 9cf57731][ppc] build fail with ld: BFD
 version 2.26.1-1.fc25 assertion fail elf64-ppc.c:14734
Message-ID: <20180709114716.GN2476@hirez.programming.kicks-ass.net>
References: <1531129883.6480.7.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531129883.6480.7.camel@abdul.in.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 03:21:23PM +0530, Abdul Haleem wrote:
> Greeting's
> 
> Today's next fails to build on powerpc with below error
> 
> kernel/cpu.o:(.data.rel+0x18e0): undefined reference to
> `lockup_detector_online_cpu'
> ld: BFD version 2.26.1-1.fc25 assertion fail elf64-ppc.c:14734
> kernel/cpu.o:(.data.rel+0x18e8): undefined reference to
> `lockup_detector_offline_cpu'
> ld: BFD version 2.26.1-1.fc25 assertion fail elf64-ppc.c:14734
> Makefile:1005: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1

Urgh, sorry about that. I think the below should cure that.

I got confused by all the varioud CONFIG options here abour and
conflated CONFIG_LOCKUP_DETECTOR and CONFIG_SOFTLOCKUP_DETECTOR it
seems.

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 80664bbeca43..08f9247e9827 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -33,15 +33,10 @@ extern int sysctl_hardlockup_all_cpu_backtrace;
 #define sysctl_hardlockup_all_cpu_backtrace 0
 #endif /* !CONFIG_SMP */
 
-extern int lockup_detector_online_cpu(unsigned int cpu);
-extern int lockup_detector_offline_cpu(unsigned int cpu);
-
 #else /* CONFIG_LOCKUP_DETECTOR */
 static inline void lockup_detector_init(void) { }
 static inline void lockup_detector_soft_poweroff(void) { }
 static inline void lockup_detector_cleanup(void) { }
-#define lockup_detector_online_cpu	NULL
-#define lockup_detector_offline_cpu	NULL
 #endif /* !CONFIG_LOCKUP_DETECTOR */
 
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
@@ -50,12 +45,18 @@ extern void touch_softlockup_watchdog(void);
 extern void touch_softlockup_watchdog_sync(void);
 extern void touch_all_softlockup_watchdogs(void);
 extern unsigned int  softlockup_panic;
-#else
+
+extern int lockup_detector_online_cpu(unsigned int cpu);
+extern int lockup_detector_offline_cpu(unsigned int cpu);
+#else /* CONFIG_SOFTLOCKUP_DETECTOR */
 static inline void touch_softlockup_watchdog_sched(void) { }
 static inline void touch_softlockup_watchdog(void) { }
 static inline void touch_softlockup_watchdog_sync(void) { }
 static inline void touch_all_softlockup_watchdogs(void) { }
-#endif
+
+#define lockup_detector_online_cpu	NULL
+#define lockup_detector_offline_cpu	NULL
+#endif /* CONFIG_SOFTLOCKUP_DETECTOR */
 
 #ifdef CONFIG_DETECT_HUNG_TASK
 void reset_hung_task_detector(void);
