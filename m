Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97CBC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72CC2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbfAIOfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:35:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:33886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729829AbfAIOfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:35:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B128AD4C;
        Wed,  9 Jan 2019 14:35:51 +0000 (UTC)
Date:   Wed, 9 Jan 2019 15:35:49 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v15 03/11] livepatch: Consolidate klp_free functions
In-Reply-To: <20190109124329.21991-4-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1901091535210.12972@pobox.suse.cz>
References: <20190109124329.21991-1-pmladek@suse.com> <20190109124329.21991-4-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019, Petr Mladek wrote:

> The code for freeing livepatch structures is a bit scattered and tricky:
> 
>   + direct calls to klp_free_*_limited() and kobject_put() are
>     used to release partially initialized objects
> 
>   + klp_free_patch() removes the patch from the public list
>     and releases all objects except for patch->kobj
> 
>   + object_put(&patch->kobj) and the related wait_for_completion()
>     are called directly outside klp_mutex; this code is duplicated;
> 
> Now, we are going to remove the registration stage to simplify the API
> and the code. This would require handling more situations in
> klp_enable_patch() error paths.
> 
> More importantly, we are going to add a feature called atomic replace.
> It will need to dynamically create func and object structures. We will
> want to reuse the existing init() and free() functions. This would
> create even more error path scenarios.
> 
> This patch implements more straightforward free functions:
> 
>   + checks kobj_added flag instead of @limit[*]
> 
>   + initializes patch->list early so that the check for empty list
>     always works
> 
>   + The action(s) that has to be done outside klp_mutex are done
>     in separate klp_free_patch_finish() function. It waits only
>     when patch->kobj was really released via the _start() part.
> 
> The patch does not change the existing behavior.
> 
> [*] We need our own flag to track that the kobject was successfully
>     added to the hierarchy.  Note that kobj.state_initialized only
>     indicates that kobject has been initialized, not whether is has
>     been added (and needs to be removed on cleanup).
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Miroslav Benes <mbenes@suse.cz>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Jason Baron <jbaron@akamai.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
