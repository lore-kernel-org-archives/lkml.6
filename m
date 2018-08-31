Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E36C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872782083E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872782083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeHaMoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:44:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:51336 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727568AbeHaMoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:44:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49B7CAEBC;
        Fri, 31 Aug 2018 08:37:37 +0000 (UTC)
Date:   Fri, 31 Aug 2018 10:37:36 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 01/12] livepatch: Change void *new_func -> unsigned
 long new_addr in struct klp_func
In-Reply-To: <20180828143603.4442-2-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1808311034480.4783@pobox.suse.cz>
References: <20180828143603.4442-1-pmladek@suse.com> <20180828143603.4442-2-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018, Petr Mladek wrote:

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
> This patch changes void *new_func -> unsigned long new_addr. It removes
> some confusion when these address are later used in the code. It is
> motivated by a followup patch that adds special NOP struct klp_func
> where we want to assign func->new_func = func->old_addr respectively
> func->new_addr = func->old_addr.
> 
> This patch does not modify the existing behavior.
> 
> IMPORTANT: This patch modifies ABI. The patches will need to use,
> for example:
> 
>   static struct klp_func funcs[] = {
> 	{
> 		.old_name = "cmdline_proc_show",
> 		.new_addr = (unsigned long)livepatch_cmdline_proc_show,
> 	}, { }
>   };
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

I'm not convinced the patch makes things any better. The next patch 
slightly improves it, but still. Is new_func really such a problem?

Thanks,
Miroslav
