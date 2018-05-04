Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZrEepq+74UmVawswFEFvm+GVkCRJxIrgRWLtxuk1laggAcgNykNnbHenoOFsgfxcWm37tI9
ARC-Seal: i=1; a=rsa-sha256; t=1525405834; cv=none;
        d=google.com; s=arc-20160816;
        b=tGRp98Mdf87o+7upG/aZa+XCGux/pU3DQtr6VEd0p2pD9lQat1r/tSQANOUWLjEcxt
         W5E/EnTIakNXPKJ8gJAb7L4PqVgi6sWpf0el7SbuTVSCvrnKFr0uPuHIPhHzj4rkE0jV
         EuFV9l9DPw3lCkM1Fui8QNrp+Z/VFcBmWd7lPSlgYjsTWdSKL4iKyt6e2mMTTvJBTCKy
         wi6/inxcI8QNOydYY7DFYMv20F1ZqN38/yLfDg3dDTxFdLZ/fK4XD8EnA05P0ml1oltd
         k9DP2vQtMmSKIF0+DA1QiywtJHXfMkd8PWicFwWpD6yVewzFeEzSJN1z0QcI5XuXJSiO
         ml7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=OotEfvRz6U+s9vyB+nxFcZVz2f7A48NO/UsGuENEZdU=;
        b=WZePSwkIEr6u4FYCqYruAT/bQjK3PgNO6FGtXLD5O0WZGpPQ0d5N9HjQESTnOs5lzy
         6nectp0s6cvdy6IirYI1YFKe4Sg8IOBJQIVATw5lNtD+CZfc0xtEc0be1i8z1z8UCcuQ
         2knehkK5LE+Ivs9McQV/53u3PlSY8kTVtPYCLQKa/SsMPQ2XOBCrx3myiqG2zCinaGQU
         4o9qXOQNGkAVzH20T6/FbNqgndkHGxCpjEyWL7tbYu/vy9gXWKkG4IhBH+v6JLDyXODK
         9fIaAfzQrFXav5OLDLoBnl+6N5RsKbca2bCr6iwGfjxkPUkCLP+AxBzywGuqfex30iaA
         oZKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=c7CtET3h;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Kz3NDhhE;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=c7CtET3h;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Kz3NDhhE;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:idjrWiFwqCJftNjNLVG_qs4kFnCIRb2H-j69IbBuig632WH8mvVUow>
Date: Fri, 4 May 2018 13:50:29 +1000
From: "Tobin C. Harding" <me@tobin.cc>
To: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/4] enable early printing of hashed pointers
Message-ID: <20180504035029.GB3712@eros>
References: <1525388861-27018-1-git-send-email-me@tobin.cc>
 <20180504022349.GH29205@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504022349.GH29205@thunk.org>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599486185375481881?=
X-GMAIL-MSGID: =?utf-8?q?1599503948388033820?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 10:23:49PM -0400, Theodore Y. Ts'o wrote:
> On Fri, May 04, 2018 at 09:07:37AM +1000, Tobin C. Harding wrote:
> > Currently if an attempt is made to print a pointer before there is
> > enough entropy then '(____ptrval____)' is printed.  This makes debugging
> > stack traces during early boot difficult.
> > 
> > It was observed that we can relax the requirement for cryptographically
> > secure hashing when debugging while still maintaining pointer hashing
> > behaviour.  This allows kernels to be debugged without developers
> > relying on different pointer printing behavior.
> > 
> > Using the hw RNG if available solves this problem for those machines
> > that have a hardware RNG, we would like to solve it for _all_ machines.
> > 
> > Patch 1 - Whitespace fixes.
> > Patch 2 - Fix get_random_bytes_arch()
> > Patch 3 - Use hw RNG for pointer hashing if available (by default).
> > Patch 4 - Use insecure hashing with command line option 'debug_early_boot'.
> 
> What tree are these patches going in?  It seems to be equally split
> between random and core kernel code.  I'm happy taking it in via the
> random tree, or if it goes in some other patch (I've already ack'ed
> the random changes).  I just want to make sure other folks aren't
> assuming I was going take the patches, while I was assuming it would
> go to Linus some other way.

Thanks for verifying this Ted, I was wondering the same thing.  Perhaps
this set should be split up, patch 4 is not related to the first three.
Assuming no comments come in over the next few days it looks like people
are ok with the first 3 patches, perhaps you could take those through
your tree (I can resend separately if easier for you).  I could then
re-spin the final patch a few more times and perhaps Andrew would take
it through his tree?

Feel free to violently correct me, I'm still learning the ins-and-outs
of the patch pathway to Linus.

thanks,
Tobin.
