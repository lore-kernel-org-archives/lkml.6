Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id f6zYN+r7GluTAQAAmS7hNA
	; Fri, 08 Jun 2018 21:58:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4A447607E7; Fri,  8 Jun 2018 21:58:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BDC23605A2;
	Fri,  8 Jun 2018 21:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BDC23605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753005AbeFHV6Y (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 17:58:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36300 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752793AbeFHV6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 17:58:23 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9F9827F6;
        Fri,  8 Jun 2018 21:58:22 +0000 (UTC)
Date: Fri, 8 Jun 2018 14:58:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: penguin-kernel@I-love.SAKURA.ne.jp, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [PATCH] kernel/hung_task.c: allow to set period separately from
 timeout
Message-Id: <20180608145821.ec20a15944d1d19b683695e7@linux-foundation.org>
In-Reply-To: <20180608133043.203744-1-dvyukov@google.com>
References: <20180608133043.203744-1-dvyukov@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Jun 2018 15:30:43 +0200 Dmitry Vyukov <dvyukov@google.com> wrote:

> Currently task hung checking period is equal to timeout,
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
> Allow setting checking period separately from timeout.
> This allows to set timeout to, say, 3 minutes, but period to 10 secs.
> 
> The period is controlled via a new hung_task_period_secs sysctl,
> similar to the existing hung_task_timeout_secs sysctl.
> The default value of 0 results in the current behavior.

I'm rather struggling to understand the difference between "period" and
"timeout".  We would benefit from a clear description of what these two
things do.  An appropriate place for this description is
Documentation/sysctl/kernel.txt, which this patch forgot to update.
