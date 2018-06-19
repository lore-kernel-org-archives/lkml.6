Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F56C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1593204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tbdUBCEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1593204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757246AbeFSNdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:33:05 -0400
Received: from mail.efficios.com ([167.114.142.138]:36336 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755616AbeFSNdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:33:03 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B812822BEB5;
        Tue, 19 Jun 2018 09:33:02 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id wQrbXvZjRwpO; Tue, 19 Jun 2018 09:33:02 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3201722BEAA;
        Tue, 19 Jun 2018 09:33:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3201722BEAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1529415182;
        bh=uxLjMneFOK6Na952HM7ivH1axggQZlSv6mxnAxDPAo4=;
        h=From:To:Date:Message-Id;
        b=tbdUBCEJprExsXMJxAUhOVCc4Czl7kkiLLXZ/+Hk7s9B6tZ49Er2lHSFV+nT3s8A9
         5I8nsyQ0vuglh+WbcYGU/g9+eNT00D63dMS235EEgHAWTZPYc7zOOBcjYSM1GBTHr+
         zHCwI3RpS0sU+ovHTTDC+TEtr7+38V0XHTVJDM7wd03qgS5KvFxeoCP6JCuyGHeIwv
         BUIM66dbMstrIa4Vwha+xm5z+12+fYiGcn4nROywN0rmsV51DcdA/N+SfnBWs3bf4U
         rIQSCwn7y6hGsBPF7dkc1MH+EZ7q6blUPigMM2U0WVZFf9Y6MwxUK6Cwyf1VuCWQ0S
         ctVO3/PrDuWRA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Dt9WZvtUcxeD; Tue, 19 Jun 2018 09:33:02 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id C1C4522BEA4;
        Tue, 19 Jun 2018 09:33:01 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH for 4.18 0/3] rseq: minor fixes, cleanup
Date:   Tue, 19 Jun 2018 09:32:27 -0400
Message-Id: <20180619133230.4087-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Those are 2 small fixes, and a cleanup to the rseq feature, targeting
4.18.

The first fix takes care of an issue that arose in the integration of
the rseq patchset (executable bit on run_param_test.sh was lost). The
second fix aligns struct rseq_cs on 32 bytes on arm32, following the
rseq.h alignment requirements.

The last patch is a cleanup: given that we have decided that system
calls were not allowed in rseq critical sections, fork/clone cannot
be done in a rseq c.s.. Therefore, there is no need to abort a rseq
critical section within the child on fork of a new process.

Thanks,

Mathieu


Mathieu Desnoyers (3):
  rseq/selftests: run_param_test.sh should be executable
  rseq/selftests: arm: align struct rseq_cs on 32 bytes
  rseq: cleanup: no need to abort rseq c.s. in child on fork

 include/linux/sched.h                          | 5 +----
 tools/testing/selftests/rseq/rseq-arm.h        | 1 +
 tools/testing/selftests/rseq/run_param_test.sh | 0
 3 files changed, 2 insertions(+), 4 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/rseq/run_param_test.sh

-- 
2.11.0

