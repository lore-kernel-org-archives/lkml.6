Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5507C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47332080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47332080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbeKADiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:38:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730360AbeKADiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:38:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A04B758E2A;
        Wed, 31 Oct 2018 18:39:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6022C4D71A;
        Wed, 31 Oct 2018 18:39:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87a7mut9cm.fsf@xmission.com>
References: <87a7mut9cm.fsf@xmission.com> <20181031053355.GQ32577@ZenIV.linux.org.uk>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     dhowells@redhat.com, Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] mount API series
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7504.1541011140.1@warthog.procyon.org.uk>
Date:   Wed, 31 Oct 2018 18:39:00 +0000
Message-ID: <7505.1541011140@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 31 Oct 2018 18:39:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> My objections fundamentally is that I can find real problems when I look
> at the code.

Eric.

You have repeatedly stated that there are "thinkos, typos and bugs" in the
code, but you have not been very forthcoming in actually disclosing *what*
those things are.

You had a go at rewriting it for yourself, with different philosophical aims,
and at one point, you posted a partially reworked git branch my way.  However,
you changed the patches in various ways that rendered it incomparable with
mine, making it very hard to actually separate bug fixes from your other
changes.  No useful notes were given.

> Further the changes have not been incremental changes that have evolved the
> code from one state to another but complete replacements of code that make
> code review very difficult and bisection completely inapplicable.

... therefore I find this a little hypocritical.

Further, your rewrite breaks NFS and other things, such as mis-renumbering the
tokens in SELinux.  Splitting the lookup-and-create operation into separate
lookup-no-create and create-or-fail won't work for NFS.  Despite your
protestation, this *has* been discussed publically - and you even joined in
the discussion.

> A couple of bugs that I can see quickly.  Several of which I have
> previously reported:
> 
> - There is an easily triggered NULL pointer deference with open_tree
>   and mount propagation.

As far as I know, these have all been cleared up.  I think that I've cleared
up all the bugs that Alan Jenkins found (many thanks to him for that!).

> - Bisection will not work with the cpuset filesystem patch.

It won't?  I don't recall this been mentioned before (but I may have missed
it).

>   At least cpuset looks like it may be mountable now.

It does mount now.  Thanks for pointing that out.

> - The setting of fc->user_ns on proc remains broken.  In particular if you
>   create a child user namespace and attempt to mount proc it will succeed
>   instead of fail.

You did mention this before - but you haven't been clear on how to fix it.  I
tried to work this out from your branch, but it's mixed in with loads of other
changes.

> - The mqueue filesystem has the same issue as proc.  fc->user_ns is misset.

I have a patch that I think should fix both of these.  I'll follow up this
message with it, if you could check it please.

David
