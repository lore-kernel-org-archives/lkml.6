Return-Path: <jack@suse.cz>
X-Google-Smtp-Source: AG47ELtbQw05+gdItUPNYxSqnu/uzcx4uILly6RqcvV9Y5zUgYjTr1hK97V6fbOZ2o7Gaav1zMJF
ARC-Seal: i=1; a=rsa-sha256; t=1521577056; cv=none;
        d=google.com; s=arc-20160816;
        b=S/+zMFVlqVErCLirt3Ei4jOwZadQplpre3wxamvEN9ow+Bj+gmmbJzWLximsXSi6ea
         MOnb/wAp9268npLuPaZX/9nRPoPWiQhCe5JwnTzrry/jn1xhxaIugOQdMhG0KwMS9Gxc
         H21+PN21K8+WuuFzvL7vVEyDUTwfNi/nDpe1CqchHlttKXfsXMc26aJWyrvHVKwwEncH
         OKT6S1BiveXb7JF5L4vBoJuQJdl3NROcAsFg16C4UU/as8mSD9sP+05tuohT/7aXqTFG
         tWPkdo8TV8V5ivb8mC2V+kJUu6IKjKq8relk+8wtjt8JlCGMGpRbzjjdl4lReJpsN2Xh
         U36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=B6RwOF1O1GvwZxBxx4aKn10fdudaOwfzwSFl60ngLek=;
        b=tKdHSO/pVZo0sa7DODjfpt74dqt2OLY7yiJ1daPMJCSXxC8jblN1lHs16pu8Yc3QwE
         rgC42qoPj3pIcRsv94r18A4eQ5GMWsHeiPwViEw3Vgh/J9YJU+polxCCWmM5iWPxCcIj
         9lGv/HEjKE7n4tfMt1h0y+5C8AGG819v71Rbgusi0JYIqf7Qb22g/SW2tlDR2wqLKyhr
         eiE+ONXUOFf4agLjuIaknhIpv52JFVga6pDz/fC49bj+2KCGnK0gox7Cw1bof6R8BvxG
         g01e+6+mTW/x38YjtEdE5j8np6NSyGnIb+NmMHT9N/qGG2O83cZi15db1+vtGhOYRK/X
         FOnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jack@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=jack@suse.cz
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jack@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=jack@suse.cz
Date: Tue, 20 Mar 2018 21:17:30 +0100
From: Jan Kara <jack@suse.cz>
To: Wei Wang <wvw@google.com>
Cc: gregkh@linuxfoundation.org, Todd Poynor <toddpoynor@google.com>,
	Wei Wang <wei.vince.wang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jan Kara <jack@suse.cz>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Sherry Cheung <SCheung@nvidia.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Huang Ying <ying.huang@intel.com>, Dennis Zhou <dennisz@fb.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, mgorman@suse.de
Subject: Re: [PATCH] mm: add config for readahead window
Message-ID: <20180320201730.xvvpc4gptqrn47ba@quack2.suse.cz>
References: <20180316182512.118361-1-wvw@google.com>
 <CAGXk5yoVMd9B=nvob7s=niCAQ9oHAX84eupF9Eet_dAk7WTStg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXk5yoVMd9B=nvob7s=niCAQ9oHAX84eupF9Eet_dAk7WTStg@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595119752476729321?=
X-GMAIL-MSGID: =?utf-8?q?1595489184282423101?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 16-03-18 18:49:08, Wei Wang wrote:
> Android devices boot time benefits by bigger readahead window setting from
> init. This patch will make readahead window a config so early boot can benefit
> by it as well.
> 
> 
> On Fri, Mar 16, 2018 at 11:25 AM Wei Wang <wvw@google.com> wrote:
> 
>     From: Wei Wang <wvw@google.com>
> 
>     Change VM_MAX_READAHEAD value from the default 128KB to a configurable
>     value. This will allow the readahead window to grow to a maximum size
>     bigger than 128KB during boot, which could benefit to sequential read
>     throughput and thus boot performance.
> 
>     Signed-off-by: Wei Wang <wvw@google.com>

Just for record we had VM_MAX_READAHEAD changed to 512 in all SUSE
distributions for quite some years. But just recently we were re-evaluating
it and we are finding less and less reasons to keep this setting to 512 -
with newer storage benefits become marginal and the overhead of reading
more unnecessarily in some other corner cases is visible as well (I still
have somewhere reports from 0-day robot that complained to me about two
performance regressions coming from increased default readahead window).

So for your specific case it might make sense to increase the window when
you have a control of both the HW and the kernel but in general I tend to
currently agree with Linus & co. that the current default is probably fine.

I don't have a strong opinion on whether your ~90ms of boot time are good
enough justification for a kernel config option...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
