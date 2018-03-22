Return-Path: <viro@ftp.linux.org.uk>
X-Google-Smtp-Source: AG47ELt5Uou47qG6mdtra35QujgC7oHXrUjO6TfE1pU0/PBQbhlmPRz/0BgrN2z6V/Ql4XYX3u+p
ARC-Seal: i=1; a=rsa-sha256; t=1521717279; cv=none;
        d=google.com; s=arc-20160816;
        b=nJab2z6EPq4Mzyuihgd/X0JIoCRETyy1VTW2vTa7TjQRYgiIiqSWWp9oGtrFHzltMC
         sb2I+kCMIsHDhCkyZcWEb1SkTzn964XrPIyfM5TYBhzcGJ1WJd1gO6EJP0VYEGW9l2CJ
         V4TpL2ZO5OCy9tqhEyUXF9Z+tH+cbn7wa8pWkTP5ofGmh5vp0X6grnFCysbvvvD97YKu
         1/pZhD2BQLfRFPvJ6h4cuO0De593GYcRZ0CYeOTJV0wl2ked2JZuhVdhcu9F9O4OAgVa
         whOUOgEv2fNClHpQd7mZiMLrWgbK1farA9/lEJm3ofNEdC8hzwgikUhssZWW754M87AQ
         umFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=zeE7pqd9Nrwer8a9PaEBImq/wEQxFI961ReyxoQMWN4=;
        b=UhwgGZJKriQkxe6pO/ZJe0moG4qOTWm+mNNZuMi6Nmv2Hy+hkTi653lIHaQdVUIUnI
         tZIZYFilaKSGLrUxBxqQGxfrl3gaAGRQKa8ny8pivdE7RXpMurW+iVL0zzXe0Wu6H1UT
         zRJIdMD9KzkL+pZBdiBH+71OISj0JcPYyX5kuPd1sYIXp+628Th+Lx7D1oQJmqFUXmmm
         i9gKqXkfQIh4E+Hqikr8Hurj+BQ1gWKFppgrgZbX0dj09ZrOAFiH7lUw9bkjVXicMngX
         3mmwGOxHPf5F0q7nA7V2zu4oZnTCp3kKv1IORI0ghMMXw1i6+v2ZfEeE4vPxhxaPPPnC
         gBHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Date: Thu, 22 Mar 2018 11:14:25 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] locks: change POSIX lock ownership on execve when
 files_struct is displaced
Message-ID: <20180322111424.GE30522@ZenIV.linux.org.uk>
References: <20180317142520.30520-1-jlayton@kernel.org>
 <20180317165859.26200-1-jlayton@kernel.org>
 <87bmfgvg8w.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bmfgvg8w.fsf@xmission.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: Al Viro <viro@ftp.linux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595195233416759536?=
X-GMAIL-MSGID: =?utf-8?q?1595636217508596654?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 12:19:59AM -0500, Eric W. Biederman wrote:
> Jeff Layton <jlayton@kernel.org> writes:
> 
> > From: Jeff Layton <jlayton@redhat.com>
> >
> > POSIX mandates that open fds and their associated file locks should be
> > preserved across an execve. This works, unless the process is
> > multithreaded at the time that execve is called.
> 
> Would this perhaps work better if we moved unshare_files to after or
> inside of de_thread.  That would remove any cases where fd->count is > 1
> simply because you are multi-threaded.  It would only leave the strange
> cases where files struct is shared between different processes.

So during the probing of binfmts, etc. the descriptor table would be modifiable
by other threads?

flush_old_exec() is far too late in execve()...
