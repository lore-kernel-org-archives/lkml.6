Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA409C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6819820882
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6819820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeGZCVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbeGZCVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:21:35 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9695C20685;
        Thu, 26 Jul 2018 01:07:17 +0000 (UTC)
Date:   Wed, 25 Jul 2018 21:07:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>, kernel-team@android.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] tracing: do not leak kernel addresses
Message-ID: <20180725210717.3b807191@vmware.local.home>
In-Reply-To: <20180725202238.165314-1-salyzyn@android.com>
References: <20180725202238.165314-1-salyzyn@android.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 13:22:36 -0700
Mark Salyzyn <salyzyn@android.com> wrote:

> From: Nick Desaulniers <ndesaulniers@google.com>
> 
> Switch from 0x%lx to 0x%pK to print the kernel addresses.
> 
> Fixes: CVE-2017-0630

Wait!!!! This breaks perf and trace-cmd! They require this to be able
to print various strings in trace events. This file is root read only,
as the CVE says.

NAK for this fix. Come up with something that doesn't break perf and
trace-cmd. That will not be trivial, as the format is stored in the
ring buffer with an address, then referenced directly. It also handles
trace_printk() functions that simply point to the string format itself.

A fix would require having a pointer be the same that is referenced
inside the kernel as well as in this file. Maybe make the format string
placed in a location that doesn't leak where the rest of the kernel
exists?

-- Steve



> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: <kernel-team@android.com>
> Cc: <stable@vger.kernel.org> # 3.18, 4.4, 4.9, 4.14
> Cc: <linux-kernel@vger.kernel.org>
> 
> ---
>  kernel/trace/trace_printk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
> index ad1d6164e946..93698023baf1 100644
> --- a/kernel/trace/trace_printk.c
> +++ b/kernel/trace/trace_printk.c
> @@ -304,7 +304,7 @@ static int t_show(struct seq_file *m, void *v)
>  	if (!*fmt)
>  		return 0;
>  
> -	seq_printf(m, "0x%lx : \"", *(unsigned long *)fmt);
> +	seq_printf(m, "0x%pK : \"", *(unsigned long *)fmt);
>  
>  	/*
>  	 * Tabs and new lines need to be converted.

