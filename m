Return-Path: <kernel-hardening-return-11863-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226U5YbqX7MZIuipQZkzz+PoVFajrXslZj6cWFRn5WgZZukH7rrLqZ5LcRQJI71+7hEV5q3n
ARC-Seal: i=1; a=rsa-sha256; t=1519249019; cv=none;
        d=google.com; s=arc-20160816;
        b=xL8wGVAUR/XYpQjRYmAZio8JshyVUK4KLXg5OYFetWfD4FpA88e/pEfmlEtKEUTm0A
         GXhLfOU3Vi3/D5UKBKqPl1qD5CzB+o7ozsk2K4BkSwDotPElr+jD+NklmbUWxgebK9Ke
         f9lC+/zpYQY6jlhRynocPX3ljsyB51pYCPpo5j/epaFqsm9A2YuZ58eiXQ7N2rKp55/n
         N4NVUb/Kqvx+E4wcSDzFAXNVgo1wVA2aDzgqCwE0Sj1JzL7z4BrcLe3OolH2M/q6lvub
         S2/h7PZLipAwzPWNJA3dmA0BABkWfVcne3FbsVMYEM1i6ovNYzaPgNwoasX0spVT8Hxm
         7/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=5l2XDgB/6wAJrxwy/1/ZyIraInETqag4ioQ5l2fwXAg=;
        b=Yjxqhi0PIC7Mwqu6E/os9Joi/i1zUsZYPtqnjO6UTYsNlgfAqjyuJ8DPmZg1X1mV5u
         LUt1whovplMLuepGx0lqYYzDuhNbyTRiTnu0mQoGc6IEU4qNQAFTxIumC2UT0qmbiu0W
         7r8mXIbOYtAXrvtt9o3Hy2ow7xVAs1zhB6tSq2s7n/ao+WEs1nHnZMkWvpL9mwFv9P03
         BCkx9aO/hnh0rPhy94iWB4EIyb7JtykIAcGGimQ+jj73aSozKGVjSQqOs4v4wj48y9HU
         dhSgafT+1sHZimkJK5gkg44jF1iGfm/LiIDGXIRssIidneP3gVZFJvggLoUocXtQtttM
         hLgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11863-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11863-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11863-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11863-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 22 Feb 2018 08:36:29 +1100
From: Dave Chinner <dchinner@redhat.com>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>, Kees Cook <keescook@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Laura Abbott <labbott@redhat.com>,
	Jerome Glisse <jglisse@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <cl@linux.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [RFC PATCH v16 0/6] mm: security: ro protection for dynamic data
Message-ID: <20180221213629.GF3728@rh>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
 <CAGXu5j+ZNFX17Vxd37rPnkahFepFn77Fi9zEy+OL8nNd_2bjqQ@mail.gmail.com>
 <20180220012111.GC3728@rh>
 <24e65dec-f452-a444-4382-d1f88fbb334c@huawei.com>
 <20180220213604.GD3728@rh>
 <20180220235600.GA3706@bombadil.infradead.org>
 <20180221013636.GE3728@rh>
 <46a9610a-182b-4765-9d83-cab6297377f3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46a9610a-182b-4765-9d83-cab6297377f3@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214870438978682?=
X-GMAIL-MSGID: =?utf-8?q?1593048059821074194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 11:56:22AM +0200, Igor Stoppa wrote:
> On 21/02/18 03:36, Dave Chinner wrote:
> > On Tue, Feb 20, 2018 at 03:56:00PM -0800, Matthew Wilcox wrote:
> >> On Wed, Feb 21, 2018 at 08:36:04AM +1100, Dave Chinner wrote:
> >>> FWIW, I'm not wanting to use it to replace static variables. All the
> >>> structures are dynamically allocated right now, and get assigned to
> >>> other dynamically allocated pointers. I'd likely split the current
> >>> structures into a "ro after init" 
> 
> I would prefer to use a different terminology, because, if I have
> understood the use case, this is not exactly the same as __ro_after_init

I want a dynamically allocated "write once" structure.

A "write once" structure is, conceptually, is exactly the same as
"ro after init". Implementation wise, it may be different to
"__ro_after_init", especially when compared to static/global
variables.

It seems lots of people get confused when discussing concepts vs
implementation... :)

> >>> 	......
> >>
> >> No, you'd do:
> >>
> >> struct xfs_mount_ro {
> >> 	[...]
> >> };
> 
> is this something that is readonly from the beginning and then shared
> among mount points or is it specific to each mount point?

It's dynamically allocated for each mount point, made read-only
before the mount completes and lives for the length of the mount
point.

> >> struct xfs_mount {
> >> 	const struct xfs_mount_ro *ro;
> >> 	[...]
> >> };
> > 
> > .... so that's pretty much the same thing :P
> 
> The "const" modifier is a nice way to catch errors through the compiler,
> iff the ro data will not be initialized through this handle, when it's
> still writable.

That's kinda implied by the const, isn't it? If we don't do it that
way, then the compiler will throw errors....

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com
