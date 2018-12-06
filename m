Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911E9C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561EF2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561EF2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLFVzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:55:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56582 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeLFVzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:55:02 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 950F886D;
        Thu,  6 Dec 2018 21:55:01 +0000 (UTC)
Date:   Thu, 6 Dec 2018 13:54:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] Uprobes: Fix kernel oops with
 delayed_uprobe_remove()
Message-Id: <20181206135457.d934354e6c1fb5ab4f5c81cc@linux-foundation.org>
In-Reply-To: <20181206124719.1fa76d92@vmware.local.home>
References: <20181206124719.1fa76d92@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 12:47:19 -0500 Steven Rostedt <rostedt@goodmis.org> wrote:

> 
>     Uprobes: Fix kernel oops with delayed_uprobe_remove()
>     
>     There could be a race between task exit and probe unregister:
>     
>       exit_mm()
>       mmput()
>       __mmput()                     uprobe_unregister()
>       uprobe_clear_state()          put_uprobe()
>       delayed_uprobe_remove()       delayed_uprobe_remove()
>     
>     put_uprobe() is calling delayed_uprobe_remove() without taking
>     delayed_uprobe_lock and thus the race sometimes results in a
>     kernel crash. Fix this by taking delayed_uprobe_lock before
>     calling delayed_uprobe_remove() from put_uprobe().
>     
>     Detailed crash log can be found at:
>       Link: http://lkml.kernel.org/r/000000000000140c370577db5ece@google.com
>     
>     Link: http://lkml.kernel.org/r/20181205033423.26242-1-ravi.bangoria@linux.ibm.com
>     
>     Acked-by: Oleg Nesterov <oleg@redhat.com>
>     Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>     Reported-by: syzbot+cb1fb754b771caca0a88@syzkaller.appspotmail.com
>     Fixes: 1cc33161a83d ("uprobes: Support SDT markers having reference count (semaphore)")
>     Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>     Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 

No cc:stable?
