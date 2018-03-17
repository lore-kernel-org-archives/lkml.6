Return-Path: <jlayton@kernel.org>
X-Google-Smtp-Source: AG47ELuWYKWxDAi9rFJlzBBi23rPq+egp+TH+J/viSInt3sgKFun7FfvoiT6UU+yygfGqhqwUWfl
ARC-Seal: i=1; a=rsa-sha256; t=1521314894; cv=none;
        d=google.com; s=arc-20160816;
        b=Z9dWIvsfZ8mWbdE0nAWdLyDuMwPjPREayuOcx/ibPVX7z8wREzRzsZGJz+dlDjBUgK
         Ss/JGOCBIEwmQZcIL3MetWyEaUV9X4ofVT+KE43fqKa9z9dQBCDKpuVX094zQclYHvy5
         pXd5SpN5/r28RNPZ8PCpAG6X9hOTKE4I8uu2zkUX0eAkfbgVbpHzB7W/UyB4K/O2KhVc
         fPH7K7xovYhJwfK2CtvklklF8sW8pZ0PPbDd3N9r3P+gbiuhYtAg+2EjNuhbrHrCnMrb
         XZrz3X8RpeSKKR3OBmioPx5ImZuuNIogo+mvzsTw7lBt7UDhdS2Gtc6vzobnyzD8sbZ1
         BZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dmarc-filter
         :arc-authentication-results;
        bh=8eY5C7xN8gpsvQEm9I3mgdSr7J8n1DXEGXSZFselqE0=;
        b=W2JCsRUDM6Nui46jSKFLgYsRh21phXm0k4BSFeGD4oMyfHmUgBCNkvFM3zcY6i7P2+
         UMTtYmnkN9Lr2WwjqReIrUJkAyzpplEUcbwEbC0aLzOt5DanG+X1OCdyp7VzV6tfEJOy
         Vcf5YTXyTGe6oadu6FXKIK5s+DTaLbotoN+ZK+pGvwzGuma98a57zQT5lBKwC+LU7yUb
         ok7Y+KpidhU+eNzf0bScV3UA4kRqQzbenMqKeFLC4RyGyoIpPO/YXsBdEXeoNZ97RTW1
         TwzY/VSzuIAKJ2dZCp3BJ7kQ3wKm8qw1kbH6rzY3kHakecLBtThwyhP3TFPL8cVqE5NJ
         FRqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jlayton@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jlayton@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jlayton@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jlayton@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F13521741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jlayton@kernel.org
Message-ID: <1521314890.4064.12.camel@kernel.org>
Subject: Re: [PATCH] locks: change POSIX lock ownership on execve when
 files_struct is displaced
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, "J. Bruce
 Fields" <bfields@fieldses.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Daniel P ." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Kate
 Stewart <kstewart@linuxfoundation.org>, Dan Williams
 <dan.j.williams@intel.com>, Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sat, 17 Mar 2018 15:28:10 -0400
In-Reply-To: <20180317155228.GN30522@ZenIV.linux.org.uk>
References: <20180317142520.30520-1-jlayton@kernel.org>
	 <20180317150533.GM30522@ZenIV.linux.org.uk>
	 <1521301408.4064.4.camel@kernel.org>
	 <20180317155228.GN30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595195233416759536?=
X-GMAIL-MSGID: =?utf-8?q?1595214286611066001?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 2018-03-17 at 15:52 +0000, Al Viro wrote:
> On Sat, Mar 17, 2018 at 11:43:28AM -0400, Jeff Layton wrote:
> > On Sat, 2018-03-17 at 15:05 +0000, Al Viro wrote:
> > > On Sat, Mar 17, 2018 at 10:25:20AM -0400, Jeff Layton wrote:
> > > > From: Jeff Layton <jlayton@redhat.com>
> > > > 
> > > > POSIX mandates that open fds and their associated file locks should be
> > > > preserved across an execve. This works, unless the process is
> > > > multithreaded at the time that execve is called.
> > > > 
> > > > In that case, we'll end up unsharing the files_struct but the locks will
> > > > still have their fl_owner set to the address of the old one. Eventually,
> > > > when the other threads die and the last reference to the old
> > > > files_struct is put, any POSIX locks get torn down since it looks like
> > > > a close occurred on them.
> > > > 
> > > > The result is that all of your open files will be intact with none of
> > > > the locks you held before execve. The simple answer to this is "use OFD
> > > > locks", but this is a nasty surprise and it violates the spec.
> > > > 
> > > > On a successful execve, change ownership of any POSIX file_locks
> > > > associated with the old files_struct to the new one, if we ended up
> > > > swapping it out.
> > > 
> > > TBH, I don't like the way you implement that.  Why not simply use
> > > iterate_fd()?
> > 
> > Ahh, I wasn't aware of it. I copied the loop in change_lock_owners from
> > close_files. I'll have a look at iterate_fd().
> 
> BTW, if iterate_fd() turns out to be slower, it might make sense to have it
> look at the bitmap to skip unpopulated parts of descriptor table faster -
> other users might also benefit from that.

Thanks, I'll keep that in mind.

Full disclosure: I haven't done any performance testing with this. My
assumption is that threaded programs that execve without forking first
are rather rare. I don't know of a great way to confirm that though.

I made a small change to the v2 patch as well to use
struct files_struct * instead of fl_owner_t here. That gives us more
type safety and should prevent any problems if Bruce's patch to remove
fl_owner_t gets merged.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
