Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578D2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3152220883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfAROwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:52:08 -0500
Received: from charlotte.tuxdriver.com ([70.61.120.58]:40072 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfAROwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:52:01 -0500
Received: from cpe-2606-a000-111b-405a-f7a2-17fc-4213-1a54.dyn6.twc.com ([2606:a000:111b:405a:f7a2:17fc:4213:1a54] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1gkVUq-0006IR-3V; Fri, 18 Jan 2019 09:51:56 -0500
Date:   Fri, 18 Jan 2019 09:51:20 -0500
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        linux-sctp@vger.kernel.org
Subject: Re: [PATCH 6/7] sctp: Convert to genradix
Message-ID: <20190118145119.GB22165@hmswarspite.think-freely.org>
References: <20181217131929.11727-1-kent.overstreet@gmail.com>
 <20181217131929.11727-7-kent.overstreet@gmail.com>
 <20181217125001.8e89ac2565417d55ef7a624e@linux-foundation.org>
 <20181217210021.GA7144@kmo-pixel>
 <20190115142926.GQ23855@localhost.localdomain>
 <20190118131022.GA22165@hmswarspite.think-freely.org>
 <20190118133534.GD666@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118133534.GD666@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:35:34AM -0200, Marcelo Ricardo Leitner wrote:
> On Fri, Jan 18, 2019 at 08:10:22AM -0500, Neil Horman wrote:
> > On Tue, Jan 15, 2019 at 12:29:26PM -0200, Marcelo Ricardo Leitner wrote:
> > > On Mon, Dec 17, 2018 at 04:00:21PM -0500, Kent Overstreet wrote:
> > > > On Mon, Dec 17, 2018 at 12:50:01PM -0800, Andrew Morton wrote:
> > > > > On Mon, 17 Dec 2018 08:19:28 -0500 Kent Overstreet <kent.overstreet@gmail.com> wrote:
> > > > > 
> > > > > > @@ -535,9 +470,6 @@ int sctp_send_add_streams(struct sctp_association *asoc,
> > > > > >  		goto out;
> > > > > >  	}
> > > > > >  
> > > > > > -	stream->incnt = incnt;
> > > > > > -	stream->outcnt = outcnt;
> > > > > > -
> > > > > >  	asoc->strreset_outstanding = !!out + !!in;
> > > > > >  
> > > > > 
> > > > > I'm seeing a reject here for some reason.  Using todays's linux-next,
> > > > > but there are no changes against net/sctp/stream.c in -next.  The
> > > > > assignment to stream->incnt has disappeared.  I did this:
> > > > > 
> > > > > @@ -535,8 +470,6 @@ int sctp_send_add_streams(struct sctp_as
> > > > >  		goto out;
> > > > >  	}
> > > > >  
> > > > > -	stream->outcnt = outcnt;
> > > > > -
> > > > >  	asoc->strreset_outstanding = !!out + !!in;
> > > > >  
> > > > >  out:
> > > > > 
> > > > > 
> > > > > We're at 4.20-rc7 and this series is rather large.  I'll merge them all
> > > > > to see what happens, but I don't think it's 4.21-rc1 material?
> > > > 
> > > > Yeah, agreed. Thanks!
> > > 
> > > Ping? Where did this go?
> > > 
> > As I recall kent reposted his series convirting flex_arrays to radix trees such
> > that it included sctp's uses.
> 
> That should be this patchset already.  Or you mean another (re)post,
> v2 or so? If yes then I missed it somehow but I still see the
> flex_array in v5.0-rc2:
> 
> net-next]$ git ls-tree v5.0-rc2 -- lib/flex_array.c
> 100644 blob 2eed22fa507c7cb0756d7ef643f8a3454eb455ec    lib/flex_array.c
> 
> and missing the convertion on sctp stack.
> 
> Current patch is the only one I could find with sctp being included:
> https://lore.kernel.org/lkml/20181217210021.GA7144@kmo-pixel/T/#re4f8656af37431a376044399681a8771375a4405
> 
Correct, and it doesn't seem to be included yet, though I acked Kents patch as I
recall.  not sure what the hold up is at this point
Neil

> > 
> > I think xin needs to repost the sctp reallocation patch to make use of those
> > radix trees appropriately still (assuming any additional work still needs to be
> > done)
> 
> This came up on another converstation with him and the lack of this
> convertion is blocking him on at least one fix, on one that the fix
> using flex_arrays is one and genradix is another.
> 
>   Marcelo
> 
> > 
> > Neil
> > 
> > >   Marcelo
> > > 
> 
