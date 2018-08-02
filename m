Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F3EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A922152D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A922152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeHBSD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:03:56 -0400
Received: from verein.lst.de ([213.95.11.211]:40381 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbeHBSD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:03:56 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DD5DA6FD12; Thu,  2 Aug 2018 18:16:48 +0200 (CEST)
Date:   Thu, 2 Aug 2018 18:16:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] aio: implement IOCB_CMD_POLL
Message-ID: <20180802161648.GA9676@lst.de>
References: <20180730071544.23998-1-hch@lst.de> <20180730071544.23998-4-hch@lst.de> <20180802002121.GU30522@ZenIV.linux.org.uk> <20180802092234.GA13797@lst.de> <20180802160032.GY30522@ZenIV.linux.org.uk> <20180802160816.GA9447@lst.de> <20180802160837.GZ30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802160837.GZ30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 05:08:38PM +0100, Al Viro wrote:
> On Thu, Aug 02, 2018 at 06:08:16PM +0200, Christoph Hellwig wrote:
> > On Thu, Aug 02, 2018 at 05:00:32PM +0100, Al Viro wrote:
> > > BTW, what happens if we insert into one queue and immediately get
> > > woken up, even before the damn thing gets to the end of ->poll(),
> > > which proceeds to call poll_wait() again (on another queue)?
> > > AFAICS, apt.error will be set by the second callback and completely
> > > ignored.  And so will the return value of ->poll()...
> > > 
> > > Sigh...  Analysis of that thing is bloody painful, mostly because
> > > it's hard to describe the state...
> > 
> > That's the problem with the ->poll interface.  We call it, then
> > have magic happen underneath where it might or might not get added
> > to one (or more if we didn't exclude that) waitqueues, and might
> > have actually been worken before return.  I can't really think of
> > a good way to do that entirely sanely.
> > 
> > Best I can think of is to only allow using file ops that do keyed
> > wakeups and rely on the keyed wakeups alone.  I've started coming
> > up with a version of that, but it won't be until tomorrow at least
> > that I can post it.
> 
> What does it buy you?  You still have to deal with trylock failures
> in wakeup...

But we'll never re-add an iocb once it has been removed from the
waitqueue.
