Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE00C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D18214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfAJXhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:37:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:33586 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730276AbfAJXhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:37:50 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D6FA01237;
        Thu, 10 Jan 2019 23:37:48 +0000 (UTC)
Date:   Thu, 10 Jan 2019 15:37:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2] kernel: release ptraced tasks before
 zap_pid_ns_processes
Message-Id: <20190110153747.75787a99b380f415ee38d145@linux-foundation.org>
In-Reply-To: <20190110175200.12442-1-avagin@gmail.com>
References: <20190110175200.12442-1-avagin@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 09:52:00 -0800 Andrei Vagin <avagin@gmail.com> wrote:

> Currently, exit_ptrace() adds all ptraced tasks in a dead list, than
> zap_pid_ns_processes() waits all tasks in a current pidns, and only
> then tasks from the dead list are released.
> 
> zap_pid_ns_processes() can stuck on waiting tasks from the dead list. In
> this case, we will have one unkillable process with one or more dead
> children.
> 
> Thanks to Oleg for the advice to release tasks in find_child_reaper().
> 
> Fixes: 7c8bd2322c7f ("exit: ptrace: shift "reap dead" code from exit_ptrace() to forget_original_parent()")
> 
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

Does this warrant a -stable backport?  7c8bd2322c7f was 4+ years ago...
