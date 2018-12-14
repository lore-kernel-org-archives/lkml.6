Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAD1C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2312086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2312086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbeLNKCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:02:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:49658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbeLNKCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:02:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C594AE4C;
        Fri, 14 Dec 2018 10:02:33 +0000 (UTC)
Date:   Fri, 14 Dec 2018 11:02:32 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 05/11] livepatch: Simplify API by removing
 registration step
Message-ID: <20181214100232.elyqlnjyhp55acxf@pathway.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-6-pmladek@suse.com>
 <20181213224625.65o77z75u4njocnp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213224625.65o77z75u4njocnp@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-12-13 16:46:25, Josh Poimboeuf wrote:
> Now that we can't re-enable a patch, I wonder if we really need both the
> 'patch->enabled' and 'klp_target_state' variables?
> 
> A patch is now always enabled, unless it's in transition, in which case
> its 'enabled' state is the same as 'klp_target_state'.
>
> For example I wonder if we could get rid of 'klp_target_state', since it
> should be the same as 'klp_transition_patch->enabled'.

There are some catches:

1. klp_update_patch_state() can be called anywhere and anytime. We
   would add yet another race-sensitive code if we access the flag
   via a pointer.

2. patch->enabled is bool while klp_target_state is triple state.
   The argument is that KLP_UNDEFINED helps to catch bugs.


> Or alternatively we could get rid of 'patch->enabled', since it should
> be the same as
> 
> 	patch == klp_transition_patch ? klp_target_state : true

This might solve the first catch but not the 2nd one. Not to say
that it is much harder to read.


> Of course this could be a follow-on cleanup patch, which could be done
> in the future, so as not to hold up the merging of these patches
> anymore.

Yes, please. This is controversial, non-trivial, and can wait.

Best Regards,
Petr
