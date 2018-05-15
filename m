Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZoouIKDgjjw8ZAqiYwBAed4Zj4tSg2pRdL7pA8icnsFL7lMI33zdL6pTNv7tyUrTgo5cc2H
ARC-Seal: i=1; a=rsa-sha256; t=1526419030; cv=none;
        d=google.com; s=arc-20160816;
        b=vE0tORAXxc5aHkXyGclMm9chxhv77adGWGSE2+X9f4LpfpS/4oqivWG++GcWk0NjzT
         Q5ZqTf6qkPzxQseFtJ+6S3Fzz4TetVrzeGwkcjYk3ZgESXNIrRmNDeZbJSKZ/BW/bomp
         JXnSg4BTLl4fW5UxlWp4dRLoc08wpTUGfunYTU6lVPsgslAT0+x/B9F7WJ+tNOOxnOWv
         9cOyaMU3hw5kUY0qys/u1+bEH8m0NujogsWB0GdEhT/qZYWPJWhQCOLeHo++cQfZ+t3d
         hRtyaFUygnkk5hvnIBFmcWytn5GWDzkDzLecGQ9IPITS1+F9csrKk8JX1IgEjLgP2zOV
         DfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=lCUTdEzuA0OP8iIqYp2CfQyX0LIEtmC19Ss0DR9PDus=;
        b=uVZi0MTgkXzcVVPP3rQY2RxcpQIbOrKNQo45TBm4+YUVgm4Y8xjieMS7KQ/sijdTOn
         AkgikWnNw/Mje4dv8o9hIoT6U00G33eDNzj5k/IVJ/mUIkhYudnYN8B7+/Go+aqx09B0
         nJuBwqEz1zRDlsN2HFpS9c4QRmlhcGLJvCi7ztPPEFC8VCWh8Z6IbHvZ+TrhSCQFtSIs
         hU73kixFyBN1gUaniJBXa7SprrSh4FUJTvCqYM/QAi/P46hqq47bhuq8MNe09I2MTlDa
         k5kBqIpZUwpK3+rCzWArBM8dZH3C0b0U4YvlJcQmhBheQWQR9H1aJOo0bfy+2YCxmXxt
         cLAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=AoyFw4gq;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=DUCcMKAv;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=AoyFw4gq;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=DUCcMKAv;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:Vk77WmHLTCC9Zd1RdG13gHEfSOLSWQ_pqnNwHdLzB1GdkstCptVA5w>
Date: Wed, 16 May 2018 07:17:06 +1000
From: "Tobin C. Harding" <me@tobin.cc>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] random: Return nbytes filled from hw RNG
Message-ID: <20180515211706.GG10152@eros>
References: <1526353586-30092-1-git-send-email-me@tobin.cc>
 <1526353586-30092-3-git-send-email-me@tobin.cc>
 <20180515093705.03850c5a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515093705.03850c5a@gandalf.local.home>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600497767242955587?=
X-GMAIL-MSGID: =?utf-8?q?1600566361399860854?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 09:37:05AM -0400, Steven Rostedt wrote:
> On Tue, 15 May 2018 13:06:25 +1000
> "Tobin C. Harding" <me@tobin.cc> wrote:
> 
> > Currently the function get_random_bytes_arch() has return value 'void'.
> > If the hw RNG fails we currently fall back to using get_random_bytes().
> > This defeats the purpose of requesting random material from the hw RNG
> > in the first place.
> > 
> > There are currently no intree users of get_random_bytes_arch().
> > 
> > Only get random bytes from the hw RNG, make function return the number
> > of bytes retrieved from the hw RNG.
> > 
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > Acked-by: Theodore Ts'o <tytso@mit.edu>
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > ---
> >  drivers/char/random.c  | 16 +++++++++-------
> >  include/linux/random.h |  2 +-
> >  2 files changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 031d18b31e0f..4b0ec597e783 100644
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
> >  {
> >  	char *p = buf;
> > +	int left = nbytes;
> 
> Just a nit, but I know some kernel devs prefer "upside-down-xmas-tree"
> style of declarations. Which would make the above:
> 
> 	int left = nbytes;
> 	char *p = buf;

Super specific coding style and rigorous code cleanliness is a big part
of why I love kernel dev.  Thanks for pointing this one out. 

While we are on these code lines, whats the typical kernel variable name
for a loop counter that is going to be counted down? 'left',
'remaining', 'to_go', 'still'???

> >  
> > -	trace_get_random_bytes_arch(nbytes, _RET_IP_);
> > -	while (nbytes) {
> > +	trace_get_random_bytes_arch(left, _RET_IP_);
> 
> Nothing to do with this patch series, but I wonder if we should move
> the trace event below, and record how much was done.

I don't fully understand trace events, I just left this line in tact
and hoped for the best :(

/me adds 'trace events' to list of things to learn more about

> > +	while (left) {
> >  		unsigned long v;
> > -		int chunk = min(nbytes, (int)sizeof(unsigned long));
> > +		int chunk = min_t(int, left, (int)sizeof(unsigned long));
> >  
> >  		if (!arch_get_random_long(&v))
> >  			break;
> >  
> >  		memcpy(p, &v, chunk);
> >  		p += chunk;
> > -		nbytes -= chunk;
> > +		left -= chunk;
> >  	}
> >  
> > -	if (nbytes)
> > -		get_random_bytes(p, nbytes);
> > +	return nbytes - left;
> >  }
> >  EXPORT_SYMBOL(get_random_bytes_arch);
> >  
> > diff --git a/include/linux/random.h b/include/linux/random.h
> > index 2ddf13b4281e..f1c9bc5cd231 100644
> > --- a/include/linux/random.h
> > +++ b/include/linux/random.h
> > @@ -38,7 +38,7 @@ extern void get_random_bytes(void *buf, int nbytes);
> >  extern int wait_for_random_bytes(void);
> >  extern int add_random_ready_callback(struct random_ready_callback *rdy);
> >  extern void del_random_ready_callback(struct random_ready_callback *rdy);
> > -extern void get_random_bytes_arch(void *buf, int nbytes);
> > +extern int __must_check get_random_bytes_arch(void *buf, int nbytes);
> >  
> >  #ifndef MODULE
> >  extern const struct file_operations random_fops, urandom_fops;
> 
> Other than that...
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks for the review Steve, will spin again.


	Tobin.
