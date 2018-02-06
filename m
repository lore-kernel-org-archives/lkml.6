Return-Path: <lhenriques@suse.com>
X-Google-Smtp-Source: AH8x2274VtgwHq2au9uI0Crn802EW8bRWY09Rsz9mLgoes07YdK0N7itQWp3SrBlIIIm8fIRvmQq
ARC-Seal: i=1; a=rsa-sha256; t=1517957492; cv=none;
        d=google.com; s=arc-20160816;
        b=KeeXzTp8kXobToFj3JlCohkfspGhwsn1NSKxiHjOmhJNRlrz6sGytikD8Gs8UJI+M4
         T6KVtZWTIdgTOItgV1aJ0E4UFq8JM9nehBhOvjutBkfzYO2y4FhwN79+MUP5pbqOHW5Y
         BcLX3FFSlxHxm53Q9gvLK5F5+hBnkGmBO6BtMulh0RxZDdy8ZEZszVfUClmOXB/7pAsx
         YJ0mhpZHMoRG0dEvVL8oU7SHx5nPBUpoXAvcyCXA8G/bRQ87j4EY7kK+34WCalMaWELN
         v0OmWjvThKPEIPUPzoJz2VvpYB9DWEaDd/q8rg0dbk17vvw98kZ3LuxmW/LKJ+ZVcpj9
         b0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=yTjvGezQbx7m3cbR5RZGFq/aUFS02rqErvqjZh+Aygw=;
        b=0+eQXfNZSmJOIcpD6WoDtGW0iCeO0SkI/rrHspqJMaT8qBrpRtnHQX70w4LAVAZ/Tx
         2OnEuqsJRAB3+DSXmgQ8SZb6XHswTjJZ+mRHx3p609J4cdnTarFnr/zjD3sQNBCIF5Rk
         zmeIefW+Ow8bEeMeHfoSxn0NWDzQQMjA+aJ5KfB970BJOaiol1yGZLH93Mfz/o3AjwtJ
         BxydVwZFFqAZYaDXRECNRn7FudLzlXXZ+NE2UmnDupouQjvHG/pfWxBcAQ/jhZN2POzs
         ZAgwPdznPt1t9vZ5RAnGrNh9hECsJzy8BltzZEd9EtLLu59c/+Fm99RIH2+ufzIxfGdB
         7FEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lhenriques@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=lhenriques@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lhenriques@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=lhenriques@suse.com
Date: Tue, 6 Feb 2018 22:51:32 +0000
From: Luis Henriques <lhenriques@suse.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Greg KH <gregkh@linuxfoundation.org>, X86 ML <x86@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v4 07/10] x86: narrow out of bounds syscalls to sys_read
 under speculation
Message-ID: <20180206225132.yewppdrnut35gzrh@hermes.olymp>
References: <151632009605.21271.11304291057104672116.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151632014097.21271.16980532033566583357.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206192925.qkmghwsbaysr4iv2@hermes.olymp>
 <CAPcyv4ihN6fy5-vBtfA0PuwXvCAj8-rMhtQmevh5sdYxbH3Yfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4ihN6fy5-vBtfA0PuwXvCAj8-rMhtQmevh5sdYxbH3Yfw@mail.gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589977480308913684?=
X-GMAIL-MSGID: =?utf-8?q?1591693795242805794?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 11:48:45AM -0800, Dan Williams wrote:
> On Tue, Feb 6, 2018 at 11:29 AM, Luis Henriques <lhenriques@suse.com> wrote:
> > On Thu, Jan 18, 2018 at 04:02:21PM -0800, Dan Williams wrote:
> >> The syscall table base is a user controlled function pointer in kernel
> >> space. Like, 'get_user, use 'MASK_NOSPEC' to prevent any out of bounds
> >> speculation. While retpoline prevents speculating into the user
> >> controlled target it does not stop the pointer de-reference, the concern
> >> is leaking memory relative to the syscall table base.
> >
> > This patch seems to cause a regression.  An easy way to reproduce what
> > I'm seeing is to run the samples/statx/test-statx.  Here's what I see
> > when I have this patchset applied:
> >
> > # ./test-statx /tmp
> > statx(/tmp) = -1
> > /tmp: Bad file descriptor
> >
> > Reverting this single patch seems to fix it.
> 
> Just to clarify, when you say "this patch" you mean:
> 
>      2fbd7af5af86 x86/syscall: Sanitize syscall table de-references
> under speculation
> 
> ...not this early MASK_NOSPEC version of the patch, right?

*sigh*

Looks like I spent some good amount of time hunting a non-issue just
because I have enough old branches hanging around to confusing me :-(

Sorry for the noise.

Cheers,
--
Luís
