Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E6AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29EE21920
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545583103;
	bh=1zH3lIDn4V7R2Fbu8GI2So4Y7mT4nuEciOg+BCSHMtc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=h9dcCXOpTOE33/C6NvVJJiBrbsgZSOMBGwUbYCVOqc+q+PLt+6PWoZ1MHI1nGiUU8
	 mC4sEp6C3I0V/9cWwnsnJYW/p1MaedbVcDCWjTclHaHJLkcmRuxEGEccXX1GPZUzzz
	 hLbnsKyH5he67L6awIgQlbaKBUfiirUXToRy8jeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeLWQiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:38:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbeLWQiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 11:38:21 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99A2F2184D;
        Sun, 23 Dec 2018 16:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545583100;
        bh=1zH3lIDn4V7R2Fbu8GI2So4Y7mT4nuEciOg+BCSHMtc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MUDOFJzdLkh8exGXn1XJjS7N14u2WruwPfUZYt3zy96wm260Nu8OFDDFlzhiaFqws
         FBuENemlbge3Wt95ZZFYsNS7jM/P2cuRJNZEUvawQxZKka+ddmKrFgtjv8kXRI3nbo
         OMG/PXeKvKhD2XxsvNp+MXZJQ6TNA6M/yomvgj9w=
Message-ID: <1545583098.4383.3.camel@kernel.org>
Subject: Re: [for-next][PATCH 2/5] tracing: Use str_has_prefix() helper for
 histogram code
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Date:   Sun, 23 Dec 2018 10:38:18 -0600
In-Reply-To: <20181222225338.34cc579c@vmware.local.home>
References: <20181222162007.697862256@goodmis.org>
         <20181222162856.666843139@goodmis.org>
         <20181222130107.43aaac9c@gandalf.local.home>
         <1545501821.4383.2.camel@kernel.org>
         <20181222225338.34cc579c@vmware.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-12-22 at 22:53 -0500, Steven Rostedt wrote:
> On Sat, 22 Dec 2018 12:03:41 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > On Sat, 2018-12-22 at 13:01 -0500, Steven Rostedt wrote:
> > > On Sat, 22 Dec 2018 11:20:09 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >   
> > > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > > 
> > > > The tracing histogram code contains a lot of instances of the
> > > > construct:
> > > > 
> > > >  strncmp(str, "const", sizeof("const") - 1)
> > > > 
> > > > This can be prone to bugs due to typos or bad cut and paste.
> > > > Use
> > > > the
> > > > str_has_prefix() helper macro instead that removes the need for
> > > > having two
> > > > copies of the constant string.
> > > > 
> > > > Cc: Tom Zanussi <zanussi@linux.intel.com>  
> > > 
> > > I have no idea why I copied your intel email. The linux.intel.com
> > > appears to be no longer active. I'm going to rebase to fix this
> > > email
> > > address.  
> > 
> > linux.intel.com is active, but there's no zanussi there, just
> > tom.zanussi ;-)
> > 
> > So tom.zanussi@linux.intel.com should work fine.
> 
> BTW, would you give me your ack-by?
> 

Sure,

Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Tom

> -- Steve
> 
