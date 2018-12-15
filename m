Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4411C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D7F206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbeLOQXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 11:23:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730075AbeLOQXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 11:23:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 756ABC058CB0;
        Sat, 15 Dec 2018 16:23:41 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6ED3860F87;
        Sat, 15 Dec 2018 16:23:40 +0000 (UTC)
Date:   Sat, 15 Dec 2018 11:23:39 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Nicholas Mc Guire <der.herr@hofr.at>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: fix non-static warnings
Message-ID: <20181215162339.rmjcyg5gqxjvp7pg@redhat.com>
References: <1544806570-21299-1-git-send-email-hofrat@osadl.org>
 <72b8f2a4-9070-23d3-4e75-66e10b2d94b5@redhat.com>
 <20181215085052.GA3426@osadl.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215085052.GA3426@osadl.at>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sat, 15 Dec 2018 16:23:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 09:50:52AM +0100, Nicholas Mc Guire wrote:
> On Fri, Dec 14, 2018 at 04:34:23PM -0500, Joe Lawrence wrote:
> > On 12/14/2018 11:56 AM, Nicholas Mc Guire wrote:
> > > Sparse reported warnings about non-static symbols. For the variables a
> > > simple static attribute is fine - for those symbols referenced by
> > > livepatch via klp_func the symbol-names must be unmodified in the
> > > relocation table - to resolve this the __noclone attribute (as 
> >   ^^^^^^^^^^
> > nit: symbol table
> 
> that should have been  relocation section  as described in
> Documentation/livepatch/module-elf-format.txt - atleast that is how
> I currently undderstand the livepatch mechanism and its seperate
> relocation section.
> 
Hi Nicholas,

Jessica can explain module-elf-format.txt in more detail, but the
highlight is that it outlines the format for _livepatch_ modules, in
this case livepatch-shadow-fix{1,2}.ko.  The special relocations
detailed in that file are needed when livepatch modules reference
symbols defined elsewhere (vmlinux, other modules) that may not
ordinarily be visible (non-exported, local, etc.) to the module loader.

When livepatch modules register themselves on load, the livepatching
core needs to find the address of the _target_ to-be-patched function
using a kallsyms lookup.  If that can't be found, the kernel will emit
an error, "livepatch: symbol 'dummy_free' not found in symbol table".
The call path is:

  klp_register_patch
    klp_init_object_loaded
      klp_find_object_symbol

if you want to trace the execution path.

> 
> thanks for your patience - so I did not yet understand how this really
> works together - will give it a rerun and repost a hopefully proper
> solution. 
>
> thx!
> hofrat

Thanks for sticking with it and learning some livepatching internals
along the way.

-- Joe
