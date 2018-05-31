Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755633AbeEaQOE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:14:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755598AbeEaQOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:14:01 -0400
Date: Thu, 31 May 2018 09:14:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [GIT PULL] two more s390 bug fixes for 4.17
Message-ID: <20180531161400.GB10203@infradead.org>
References: <20180530075920.1f73275a@mschwideX1>
 <20180530074130.GA6927@infradead.org>
 <20180530111140.40c791bd@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530111140.40c791bd@mschwideX1>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 11:11:40AM +0200, Martin Schwidefsky wrote:
> On Wed, 30 May 2018 00:41:30 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > > -	req->completion_data = cqr;
> > > +	*((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req)) = cqr;
> > > +  
> > 
> > Please don't play such tricks.  In general your driver structure
> > should have struct request embedded.  If for some reason
> > struct dasd_ccw_req has a different life time please create a new
> > structure instead of these hacks.
> 
> Why do you consider this to be a 'trick'? The blk_mq_rq_to_pdu is
> meant to be used to access a block of data that is is associated
> with a request, no? With the change we store a single value, the
> pointer to a struct dasd_ccw_req. The struct request comes first,
> later do_dasd_request creates the struct dasd_ccw_req with the
> CCW chain for the request. And for the blk timeout handler we need
> a way to find the dasd_ccw_req again.

We'll we try really hard to have a structure that we can use
container_of on.  At least a minimal container with just the pointer
for a quick fix, but in general it seems like you should be able
to allocate the whole dasd_ccw_req with the request and just initialize
it later.
