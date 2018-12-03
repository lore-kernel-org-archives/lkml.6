Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC356C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864DE20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864DE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeLCNZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:25:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:47682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbeLCNZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:25:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 009BCAE1F;
        Mon,  3 Dec 2018 13:24:22 +0000 (UTC)
Date:   Mon, 3 Dec 2018 14:24:21 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 01/11] livepatch: Change unsigned long old_addr ->
 void *old_func in struct klp_func
In-Reply-To: <20181129094431.7801-2-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1812031339170.22317@pobox.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com> <20181129094431.7801-2-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018, Petr Mladek wrote:

> The address of the to be patched function and new function is stored
> in struct klp_func as:
> 
> 	void *new_func;
> 	unsigned long old_addr;
> 
> The different naming scheme and type is derived from the way how
> the addresses are set. @old_addr is assigned at runtime using
> kallsyms-based search. @new_func is statically initialized,
> for example:
> 
>   static struct klp_func funcs[] = {
> 	{
> 		.old_name = "cmdline_proc_show",
> 		.new_func = livepatch_cmdline_proc_show,
> 	}, { }
>   };
> 
> This patch changes unsigned log old_addr -> void *old_func. It removes
> some confusion when these address are later used in the code. It is
> motivated by a followup patch that adds special NOP struct klp_func
> where we want to assign func->new_func = func->old_addr respectively
> func->new_func = func->old_func.
> 
> This patch does not modify the existing behavior.
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/livepatch.h     |  4 ++--
>  kernel/livepatch/core.c       |  6 +++---
>  kernel/livepatch/patch.c      | 18 ++++++++++--------
>  kernel/livepatch/patch.h      |  2 +-
>  kernel/livepatch/transition.c |  4 ++--
>  5 files changed, 18 insertions(+), 16 deletions(-)

kernel/livepatch/patch.h also mentions old_addr in a comment.

You can add

Acked-by: Miroslav Benes <mbenes@suse.cz>

with that fixed.

Miroslav
