Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88086C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 18:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4617C208D5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 18:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4617C208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934030AbeFQSWG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 14:22:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50446 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933681AbeFQSWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 14:22:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fUcJO-0006uB-Ht; Sun, 17 Jun 2018 18:22:02 +0000
Date:   Sun, 17 Jun 2018 19:22:02 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC][PATCHES] getting rid of int *open in ->atomic_open() and
 friends
Message-ID: <20180617182202.GA17927@ZenIV.linux.org.uk>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
 <CA+55aFz9cS3m=wZxqKbzrCLEjhPoPddKw5U2MDKNqbG79Wx6bw@mail.gmail.com>
 <20180609051051.GF30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609051051.GF30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 06:10:51AM +0100, Al Viro wrote:
> On Fri, Jun 08, 2018 at 11:57:06AM -0700, Linus Torvalds wrote:
> > I'm obviously biased since I asked for this, but:
> > 
> > On Fri, Jun 8, 2018 at 11:48 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > >  33 files changed, 135 insertions(+), 180 deletions(-)
> > 
> > this already looks nice.
> > 
> > I'll go through the individual patches and see if there's anything
> > there that raises my hackles. Silence will mean assent in this case
> 
> BTW, looking through alloc_file() callers - in cxl_getfile() we have
[snip]

> That's a double iput when we hit alloc_file failure...  There's a bunch
> of callers that can be massaged into something along such lines (not
> sharing that bug, though) and I wonder if we would be better off with
> wrapper like

... and call-by-editor strikes again - this window we've got it
cut'n'pasted into ocxlflash_getfile(), with the same double iput
in place...
