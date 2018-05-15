Return-Path: <minchan.kernel@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526374575; cv=none;
        d=google.com; s=arc-20160816;
        b=MnBKzHebGGm9AIwo1d2z641tAU+P7KWElIMOEe5lDMLs1rnBdGxoOSfl998UKvToTs
         dTV4L2EsI475/jSmCS5FolqL8MiWmMBBoz4ndR7UvWwmmfokVf3CIZlZssnKM2sp5DM3
         Sy9hAAokXdtltGIaNPYQiEBj/pestD6qfs4UkKX8fyIUXB3/J86nUHcBRtK/pYMUHq/v
         YJI9PZwPR4VpLX4CjojuXrcKeGFnkydBwEBLG+DVPe6pnxDtYaURJQMiQPUWoOxetouB
         YqkmRo+6G5gpRSfn03x30qF4xGX+kaS33Nn+PjAmFpuq3WezV9bbPQ46JIKGKq+CHawI
         VtaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:dkim-signature
         :arc-authentication-results;
        bh=tykfmoq2qwtP5IivIWUXLl8u2z5Eq5YPw8yVUxy9lbo=;
        b=vKYaOGwvRrpYirATNEn/24fE+ttlKAEGn1vIFPl8AY/Qg64hI87/K88jauZhUUm3jN
         DtvgfhOK8mjoTqFv1IssZ5TV0qlEssr3soVjEs3I/NvS4NTsrkhG+nsyhbpLlDV6puKf
         +aFzE41lx6vQrtGvuZJjGTZWiZEspy3E3wIs2mC5jHz3Pvld1100VoX+4vVrSTQ54oAu
         Ow5A9DpYb9JRpSbKkl4fq4VheJ9LeuGm7InhekEsNQR9vlDPviqeN5p0WbffOy7yFxGJ
         1nzbuK8hoX6F8f8w7YsKNdbJjvnOlGKVu+ve+eFiHY95pkD5LqDeNtFIDF0SvLnNYHop
         HdiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Y3LR0Q2O;
       spf=pass (google.com: domain of minchan.kernel@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=minchan.kernel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Y3LR0Q2O;
       spf=pass (google.com: domain of minchan.kernel@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=minchan.kernel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrQrnP2k/V+OM73ik0btGeq9Je+81mRA7XzBgA8NLwdEyPE8jGHohdhysX8Typ6InE68oyw9Q==
From: Minchan Kim <minchan.kernel@gmail.com>
X-Google-Original-From: Minchan Kim <minchan@kernel.org>
Date: Tue, 15 May 2018 17:56:10 +0900
To: Martijn Coenen <maco@android.com>
Cc: Minchan Kim <minchan.kernel@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ganesh Mahendran <opensource.ganesh@gmail.com>,
	Joe Perches <joe@perches.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6] ANDROID: binder: change down_write to down_read
Message-ID: <20180515085610.GA98128@rodete-desktop-imager.corp.google.com>
References: <20180507141537.4855-1-minchan@kernel.org>
 <20180507172829.GA66161@joelaf.mtv.corp.google.com>
 <20180508105101.GB8209@rodete-desktop-imager.corp.google.com>
 <20180508230813.GA102094@joelaf.mtv.corp.google.com>
 <20180509064023.GD8209@rodete-desktop-imager.corp.google.com>
 <20180509231941.GA4790@joelaf.mtv.corp.google.com>
 <20180515062732.GA183759@rodete-desktop-imager.corp.google.com>
 <CAB0TPYHseQ-Lx4guzykjxY9xP2yP5Kga+oZMTmC7Bb7XXRAFFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYHseQ-Lx4guzykjxY9xP2yP5Kga+oZMTmC7Bb7XXRAFFQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599815073448562806?=
X-GMAIL-MSGID: =?utf-8?q?1600519747028745276?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 09:46:01AM +0200, Martijn Coenen wrote:

< snip >

> >> About the unmap at runtime part, your commit message was a bit confusing. You
> >> said "every binder buffers should be mapped in advance by binder_mmap." but I
> >> think the new binder shrinker mechanism doesn't make that true anymore.
> >
> > It's good point. I didn't know know that.
> > When I see binder_vm_fault, it emits SIGBUS. That means shrinker cannot zap pages
> > process is using, I think. IOW, every pages for binder are mapped at mmap time
> > and is never mapped in runtime by page fault. Right?
> 
> Right - the address range is allocated once, and an initial amount of
> pages is mapped into it. For every transaction into that process, we
> will see if there's enough pages, and if not allocate so that we have
> enough of them - so this is not done by page fault. The shrinker won't
> touch pages for which a transaction is in progress. Of course a
> process itself could still try to read from an unallocated address,
> but in that case returning SIGBUS and having that process crash seems
> fine.

Thanks for the confirmation.

> 
> I'm also not sure the read lock is needed, but I would need to read a
> whole lot more code to convince myself it's not.

For page zapping, we shouldn't need mmap_sem write lock.
We should replace it with down_read/write, too.

Thanks.
