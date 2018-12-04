Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A542C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BD02081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BD02081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeLDQIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:08:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:41434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726954AbeLDQIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:08:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C69E2ADFE;
        Tue,  4 Dec 2018 16:08:04 +0000 (UTC)
Date:   Tue, 4 Dec 2018 17:08:03 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 08/11] livepatch: Remove Nop structures when unused
In-Reply-To: <20181129094431.7801-9-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1812041707430.8063@pobox.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com> <20181129094431.7801-9-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018, Petr Mladek wrote:

> Replaced patches are removed from the stack when the transition is
> finished. It means that Nop structures will never be needed again
> and can be removed. Why should we care?
> 
>   + Nop structures make false feeling that the function is patched
>     even though the ftrace handler has no effect.
> 
>   + Ftrace handlers are not completely for free. They cause slowdown that
>     might be visible in some workloads. The ftrace-related slowdown might
>     actually be the reason why the function is not longer patched in
>     the new cumulative patch. One would expect that cumulative patch
>     would allow to solve these problems as well.
> 
>   + Cumulative patches are supposed to replace any earlier version of
>     the patch. The amount of NOPs depends on which version was replaced.
>     This multiplies the amount of scenarios that might happen.
> 
>     One might say that NOPs are innocent. But there are even optimized
>     NOP instructions for different processor, for example, see
>     arch/x86/kernel/alternative.c. And klp_ftrace_handler() is much
>     more complicated.
> 
>   + It sounds natural to clean up a mess that is not longer needed.
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

M
