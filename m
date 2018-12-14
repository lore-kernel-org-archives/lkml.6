Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B320C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0BD206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbeLNO1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:27:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730058AbeLNO1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:27:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0023E3082139;
        Fri, 14 Dec 2018 14:27:17 +0000 (UTC)
Received: from treble (ovpn-120-195.rdu2.redhat.com [10.10.120.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 53FD426FCF;
        Fri, 14 Dec 2018 14:27:12 +0000 (UTC)
Date:   Fri, 14 Dec 2018 08:27:10 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 05/11] livepatch: Simplify API by removing
 registration step
Message-ID: <20181214142710.iprnzxxty5k5vqoz@treble>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-6-pmladek@suse.com>
 <20181213224625.65o77z75u4njocnp@treble>
 <20181214100232.elyqlnjyhp55acxf@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181214100232.elyqlnjyhp55acxf@pathway.suse.cz>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 14 Dec 2018 14:27:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:02:32AM +0100, Petr Mladek wrote:
> On Thu 2018-12-13 16:46:25, Josh Poimboeuf wrote:
> > Now that we can't re-enable a patch, I wonder if we really need both the
> > 'patch->enabled' and 'klp_target_state' variables?
> > 
> > A patch is now always enabled, unless it's in transition, in which case
> > its 'enabled' state is the same as 'klp_target_state'.
> >
> > For example I wonder if we could get rid of 'klp_target_state', since it
> > should be the same as 'klp_transition_patch->enabled'.
> 
> There are some catches:
> 
> 1. klp_update_patch_state() can be called anywhere and anytime. We
>    would add yet another race-sensitive code if we access the flag
>    via a pointer.

True.

> 2. patch->enabled is bool while klp_target_state is triple state.
>    The argument is that KLP_UNDEFINED helps to catch bugs.
> 
> 
> > Or alternatively we could get rid of 'patch->enabled', since it should
> > be the same as
> > 
> > 	patch == klp_transition_patch ? klp_target_state : true
> 
> This might solve the first catch but not the 2nd one.

It could WARN_ON if it's KLP_UNDEFINED when it's not supposed to be.

> Not to say that it is much harder to read.

We could put it in a klp_patch_enabled(patch) wrapper.

> > Of course this could be a follow-on cleanup patch, which could be done
> > in the future, so as not to hold up the merging of these patches
> > anymore.
> 
> Yes, please. This is controversial, non-trivial, and can wait.

No problem.

-- 
Josh
