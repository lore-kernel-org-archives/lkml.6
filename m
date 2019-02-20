Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D11FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0E92147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfBTTfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:35:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfBTTfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:35:11 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 152F72146E;
        Wed, 20 Feb 2019 19:35:11 +0000 (UTC)
Date:   Wed, 20 Feb 2019 14:35:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <miaoxie@huawei.com>
Subject: Re: [PATCH] tracing: fix incorrect tracer freeing when opening
 tracing pipe
Message-ID: <20190220143509.6121f58c@gandalf.local.home>
In-Reply-To: <ed080680-ddac-3e99-720e-a8371fce5ab6@huawei.com>
References: <1550060946-45984-1-git-send-email-yi.zhang@huawei.com>
        <20190213083635.36f4762e@gandalf.local.home>
        <ed080680-ddac-3e99-720e-a8371fce5ab6@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Feb 2019 19:19:03 +0800
"zhangyi (F)" <yi.zhang@huawei.com> wrote:

> On 2019/2/13 21:36, Steven Rostedt Wrote:
> > On Wed, 13 Feb 2019 20:29:06 +0800
> > "zhangyi (F)" <yi.zhang@huawei.com> wrote:
> >   
> >> Commit d716ff71dd12 ("tracing: Remove taking of trace_types_lock in
> >> pipe files") use the current tracer instead of the copy in
> >> tracing_open_pipe(), but it forget to remove the freeing sentence in
> >> the error path.
> >>
> >> Fixes: d716ff71dd12 ("tracing: Remove taking of trace_types_lock in pipe files")  
> > 
> > Thanks.
> > 
> > As this is harmless (frees to NULL is ok, and iter is allocated with
> > kzalloc()), I'm going to just add this for the next merge window.
> >   
> 
> This patch patch want to remove kfree(iter->trace) instead of kfree(iter),
> which is set by tr->current_trace and probably not allocated dynamically.
> So if we kfree such tracer in the error path, it will lead to BUG_ON.
> 

This should have been mentioned in the change log. Anyway, I tagged it
for stable, but it will be pulled in during the next merge window, as
that shouldn't be too long from now.

-- Steve
