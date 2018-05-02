Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZo3MUnrOmxncOWCYWr9ayg9Q/Q8mQSEKbPjShNP1jUlHHNC9H8K+WOKKplZxr1D/m89/COR
ARC-Seal: i=1; a=rsa-sha256; t=1525226847; cv=none;
        d=google.com; s=arc-20160816;
        b=Td/jIVsmT5DwWaXcZMMVKay9iRRp8a8/cNo53VJkeXKt/gB1dnJE8726WQ0t5MW6Yh
         GjEbmFH4YLz/1e+gszAaAkGWzEk7kCMn+CWlBbrWmsVrQdPb8+Vh1HQokxOLceyBPkgo
         LTemk4FKGyg4ZKbS0EySBTH0+R8OywsZapFpp96g23S623YcPQ0TvrrTyHMyltnI4Tr1
         hfRFVaNtgPlY/dytmFiTYXrRqPi0Bt4U1v9+eW0t8kHa5Wj0ol/pcmnGnINxAldLWk6Q
         e9piJczBP9EAz4n5LFJG0wJ9p9wqLjQjKEcWqYtwKboYm+FI02tm3kLleIM+Jwz4ctAL
         Pd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=7n8b+O/j1/JLNmLZE7eifO3fZLkV03qhmHmfrqScx0U=;
        b=PIgZigy4V2wx+CanBY1L02mvGw8tuJc8TLE4L1UkObTaGIwHtHJE8WIil0oE4Hjy+e
         v2JWfhitcvjY67tA7ttA7SqISqRKEbAIwfUaFMcDPBX1MVQUwYzOHCwmB5Bcl7WNJISW
         mmfHJ0ricx9pJMA6EllnohtdK8LWoawMhx2y/4p/w7i7O8mIMBArjwb4BxuX62PUG0zL
         N9pV6cGksu10hf6SAWBFrsbB90rFeSTRvhjBB5wJRQsvMsFDxJHYgA1RYObsTez+Ui/B
         LpFen9uuGGkUGSVYmUn59G63Sbpe/nPtBAOiCVRdxlnCpVe6u2m9HGIkveqaDhPAYl/b
         jSzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=B4oedvxF;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=d5fhWhQ/;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=B4oedvxF;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=d5fhWhQ/;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:XR3pWkpYFDrxFdgzwNf5SzGRKyjTIHkfxLlQttwGx86vSD6IvaILbA>
Date: Wed, 2 May 2018 12:07:22 +1000
From: "Tobin C. Harding" <me@tobin.cc>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] random: Return nbytes filled from hw RNG
Message-ID: <20180502020722.GF3791@eros>
References: <1525217620-4107-1-git-send-email-me@tobin.cc>
 <1525217620-4107-3-git-send-email-me@tobin.cc>
 <20180501213902.4ea6bbf9@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501213902.4ea6bbf9@vmware.local.home>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599306642017406992?=
X-GMAIL-MSGID: =?utf-8?q?1599316266562477173?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 09:39:02PM -0400, Steven Rostedt wrote:
> On Wed,  2 May 2018 09:33:39 +1000
> "Tobin C. Harding" <me@tobin.cc> wrote:
> 
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 031d18b31e0f..3a66507ea60b 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -1725,26 +1725,28 @@ EXPORT_SYMBOL(del_random_ready_callback);
> >   * key known by the NSA).  So it's useful if we need the speed, but
> >   * only if we're willing to trust the hardware manufacturer not to
> >   * have put in a back door.
> > + *
> > + * Return number of bytes filled in.
> >   */
> > -void get_random_bytes_arch(void *buf, int nbytes)
> > +int __must_check get_random_bytes_arch(void *buf, int nbytes)
> 
> The "__must_check" makes no sense in the C file. It belongs in the
> header file. There wont be any complaint about it here.

Oh thanks.

/steve schooling noobs all day long
