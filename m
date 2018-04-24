Return-Path: <kernel-hardening-return-13112-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/rljYAvwGn1KCXFgHPUbORoiXhoSTuT/35EPqYZyaBf5MuzzduV1xNQ2E93Yu2U/Zo564d
ARC-Seal: i=1; a=rsa-sha256; t=1524581077; cv=none;
        d=google.com; s=arc-20160816;
        b=pgllk7Kh+0Sz7PaNPf3EX+g0VgFqs3tkdkZfduGHNx4gVIHJGq9p3aqqQ16slrS2am
         ydoUv73SAdhP5P7REh9swrIer6wZ8XQ7Msx5ohpRLg0CMVDpzEqnl55MMlcgZXdSV30u
         6CQ/zGfzhx5fvZXIPkK3Yso+Ou3TaZ7niTzDXhBP50vvNAlSvmn8QK/aQ31WJPQEGH6H
         U1QOC0kUXpZuzBsQYh9o3C1xfib6x/BVTKOly1A/U9948NFzxbe3e+Ot9/4laEOA+EoH
         IUMjrQ8zaQrZGT5v4/XG9rz29FsNQZUYq47sGm+wxTQKBzcILPAFGt/qVnBWHxJV/qET
         F2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=cbjiz7pPGpK/ovaRRpBQt9/XbQmxLHrO/+PvPxILOpM=;
        b=Ejf9mbRYV27U/nomU6+QL2tFAELxkyVhm1LFtNVyRCd4cvCL2dx/1Ctt4mmV8CvduT
         Og85vPVzQ3G8+NaAyjc4+ST6y8QNvn34AoMmVEg3AMnWt9J+9sQM1VBu+W1THHkvcfSw
         b7yl09vJew+M/fw4EK8/IqkOMXs3NtqJY8ETOXB7QkPDwAU/uOueahTW8gzlxiuNlNvc
         pXwFI9t3PiaMKyJXrtSQnxB7VRmye/9dPida9MXoUx4tMmhJ6E3V3GFbKpKwxQgGnc6W
         MbZlCABVxustjyC+6FmfSZjj6eW7xkpjSXyd337jRLGvaUPpeXxZWvviq7+VzPmIZEFt
         0uvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=kzOv+Olv;
       spf=pass (google.com: domain of kernel-hardening-return-13112-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13112-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=kzOv+Olv;
       spf=pass (google.com: domain of kernel-hardening-return-13112-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13112-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 24 Apr 2018 07:44:04 -0700
From: Matthew Wilcox <willy@infradead.org>
To: lazytyped <lazytyped@gmail.com>
Cc: Igor Stoppa <igor.stoppa@gmail.com>, keescook@chromium.org,
	paul@paul-moore.com, sds@tycho.nsa.gov, mhocko@kernel.org,
	corbet@lwn.net, labbott@redhat.com, linux-cc=david@fromorbit.com,
	--cc=rppt@linux.vnet.ibm.com, --security-module@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Igor Stoppa <igor.stoppa@huawei.com>,
	Carlos Chinea Perez <carlos.chinea.perez@huawei.com>,
	Remi Denis Courmont <remi.denis.courmont@huawei.com>
Subject: Re: [PATCH 7/9] Pmalloc Rare Write: modify selected pools
Message-ID: <20180424144404.GF26636@bombadil.infradead.org>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
 <20180423125458.5338-8-igor.stoppa@huawei.com>
 <20180424115050.GD26636@bombadil.infradead.org>
 <eb23fbd9-1b9e-8633-b0eb-241b8ad24d95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb23fbd9-1b9e-8633-b0eb-241b8ad24d95@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598541768538376919?=
X-GMAIL-MSGID: =?utf-8?q?1598639127650943440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 02:32:36PM +0200, lazytyped wrote:
> On 4/24/18 1:50 PM, Matthew Wilcox wrote:
> > struct modifiable_data {
> > 	struct immutable_data *d;
> > 	...
> > };
> >
> > Then allocate a new pool, change d and destroy the old pool.
> 
> With the above, you have just shifted the target of the arbitrary write
> from the immutable data itself to the pointer to the immutable data, so
> got no security benefit.

There's always a pointer to the immutable data.  How do you currently
get to the selinux context?  file->f_security.  You can't make 'file'
immutable, so file->f_security is the target of the arbitrary write.
All you can do is make life harder, and reduce the size of the target.

> The goal of the patch is to reduce the window when stuff is writeable,
> so that an arbitrary write is likely to hit the time when data is read-only.

Yes, reducing the size of the target in time as well as bytes.  This patch
gives attackers a great roadmap (maybe even gadget) to unprotecting
a pool.
