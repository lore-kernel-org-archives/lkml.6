Return-Path: <viro@ftp.linux.org.uk>
X-Google-Smtp-Source: AB8JxZo9L0m2wsmbvC0MxNwelOT3ZejtLRmWq0yGhg7JpiFmzxc8ZAFoOJ/5/r6pVB342jnf7uZs
ARC-Seal: i=1; a=rsa-sha256; t=1525277385; cv=none;
        d=google.com; s=arc-20160816;
        b=w3fNKSvqPxo4XHAsmk6X0dgs1sNIYCEy01WgEt98KWxinCbfGATqXn55LumlcHhNef
         mY16rbPCMd88AHp7IHNtpeWfIF/YE3eMrVQMbKuieyGoWjZNInDV4FGx7LwmET6kad93
         /VJcJ52Kh7p7Hk9TBs6SzQ+pPMDbuR/vt3ATJGaaqprgYp1yw58zVaebRnHxO227NnJY
         DOza76Rgumfr7xzuDRd0G8zBp2VA7u7qEe54ES+dEBzQOgWkk3F4Ts6N70EtcxtRDXdz
         CwUTRiI7L8KvHvUaOHrIm0sUYxTc80t7purdcCB9zUw44hushAHuPqUWnss3aR2AJWea
         xPdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=5yBtrllCXDaXdxYRt8q6bEOS+BOmT15Iriq0zDUmcBE=;
        b=MLfEnYHyoUOIB6WFMQeOna7PDXH4QYZ5bOy/53ATVKhEYwWQKh5N/t3pl8X2qjrufw
         nQMqW7QuWuhMWnAAxuDSAKq5kWczS8/OHcc2XiNvinUb9UI+KjGNMmNOiKpP8DZki9Ms
         Kv1SU+FB+hOzMOP2OC95sxNIPhveDb2e5RLSU075Nv7r7ITSu0+wIkHYPH5POh8G41Xp
         Axf9Vdb/+PAGgUaPZJkve+oo32a5Wo66CD7SuCT3BYUotfvHMjVOIPTjtXi0Hc0NKK3R
         IZgbQjg5lasuAX+eTArsj6XDS4K8o2Xev/ZgCip17WPDRDZeuvWcJmlaLGSft5hFzxR6
         TYiw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Date: Wed, 2 May 2018 17:09:39 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, tglx@linutronix.de,
	kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
	pombredanne@nexb.com, linux-api@vger.kernel.org
Subject: Re: [PATCH 0/6 resend] statfs: handle mount propagation
Message-ID: <20180502160939.GU30522@ZenIV.linux.org.uk>
References: <20180502154239.14013-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502154239.14013-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: Al Viro <viro@ftp.linux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599367740433603357?=
X-GMAIL-MSGID: =?utf-8?q?1599369259669839112?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 05:42:33PM +0200, Christian Brauner wrote:
> Hey,
> 
> This is the second resend of this patchset. I'm not sure whether it has
> simply been overlooked but the number of people get_maintainer.pl was
> rather small and seemed a little random so I added Linus and Christoph,
> two people I know that do look at VFS stuff at least from time to time,
> although they weren't listed by get_maintainer.pl. I hope that's ok.
> 
> This little series
> - unifies the definition of constants in statfs.h and fs.h
>   *Note, that Andreas has expressed doubts whether this unification is
>   useful. Please see https://lkml.org/lkml/2018/4/13/571 . I still think
>   it is but I'm happy to drop these two patches if others agree.*
> - extends statfs to handle mount propagation. This will let userspace
>   easily query a given mountpoint for MS_UNBINDABLE, MS_SHARED,
>   MS_PRIVATE and MS_SLAVE without always having to do costly parsing of
>   /proc/<pid>/mountinfo.
>   To this end the flags:
>   - ST_UNBINDABLE
>   - ST_SHARED
>   - ST_PRIVATE
>   - ST_SLAVE
>   are added. They have the same value as their MS_* counterparts.

How about some rationale for that in the first place?  statfs() looks like
a bad match for that - not to mention anything else, there's no way to
get anything beyond "it is a peer of something", not even "do these two
get propagation between them".  What would be using that, what would the
userland side of users look like, etc...

And in any case linux-api should've been Cc'd.  I'm not saying that this
(or something similar) would be an inherently bad idea, but the question
"why this way?" deserves a bit more than "parsing is costly"...
