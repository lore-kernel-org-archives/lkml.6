Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AB8JxZpH9zz3wg/q6LEYSLJCb1A2r0GfwpZ0piuZHBEu7AE6T7iocc9zFxQmWvWZPL+WbW2u5QsN
ARC-Seal: i=1; a=rsa-sha256; t=1527139166; cv=none;
        d=google.com; s=arc-20160816;
        b=voFKClk727TqrolaXGdpqNZPja7z51lG2E9sUoJCMktIPjh4TrdesdmRGbFJwDO3oE
         iVUgvU7zKJ+2BOWd/WBUCePyrsBGxP7d3BdqGc9jtcBwCLDpgLk+xQO43lMAtcIuVcWS
         EgOf6Ny/UxcGescWBxrbeb3hGfMhjdtjbpcjPi6LgX/jRXiZMbMxjQHRghtnFSS16gLu
         +OlFcCdxDG4lTk/ymPYx855J9/bhl+9Ar9kVU1b7XIayHpw3tr2XK51mNsfu5lfBvJUA
         z3YvaRJ9LRdwDAIxCI03xvSNCepjdKfhYlv9PNqxL9x2/zgjHCa+2+Ia419ej+nEATke
         gBdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=N7i88fJ8JedeN1ByUAy346KO0+/p00d+ltO+gSj6UB4=;
        b=vVxBMHoukVACVUyth4vhpbqKp5lcL7wGN4kwQFL7PGD0kMHBeQ5rlNimamZXdYcs1U
         vIDoiTbZVxd6p/CShhgGJluj5eTbpdAIwFBz/sFG/ygH2mQiREcGDlONfsgyeI0zH4bU
         csFHGeIfT3Z+m/Pq+A6rSzL72NRA+u+WyAWjzdJKNeTkZZHNNe0NpDViOx7+isz9v4OT
         KTA5ai4bAhH/5oqjzYFZj9TG8L8PzX4aPaNeZc6D0RGsIY6OksXPKiPMUBuXb+jXLkbc
         GEBeU3QkWD9V+bJVJtiixLj61+w6+OT85zQ6SqSxqZkA4DuCK9l/jWPqfTJh0aGrSZsl
         JZGA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=kv+AGfFK;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=kv+AGfFK;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Wed, 23 May 2018 22:19:19 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Huaisheng Ye <yehs2007@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, vbabka@suse.cz, mgorman@techsingularity.net,
	kstewart@linuxfoundation.org, alexander.levin@verizon.com,
	gregkh@linuxfoundation.org, colyli@suse.de, chengnt@lenovo.com,
	hehy1@lenovo.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
	linux-btrfs@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [RFC PATCH v2 00/12] get rid of GFP_ZONE_TABLE/BAD
Message-ID: <20180524051919.GA9819@bombadil.infradead.org>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
 <20180522183728.GB20441@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522183728.GB20441@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087516393165793?=
X-GMAIL-MSGID: =?utf-8?q?1601321478153946944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 08:37:28PM +0200, Michal Hocko wrote:
> So why is this any better than the current code. Sure I am not a great
> fan of GFP_ZONE_TABLE because of how it is incomprehensible but this
> doesn't look too much better, yet we are losing a check for incompatible
> gfp flags. The diffstat looks really sound but then you just look and
> see that the large part is the comment that at least explained the gfp
> zone modifiers somehow and the debugging code. So what is the selling
> point?

I have a plan, but it's not exactly fully-formed yet.

One of the big problems we have today is that we have a lot of users
who have constraints on the physical memory they want to allocate,
but we have very limited abilities to provide them with what they're
asking for.  The various different ZONEs have different meanings on
different architectures and are generally a mess.

If we had eight ZONEs, we could offer:

ZONE_16M	// 24 bit
ZONE_256M	// 28 bit
ZONE_LOWMEM	// CONFIG_32BIT only
ZONE_4G		// 32 bit
ZONE_64G	// 36 bit
ZONE_1T		// 40 bit
ZONE_ALL	// everything larger
ZONE_MOVABLE	// movable allocations; no physical address guarantees

#ifdef CONFIG_64BIT
#define ZONE_NORMAL	ZONE_ALL
#else
#define ZONE_NORMAL	ZONE_LOWMEM
#endif

This would cover most driver DMA mask allocations; we could tweak the
offered zones based on analysis of what people need.

#define GFP_HIGHUSER		(GFP_USER | ZONE_ALL)
#define GFP_HIGHUSER_MOVABLE	(GFP_USER | ZONE_MOVABLE)

One other thing I want to see is that fallback from zones happens from
highest to lowest normally (ie if you fail to allocate in 1T, then you
try to allocate from 64G), but movable allocations hapen from lowest
to highest.  So ZONE_16M ends up full of page cache pages which are
readily evictable for the rare occasions when we need to allocate memory
below 16MB.

I'm sure there are lots of good reasons why this won't work, which is
why I've been hesitant to propose it before now.
