Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B947C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F25C208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F25C208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732420AbeGKCnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:43:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47054 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbeGKCnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:43:37 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd54R-0003pc-8i; Wed, 11 Jul 2018 02:41:35 +0000
Date:   Wed, 11 Jul 2018 03:41:35 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [RFC][PATCH 08/42] make sure do_dentry_open() won't return
 positive as an error
Message-ID: <20180711024135.GO30522@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
 <20180711022206.12571-8-viro@ZenIV.linux.org.uk>
 <CA+55aFzcXNLZ7__OCWDwkDgeQuC=kxzxVW-CYJ-T3MwhtXed+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzcXNLZ7__OCWDwkDgeQuC=kxzxVW-CYJ-T3MwhtXed+Q@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 07:39:07PM -0700, Linus Torvalds wrote:
> On Tue, Jul 10, 2018 at 7:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >
> >  cleanup_all:
> > +       if (unlikely(error > 0)) {
> > +               WARN_ON(1);
> > +               error = -EINVAL;
> > +       }
> 
> Can we please do this as
> 
>         if (WARN_ON_ONCE(error > 0))
>                 error = -EINVAL;
> 
> 
> instead?
> 
> That already should do the unlikely for you, and *if* somebody can
> trigger this, at least they won't be spamming the logs and making a
> mess. A single warning is fine.

No problem, will do...
