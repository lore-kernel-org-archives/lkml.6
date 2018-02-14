Return-Path: <kernel-hardening-return-11786-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226ampVxa4clSrCx2jfHkFsiPvpsXzA0x6QU1hmojsaoEnO2IhfFcrBvEq6XtZSjlcwxXxhf
ARC-Seal: i=1; a=rsa-sha256; t=1518639263; cv=none;
        d=google.com; s=arc-20160816;
        b=WwoKvMKXfFP9pAc7Mr7UwuTZ08DaxmarOZxEEw9/W2TkubNEqJZg3MCF8rdFt1inz6
         5WxvF9+mY0WNPPHkAxRM5f0j8nNvmT6MVVHyFIbKxgsbUdmbRIX0BwkUYMQ1SPcx/yzS
         X+pBr0ELKUl3izyexnrP7vJClkH1Af4dF6ONTopXVhgVnX/6+0KklV3583atFFgbeOI8
         J6aTi2hZRM3qjh2HWtRIHXEiiXTyC7agrltQf4EXllTgQjfCucMtIfMOmLShr3p1EgD/
         vMuCoxLdLdpZjKFvgMFhvtAurkdwrjKphZj0E4RpOZKkfhVuR7OuPJfs7hhPu00vsYXB
         4fOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=HMbY14q2gYyQ3xZ9ZFfxFBGqZ3oA2aGG88VGoas1jWQ=;
        b=ifThpI5cEk1pObsRojO345X6Vq6dD9uMuJUT+/6GRfoGVlOg3/Ri5KFjtRHoVFefm8
         EUlub22SeC/+4FBE4pHSghJihJIWe2qKzvFOrsSkFpYfBoP2dxA6Ee1NT8sNW8I3KyXZ
         LwjNAbo1oryDncyxNm2+SGMp4XCNM8V3dRxgnXtl6zki5YT/4VA234sk9Nw6ueHucJJj
         n8XTqDUZRnJp2FWrEGtqpXAA4IVhshxUrS9S6TkfDav4qywbKfirIh4uCfZUMhFrDE+x
         vpLR43A3eOOKiuqqr2ciElTXuNEPjARQSE8Rads8BVtYhWJq6ZaT1xy9JDiM4g0OLyrV
         uHqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=n9UrC9FQ;
       spf=pass (google.com: domain of kernel-hardening-return-11786-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11786-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=n9UrC9FQ;
       spf=pass (google.com: domain of kernel-hardening-return-11786-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11786-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Feb 2018 12:14:00 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Christopher Lameter <cl@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 2/2] mm: Add kvmalloc_ab_c and kvzalloc_struct
Message-ID: <20180214201400.GD20627@bombadil.infradead.org>
References: <20180214182618.14627-1-willy@infradead.org>
 <20180214182618.14627-3-willy@infradead.org>
 <alpine.DEB.2.20.1802141354530.28235@nuc-kabylake>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1802141354530.28235@nuc-kabylake>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401933337716102?=
X-GMAIL-MSGID: =?utf-8?q?1592408684152623008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 01:55:59PM -0600, Christopher Lameter wrote:
> On Wed, 14 Feb 2018, Matthew Wilcox wrote:
> 
> > +#define kvzalloc_struct(p, member, n, gfp)				\
> > +	(typeof(p))kvzalloc_ab_c(n,					\
> > +		sizeof(*(p)->member) + __must_be_array((p)->member),	\
> > +		offsetof(typeof(*(p)), member), gfp)
> > +
> 
> Uppercase like the similar KMEM_CACHE related macros in
> include/linux/slab.h?>

Do you think that would look better in the users?  Compare:

@@ -1284,7 +1284,7 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
                return -EOPNOTSUPP;
        if (mem.nregions > max_mem_regions)
                return -E2BIG;
-       newmem = kvzalloc(size + mem.nregions * sizeof(*m->regions), GFP_KERNEL);
+       newmem = kvzalloc_struct(newmem, regions, mem.nregions, GFP_KERNEL);
        if (!newmem)
                return -ENOMEM;

@@ -1284,7 +1284,7 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
                return -EOPNOTSUPP;
        if (mem.nregions > max_mem_regions)
                return -E2BIG;
-       newmem = kvzalloc(size + mem.nregions * sizeof(*m->regions), GFP_KERNEL);
+       newmem = KVZALLOC_STRUCT(newmem, regions, mem.nregions, GFP_KERNEL);
        if (!newmem)
                return -ENOMEM;

Making it look like a function is more pleasing to my eye, but I'll
change it if that's the only thing keeping it from being merged.
