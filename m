Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZozJGo9ldqJamZWrIhzqWAoeOe2gEnQVT0UBEuHCyB8Y0VjhMaVG25xua56IGuakS+7zVXM
ARC-Seal: i=1; a=rsa-sha256; t=1526423203; cv=none;
        d=google.com; s=arc-20160816;
        b=MBffbsxwtHKhMJ+XdOn2eo/5wULvOX+RjZrdf2lYhGDSWy3xQCIwxQ+UTNHY3ccCOZ
         kwFUE9Q2XQs8e6hQO2NzHWSy00H0r37QUWEqX4E0G13uwHqQpzsvqDEAYTsUuIhUGIjf
         HS1BEM+uiXDgf33ep1b1yYcIjlvU58SMWLgz+X5oVbCi4D36Bq7TDiWtq8GAl4xRa74E
         DYxz1nfTkzyz26qVHoca4RG9QcAeI6Iho5kdT2pv/eYJ1MwZtHApZyyLOguk1eTpaEDB
         cwky3/L4Q1whOtMgP3/+h5HrErBH764+l4KWISsvmSD2ftGEsze0CvkwLLK4voW8bnUG
         BJIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=nJh0GTDcRnAlX9upvk9vWfCUUXtolzvQHkQlWASE2/0=;
        b=wUxFEbzoSM+KTxJzsTVNqp9Rn463PucFEEaySmtlKEF848OKEeya18i1+nlsa0BnuG
         adpztZT/K0yPXkZNyT0SpXl/wAIVbv7D9NxflJqDaS69Cf3y4LqiTOoTQE/dI3IYTFe5
         80QK8Yv+JcflquOgQ6tTnbfpNoNOZ9hMtm/yvckv5xQX6SzD1bp1qokG7jjWsGbyYOiL
         He4V2CEN6b15bAA0hsEm+c8HXtDuiNQQmZfMD4IuJF4MORCojZ7HK+7uQ6DQnsCbIN2f
         in1n0zHqlbOs+OZyfAlLb3/QIhopxSRgoQ+5IR/R4aisONpPcwybbdfszfWeMhq0//B0
         NWGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=jIuvAL6I;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=L6y5U1J1;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=jIuvAL6I;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=L6y5U1J1;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:oV77WoMU7ORw7moZK5RS3ISHLAWkYfZz5duS7L1RW_PqnQGKHMKFcA>
Date: Wed, 16 May 2018 08:26:38 +1000
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
Message-ID: <20180515222638.GH10152@eros>
References: <1526353586-30092-1-git-send-email-me@tobin.cc>
 <1526353586-30092-3-git-send-email-me@tobin.cc>
 <20180515093705.03850c5a@gandalf.local.home>
 <20180515211706.GG10152@eros>
 <20180515173546.6d80b119@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515173546.6d80b119@gandalf.local.home>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600497767242955587?=
X-GMAIL-MSGID: =?utf-8?q?1600570736429059458?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 05:35:46PM -0400, Steven Rostedt wrote:
> On Wed, 16 May 2018 07:17:06 +1000
> "Tobin C. Harding" <me@tobin.cc> wrote:
> 
> > > > -void get_random_bytes_arch(void *buf, int nbytes)
> > > > +int __must_check get_random_bytes_arch(void *buf, int nbytes)
> > > >  {
> > > >  	char *p = buf;
> > > > +	int left = nbytes;  
> > > 
> > > Just a nit, but I know some kernel devs prefer "upside-down-xmas-tree"
> > > style of declarations. Which would make the above:
> > > 
> > > 	int left = nbytes;
> > > 	char *p = buf;  
> > 
> > Super specific coding style and rigorous code cleanliness is a big part
> > of why I love kernel dev.  Thanks for pointing this one out. 
> 
> It's a relatively new form, but I like it. It makes the code look "less
> messy" ;-)  Some devs don't care, others do. This file already breaks
> it, so it really is up to you. Like I said, it's "just a nit", not
> really important.
> 
> > 
> > While we are on these code lines, whats the typical kernel variable name
> > for a loop counter that is going to be counted down? 'left',
> > 'remaining', 'to_go', 'still'???
> 
> "left" looks good to me.
> 
> > 
> > > >  
> > > > -	trace_get_random_bytes_arch(nbytes, _RET_IP_);
> > > > -	while (nbytes) {
> > > > +	trace_get_random_bytes_arch(left, _RET_IP_);  
> > > 
> > > Nothing to do with this patch series, but I wonder if we should move
> > > the trace event below, and record how much was done.  
> > 
> > I don't fully understand trace events, I just left this line in tact
> > and hoped for the best :(
> 
> Your patch is fine. This could be something to add after your series.
> 
> > 
> > /me adds 'trace events' to list of things to learn more about
> 
> Just look at /sys/kernel/debug/tracing/events
> 
> Or read Documentation/trace/ftrace.{rst,txt}.

Awesome, cheers.
