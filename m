Return-Path: <kent.overstreet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527114272; cv=none;
        d=google.com; s=arc-20160816;
        b=YfjgxWCbZnPYWtzPx1SXMTLLZ9hvKBVlSKOJpRKSsDv/c5+3fSg2QixsmpIOuVD/oY
         M1JGfEkMMz0wILYZ/0VTLtwcienWj9nYOq3SyLCKd+AFC9udF3WuGYngGo9MuQm3Y/tG
         sGWZptZQBJqi9SynLqYbIFsDD3bsqB+AlHKV7e1NStuP63sLmCsPO2+MpjoBF/odO25i
         /KR4qKW9UgedxPRYOXtVV3PLhyo+TosO8MocP//halol508lUPQjqbgvU9AfuWYRcLg3
         /mV7a5LSurI2ICDF+eYGot10FL43qe/k/PX6FBaTjnasqqe+omCxdJMp7Upj7ZC8LZ+h
         x81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=oWecHdn1KIXrq2Dz8xoFCurWdW7GcLb58fzF1sy6CZw=;
        b=HZIWk4WLTL1oBsbAnQn5lLm3O0UHOUbriut4g10GZ8Adgo5yWSAGGHIfV5twu3uq6h
         VZFX2xr4nWdm+GZ7i4H7kxLZkkZemvQ3CVd9X/1tFidTY4Ssvf64X0HGvkE07J0vjD5m
         pTqc33vquP731fYZsK5WRbdkC/qHZxZByuS3z80+1le8ad+rRxlXBSkf33M5xTxWGYrV
         3PwZcmcz+WUn7P0l6zm22IL2ImeJ8qu19LV/cQlwLCyXlAt1vya0efZqtxp8Uvo7bFtV
         znUtwruLn+I+zc7U9Pa5FNHmTI755sm9PEWx8gLqeQWQU3XfZvS3/isE7aZLrk/FKdch
         0M+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dc/BQ/P9;
       spf=pass (google.com: domain of kent.overstreet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kent.overstreet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dc/BQ/P9;
       spf=pass (google.com: domain of kent.overstreet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kent.overstreet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: ADUXVKJRBwDGnUk70a+3d2gMWdSs7GpSrUJXX9fpJLtxbhIrsw9P1NeNPsOHXWzJu7VJz+/4es0ZCg==
Date: Wed, 23 May 2018 18:24:28 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org, gregkh@linuxfoundation.org,
	linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
	dev@openvswitch.org, shli@kernel.org, linux-raid@vger.kernel.org,
	Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Subject: Re: [PATCH 4/6] openvswitch: convert to genradix
Message-ID: <20180523222428.GC23040@kmo-pixel>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
 <20180523011821.12165-4-kent.overstreet@gmail.com>
 <20180523123401.GB19987@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523123401.GB19987@bombadil.infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601215741901107818?=
X-GMAIL-MSGID: =?utf-8?q?1601295375173813116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 05:34:01AM -0700, Matthew Wilcox wrote:
> On Tue, May 22, 2018 at 09:18:19PM -0400, Kent Overstreet wrote:
> > the new generic radix trees have a simpler API and implementation, and
> > no limitations on number of elements, so all flex_array users are being
> > converted
> 
> This doesn't really feel like it should be a flexarray / genradix user.
> It just wants to allocate a lot of buckets and use them.  Maybe kvmalloc
> is the right approach for this user of flexarray?

Yeah probably, or a rhashtable.

Now that you mention it, I think the md code should definitely be using kvmalloc
too.
