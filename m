Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974DBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEAE20879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfAJNmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:42:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:39598 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728892AbfAJNmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:42:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0615FAD08;
        Thu, 10 Jan 2019 13:42:18 +0000 (UTC)
Date:   Thu, 10 Jan 2019 14:42:17 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 08/11] livepatch: Remove Nop structures when unused
In-Reply-To: <20190109124329.21991-9-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1901101441580.15065@pobox.suse.cz>
References: <20190109124329.21991-1-pmladek@suse.com> <20190109124329.21991-9-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019, Petr Mladek wrote:

> Replaced patches are removed from the stack when the transition is
> finished. It means that Nop structures will never be needed again
> and can be removed. Why should we care?
> 
>   + Nop structures give the impression that the function is patched
>     even though the ftrace handler has no effect.
> 
>   + Ftrace handlers do not come for free. They cause slowdown that might
>     be visible in some workloads. The ftrace-related slowdown might
>     actually be the reason why the function is no longer patched in
>     the new cumulative patch. One would expect that cumulative patch
>     would help solve these problems as well.
> 
>   + Cumulative patches are supposed to replace any earlier version of
>     the patch. The amount of NOPs depends on which version was replaced.
>     This multiplies the amount of scenarios that might happen.
> 
>     One might say that NOPs are innocent. But there are even optimized
>     NOP instructions for different processors, for example, see
>     arch/x86/kernel/alternative.c. And klp_ftrace_handler() is much
>     more complicated.
> 
>   + It sounds natural to clean up a mess that is no longer needed.
>     It could only be worse if we do not do it.
> 
> This patch allows to unpatch and free the dynamic structures independently
> when the transition finishes.
> 
> The free part is a bit tricky because kobject free callbacks are called
> asynchronously. We could not wait for them easily. Fortunately, we do
> not have to. Any further access can be avoided by removing them from
> the dynamic lists.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
