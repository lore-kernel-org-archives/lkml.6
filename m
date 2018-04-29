Return-Path: <kernel-hardening-return-13156-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZrls/C5jMv86nqBb2cJCN1oGkzZuL9l5wZFjRueUBToPANUGAyPnv7HNN4mmqmEmhlctlfN
ARC-Seal: i=1; a=rsa-sha256; t=1524971405; cv=none;
        d=google.com; s=arc-20160816;
        b=BsTzh3iDAJ2HLj5BXKmy3NjHs8D3uRCyzjzo76ZNDKIwTOn6PO+sUo9WuvesJAiQKB
         WJ+DneUvPSPE2YU2dcidDvxWJ9ozTv4NnaUHftkmHtNwgYCzmfHzdXQJpwxak1ylvhfO
         lXLUu9ZvVJklmIDeIyOyuklOvAvrhhmBHJNryY5F/UCpkNrWNqVhFcRQN7uvZ4VRtbEc
         j1CrqoYq8COHRdXEjscCjd6jmCFxMLbpM07T6d3QGwm/itD/Dfr7YtzN6d7nltic6hB3
         LKZLNB3/3snF6MQL6ILy6W0Tc6zBg/7TW0MZG5Sy9LQZussITxKT7AhePI8Wg3pFMAgs
         MuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=vS3rKhKmVNWdP8BTx6DUkw/BP6aZMddutgC86Vsw5Rk=;
        b=NxWZTJB/yDJInmx6y3OwX+Nks43Cypr2VyXxWA7855GjeDXbvMdhaCb4RBrrlychK6
         b3SF7aqMZ/V9rRhLdfkcEKnkXu8+tjwhcRDo3KJerD7DybK93UcyfBPY1vklI/hLgAla
         ipjugRcd5vb+lYiGehanakmuxsBB1Tdn/LvL6a+V3Yp/0McgEYvfc/BcsE7ugpHVDvY4
         i3a4wdJtok7L3wUFwJTjhM9AhOecxRqGkg8oNdO+ngnmSkQpQBJu5nnstKALxOE9C62y
         cuh0YjDy65unKZjGptpTYGr/w8fY9jYnDdsKLDCKQ7eZphOE6r/ig1WDNzJlJ0DRu3LL
         Vlxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=SKgxWTrK;
       spf=pass (google.com: domain of kernel-hardening-return-13156-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13156-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=SKgxWTrK;
       spf=pass (google.com: domain of kernel-hardening-return-13156-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13156-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sat, 28 Apr 2018 20:09:40 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Igor Stoppa <igor.stoppa@gmail.com>
Cc: mhocko@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
	linux-mm@kvack.org, kernel-hardening@lists.openwall.com,
	linux-security-module@vger.kernel.org, labbott@redhat.com,
	linux-kernel@vger.kernel.org, igor.stoppa@huawei.com
Subject: Re: [PATCH 0/3] linux-next: mm: hardening: Track genalloc allocations
Message-ID: <20180429030940.GA2541@bombadil.infradead.org>
References: <20180429024542.19475-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180429024542.19475-1-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599046930013437561?=
X-GMAIL-MSGID: =?utf-8?q?1599048416410377224?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 29, 2018 at 06:45:39AM +0400, Igor Stoppa wrote:
> This patchset was created as part of an older version of pmalloc, however
> it has value per-se, as it hardens the memory management for the generic
> allocator genalloc.
> 
> Genalloc does not currently track the size of the allocations it hands out.
> 
> Either by mistake, or due to an attack, it is possible that more memory
> than what was initially allocated is freed, leaving behind dangling
> pointers, ready for an use-after-free attack.

This is a good point.  It is worth hardening genalloc.
But I still don't like the cost of the bitmap.  I've been
reading about allocators and I found Bonwick's paper from 2001:
https://www.usenix.org/legacy/event/usenix01/full_papers/bonwick/bonwick.pdf
Section 4 describes the vmem allocator which would seem to have superior
performance and lower memory overhead than the current genalloc allocator,
never mind the hardened allocator.

Maybe there's been an advnace in resource allocator technology since
then that someone more familiar with CS research can point out.
