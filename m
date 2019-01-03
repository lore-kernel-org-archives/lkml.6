Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C25C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5772070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfACMrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:40450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731667AbfACMrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7CA54AFCC;
        Thu,  3 Jan 2019 12:47:41 +0000 (UTC)
Date:   Thu, 3 Jan 2019 13:47:40 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v14 07/11] livepatch: Add atomic replace
Message-ID: <20190103124740.s3mpgmjw4no4qr6f@pathway.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-8-pmladek@suse.com>
 <20181213225528.ies3kxjjtzl6dmd3@treble>
 <20181217152741.2i2trzjk5rmofgc3@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217152741.2i2trzjk5rmofgc3@pathway.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-12-17 16:27:41, Petr Mladek wrote:
> On Thu 2018-12-13 16:55:28, Josh Poimboeuf wrote:
> > On Thu, Nov 29, 2018 at 10:44:27AM +0100, Petr Mladek wrote:
> > Side note, it would probably be useful to have a klp_for_each_patch()
> > helper.
> 
> Will do.

Hmm, there are two possibilities:

1) #define klp_for_each_patch(patch)	\
	list_for_each_entry(patch, &klp_patches, list)

2) #define klp_for_each_patch(patches, patch)	\
	list_for_each_entry(patch, &patches, list)

Problems:

1st variant would need to declare klp_patches in
include/linux/livepatch.h. Josh did not like even
kernel/livepatch/core.h.

2nd variant looks ugly to me.


Alternative solution would be to move all klp_for_each*()
definitions from include/linux/livepatch.h to kernel/livepatch/core.h.
But there might be some users. I wonder if we use these
macros when preparing the cumulative patches.


As any solution looks controversial, I would prefer to postpone this change
after this patchset is accepted.

Best Regards,
Petr
