Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZqYv9hW2FEijyE2UqPNBlJr3kiyT+mb3Rd1XPmQixVcUnrxxbYIW+TDbpSKUrTYrLPIKyAT
ARC-Seal: i=1; a=rsa-sha256; t=1526418603; cv=none;
        d=google.com; s=arc-20160816;
        b=uV0rIZ258mHpyy8m89vB9WTCfaxVxPST4hf7Wol+rLnRT537HOkoSd8KDQm+uF4rfl
         NOFs3k+aB///ZqivwTppoY73+/jjUTzjIx6l9HvTe8wK8P7y8uXRvNbXf8We7WhSybey
         1C5+P8nqVizXozCJhi1kk9wC6f2kBlYzWzVxUlzs8yIs4q787HLqB8HvDUwQVWwcwjJf
         maSYDRQwXOZivLO28bpKN0hTb1L3Yz8jHoTJlaKom4PT0LDwh+kTsG6YNn2uasMdrbqS
         t1NsEGMLKGtPUX+93oR/4ruQdidYjGV2xOiTFOh4vgyAYiZagZYAE1M43fD9MHDxd7SM
         frVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=e7zXlRYI/cphqJXQe4vG0sslfPyYX64qlnUlGfqgJFA=;
        b=cm/XBKzyvLiLTEAdqi6tn2q3o98V/p95yHrE5zrJ0MJWl7BHrJ7BTjGw7hwmWmXu3/
         ZmWRQjhVDwpiKoxF79gPnapmdkCBpDiO0aJop+AC4oWyagNaIlIL5OsZ4LeJyQ9olT0L
         7TRvv0cYcxA4gQA+qQKeGJmrKc0RKuIoezjybuYsLiR7NKEct/O2p4FoYZxmtcskROBB
         tnuu57l0G9XrGXyL+1EVPKLl2/e5a57uENe5QRVju4XAL2WlLnA0KO7jZ8sBYLEe5BPb
         lW2F2rDdsCAoz4CXuvbsRCOKXGGl4JAozNa1SQvec1HDpRjfPVZo2AQ3IwQJWg5230Mt
         dBUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=kRSPoiG/;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=mlnhJvJ+;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=kRSPoiG/;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=mlnhJvJ+;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:qEz7Wo7mVYN_TMY7Nawc0ohVrgLWl0Fx5v58tYsBCc0hO_gJlXEZDg>
Date: Wed, 16 May 2018 07:09:55 +1000
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
Subject: Re: [PATCH v4 3/3] vsprintf: Use hw RNG for ptr_key
Message-ID: <20180515210955.GF10152@eros>
References: <1526353586-30092-1-git-send-email-me@tobin.cc>
 <1526353586-30092-4-git-send-email-me@tobin.cc>
 <20180515094744.45267e97@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515094744.45267e97@gandalf.local.home>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600497770894213434?=
X-GMAIL-MSGID: =?utf-8?q?1600565913216960154?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 09:47:44AM -0400, Steven Rostedt wrote:
> On Tue, 15 May 2018 13:06:26 +1000
> "Tobin C. Harding" <me@tobin.cc> wrote:
> 
> > Currently we must wait for enough entropy to become available before
> > hashed pointers can be printed.  We can remove this wait by using the
> > hw RNG if available.
> > 
> > Use hw RNG to get keying material.
> > 
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > ---
> >  lib/vsprintf.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index b82f0c6c2aec..3697a19c2b25 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -1657,9 +1657,8 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
> >  static bool have_filled_random_ptr_key __read_mostly;
> >  static siphash_key_t ptr_key __read_mostly;
> >  
> > -static void fill_random_ptr_key(struct random_ready_callback *unused)
> > +static void ptr_key_ready(void)
> >  {
> > -	get_random_bytes(&ptr_key, sizeof(ptr_key));
> >  	/*
> >  	 * have_filled_random_ptr_key==true is dependent on get_random_bytes().
> >  	 * ptr_to_id() needs to see have_filled_random_ptr_key==true
> 
> Nothing to do with this patch, but I believe there's a missing memory
> barrier in the code.
> 
> Right after this we have:
> 
> 	smp_mb();
> 	WRITE_ONCE(have_filled_random_ptr_key, true);
> 
> Where the comment says that have_filled_random_ptr_key must be set
> after ptr_key has been updated. But there's no memory barrier on the
> read side. In fact, I think this could be a smp_wmb() instead of a
> smp_mb(). The read side has:
> 
> 	if (unlikely(!have_filled_random_ptr_key))
> 		return string(buf, end, "(ptrval)", spec);
> 
> /* Missing memory barrier smp_rmb() here. */
> 
> 	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
> 
> Thus we can have something like:
> 
> 	CPU0				CPU1
> 	----				----
> 				   load ptr_key = 0
>    store ptr_key = random
>    smp_mb()
>    store have_filled_random_ptr_key
> 
> 				   load have_filled_random_ptr_key = true
> 
> 				    BAD BAD BAD!
> 
> I'll send a patch.

Awesome reviewing.  Thanks for catching this.


	Tobin
