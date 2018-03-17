Return-Path: <jlayton@kernel.org>
X-Google-Smtp-Source: AG47ELtsj/ctQJoUCuRrd9MgCQZjbiMVbAvY8Hj3Lc6CqwYoWR8deNh38zv0AiQP0nNpI78tOeDU
ARC-Seal: i=1; a=rsa-sha256; t=1521301411; cv=none;
        d=google.com; s=arc-20160816;
        b=BEulLf7fFd2rBEyZtlWTIFg9ZICCkGwTiORyaVAtw038hJG5uQKEDrcAKSFs5M8e2H
         e7mtTnOZrKV6/z4//caTnKx+RHPJU9rBdLXHAOwYDLy9JCs0wX4+7KifTiz8rfdoQE4X
         ynKyEYPA4uAIDORoOwq7+spAh6IYEwIHPLLvKwG2Dq+v1qMHezNx2u7K9pQqvX3JxmHk
         ttJh+31dZo7zyVRilKVWezaQkuGA459R7EwkFhFcGCeVByRRgI009BVMC9SY8miBaqKE
         q+B5WO+tgga2hSw7qkTQR1Ppd+yAM1CEGuDAwLFlt9tZ2VRAqaCECWaMPqwOvat/1yp7
         9X2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dmarc-filter
         :arc-authentication-results;
        bh=qm+gXPn0kY4Yf4JLu66CW0JZ4HANvk8POYMMXcHedhE=;
        b=iwIXndNL7YzEsLjoBBdsxpdVGbNC1oYcL8Gl8zAWPf9wz3MDnlNlKYsWysLW2mewH5
         9RiVU4qfGClTVpKrxZNIzDZWDSWmQqgJNPggeGyTqLDkZ+/7pKWOa0H2HG1MR/UQL3zp
         GN9rSsSq3ZgOf5zJ9v1G0RiqklfT+yRyF/XFIJKtfMetU/PZfGkZy2O7uzY2hUP6+bhf
         dfAYaYTU0t2NvebYjlvUeF6sM9Qtiepyh98MCluSyFEBUmuQFIA1h+ensRXcw7hxq283
         120YSYTHrgTXKWvlpOO3hY+wkcMbu3PjSFR9npYWklhiNaHKFgNoTfABFa9BXH3JHWpF
         vERg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jlayton@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jlayton@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jlayton@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jlayton@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C73920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jlayton@kernel.org
Message-ID: <1521301408.4064.4.camel@kernel.org>
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
Date: Sat, 17 Mar 2018 11:43:28 -0400
In-Reply-To: <20180317150533.GM30522@ZenIV.linux.org.uk>
References: <20180317142520.30520-1-jlayton@kernel.org>
	 <20180317150533.GM30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595195233416759536?=
X-GMAIL-MSGID: =?utf-8?q?1595200148715382874?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 2018-03-17 at 15:05 +0000, Al Viro wrote:
> On Sat, Mar 17, 2018 at 10:25:20AM -0400, Jeff Layton wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> > 
> > POSIX mandates that open fds and their associated file locks should be
> > preserved across an execve. This works, unless the process is
> > multithreaded at the time that execve is called.
> > 
> > In that case, we'll end up unsharing the files_struct but the locks will
> > still have their fl_owner set to the address of the old one. Eventually,
> > when the other threads die and the last reference to the old
> > files_struct is put, any POSIX locks get torn down since it looks like
> > a close occurred on them.
> > 
> > The result is that all of your open files will be intact with none of
> > the locks you held before execve. The simple answer to this is "use OFD
> > locks", but this is a nasty surprise and it violates the spec.
> > 
> > On a successful execve, change ownership of any POSIX file_locks
> > associated with the old files_struct to the new one, if we ended up
> > swapping it out.
> 
> TBH, I don't like the way you implement that.  Why not simply use
> iterate_fd()?

Ahh, I wasn't aware of it. I copied the loop in change_lock_owners from
close_files. I'll have a look at iterate_fd().

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
