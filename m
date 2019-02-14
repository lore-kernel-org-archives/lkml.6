Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B37C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28732229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502110AbfBNP35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:29:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45840 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfBNP35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:29:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF4E080D;
        Thu, 14 Feb 2019 07:29:56 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 888523F575;
        Thu, 14 Feb 2019 07:29:55 -0800 (PST)
From:   Quentin Perret <quentin.perret@arm.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, joelaf@google.com,
        smuckle@google.com, dietmar.eggemann@arm.com,
        quentin.perret@arm.com
Subject: [PATCH v2] tracing: Fix number of entries in trace header
Date:   Thu, 14 Feb 2019 15:29:50 +0000
Message-Id: <20190214152950.4179-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214150130.3162-1-quentin.perret@arm.com>
References: <20190214150130.3162-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit

  441dae8f2f29 ("tracing: Add support for display of tgid in trace output")

removed the call to print_event_info() from print_func_help_header_irq()
which results in the ftrace header not reporting the number of entries
written in the buffer. As this wasn't the original intent of the patch,
re-introduce the call to print_event_info() to restore the orginal
behaviour.

Fixes: 441dae8f2f29 ("tracing: Add support for display of tgid in trace output")
Cc: 4.13+ <stable@vger.kernel.org> # v4.13+
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Acked-by: Joel Fernandes <joelaf@google.com>
---
 kernel/trace/trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c521b7347482..c4238b441624 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3384,6 +3384,8 @@ static void print_func_help_header_irq(struct trace_buffer *buf, struct seq_file
 	const char tgid_space[] = "          ";
 	const char space[] = "  ";
 
+	print_event_info(buf, m);
+
 	seq_printf(m, "#                          %s  _-----=> irqs-off\n",
 		   tgid ? tgid_space : space);
 	seq_printf(m, "#                          %s / _----=> need-resched\n",
-- 
2.20.1

