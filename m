Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D40C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83433204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="MqL7zOp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83433204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757297AbeFSNdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:33:08 -0400
Received: from mail.efficios.com ([167.114.142.138]:36418 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755921AbeFSNdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:33:04 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7074E22BED0;
        Tue, 19 Jun 2018 09:33:03 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id ObasYV7wy09u; Tue, 19 Jun 2018 09:33:02 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8F1A822BEB2;
        Tue, 19 Jun 2018 09:33:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8F1A822BEB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1529415182;
        bh=dc7ioORrLkLrc6wQCUC+eJzUO5Shuwci3kT0nPVw+W4=;
        h=From:To:Date:Message-Id;
        b=MqL7zOp6h7/gni4H0/Qg/LC4KWu2eKV6kVHMUogr5FUXiQfBUUCaG8GsON0owy+Hd
         GNUry5jvTvUZbuoLMAdXZEaXopFiGI8JVtnqttdcA9K3eBcS/+PxavzAktVBK3xCUB
         nmpQCvSCrsT76Awk5/0siyZ3RDmhfpsr3DlORVicTmi1vivGNWu3xx+Que+FkelfAw
         3wWPp1KKOn3lS2bwGIECdsu3QK6AVRIlv/Y13B7lLVhpwK/bEINSPU7ELQzRJBXyq9
         X6XvZ28Pq+0CndlG2cMnkesiY/STk6EnaHI5lxBUMlzbeYs7nvQBCdSzP7dfvBjKig
         pRWX+rhyO+9+w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id HUBaosOlRGsO; Tue, 19 Jun 2018 09:33:02 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 288FA22BEA6;
        Tue, 19 Jun 2018 09:33:02 -0400 (EDT)
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kselftest@vger.kernel.org, Andrew Hunter <ahh@google.com>
Subject: [PATCH for 4.18 1/3] rseq/selftests: run_param_test.sh should be executable
Date:   Tue, 19 Jun 2018 09:32:28 -0400
Message-Id: <20180619133230.4087-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180619133230.4087-1-mathieu.desnoyers@efficios.com>
References: <20180619133230.4087-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The executable bit of the run_param_test.sh script got lost in
the merge.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: linux-kselftest@vger.kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Chris Lameter <cl@linux.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Andrew Hunter <ahh@google.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Maurer <bmaurer@fb.com>
Cc: linux-api@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 tools/testing/selftests/rseq/run_param_test.sh | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/rseq/run_param_test.sh

diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
old mode 100644
new mode 100755
-- 
2.11.0

