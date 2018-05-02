Return-Path: <SRS0=DzSU=HV=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AB8JxZp210kt2/1RNlsBFI5Njmd8A2tjnQ8ucahmqDqKXL0RwIaH2V9c0BBrKEddytrWM2v4CdDV
ARC-Seal: i=1; a=rsa-sha256; t=1525225510; cv=none;
        d=google.com; s=arc-20160816;
        b=XIA2CZ24kvIV3cbLgG5KNJFBO1r79P6xZ/K7R0h4oCZAK4OscHo9dDY1yUL8FZlRZZ
         T+YqxGvj3MFWcQcfmdwkAHQTu6P1wwSpgxSFruhP7kx60WBL4ueIlulUD0sUW9aRMVzy
         hyIHFrT3UmQOwQfmTeFcNUFNsyNSR2a8VHQiyHEUVX/k+MYv+hq0BopE4rUZhWDjgU7A
         mvmTm/swp7sgjjWM/hwRPlMvQNQ9aF8vYBAnw2zQMZa8wznRueOdTFqPr4WBdANxYwiC
         sc/cTki51Tqd5kpoHkAdX9VS6+o7GKSzgQ40cSTnEzbLWttEAR8ZARn7mATOaddbltQ3
         QqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=coVzBXHODu/BJpHOTdQoD2dy+AAqCMz6Yz+juvwoHkI=;
        b=n+rU+Lxt8cWdB5YUs39yigI4Kjhk5ruAni5H8UYAPcpck5roOeN6Kebd+9FJ+V68ux
         xQYscQhzQur/ZF3LLY+3MoK9jEESnz2uDOejX/sUnTz8ajDNkw8PjbKWcWE+1upvbUUz
         BxIGUi31iqG44uWlfy7thpR7I3N+I8oC3ebwtypF2myIfhRAZJSpJzDjiOUf/7SmbIQR
         5OmWswIHAcGONK/9+a74AODMBaOJnALL5g9XbMm2Czyicn1/+w5Dh4Ra25Yl2plOSO2Y
         MZwKbrcEFTPwKbPAPbUNnJ0LDjqUZ6bDg+0uCYOywcZdLn0/bAJnSFV0OmqdsTyPJwx3
         VfJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srs0=dzsu=hv=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=DzSU=HV=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srs0=dzsu=hv=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=DzSU=HV=goodmis.org=rostedt@kernel.org
Date: Tue, 1 May 2018 21:45:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: tcharding <me@tobin.cc>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Kees Cook <keescook@chromium.org>, Anna-Maria Gleixner
 <anna-maria@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
 Theodore Ts'o <tytso@mit.edu>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] vsprintf: Add use-early-random-bytes cmd line
 option
Message-ID: <20180501214507.22138131@vmware.local.home>
In-Reply-To: <20180502012758.GD3791@eros>
References: <1525217620-4107-1-git-send-email-me@tobin.cc>
	<1525217620-4107-4-git-send-email-me@tobin.cc>
	<CA+55aFzuGrp3XGhsj989XS-vAw9S9bzFUX6mNpvPaMfew6v1iA@mail.gmail.com>
	<20180502012758.GD3791@eros>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599306645428721863?=
X-GMAIL-MSGID: =?utf-8?q?1599314864549834987?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2 May 2018 11:27:58 +1000
tcharding <me@tobin.cc> wrote:

> On Wed, May 02, 2018 at 01:02:34AM +0000, Linus Torvalds wrote:
> > On Tue, May 1, 2018 at 4:34 PM Tobin C. Harding <me@tobin.cc> wrote:
> > 
> >   
> > > This option should NOT be enabled on production kernels.  
> > 
> > I think with your fixes to get_random_bytes_arch(), it's perfectly fine to
> > use on production kernels (and doesn't even need a kernel command line
> > option).
> > 
> > It was only with the "use weak crypto" (that get_random_bytes_arch() used
> > to fall back on) that it was a problem. That fixed "verify that
> > get_random_bytes_arch() really uses hw crypto" is certainly not weak crypto.  

Except for where hardware vendors control what random bytes you
actually get ;-)

> 
> Ok, I'll wait to see if anyone with a more paranoid disposition adds to
> this otherwise will implement as suggested.

I still test on a lot of old boxes (my old workstations turn into my
test boxes). I haven't tried to see which machines have RDRAND support.
But regardless, can we still have a command line option that forces
early randomization even if RDRAND isn't supported?

-- Steve
