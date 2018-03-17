Return-Path: <viro@ftp.linux.org.uk>
X-Google-Smtp-Source: AG47ELuEh5NQdo9ibngg2o+1GmkExUGLF6d+6h3jttF90TZUMEufOCiPkcbX2h6R7MOwmZz1txzm
ARC-Seal: i=1; a=rsa-sha256; t=1521301960; cv=none;
        d=google.com; s=arc-20160816;
        b=eT8SgU1XA8+VoxdDn+yb4UJTKsL2OQJBZD2c2g+Cg+cL8SZMrA1za7L5ftSMJ5qdta
         s9IXKsjC2CA+uTmp+KEP8+2bzWy3M7oBDOQxGWCjYR5ZdBK9LTM7wPOxUr++x+02LZCM
         6Th7bFZ1Bu5I5yVz4ZZvmmh7Y1L9VDDGaRHxqtc5P57VBe+1PtNZGhX85nJAeM3Gm7MA
         miy/vIT7pkh8s5YgN4rOJwOq6hwIwpeCUJpwU7bBOZpC8FcSlbJfsMMDvFSG89Oxmphl
         3IT7sXzBUsa/lteb3yYkWvKN9bXgLldnnxmmwESD15ACBbebsu5C6UNoFbvZUn8jplxv
         4XzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=fC0yYW+KYL1o7QWxrXkJSOnjXILLeuYtK+kG8Xz7p8E=;
        b=MlyL13kI7uMUNkVza/ZUx6zUu3o9TW0iJ0MZvxwBXIkzuQvAD8Yh1lfMymTlArUZhM
         9rmMbSpXyN1C/TzL+gjyR1UYcP9CtUEqFZWrDXuDeqvwpKrly5DZRuHqBYdvr+9WHSSY
         A+gYK0E2oPWz8LapYG+PCPhAJDN/l1bjz32khAG5Fa/AXvSEbV7CmqSMC2FVQLem08BH
         YOo+HhHr29nr90afXEpWS4PElFjLaa0+AoClyngiqps8ZyvKHU1lWTbdbTTyJ/xp649A
         piU1DgzE6fotmZKSRowUjoZ6JvzTBvo4XPha6dRkSB9UHIf1nfa/yBIDTYeTQohk2XU/
         LOSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Date: Sat, 17 Mar 2018 15:52:28 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] locks: change POSIX lock ownership on execve when
 files_struct is displaced
Message-ID: <20180317155228.GN30522@ZenIV.linux.org.uk>
References: <20180317142520.30520-1-jlayton@kernel.org>
 <20180317150533.GM30522@ZenIV.linux.org.uk>
 <1521301408.4064.4.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521301408.4064.4.camel@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: Al Viro <viro@ftp.linux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595195233416759536?=
X-GMAIL-MSGID: =?utf-8?q?1595200724570528919?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 17, 2018 at 11:43:28AM -0400, Jeff Layton wrote:
> On Sat, 2018-03-17 at 15:05 +0000, Al Viro wrote:
> > On Sat, Mar 17, 2018 at 10:25:20AM -0400, Jeff Layton wrote:
> > > From: Jeff Layton <jlayton@redhat.com>
> > > 
> > > POSIX mandates that open fds and their associated file locks should be
> > > preserved across an execve. This works, unless the process is
> > > multithreaded at the time that execve is called.
> > > 
> > > In that case, we'll end up unsharing the files_struct but the locks will
> > > still have their fl_owner set to the address of the old one. Eventually,
> > > when the other threads die and the last reference to the old
> > > files_struct is put, any POSIX locks get torn down since it looks like
> > > a close occurred on them.
> > > 
> > > The result is that all of your open files will be intact with none of
> > > the locks you held before execve. The simple answer to this is "use OFD
> > > locks", but this is a nasty surprise and it violates the spec.
> > > 
> > > On a successful execve, change ownership of any POSIX file_locks
> > > associated with the old files_struct to the new one, if we ended up
> > > swapping it out.
> > 
> > TBH, I don't like the way you implement that.  Why not simply use
> > iterate_fd()?
> 
> Ahh, I wasn't aware of it. I copied the loop in change_lock_owners from
> close_files. I'll have a look at iterate_fd().

BTW, if iterate_fd() turns out to be slower, it might make sense to have it
look at the bitmap to skip unpopulated parts of descriptor table faster -
other users might also benefit from that.
