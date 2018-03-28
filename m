Return-Path: <kernel-hardening-return-12790-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+jLgvLt6fjlvVQHxT4TUBRVAAjLe60pOix/si9Yj5bQbFPkjTSBskBJO2surKOiM7WTVvs
ARC-Seal: i=1; a=rsa-sha256; t=1522230727; cv=none;
        d=google.com; s=arc-20160816;
        b=LTBeJkRzmC+M2A1a7e5UVU7dxKpDKjiMLKxs8CXcEwWEivRzKWMwxJ1VR/8EGU9Ccu
         d1OBj/Xm3tbDXlH848YIpuWk0bvPGtRUF811dyL5hsXiFBWalacozxcZ1aKkokJrlF/G
         aBt80D2zoJCS1IERmA64mpo+NhMa0nowkWv6RVJRWPreqNHysLX90XRBW9Bcx+3G181X
         9ECeXf0C9HNKIOWRV93Qx+4pWtavdXfxOOPZJPNwy9hXrRfhdxXremYvGkthmifOc4Yv
         hE2F8Yxwvsic2bfwreohiFUaC71pA4Cj6Xz2EhEQVQxVGnHP2c+BVkEvs+nNFTHlQpls
         ppSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=ap01b+NN4TN2RAdSmxfFtq74xMFtY+X+K8FZimd2wwg=;
        b=R70YP64UQJH7uWzN9Z4FmC3PQGtDGFBmOaRkI1Mjs2TxMZ3WgctFLFTc0oM0Ph0zi/
         CDq6n17p1lMos1MwZDSpbquGHrL79NHpk37K+DPRqgTebn9ACiyzOy1sWW6q7/j7iX4L
         /uSfxdtMWdF6rZFJgqVmHhgDv9M7ocAtSkhw+ItDASCVS+h/iSPhLJQeLhnaPJcRKknp
         q54cOjj8OkSjUvwd579EBbJScPLes/rWw388464+RwdAcCCViTcpsfcXGQAbxpmisqrp
         Dj1wrKthT6MeAwKZW7VM88vL7biSTcctEOqk/wTpGdsj/aBjfd5gOdWaVRvQlJb6BZMO
         +kew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=IxctZlc5;
       spf=pass (google.com: domain of kernel-hardening-return-12790-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12790-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=IxctZlc5;
       spf=pass (google.com: domain of kernel-hardening-return-12790-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12790-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 28 Mar 2018 11:51:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH] task_struct: Only use anon struct under randstruct plugin
Message-ID: <20180328095140.GP4043@hirez.programming.kicks-ass.net>
References: <20180327213609.GA2964@beast>
 <20180327160342.e2bc9a15afda5823c8daf4fb@linux-foundation.org>
 <CA+55aFzi0aUGuxDOwj1HkrP6r2Df2jk5F0HDTOQCG6_eeytbYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzi0aUGuxDOwj1HkrP6r2Df2jk5F0HDTOQCG6_eeytbYw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596128328848013628?=
X-GMAIL-MSGID: =?utf-8?q?1596174607830542710?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 02:22:31PM -1000, Linus Torvalds wrote:
> On Tue, Mar 27, 2018 at 1:03 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > Why?  What caused this padding?  It happens in all configs?
> 
> I assume what happens is that the anonymous struct ends up containing
> fields that are cacheline-aligned, and then the whole anonymous struct
> is cacheline-aligned.

Yes, structures inherit the alignment requirements of their constituent
members.

> Which is all kinds of stupid, since the anonymous struct itself does
> not exist outside of the outer struct. So it would be entirely
> sufficient to just make the outer struct cacheline aligned (like it
> used to be), but not align the inner anonymous one - just the fields
> in it.
> 
> But there may be "reasons" why the inner anonymous  one needs to be
> aligned. Maybe it's some standards requirement, or maybe it's just an
> internal gcc implementation detail.

Last time I read the standard there wasn't a distinction between
anonymous and regular structures for this. So in that regards a strict
reading of the standard would mandate this behaviour.

> Regardless, it's a bit sad. It also means that when randomization is
> on, that unnecessary padding will be there.

The other complaint is that the anonymous structure makes the pahole
output (which is what I showed) unnecessarily ugly.
