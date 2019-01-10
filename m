Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB4CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A762120879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfAJN4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:56:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:41882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727753AbfAJN4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:56:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 10440ACBC;
        Thu, 10 Jan 2019 13:56:32 +0000 (UTC)
Date:   Thu, 10 Jan 2019 14:56:31 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 10/11] livepatch: Remove ordering (stacking) of the
 livepatches
In-Reply-To: <20190109124329.21991-11-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1901101456150.15065@pobox.suse.cz>
References: <20190109124329.21991-1-pmladek@suse.com> <20190109124329.21991-11-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019, Petr Mladek wrote:

> The atomic replace and cumulative patches were introduced as a more secure
> way to handle dependent patches. They simplify the logic:
> 
>   + Any new cumulative patch is supposed to take over shadow variables
>     and changes made by callbacks from previous livepatches.
> 
>   + All replaced patches are discarded and the modules can be unloaded.
>     As a result, there is only one scenario when a cumulative livepatch
>     gets disabled.
> 
> The different handling of "normal" and cumulative patches might cause
> confusion. It would make sense to keep only one mode. On the other hand,
> it would be rude to enforce using the cumulative livepatches even for
> trivial and independent (hot) fixes.
> 
> However, the stack of patches is not really necessary any longer.
> The patch ordering was never clearly visible via the sysfs interface.
> Also the "normal" patches need a lot of caution anyway.
> 
> Note that the list of enabled patches is still necessary but the ordering
> is not longer enforced.
> 
> Otherwise, the code is ready to disable livepatches in an random order.
> Namely, klp_check_stack_func() always looks for the function from
> the livepatch that is being disabled. klp_func structures are just
> removed from the related func_stack. Finally, the ftrace handlers
> is removed only when the func_stack becomes empty.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
