Return-Path: <kernel-hardening-return-11844-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224p0hG2TqmJD0vhqKCutUVhMSNswt5VEMcAvjt2b9nUsjE2tMiVg6CIPLcWekkpJlpDwcK9
ARC-Seal: i=1; a=rsa-sha256; t=1519177028; cv=none;
        d=google.com; s=arc-20160816;
        b=jZ224qr+1zXJcvZgS3ETo2jxqQ27hqG3fObeFa7VcWs6woSFjj9dHwoEH173UFojHa
         Pww7n+EtT9MIhq31cVBdqC85ru+OTL2mgKpsmebhtfOWNH13Pgluhx7rBcIWh/KgGrnk
         v12W/ArBXwrnlCiQMXMNXXUhEKaXEedwG+I61ZNlNWzdnH9nmBEupQz4hHMaRGG5o9u+
         yd6qS23T6Tzydd3NJUAtA1tMQEf5gHIuoswFdZqYy2wRjOpGhcrWZwFlP6yCWvbIdaoA
         kRRZbog/+eokdr0n30AdJTLZw7ycWuntBFJHZe1mQHa0BR4Uc7cuwmv0gmYdaEtlhypk
         mrEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=pUrw2KR0rjeoXTDhS0m7N647mr9En/ONvA5Rskee4w4=;
        b=LxI6C+CEKMEm6VmomN5/kRiOq63sr/lCl/Nh8Ii6d4H8quFZe7hYGMfxbn2BYTjus6
         etzSbOBx1dT80hbTxbN5U07GqDhdZKxt7gfPhGfZT62/kh6su/o946aCsZy5MOYOV7To
         uLpD8OgAHgQH06z7c1uWSfW91jfi1yrkyD7VE219Ts30RfDnjXsjH5TpHuNYOaKoSS0g
         2OGzqL+w0NwQ3qyjOSGunmxbqyUgj1IhWNObUGiwPyehq5hrkT/99tp5eDBgato25/3o
         ZWMCbrSx4Qo4Scl+frpqgB7PBwvLgBFOS8B/zwS03ziYDfOSk64tWWimtF9Nk3FHTIaF
         EExQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11844-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11844-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11844-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11844-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 21 Feb 2018 12:36:36 +1100
From: Dave Chinner <dchinner@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Igor Stoppa <igor.stoppa@huawei.com>, Kees Cook <keescook@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Laura Abbott <labbott@redhat.com>,
	Jerome Glisse <jglisse@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <cl@linux.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [RFC PATCH v16 0/6] mm: security: ro protection for dynamic data
Message-ID: <20180221013636.GE3728@rh>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
 <CAGXu5j+ZNFX17Vxd37rPnkahFepFn77Fi9zEy+OL8nNd_2bjqQ@mail.gmail.com>
 <20180220012111.GC3728@rh>
 <24e65dec-f452-a444-4382-d1f88fbb334c@huawei.com>
 <20180220213604.GD3728@rh>
 <20180220235600.GA3706@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220235600.GA3706@bombadil.infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214870438978682?=
X-GMAIL-MSGID: =?utf-8?q?1592972571702037993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 03:56:00PM -0800, Matthew Wilcox wrote:
> On Wed, Feb 21, 2018 at 08:36:04AM +1100, Dave Chinner wrote:
> > FWIW, I'm not wanting to use it to replace static variables. All the
> > structures are dynamically allocated right now, and get assigned to
> > other dynamically allocated pointers. I'd likely split the current
> > structures into a "ro after init" structure and rw structure, so
> > how does the "__ro_after_init" attribute work in that case? Is it
> > something like this?
> > 
> > struct xfs_mount {
> > 	struct xfs_mount_ro{
> > 		.......
> > 	} *ro __ro_after_init;
       ^^^^^^^^

pointer, not embedded structure....

> > 	......
> 
> No, you'd do:
> 
> struct xfs_mount_ro {
> 	[...]
> };
> 
> struct xfs_mount {
> 	const struct xfs_mount_ro *ro;
> 	[...]
> };

.... so that's pretty much the same thing :P

> > Also, what compile time checks are in place to catch writes to
> > ro structure members? Is sparse going to be able to check this sort
> > of thing, like is does with endian-specific variables?
> 
> Just labelling the pointer const should be enough for the compiler to
> catch unintended writes.

Ok.

> > > I'd be interested to have your review of the pmalloc API, if you think
> > > something is missing, once I send out the next revision.
> > 
> > I'll look at it in more depth when it comes past again. :P
> 
> I think the key question is whether you want a slab-style interface
> or whether you want a kmalloc-style interface.  I'd been assuming
> the former, but Igor has implemented the latter already.

Slabs are rally only useful when you have lots of a specific type of
object. I'm concerned mostly about one-off per-mount point
structures, of which there are relatively few. A heap-like pool per
mount is fine for this.

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com
