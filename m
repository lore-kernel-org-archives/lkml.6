Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AH8x226eoljUyW5aFpy2XZeq6KFW8rEeRmSJaCHggWicr9BGYIkZZ/3stYL0iRc96BEs12r5xofv
ARC-Seal: i=1; a=rsa-sha256; t=1519028670; cv=none;
        d=google.com; s=arc-20160816;
        b=vqzBj5i3fM7o+cM8Vh0J6DbAMQv6RQ3QffO521nL63W/7K7iMtT3uhZD653hdelyF9
         LhujdHmNkpi3eA4yiFzJZgWbRUBrkHN8dNhwjfHXeKnVPPki6mMoaLUDPotTVpneinI4
         w32cT+90AMY4bolwj8OMI/HwdSFUT9og20rM50skXIWeyhTOlATT7FB7wUS9Y7AkmqLL
         tXeZO2BeXyBGjOG3G5QGc+kZslyUcmUOx365Vrq96IFyO6v25BrEIwRUw76T7kQf/Mpv
         5pJ3HFsa8k9iE0sbrphGW2jpb9YEKjnb4HlxF0PWhvy4pheMz7MxOw4fjdoM1k7klAYU
         aSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=uJDzz0BW1zRaQoJE4maFgw7wh7UXmw+maMhLTL+hSGY=;
        b=WiMKRRf97PC47ZL1+bmYD0Ama8voQEu9uQbHXPtrFybrqwDNOjYrkfEW+J1rrVjxyR
         Ui/wRLoF7FRbiLSMwvOzA0pikgRqafT7ZifU4lxGUR9XYNGBC0BmiKt41mVw7bCdKDyk
         SmVCOTyUQIaNk0T5kMrwLPlpHwfKm2+dUHsJu/k1uULdRXbJsb433Ihwym3AxbG0OG+g
         buVeVbXMSqEOWI4AY0IpDYWbUqBEPwt//3uGO1c8rqLvGKXDluPynF/WMRTJ/u1pWSZA
         ooC7L7YQY32lyyRSF0P7wgrxQMGJ6J9mPrlyOOZDbrmkmpkd9e2cbGTJCiWYWyrjnzvS
         5ePg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Mon, 19 Feb 2018 09:24:28 +0100
From: Michal Hocko <mhocko@kernel.org>
To: robert.m.harris@oracle.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kemi Wang <kemi.wang@intel.com>,
	David Rientjes <rientjes@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Kangmin Park <l4stpr0gr4m@gmail.com>, Mel Gorman <mgorman@suse.de>,
	Yisheng Xie <xieyisheng1@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huang Ying <ying.huang@intel.com>,
	Vinayak Menon <vinmenon@codeaurora.org>
Subject: Re: [PATCH 0/1] mm, compaction: correct the bounds of
 __fragmentation_index()
Message-ID: <20180219082428.GC21134@dhcp22.suse.cz>
References: <1518972475-11340-1-git-send-email-robert.m.harris@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518972475-11340-1-git-send-email-robert.m.harris@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592757962533260207?=
X-GMAIL-MSGID: =?utf-8?q?1592817007304891475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun 18-02-18 16:47:54, robert.m.harris@oracle.com wrote:
> From: "Robert M. Harris" <robert.m.harris@oracle.com>
> 
> __fragmentation_index() calculates a value used to determine whether
> compaction should be favoured over page reclaim in the event of
> allocation failure.  The function purports to return a value between 0
> and 1000, representing units of 1/1000.  Barring the case of a
> pathological shortfall of memory, the lower bound is instead 500.  This
> is significant because it is the default value of
> sysctl_extfrag_threshold, i.e. the value below which compaction should
> be avoided in favour of page reclaim for costly pages.
> 
> Here's an illustration using a zone that I fragmented with selective
> calls to __alloc_pages() and __free_pages --- the fragmentation for
> order-1 could not be minimised further yet is reported as 0.5:

Cover letter for a single patch is usually an overkill. Why is this
information not valuable in the patch description directly?

> # head -1 /proc/buddyinfo
> Node 0, zone      DMA   1983      0      0      0      0      0      0      0      0      0      0 
> # head -1 /sys/kernel/debug/extfrag/extfrag_index
> Node 0, zone      DMA -1.000 0.500 0.750 0.875 0.937 0.969 0.984 0.992 0.996 0.998 0.999 
> # 
> 
> With extreme memory shortage the reported fragmentation index does go
> lower.  In fact, it can go below zero:
> 
> # head -1 /proc/buddyinfo
> Node 0, zone      DMA      1      0      0      0      0      0      0      0      0      0      0 
> # head -1 /sys/kernel/debug/extfrag/extfrag_index
> Node 0, zone      DMA -1.000 0.-500 0.-250 0.-125 0.-62 0.-31 0.-15 0.-07 0.-03 0.-01 0.000 
> # 
> 
> This patch implements and documents a modified version of the original
> expression that returns a value in the range 0 <= index < 1000.  It
> amends the default value of sysctl_extfrag_threshold to preserve the
> existing behaviour.  With this patch in place, the same two tests yield
> 
> # head -1 /proc/buddyinfo
> Node 0, zone      DMA   1983      0      0      0      0      0      0      0      0      0      0 
> # head -1 /sys/kernel/debug/extfrag/extfrag_index
> Node 0, zone      DMA -1.000 0.000 0.500 0.750 0.875 0.937 0.969 0.984 0.992 0.996 0.998 
> # 
> 
> and
> 
> # head -1 /proc/buddyinfo
> Node 0, zone      DMA      1      0      0      0      0      0      0      0      0      0      0 
> # head -1 /sys/kernel/debug/extfrag/extfrag_index
> Node 0, zone      DMA -1.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 
> # 
> 
> Robert M. Harris (1):
>   mm, compaction: correct the bounds of __fragmentation_index()
> 
>  Documentation/sysctl/vm.txt |  2 +-
>  mm/compaction.c             |  2 +-
>  mm/vmstat.c                 | 47 +++++++++++++++++++++++++++++++++++----------
>  3 files changed, 39 insertions(+), 12 deletions(-)
> 
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
