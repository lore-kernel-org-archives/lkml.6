Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1675CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB43F20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB43F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeK0EIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:08:37 -0500
Received: from smtprelay0049.hostedemail.com ([216.40.44.49]:36914 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726254AbeK0EIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:08:36 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E1F7C1822451D;
        Mon, 26 Nov 2018 17:13:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bat42_3ea9cc07bb914
X-Filterd-Recvd-Size: 2846
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon, 26 Nov 2018 17:13:50 +0000 (UTC)
Message-ID: <48bb15770ef1755a0210db8137045176864d2ece.camel@perches.com>
Subject: Re: RFC: script to convert vsprintf uses of %pf to %ps and %pF to
 %pS
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date:   Mon, 26 Nov 2018 09:13:48 -0800
In-Reply-To: <20181126060824.GG540@jagdpanzerIV>
References: <8eb7769cb8550e82105b71ba67fd603394e23b1e.camel@perches.com>
         <20181126053517.GF540@jagdpanzerIV> <20181126060824.GG540@jagdpanzerIV>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-26 at 15:08 +0900, Sergey Senozhatsky wrote:
> > There are approximately these total uses of the symbolic
> > lookup vsprintf extensions %p[SsFf]:
> > 
> > $ git grep '".*[^%]%p[SsFf]' | \
> >   grep -oh '%p[SsFf]' | sort | uniq -c | sort -rn
> >     231 %pS
> >      65 %ps
> >      60 %pf
> >      47 %pF
> 
> I didn't bother to remove "pf/pF" because I didn't want to count on:
>   a) everyone running checkpatch.pl
>   b) everyone testing all printk-s they added
> 
> I guess pf/pF still can sneak in.

Any use of %p<invalid_extension> could sneak in.

And thanks, the checkpatch test for %p<invalid_extensions>
should be updated too.

> But I don't have a really strong opinion on this. If general
> consensus is that we shall remove deprecated specifiers, then
> I'm fine.

I think converting deprecated things is generally good.

Also, the %p<extension> lettering space is limited, so
cleaning deprecated extensions is useful.

> After running this script I still have a bunch of leftovers:
> 
> //
> // these two are probably not really relevant, but still - %pF/%pf
> //
> tools/lib/traceevent/event-parse.c:             if (asprintf(&format, "%%pf: (NO FORMAT FOUND at %llx)\n", addr) < 0)
> tools/lib/traceevent/event-parse.c:     if (asprintf(&format, "%s: %s", "%pf", printk->printk) < 0)

I was not/am not sure about those.

> arch/um/kernel/sysrq.c: pr_info(" [<%08lx>] %s%pF\n", address, reliable ? "" : "? ",
> arch/x86/xen/multicalls.c:                              printk(KERN_DEBUG "  call %2d/%d: op=%lu arg=[%lx] result=%ld\t%pF\n",
> kernel/async.c:         pr_debug("calling  %lli_%pF @ %i\n",
> kernel/async.c:         pr_debug("initcall %lli_%pF returned 0 after %lld usecs\n",

Missed those by using \b, thanks again.


