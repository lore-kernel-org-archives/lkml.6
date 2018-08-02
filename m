Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC3EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73D6214DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73D6214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbeHBKqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:46:25 -0400
Received: from verein.lst.de ([213.95.11.211]:38669 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeHBKqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:46:25 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1443D68D64; Thu,  2 Aug 2018 11:00:53 +0200 (CEST)
Date:   Thu, 2 Aug 2018 11:00:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] aio: implement IOCB_CMD_POLL
Message-ID: <20180802090052.GB13473@lst.de>
References: <20180730071544.23998-1-hch@lst.de> <20180730071544.23998-4-hch@lst.de> <20180801235412.GT30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801235412.GT30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 12:54:12AM +0100, Al Viro wrote:
> On Mon, Jul 30, 2018 at 09:15:43AM +0200, Christoph Hellwig wrote:
> 
> > +	apt.error = -EINVAL; /* same as no support for IOCB_CMD_POLL */
> 
> > +	mask = vfs_poll(req->file, &apt.pt) & req->events;
> > +	if (mask || apt.error) {
> > +		bool removed = false;
> > +
> > +		/* we did not manage to set up a waitqueue, done */
> > +		if (unlikely(!req->head))
> > +			goto out_fput;
> 
> > +out_fput:
> > +	fput(req->file);
> > +	return apt.error;
> 
> Ugh...  So anything that simply returns a constant value, without
> even bothering to do poll_wait() (on the theory that no matter how
> much you wait, nothing will change) is going to git -EINVAL?
> What am I missing here?

I can change it to return that constant value, but is it really going
to be useful to keep resubmitting an iocb for something that we can't
actually poll?  I don't think we help the application with that at all.
