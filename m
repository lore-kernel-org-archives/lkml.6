Return-Path: <tytso@thunk.org>
X-Google-Smtp-Source: AB8JxZqL1v24E59lf+pIhuTp8+jnsN+M9PWLATerxpg8g0rvbo9K79fKMLSRHoDDpYPRnX/6PQwB
ARC-Seal: i=1; a=rsa-sha256; t=1525400650; cv=none;
        d=google.com; s=arc-20160816;
        b=NwU3Rvti83k/8CekOxUByRll10lnMtrh22/ue5w/Cei2NTtH0M/ZiNWvnMOyvQ2+qg
         J7AdGjSoZI+YQXvdv7L9CkFfL3jvXz0ZmtSEAY2xmrm4Ky1PRw2vdt/T+jmqpgubvjZF
         yiZ3yVgjYWZq3wmJgvmKqQ5qIgg7XgBWwOJt3RsH9Bwf7NARHNQRadIP5PaYWQxFLmrU
         rc+edG/iHhjztc3kMtDFFjAlBbBwBzeUbFoA684xkNfA3/8gnofy/ps2oAHZuA+sHK07
         voRhUevPG/eD1fQLKMiFzotMOnbe9REk86/ponzCLLiQfN/DnrHYjRswB01aOfGfJ/US
         6sEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=97uYGGCmcZHrEF/rkqdhugK4alP8DTpkSpGrCUSIAEw=;
        b=LoPIUyoNsJLMiJ67E2iisomPpYgPI0BUSU61ez3GFZieoxctoQdPnXkIPKRTso2jom
         BJ6R+bdyycr0GRNUjpxD5aa6yKlp7av/mqgu/5Z/Co7CkrMnjeDUQjMDQcqJZ7p++a/x
         2GpKmN0+hJeRuRpnra94wpUEJTFcZUyY0h9FRNx3I3FxpCMCksjjFsrcNlGj1KpDRByU
         LaTCSKD7lvxwvGG3x4u6gC69ZPAFyBta0jrEwYUDIgaRimihW/uCN1LnN0xqYhkQH8QF
         YZ85uJJSnmMSwPkfU+RnqxCdGoI8xhyg91RokDgdvTgX4TIb58w3tO2X4xlaHSIotmP9
         KxIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=jWRnAKLp;
       spf=pass (google.com: domain of tytso@thunk.org designates 74.207.234.97 as permitted sender) smtp.mailfrom=tytso@thunk.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=jWRnAKLp;
       spf=pass (google.com: domain of tytso@thunk.org designates 74.207.234.97 as permitted sender) smtp.mailfrom=tytso@thunk.org
Date: Thu, 3 May 2018 22:23:49 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/4] enable early printing of hashed pointers
Message-ID: <20180504022349.GH29205@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	"Tobin C. Harding" <me@tobin.cc>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
References: <1525388861-27018-1-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525388861-27018-1-git-send-email-me@tobin.cc>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599486185375481881?=
X-GMAIL-MSGID: =?utf-8?q?1599498512439415614?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 09:07:37AM +1000, Tobin C. Harding wrote:
> Currently if an attempt is made to print a pointer before there is
> enough entropy then '(____ptrval____)' is printed.  This makes debugging
> stack traces during early boot difficult.
> 
> It was observed that we can relax the requirement for cryptographically
> secure hashing when debugging while still maintaining pointer hashing
> behaviour.  This allows kernels to be debugged without developers
> relying on different pointer printing behavior.
> 
> Using the hw RNG if available solves this problem for those machines
> that have a hardware RNG, we would like to solve it for _all_ machines.
> 
> Patch 1 - Whitespace fixes.
> Patch 2 - Fix get_random_bytes_arch()
> Patch 3 - Use hw RNG for pointer hashing if available (by default).
> Patch 4 - Use insecure hashing with command line option 'debug_early_boot'.

What tree are these patches going in?  It seems to be equally split
between random and core kernel code.  I'm happy taking it in via the
random tree, or if it goes in some other patch (I've already ack'ed
the random changes).  I just want to make sure other folks aren't
assuming I was going take the patches, while I was assuming it would
go to Linus some other way.

				- Ted
