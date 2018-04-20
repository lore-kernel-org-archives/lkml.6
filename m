Return-Path: <david@redhat.com>
X-Google-Smtp-Source: AB8JxZoyl6awJUVtNvtNXoPLr60nM4y/h6lkGMw9d13xji6GaZZdugibYqIYYHp3iupaYAX3W5OH
ARC-Seal: i=1; a=rsa-sha256; t=1524209439; cv=none;
        d=google.com; s=arc-20160816;
        b=FQ2Tv7OARDG3btJUFz56ZYIudfWt/tpQRu3wgt9T2xv/8ic/WmGxml9TZ29aoojO3H
         oytYDJETFwhOVIPDDDos8dp1nKz6yonwDnisBPmDKVOyZDmOAwKvvLv/QMMK5JQmqC9Q
         FvX9+HAruNVr568/6Fe5b4rOy5DQ0m10D/QenyJ0vj6N3h3h+qxIjMhGZmABKTHfmObq
         JqtWmY8ST3SWM5Vwvli8ZyNyXwbIPhKAGYKdtLA8Kh41PiFkegUfWwdajpmh7DG++M7N
         f7pN5QsDioA4xADqdA5R4tPsML4MiWtt7LPwsCjeWyELDMpcxNcmt2YaczfG2Ktpn1kW
         fQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=2C2y1Dy915RVvI3pUqvwgWqyUN8z9YdZC3OsonZzZhY=;
        b=lz79IUgWmsoCeztl+QGnwu2NPj3R0kka/cWuQ28UMOZ1aEAAKeF+tL1xnMWb/zSryI
         wQ3q5+boHe1pIJVTcYG5sgp6RJVFONU/KVaebWK1oCNQLDD+508QcUoiIeyOXdvdxmbt
         4wGZp+rfi6/Uy6SZOubyJo7KibDFhA4tSOKf3q0dVjSHh9hDBPqLenmHelHJSAHbSJ4w
         25L5UMtVcOYfmnP6gBJJ4UGyJDD9jLu+R8NdOv3cKgl7xElstG1NfHpmkJcVRIcoI3dc
         rEW7q80ACQP9qWVCU9O7EzenUUjRLrsI0qKzYFNc5jJOdD86DfoxUEf3vcwLrec/diOi
         kLXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH RFC 2/8] mm: introduce PG_offline
To: linux-mm@kvack.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Huang Ying <ying.huang@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Miles Chen <miles.chen@mediatek.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mel Gorman <mgorman@techsingularity.net>, Rik van Riel <riel@redhat.com>,
 James Hogan <jhogan@kernel.org>,
 "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20180413131632.1413-1-david@redhat.com>
 <20180413131632.1413-3-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6624ec31-0b18-62dc-bcc3-5f8a2bf8da49@redhat.com>
Date: Fri, 20 Apr 2018 09:30:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413131632.1413-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597637040722220932?=
X-GMAIL-MSGID: =?utf-8?q?1598249436508740363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13.04.2018 15:16, David Hildenbrand wrote:
> online_pages()/offline_pages() theoretically allows us to work on
> sub-section sizes. This is especially relevant in the context of
> virtualization. It e.g. allows us to add/remove memory to Linux in a VM in
> 4MB chunks.
> 
> While the whole section is marked as online/offline, we have to know
> the state of each page. E.g. to not read memory that is not online
> during kexec() or to properly mark a section as offline as soon as all
> contained pages are offline.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/page-flags.h     | 10 ++++++++++
>  include/trace/events/mmflags.h |  9 ++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index e34a27727b9a..8ebc4bad7824 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -49,6 +49,9 @@
>   * PG_hwpoison indicates that a page got corrupted in hardware and contains
>   * data with incorrect ECC bits that triggered a machine check. Accessing is
>   * not safe since it may cause another machine check. Don't touch!
> + *
> + * PG_offline indicates that a page is offline and the backing storage
> + * might already have been removed (virtualization). Don't touch!
>   */
>  
>  /*
> @@ -100,6 +103,9 @@ enum pageflags {
>  #if defined(CONFIG_IDLE_PAGE_TRACKING) && defined(CONFIG_64BIT)
>  	PG_young,
>  	PG_idle,
> +#endif
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +	PG_offline,		/* Page is offline. Don't touch */
>  #endif
>  	__NR_PAGEFLAGS,
>  
> @@ -381,6 +387,10 @@ TESTCLEARFLAG(Young, young, PF_ANY)
>  PAGEFLAG(Idle, idle, PF_ANY)
>  #endif
>  
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +PAGEFLAG(Offline, offline, PF_ANY)
> +#endif
> +
>  /*
>   * On an anonymous page mapped into a user virtual memory area,
>   * page->mapping points to its anon_vma, not to a struct address_space;
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index a81cffb76d89..14c31209e34a 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -79,6 +79,12 @@
>  #define IF_HAVE_PG_IDLE(flag,string)
>  #endif
>  
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +#define IF_HAVE_PG_OFFLINE(flag,string) ,{1UL << flag, string}
> +#else
> +#define IF_HAVE_PG_OFFLINE(flag,string)
> +#endif
> +
>  #define __def_pageflag_names						\
>  	{1UL << PG_locked,		"locked"	},		\
>  	{1UL << PG_waiters,		"waiters"	},		\
> @@ -104,7 +110,8 @@ IF_HAVE_PG_MLOCK(PG_mlocked,		"mlocked"	)		\
>  IF_HAVE_PG_UNCACHED(PG_uncached,	"uncached"	)		\
>  IF_HAVE_PG_HWPOISON(PG_hwpoison,	"hwpoison"	)		\
>  IF_HAVE_PG_IDLE(PG_young,		"young"		)		\
> -IF_HAVE_PG_IDLE(PG_idle,		"idle"		)
> +IF_HAVE_PG_IDLE(PG_idle,		"idle"		)		\
> +IF_HAVE_PG_OFFLINE(PG_offline,		"offline"	)
>  
>  #define show_page_flags(flags)						\
>  	(flags) ? __print_flags(flags, "|",				\
> 

I am thinking right now of gluing this to CONFIG_MEMORY_PG_OFFLINE and
allowing it to be used also for ordinary balloon drivers. It is then
basically a way to signal using kdump "don't dump this page, the content
is either invalid or not even accessible".

-- 

Thanks,

David / dhildenb
