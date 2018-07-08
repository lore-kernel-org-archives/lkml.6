Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E291C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D6C208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Vjux5r8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D6C208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932886AbeGHVDn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:03:43 -0400
Received: from mail.efficios.com ([167.114.142.138]:41954 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932233AbeGHVDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:03:40 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BFA431C3AC0;
        Sun,  8 Jul 2018 17:03:39 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id zxunytXbd-Di; Sun,  8 Jul 2018 17:03:39 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7C2111C3ABD;
        Sun,  8 Jul 2018 17:03:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7C2111C3ABD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1531083819;
        bh=7UBJEI3agCX2WNUSDU4MijcR0XDLSjmGnvzJ9lm6N84=;
        h=From:To:Date:Message-Id;
        b=Vjux5r8bTuK7AXYrQTSzvYXrhYy/6nUYEInGeCPRzCa62JLEDO3wcdbacZ60hBCq8
         Z9CCzUabI8ATAViHQRKUEHAqcg9v/jDeAHqCVDf763hV/WskDbZoZP0rbTugfnQpEn
         tWkBzFadHIJdvM0lW7oBIGz05nzXlqn3YOeZe5fOlqxZ+k+9akWFWOMo/gKx1+sz1a
         SRfWiYTu6r8J46AFLn3rrDBi0YwHj8IJw3M2s8k/LTdeUIIjVM5iO3PZ1YxQbsPx7r
         q0mmnXU7nh1MK8qlb7cxfMuzasbziYCqtwxiIBImYG8BOC9LLxDVLKBMGKStERAyUU
         mQQtkdPEsnIVQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id v_tlwv-ZI3hg; Sun,  8 Jul 2018 17:03:39 -0400 (EDT)
Received: from thinkos.etherlink (cable-192.222.247.4.electronicbox.net [192.222.247.4])
        by mail.efficios.com (Postfix) with ESMTPSA id 14F481C3AB7;
        Sun,  8 Jul 2018 17:03:39 -0400 (EDT)
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
Subject: [PATCH for 4.18 0/6] Restartable Sequences updates
Date:   Sun,  8 Jul 2018 17:03:24 -0400
Message-Id: <20180708210330.27324-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the recent discussion thread [1] about rseq uapi, here is
a set of updates submitted for integration into 4.18. Those change all
rseq __get_user/__put_user for get_user/put_user as discussed.

Thanks,

Mathieu

[1] https://lkml.kernel.org/r/20180702223143.4663-1-mathieu.desnoyers@efficios.com

Mathieu Desnoyers (6):
  rseq: use __u64 for rseq_cs fields, validate user inputs
  rseq: use get_user/put_user rather than __get_user/__put_user
  rseq: uapi: update uapi comments
  rseq: uapi: declare rseq_cs field as union, update includes
  rseq: remove unused types_32_64.h uapi header
  rseq/selftests: cleanup: update comment above rseq_prepare_unload

 include/uapi/linux/rseq.h           | 102 ++++++++++++++++++++----------------
 include/uapi/linux/types_32_64.h    |  50 ------------------
 kernel/rseq.c                       |  36 ++++++++-----
 tools/testing/selftests/rseq/rseq.h |  24 ++++++---
 4 files changed, 97 insertions(+), 115 deletions(-)
 delete mode 100644 include/uapi/linux/types_32_64.h

-- 
2.11.0

