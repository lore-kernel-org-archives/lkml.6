Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AIpwx48Du8pX0MHnA1UuACcDvGhzb6YLIjVN//hr6yIPaNUf0Y7jkaPu3pgwozv9RG5KexDv/wjs
ARC-Seal: i=1; a=rsa-sha256; t=1523639486; cv=none;
        d=google.com; s=arc-20160816;
        b=Q7JJ7idZIxCRZkb5ZCi7aJvuX26GR4VKNMbf0qZ82XvOLuygqDCJ71InaRSsgeUYPR
         LFAG9EiYGZTBTf2qjqajpsyBEj9TqovirYczQkmd5tpOjqE7p0iT1Ic2PZfhT+pjYJ1P
         mfaWEggiOwTfitBLOnlUy65x2D/vJwf30UdU67tZC/x602PymPgV0oTTlQodyuZXDN9/
         kXNepZvv8CeKWBEFG/3Q+o01DWloDMLb15/o2DwxD1c9Ea5SFAEydiqlzf4zGa/3zT7Q
         JihhvxyEQfFHkM1x5puQgVwecwJqst6+aNJWRqKxD5TLimKTNIHkPXjil2/tPqwfCij6
         3m/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=/3EfIcqoQfv1K0nrBHoJ4RR6tH9nWpqyqMZqN8jQVro=;
        b=jnBZ9zJnRgmUyvJH08u27uai6TQ70/C/zvR7IPG/PUoKDyDEqAbjMQWnleUpWG0CrC
         K4RJue6pEyONmyA3qyHG1UTZZ3Bo2G9y0W/Vz4ptpgEmAJ4SFLsue+xqQsr+pOl/xKQL
         TSq8m9MSofa4Eom4lYU2OhZzOvLJAeR7/tdHcQwUdDfGTc3JIyJ71FZg2LK2wi+ubDMe
         RfVeMf12d2d+yfkTYUkiXWNFlIw4yR8QdhOY0vtlLyNcmHVFxyQYxShAsYBgN1BZiIYz
         XPSKxUr2HmUWwlmdxb9dEE9GpPBARmg2nYNvSkmZScxKLso1ZD26OCwjP+A94NEpzI1Y
         sEFw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=jUhLkIvV;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=jUhLkIvV;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Fri, 13 Apr 2018 10:11:20 -0700
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Huang Ying <ying.huang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Miles Chen <miles.chen@mediatek.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rik van Riel <riel@redhat.com>, James Hogan <jhogan@kernel.org>,
	"Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/8] mm: introduce PG_offline
Message-ID: <20180413171120.GA1245@bombadil.infradead.org>
References: <20180413131632.1413-1-david@redhat.com>
 <20180413131632.1413-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413131632.1413-3-david@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597637040722220932?=
X-GMAIL-MSGID: =?utf-8?q?1597651798037366651?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 03:16:26PM +0200, David Hildenbrand wrote:
> online_pages()/offline_pages() theoretically allows us to work on
> sub-section sizes. This is especially relevant in the context of
> virtualization. It e.g. allows us to add/remove memory to Linux in a VM in
> 4MB chunks.
> 
> While the whole section is marked as online/offline, we have to know
> the state of each page. E.g. to not read memory that is not online
> during kexec() or to properly mark a section as offline as soon as all
> contained pages are offline.

Can you not use PG_reserved for this purpose?

> + * PG_offline indicates that a page is offline and the backing storage
> + * might already have been removed (virtualization). Don't touch!

 * PG_reserved is set for special pages, which can never be swapped out. Some
 * of them might not even exist...

They seem pretty congruent to me.
