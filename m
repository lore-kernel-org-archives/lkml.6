Return-Path: <osandov@osandov.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524165882; cv=none;
        d=google.com; s=arc-20160816;
        b=fxt4wu9fMtdlp8Piks6h2d7Ax0cKNvF+ZeqSLt9z97gdtYuD3BkJhtT6bzN4w1zOtB
         JvmrBFCfv0d2M3ok//MDYc4Dg0bIeI9B1BvHVB9B2XBWKyVdS4ZIsXxgE4V6N+K5bJ0Q
         YC3n0fGI/gsVdO35hrOTOyc7gLtr11y/A2+TrvqXsThGKkYe3HUacfl5ZMieWfVkn6KE
         L3GYVMtRyx7v3NWDLE5BJKHjDdqFJPKDwYBW6re+0W9QlVTf6X5dNFVAMriMDQgoKZH1
         hYd8XOGB6npkEq6uWGhbeiuh0ezrmCSXmsX0GyF92V2gUEDshGEcIJz3kzwIE/Q0iTKc
         Stvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=AHT9+BOtOaDjHMqKQqMuUurkCknO4ceZiw6pZQtoRM4=;
        b=N0N7Fytgs7MNy7pG1v97dcg+8vzCZEMhFvUir1PmzLlss1SSihtyS+gbtLzK9O6NAp
         3WWR5S8/oCKipZKfz1glG/arEbA9iB6eNgT9oZs+UChcnua1ES3B8fs9iEByxWV4Fa+q
         D7aOJKiu2udSowyhimYMO/cZ9lGWlPXHzcjbPgHF95QWR55xYja4jyq5Cfs+C6RAs5po
         GNYLdlz9ttqqGKN1pm7dGCFPC6Sh680UCQ7E/zTiQ5jxy4HHae0mgoFZmt6z+qSWMAlX
         aEAbQxINmifBcUVNCfWDTsTChR5wE93fHrGnf+plARgpO/l7JUiC875wi++ncC2FiQNB
         rpnw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@osandov-com.20150623.gappssmtp.com header.s=20150623 header.b=JTlqxFGU;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of osandov@osandov.com) smtp.mailfrom=osandov@osandov.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@osandov-com.20150623.gappssmtp.com header.s=20150623 header.b=JTlqxFGU;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of osandov@osandov.com) smtp.mailfrom=osandov@osandov.com
X-Google-Smtp-Source: AIpwx4+tz4DasH2iJCyB9bZnFgF8CjOBrCEq3H8+kR1ghNRNCLxoqmQ1+sG9f37aSa0xuAjCTREaeA==
Date: Thu, 19 Apr 2018 12:24:39 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Steffen Maier <maier@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Li Zefan <lizf@cn.fujitsu.com>, Li Zefan <lizefan@huawei.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [PATCH 2/2] tracing/events: block: dev_t via driver core for
 plug and unplug events
Message-ID: <20180419192341.GC20941@vader>
References: <20180413130719.22921-1-maier@linux.ibm.com>
 <20180413130719.22921-3-maier@linux.ibm.com>
 <20180415083154.GA12254@kroah.com>
 <59186bf6-abf1-87b0-914d-eed1b40ef4a8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59186bf6-abf1-87b0-914d-eed1b40ef4a8@linux.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597636500726736984?=
X-GMAIL-MSGID: =?utf-8?q?1598203764071663505?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 06:33:27PM +0200, Steffen Maier wrote:
> Hi Greg,
> 
> On 04/15/2018 10:31 AM, Greg Kroah-Hartman wrote:
> > On Fri, Apr 13, 2018 at 03:07:18PM +0200, Steffen Maier wrote:
> > > diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> > > index a13613d27cee..cffedc26e8a3 100644
> > > --- a/include/trace/events/block.h
> > > +++ b/include/trace/events/block.h
> > > @@ -460,14 +460,18 @@ TRACE_EVENT(block_plug,
> > >   	TP_ARGS(q),
> > >   	TP_STRUCT__entry(
> > > +		__field( dev_t,		dev			)
> > >   		__array( char,		comm,	TASK_COMM_LEN	)
> > >   	),
> > >   	TP_fast_assign(
> > > +		__entry->dev = q->kobj.parent ?
> > > +		container_of(q->kobj.parent, struct device, kobj)->devt : 0;
> > 
> > That really really really scares me.  It feels very fragile and messing
> > with parent pointers is ripe for things breaking in the future in odd
> > and unexplainable ways.
> > 
> > And how can the parent be NULL?
> 
> I'm hoping for help by block layer experts.
> 
> I suppose block device unplug/removal could be a case. But I don't know the
> details how this works and if object release is protected while I/O is
> pending and new I/O is rejected beforehand. That might make my approach safe
> as it would not call the trace functions while the parent pointer changes.

We quiesce and freeze the queue before tearing it down, so it won't be
NULL while we're still doing I/O. Cc'ing Bart in case I'm lying to you,
though ;)

> > I don't know the block layer but this feels very wrong to me.  Are you
> > sure there isn't some other way to get this info?
> 
> No, I'm not sure at all. But I'm no block layer expert either. This is just
> an idea I had which did work for my cases and I'm looking for confirmation
> or denial by the experts. So if it's not safe from a block layer point of
> view either, then I have to ditch it.

There's not a pretty way to do this, but using the proper helpers would
be preferred:

disk_devt(dev_to_disk(kobj_to_dev(q->kobj.parent)))

The parent of a request_queue is always a gendisk, so this should always
work.

> -- 
> Mit freundlichen Grüßen / Kind regards
> Steffen Maier
> 
> Linux on z Systems Development
> 
> IBM Deutschland Research & Development GmbH
> Vorsitzende des Aufsichtsrats: Martina Koederitz
> Geschaeftsfuehrung: Dirk Wittkopp
> Sitz der Gesellschaft: Boeblingen
> Registergericht: Amtsgericht Stuttgart, HRB 243294
> 
