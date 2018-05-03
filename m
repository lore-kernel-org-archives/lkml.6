Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZpS42piX92NyqqXPyyWbBoivvxUDh6Ob/o/EyjUvJF/xN2FdzipmGRTpHycdwbcRfIeSMBR
ARC-Seal: i=1; a=rsa-sha256; t=1525316220; cv=none;
        d=google.com; s=arc-20160816;
        b=Kp61ZM3UFuoo9PX/nxXCk83XqdfJwXG4uYAIBHt1aQY6Jswwa/xwNLIE/VLJ/XNbNf
         Bf4s/wWJXRJ4JOirIbAv8EGJO6pLdubYp+w7eggmOnSlTx9GtK2U9vITzRjNjfsG3cOx
         qwFbNALqmnmdICzIT+j8vaqyFU6Qee7HIWc0QOQRksxEAWEeDbvRz8N9/tMbZ++J5foR
         4EIS1sKSAMDWhpagsuV4wvkQRLLWBIEu4xGWnDVUXWZO6hSYHspvGfhWe9WcI/bPyY0N
         ZjNFU15GtfkrrVMCvpKMABslJR2qkDua4JsuuX9+gobQdBk3WjaoRc3GusWw6QNYLSVA
         m60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=R2UmE1K2yeKXv2irPH0wfbCDEYZZEQzrdi6C9qgR9qU=;
        b=eezfJwb5kuMaAsj1wsYLzkv/AsTMfZOqCzHtPlylUBU/JFG4sMDQw+fbNU2XAAwZbw
         ArbG7giAwnhYy/JA1mZV0SPPrz3N5ipTyoZAUW5mFXUbj75GtlvcJ29KlI1U13j1bU1+
         fF6bP+2S80/LLz8M4aMlJiE9aw0bsMqtQHHMlYYp/NxkjnrcyS3e/8iIfBeuvQAEPLmq
         JyNIVBWxWCMdNcQIVWVU2CJPRssCmPBZ4iwh8yIeTuUInmSRNYaqSmQ9rRrfSXNhEKt9
         HqiXi36W8I0wTtGj+39IchtRxNjFxXhDHtNUtWqch2RuCs7132bDThIh3a/QJoTgj1LV
         6vvw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=YQxiGMM9;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=PjRm6WZ1;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=YQxiGMM9;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=PjRm6WZ1;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:e3rqWqttEd-jnJ6QxzdLEvMBQzpDG1i4n70xcnPtxa0jabWAbkRKuQ>
Date: Thu, 3 May 2018 12:56:55 +1000
From: "Tobin C. Harding" <me@tobin.cc>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Theodore Ts'o <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] vsprintf: Add use-early-random-bytes cmd line option
Message-ID: <20180503025655.GL3791@eros>
References: <1525217620-4107-1-git-send-email-me@tobin.cc>
 <1525217620-4107-4-git-send-email-me@tobin.cc>
 <20180502145645.a1fa72b86f2501432f003edc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502145645.a1fa72b86f2501432f003edc@linux-foundation.org>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599306645428721863?=
X-GMAIL-MSGID: =?utf-8?q?1599409981586543365?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 02:56:45PM -0700, Andrew Morton wrote:
> On Wed,  2 May 2018 09:33:40 +1000 "Tobin C. Harding" <me@tobin.cc> wrote:
> 
> > Currently if an attempt is made to print a pointer before there is
> > enough entropy then '(____ptrval____)' is printed.  This makes debugging
> > early stage stack traces difficult.  We can relax the requirement for
> > cryptographically secure hashing when debugging while still maintaining
> > pointer hashing behaviour.
> > 
> > Add a command line option 'use-early-random-bytes'.  When enabled get
> > key material from the hw RNG if available.
> 
> Documentation/admin-guide/kernel-parameters.rst, please.
> 
> > This option should NOT be enabled on production kernels.
> 
> And the documentation should explain why this recommendation is made. 
> Here was I scratching my head wondering why this feature isn't just
> permanently enabled.  Still scratching away...

Thanks for the review.  I think v2 covers your concerns, it patches
Documentation/kernel-parameters

If you are still scratching after reading v2 please do say so, I
appreciate the feedback.

thanks,
Tobin.
