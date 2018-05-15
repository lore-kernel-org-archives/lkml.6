Return-Path: <SRS0=cHGH=IC=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AB8JxZp93x1AtZGmz9QQptfggA2M+7+Sgt78g2jqHsfli7LZaqS/r0FjaDOCMbJDAaJ3f+E3Ffle
ARC-Seal: i=1; a=rsa-sha256; t=1526420149; cv=none;
        d=google.com; s=arc-20160816;
        b=C281RAGpvNhlqUxc7Pehy23AMR6lh82dEDjK3qlflH4pVO5OI2sC7L/d3ATLpB2O8I
         JdYZCUc9XmtVKMMe3HKCSGgsdcBs126tTrMhfFU9aaoVrmrOVAfNSDe7fnRICpvcrwV+
         NgYGG+pIOyaSON9405KCz3WA64/N/263A0pPzFr/lEmoJigK97eINfC0L2PU4JQWULUS
         zfeXc3KdOXckwEK1MjpQyiPxHhP4SNntJOiqA0Lhdu9cfTxXhTNRHHNBFJKmgbNvehO6
         IPN287UTtj6jmFBbYYOGFeYly6U7mRhcN3yCNA12asgIMjjsXlBxllzjDTvH3RU1xD/g
         M7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=+QL361eJfLSmQxExyjZvZBd4KJc1X44aP1ZmCsQwels=;
        b=dA5UqP6AQYkOR9n1SOo4cbE/w+xfjd1hwOKtNqWrSKT/OVqs9D7tzDQKUp+5BM4SLS
         kyWI5+Q6YUj9+lre8ZHSjXo7TOI5SNw8ohxzqpqQERUHdz+Qp4pNrF+PbJtY3fpMGClk
         UnyMoIbYf3lrOoApO8R/ojpkdnu6dbRF2ebNEl+5xrBoxMIs1y2AXQyAdCpxYhElGCvl
         KLeyE1EHv9YfqfLxkgfWDiSfcCJuqD/I0PJfT4JeVsFAH0QCi5IR56Kvlu+Dh/BIaY4D
         NfyYZN5wtH5CZt7uXQHIcpgIbshOpt6VOnZkbMLsqNGp9v6g3QbrcnWGoArr5iICMKeH
         Pkow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srs0=chgh=ic=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=cHGH=IC=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srs0=chgh=ic=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=cHGH=IC=goodmis.org=rostedt@kernel.org
Date: Tue, 15 May 2018 17:35:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Theodore Ts'o <tytso@mit.edu>, Linus Torvalds
 <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Kees
 Cook <keescook@chromium.org>, Anna-Maria Gleixner
 <anna-maria@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] random: Return nbytes filled from hw RNG
Message-ID: <20180515173546.6d80b119@gandalf.local.home>
In-Reply-To: <20180515211706.GG10152@eros>
References: <1526353586-30092-1-git-send-email-me@tobin.cc>
	<1526353586-30092-3-git-send-email-me@tobin.cc>
	<20180515093705.03850c5a@gandalf.local.home>
	<20180515211706.GG10152@eros>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600497767242955587?=
X-GMAIL-MSGID: =?utf-8?q?1600567534034720688?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 16 May 2018 07:17:06 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> > > -void get_random_bytes_arch(void *buf, int nbytes)
> > > +int __must_check get_random_bytes_arch(void *buf, int nbytes)
> > >  {
> > >  	char *p = buf;
> > > +	int left = nbytes;  
> > 
> > Just a nit, but I know some kernel devs prefer "upside-down-xmas-tree"
> > style of declarations. Which would make the above:
> > 
> > 	int left = nbytes;
> > 	char *p = buf;  
> 
> Super specific coding style and rigorous code cleanliness is a big part
> of why I love kernel dev.  Thanks for pointing this one out. 

It's a relatively new form, but I like it. It makes the code look "less
messy" ;-)  Some devs don't care, others do. This file already breaks
it, so it really is up to you. Like I said, it's "just a nit", not
really important.

> 
> While we are on these code lines, whats the typical kernel variable name
> for a loop counter that is going to be counted down? 'left',
> 'remaining', 'to_go', 'still'???

"left" looks good to me.

> 
> > >  
> > > -	trace_get_random_bytes_arch(nbytes, _RET_IP_);
> > > -	while (nbytes) {
> > > +	trace_get_random_bytes_arch(left, _RET_IP_);  
> > 
> > Nothing to do with this patch series, but I wonder if we should move
> > the trace event below, and record how much was done.  
> 
> I don't fully understand trace events, I just left this line in tact
> and hoped for the best :(

Your patch is fine. This could be something to add after your series.

> 
> /me adds 'trace events' to list of things to learn more about

Just look at /sys/kernel/debug/tracing/events

Or read Documentation/trace/ftrace.{rst,txt}.


-- Steve
