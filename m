Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86FAC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D22420836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D22420836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbeFSXDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:03:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39834 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeFSXD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:03:29 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8DC3BD10;
        Tue, 19 Jun 2018 23:03:28 +0000 (UTC)
Date:   Tue, 19 Jun 2018 16:03:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     penguin-kernel@I-love.SAKURA.ne.jp, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [PATCH v2] kernel/hung_task.c: allow to set checking interval
 separately from timeout
Message-Id: <20180619160327.b6ca2389401f421116c155ad@linux-foundation.org>
In-Reply-To: <20180611111004.203513-1-dvyukov@google.com>
References: <20180611111004.203513-1-dvyukov@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018 13:10:04 +0200 Dmitry Vyukov <dvyukov@google.com> wrote:

> Currently task hung checking interval is equal to timeout,
> as the result hung is detected anywhere between timeout and 2*timeout.
> This is fine for most interactive environments, but this hurts automated
> testing setups (syzbot). In an automated setup we need to strictly order
> CPU lockup < RCU stall < workqueue lockup < task hung < silent loss,
> so that RCU stall is not detected as task hung and task hung is not
> detected as silent machine loss. The large variance in task hung
> detection timeout requires setting silent machine loss timeout to
> a very large value (e.g. if task hung is 3 mins, then silent loss
> need to be set to ~7 mins). The additional 3 minutes significantly
> reduce testing efficiency because usually we crash kernel within
> a minute, and this can add hours to bug localization process as it
> needs to do dozens of tests.
> 
> Allow setting checking interval separately from timeout.
> This allows to set timeout to, say, 3 minutes,
> but checking interval to 10 secs.
> 
> The interval is controlled via a new hung_task_check_interval_secs
> sysctl, similar to the existing hung_task_timeout_secs sysctl.
> The default value of 0 results in the current behavior:
> checking interval is equal to timeout.

I suppose we shoold do this:

--- a/kernel/sysctl.c~kernel-hung_taskc-allow-to-set-checking-interval-separately-from-timeout-fix
+++ a/kernel/sysctl.c
@@ -145,7 +145,10 @@ static int minolduid;
 static int ngroups_max = NGROUPS_MAX;
 static const int cap_last_cap = CAP_LAST_CAP;
 
-/*this is needed for proc_doulongvec_minmax of sysctl_hung_task_timeout_secs */
+/*
+ * This is needed for proc_doulongvec_minmax of sysctl_hung_task_timeout_secs
+ * and hung_task_check_interval_secs
+ */
 #ifdef CONFIG_DETECT_HUNG_TASK
 static unsigned long hung_task_timeout_max = (LONG_MAX/HZ);
 #endif

