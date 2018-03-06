Return-Path: <kernel-hardening-return-12142-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtiZ0fDpr6LNAjl6FQiDOW8sK+0Qnka7bGqqZmAw2MNmOAGLi+y2SVVo9s5cuGDlbgwOqKp
ARC-Seal: i=1; a=rsa-sha256; t=1520345472; cv=none;
        d=google.com; s=arc-20160816;
        b=ZlNgS91Zo/SRs9tVIWgXiVuKOW11s1KgYxhELWv/5rbbB1IhB7J/OoMaM/wJuxTt9e
         JRtcU55sbTyFjWFChyulpdBM5XQEQABYx8euQXuWn/KF0lCH8FOVEw/6YpgSrXYX2K/N
         ts558NvY/jsWD6t7xlImaw3SyMeNkp/Tw8ePN4fvQpwNJZSM1T1DwD+EqzrRy1MpIZdu
         XvVKGEPYvOlTDGtR3MXAqA6ZUZOiq7+eJDH7y/si0glDKfOO789ebmaGk3RqOBidHdHz
         yovO6ML62ZR/T3nwAjmC8u4FTtaiEQt0hHQ90qRlG7bqymGOW6z3B3S0sHg/xyZzS5eF
         XgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=th9Sp3o5IQSn4wlvyP0N2Bybd0wAyr/nTty04d6dSrI=;
        b=s9YrsoknW/mlzuKY1uBWAuUbj9cUDKZ5RMZ3kvTixlCrjjmVMuv68ghs96oX92Bm0p
         hjJerpWc8EfUO/lQoRlrW+aLgcIe4PRi7hioEbu3ln6+A0Ja2lwFA+7S50s+xgOlqxU1
         zIQz0tObVSAwi4gLeh+8E5cv5kMwQ+6YEY8lBZa79IzG4Rgn6nbVaJcs+mXArx5j3pIV
         t3K0kdtz8QPyJcao9HwVkPRI3vdoyNbGqm63Es02bTfudFqbCCVnBR3fwdCu8M1Gbm5a
         FehfSKAVOR9/BQb7RUkUnT0LAb/XPRDFJXZItvDlw+96rWzMrYFTfzPNtpO7CSV90wcI
         VqJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=SREgEfgQ;
       spf=pass (google.com: domain of kernel-hardening-return-12142-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12142-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=SREgEfgQ;
       spf=pass (google.com: domain of kernel-hardening-return-12142-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12142-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 6 Mar 2018 06:10:47 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: david@fromorbit.com, keescook@chromium.org, mhocko@kernel.org,
	labbott@redhat.com, linux-security-module@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 1/7] genalloc: track beginning of allocations
Message-ID: <20180306141047.GB13722@bombadil.infradead.org>
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-2-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228200620.30026-2-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676614912638441?=
X-GMAIL-MSGID: =?utf-8?q?1594197774701738055?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:06:14PM +0200, Igor Stoppa wrote:
> + * Encoding of the bitmap tracking the allocations
> + * -----------------------------------------------
> + *
> + * The bitmap is composed of units of allocations.
> + *
> + * Each unit of allocation is represented using 2 consecutive bits.
> + *
> + * This makes it possible to encode, for each unit of allocation,
> + * information about:
> + *  - allocation status (busy/free)
> + *  - beginning of a sequennce of allocation units (first / successive)
> + *
> + *
> + * Dictionary of allocation units (msb to the left, lsb to the right):
> + *
> + * 11: first allocation unit in the allocation
> + * 10: any subsequent allocation unit (if any) in the allocation
> + * 00: available allocation unit
> + * 01: invalid
> + *
> + * Example, using the same notation as above - MSb.......LSb:
> + *
> + *  ...000010111100000010101011   <-- Read in this direction.
> + *     \__|\__|\|\____|\______|
> + *        |   | |     |       \___ 4 used allocation units
> + *        |   | |     \___________ 3 empty allocation units
> + *        |   | \_________________ 1 used allocation unit
> + *        |   \___________________ 2 used allocation units
> + *        \_______________________ 2 empty allocation units
> + *
> + * The encoding allows for lockless operations, such as:
> + * - search for a sufficiently large range of allocation units
> + * - reservation of a selected range of allocation units
> + * - release of a specific allocation
> + *
> + * The alignment at which to perform the research for sequence of empty
> + * allocation units (marked as zeros in the bitmap) is 2^1.
> + *
> + * This means that an allocation can start only at even places
> + * (bit 0, bit 2, etc.) in the bitmap.
> + *
> + * Therefore, the number of zeroes to look for must be twice the number
> + * of desired allocation units.
> + *
> + * When it's time to free the memory associated to an allocation request,
> + * it's a matter of checking if the corresponding allocation unit is
> + * really the beginning of an allocation (both bits are set to 1).
> + *
> + * Looking for the ending can also be performed locklessly.
> + * It's sufficient to identify the first mapped allocation unit
> + * that is represented either as free (00) or busy (11).
> + * Even if the allocation status should change in the meanwhile, it
> + * doesn't matter, since it can only transition between free (00) and
> + * first-allocated (11).

This seems unnecessarily complicated.  Why not handle it like this:

 - Double the bitmap in size (as you have done) but
 - The first half of the bits are unchanged from the existing implementation
 - The second half of the bits are used for determining the length

On allocation, you look for a sufficiently-large string of 0 bits in
the first-half.  When you find it, you set all of them to 1, and set one
bit in the second-half to indicate where the tail of the allocation is
(you might actually want to use an rbtree or something to handle this ...
using all these bits seems pretty inefficient).
