Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D388C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0723F22EC0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="iSVqkZLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0723F22EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753961AbeGESGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:06:14 -0400
Received: from mail.efficios.com ([167.114.142.138]:58540 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753677AbeGESGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:06:11 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0A64B231D26;
        Thu,  5 Jul 2018 14:06:11 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id nXMELTCUQPmt; Thu,  5 Jul 2018 14:06:10 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9E5DD231D1D;
        Thu,  5 Jul 2018 14:06:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9E5DD231D1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530813970;
        bh=i4xPsqVfC20YC2S80/KenZzzoCDeNPO1J2MQe28ccUo=;
        h=From:To:Date:Message-Id;
        b=iSVqkZLTY9UDGZDaO4Nuc2rJLISkA0EurW/1dPQIT3SsFiOfJJ1obaYw5NBceBZIL
         MH7gRNZ1JFCS7ZDSj+dauAYd2svDNgnkX2ymYGjNh8jxFcl1ZrwEdqQax7CZZ9/QQ1
         LphxizJF8lMDkCZTaKrKdJkiY7+wTN4o1+O03/J9oKK9mk8bA9riXvLuxfQDfo0Dfw
         PzR3+Z/5cIeynRAq/clURiDtwWbfCvrs+SCeGvaRkBVPRHnSi52OAIq59ECIyqYa/G
         kTbzZrkYEAKwBuG2smLbO2elXg+gsaLgchjdbc4jOtTpyIlZkFsG0XNCSoHcPXBdbv
         AvJ/sd9J/AorA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id W0wwOdHIwFMs; Thu,  5 Jul 2018 14:06:10 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 281C7231D17;
        Thu,  5 Jul 2018 14:06:10 -0400 (EDT)
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
Subject: [RFC PATCH for 4.18 0/5] Restartable Sequences updates
Date:   Thu,  5 Jul 2018 14:05:56 -0400
Message-Id: <20180705180601.18423-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the recent discussion thread [1] about rseq uapi, here is
a set of updates submitted for comments.

Thanks,

Mathieu

[1] https://lkml.kernel.org/r/20180702223143.4663-1-mathieu.desnoyers@efficios.com

Mathieu Desnoyers (5):
  rseq: use __u64 for rseq_cs fields, validate user inputs
  rseq: uapi: update uapi comments
  rseq: uapi: declare rseq_cs field as union, update includes
  rseq: remove unused types_32_64.h uapi header
  rseq/selftests: cleanup: update comment above rseq_prepare_unload

 include/uapi/linux/rseq.h           | 102 ++++++++++++++++++++----------------
 include/uapi/linux/types_32_64.h    |  50 ------------------
 kernel/rseq.c                       |  26 +++++----
 tools/testing/selftests/rseq/rseq.h |  24 ++++++---
 4 files changed, 92 insertions(+), 110 deletions(-)
 delete mode 100644 include/uapi/linux/types_32_64.h

-- 
2.11.0

