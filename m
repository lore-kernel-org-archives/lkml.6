Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8902FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5959E20834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5959E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeLCP3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:29:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:41766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726549AbeLCP3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:29:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3EF0ADF2;
        Mon,  3 Dec 2018 15:29:33 +0000 (UTC)
Date:   Mon, 3 Dec 2018 16:29:32 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 04/11] livepatch: Refuse to unload only livepatches
 available during a forced transition
In-Reply-To: <20181129094431.7801-5-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1812031614530.22317@pobox.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com> <20181129094431.7801-5-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You probably forgot to replace the subject with Josh's proposal.

> module_put() is currently never called in klp_complete_transition() when
> klp_force is set. As a result, we might keep the reference count even when
> klp_enable_patch() fails and klp_cancel_transition() is called.

Correct.

> This might make an assumption that a module might get blocked in some
> strange init state. Fortunately, it is not the case. The reference count
> is ignored when mod->init fails and erroneous modules are always removed.

I do not understand the paragraph and its connection to the problem (and I don't
remember if I understood it previously or not and forgot to mention it).

> Anyway, this might make some confusion. Instead, this patch moves
> the global klp_forced flag into struct klp_patch. As a result,
> we block only modules that might still be in use after a forced
> transition. Newly loaded livepatches might be eventually completely
> removed later.

It makes sense by itself only.

> It is not a big deal. But the code is at least consistent with
> the reality.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>


> @@ -633,5 +632,7 @@ void klp_force_transition(void)
>  	for_each_possible_cpu(cpu)
>  		klp_update_patch_state(idle_task(cpu));
>  
> -	klp_forced = true;
> +	/* Refuse unloading all livepatches. The code might be in use. */
> +	list_for_each_entry(patch, &klp_patches, list)
> +		patch->forced = true;

Is the comment necessary? If yes, I'd change it to something similar to the new
subject.

Thanks,
Miroslav
