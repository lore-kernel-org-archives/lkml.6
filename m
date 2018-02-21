Return-Path: <kernel-hardening-return-11862-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226cch+rAJZV5tSwh9DJi8nF08Q/iQJ2tWkaeB2bThBgApK2/1RbPNKCa/IR8OGt5oHcSXEX
ARC-Seal: i=1; a=rsa-sha256; t=1519246775; cv=none;
        d=google.com; s=arc-20160816;
        b=XS0vKdfezi48C5rTfk3eolFDqxpFZuIidOccXn3T6dmHmo813IwVcx4TdWrkSSyh4I
         A9sFGz+JU24fFDjftzu8hod42WOdAYlaUYc5xSg/4gvKY4Upmr0qKqzJ68kknj95Cy+g
         Ojp9fPoIzg72GhFvCSGeZvAfjWbS9n1/ZnleMIw0f39nhxFXY1LtnAGXDJEXUOr9SUCk
         wpgUZpQJVPJhdqP+QCZvT4xZYgNXsINLWJXJ1nzawqdJ18MG7DRpnxAQ+GaMrNueGjYA
         SRx9csmMt5fugw2J3YWuTs/h57RZeCMj2MwRltgRZs/DCsiVi13aaWxXRPJRbVABkhKH
         f9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=pKqTAaUWIvOkq+Zs17O3kcywSPqN59hanDFEK6Rw4Rg=;
        b=XIXe5x8BL8NuG/5C0OKhjc/8wsXhWWfQrtyeBKw9cFoPSmQKJB1NsQhAdJIv9bfoge
         yt4c1D2vx34baNHwTbvROKxyOA+RwXZPDccvU8q+Jk6nVFfXOOmummG9hct0wRps8Zm/
         WRWIBTUOui6LW4m61+jUhJNkOW8XvTRQ2KRXKYN/TCU+pJRh2E0mPtYgnlhXJ86tGLxZ
         OWH9BRjlG9M00w7NfE7aO+v/0LUkcFNYlTJIAq+rtzFKeoIWSnT2o9H9Ddj+6R292bDy
         wi0gtaPxoQhlEsuIsvL5OTc7/0m9zXwBFPFM2LVjQ5pliEhwQ+ifVawWTfTrec8srpKY
         gLCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11862-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11862-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11862-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11862-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 21 Feb 2018 12:59:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>,
 Laura Abbott <labbott@redhat.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2] fork: Unconditionally clear stack on fork
Message-Id: <20180221125914.dc95830eada5fb958c13e36b@linux-foundation.org>
In-Reply-To: <20180221102933.GD2231@dhcp22.suse.cz>
References: <20180221021659.GA37073@beast>
	<20180221102933.GD2231@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592975104699087561?=
X-GMAIL-MSGID: =?utf-8?q?1593045706345296033?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 21 Feb 2018 11:29:33 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> On Tue 20-02-18 18:16:59, Kees Cook wrote:
> > One of the classes of kernel stack content leaks[1] is exposing the
> > contents of prior heap or stack contents when a new process stack is
> > allocated. Normally, those stacks are not zeroed, and the old contents
> > remain in place. In the face of stack content exposure flaws, those
> > contents can leak to userspace.
> > 
> > Fixing this will make the kernel no longer vulnerable to these flaws,
> > as the stack will be wiped each time a stack is assigned to a new
> > process. There's not a meaningful change in runtime performance; it
> > almost looks like it provides a benefit.
> > 
> > Performing back-to-back kernel builds before:
> > 	Run times: 157.86 157.09 158.90 160.94 160.80
> > 	Mean: 159.12
> > 	Std Dev: 1.54
> > 
> > and after:
> > 	Run times: 159.31 157.34 156.71 158.15 160.81
> > 	Mean: 158.46
> > 	Std Dev: 1.46
> 
> /bin/true or similar would be more representative for the worst case
> but it is good to see that this doesn't have any visible effect on
> a more real usecase.

Yes, that's a pretty large memset.  And while it will populate the CPU
cache with the stack contents, doing so will evict other things.

So some quite careful quantitative testing is needed here, methinks.
