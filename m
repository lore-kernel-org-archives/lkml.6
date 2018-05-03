Return-Path: <viro@ftp.linux.org.uk>
X-Google-Smtp-Source: AB8JxZq+vVLrzZIQBw0vmls5xjnPqWGwChct3uJKf/SYzmwOIdRK8vVd6Y93EKP9ACEj2KVK8XBC
ARC-Seal: i=1; a=rsa-sha256; t=1525355000; cv=none;
        d=google.com; s=arc-20160816;
        b=olaHHGd1QoKfZWwKZ6dgJPe74af07Me9fct3btnFbNaSiDVvqf5H9AxRoiLpd+5gQN
         buWNhmr8E0339E+o2GJ9+Gppk/Qotpg9ZAMPpwSunBQMTouU5J6waJhHYS84OAhAM9PS
         B5MdlvLr7DevKZGP/Tv4xb9qEDbW7MSA2r3PidQsQcQtKDJRX4SvOoLTnzf62SfVV66H
         3FZC8Yz7n534iou+RsZqAjzFpJjz931h+evQRmsdDriXWPBjaJYoJGH+RIqHXz0Hh6cU
         545upRLn/WRva53QykqHdySAcSMQ9R9ZzVhBkx2nso7iEOCX4mjgb+SoDiP6kEiFgcwa
         lDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=aIky7PZtQEn8ymmBgjA17CmSsAcJRhId6YNETTB2vHM=;
        b=HiV6MRyUI9E8W2ADlbsGNOqRsCLow6XEMI8RD5vOB7qKIx1x6YkgS7P/OmauYHODIB
         WMCOxah2U4SZn0C6y9sf1nKu90AQDjlSZwE+WLXlACVNG3f/uS470gfE+4Bvv5JD65PR
         /+iJS9lDt1EHy5auzT1acqvH7+QDzdtnuZM463s4lpq1bU74+6XrFElSKNWuKeu/H1M/
         f4RObhZcTmQuKACAvGPPu1kRiE4gw0hyYpakulSpXo413Bx3E0WP4qOdB6zkpgWVRLOe
         dD4ccXsQ0lamqb7D0OUzOBye2n3C1mN3jKVJeqaFiphcgQz07YkSXW2q7pvmmSVr3VSX
         OlHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Date: Thu, 3 May 2018 14:43:17 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christian Brauner <christian.brauner@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	hch@infradead.org, tglx@linutronix.de, kstewart@linuxfoundation.org,
	Greg KH <gregkh@linuxfoundation.org>, pombredanne@nexb.com,
	Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 0/6 resend] statfs: handle mount propagation
Message-ID: <20180503134317.GA30522@ZenIV.linux.org.uk>
References: <20180502154239.14013-1-christian.brauner@ubuntu.com>
 <20180502160939.GU30522@ZenIV.linux.org.uk>
 <CAPP7u0VPyWAsL_kkb4JnJHMmK=kM0m4zRjVjst1iHDd6V=t0mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPP7u0VPyWAsL_kkb4JnJHMmK=kM0m4zRjVjst1iHDd6V=t0mQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: Al Viro <viro@ftp.linux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599367740433603357?=
X-GMAIL-MSGID: =?utf-8?q?1599450644653667613?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 03:04:36PM +0200, Christian Brauner wrote:

> >From a userspace perspective we often run into the case where we simply
> want to know whether a given mountpoint is MS_SHARED or is MS_SLAVE.
> If it is we remount it as MS_PRIVATE to prevent any propagation from
> happening. We don't care about the peer relationship or how the
> propagation is exactly setup. We only want to prevent any propagation
> from happening.

So what's to stop you from doing exactly that --
	mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL)
without bothering with statfs() in the first place?  It's not like the
damn thing had been costly - it's O(mounts in your namespace) with not
to high constant, and in any case cheaper than allocating all of them
back when you did clone(2).  Confused...

> The above case is what I see most often. A more specific use-case is to
> differentiate between MS_SLAVE and MS_SHARED mountpoints.
> Mountpoints that are MS_SLAVE are kept intact and mountpoints that are
> MS_SHARED are made MS_PRIVATE.
> 
> For both cases the only way to do this right now is by parsing
> /proc/<pid>/mountinfo. Yes, it is doable but still it is somewhat costly
> and annoying as e.g. those mount propagation fields are optional.

Umm...  And how would you get the list of mountpoints to feed to statfs()
if not by parsing mountinfo?  IDGI...
