Return-Path: <mgorman@suse.de>
X-Google-Smtp-Source: AH8x224ngIDD1E0YtsAG4wj/ykwNiyq/mPUn370XUoGAK73mrGNlqQjVqF/SCAUJuAVbhijB4x9Y
ARC-Seal: i=1; a=rsa-sha256; t=1519045828; cv=none;
        d=google.com; s=arc-20160816;
        b=oy70yLZHLyFlKsv08YMg9GyUeYctREFVvm7ZTW6XKhPO/1tbdeSb2SsOjuHX0MuvQ9
         83RU4/mAjq6Qhi0i6ZIXRvmTtRE1dVmha33djZNixG8sjrDHSA2osjnnDRfG5YkI0gvR
         aEk6LKnI4gIzzZTq8hoC0IalJpyvtL7jMuM2chcImeRPqF6T3ycJ3oaYeFyAUWY0u/Pr
         RzHVP1uAlrPVg6oImGI4y/vUZrhkj6t7UqD+q5gSolJwQy4CAbXBkUP0gnDoXNMus1GX
         2C9G5M9KnQkqpZ08fTbrytI9nDMivt+R5QOu8XYgG2QzJhdbj/rkp/YApC3nUHlraUtM
         JaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=BaJYi7N7zx2+lnHUxHO9C/0xeEmXPMiu9ibU7hBT+yg=;
        b=T8VHoS129BNZI9nELdT8SyUnE3lysefIDuvEVR3304UvOsAr/CgbNxoFXaP+SneF1G
         lkbrz5PM5srOZTlWaa6MW5tWLK/PB2h1Dqur2m4B/WBjH/SZjbrVfNa/bpGxaUyom3h3
         9Aurix/aNaSBvKabsvrPAl0JiByQYDD4Hp5Rowa8zYogVo6hBkQiK9fnnS55iQ/QjOVS
         0EtzYhIHlHi9eKvJaSyUhWdYTzufgJGxzJ0VIwavtFRvYVsZmyS77BP953u8wX3SI3/u
         68Ot9xlQnv+K9IuUgGCUelF10zHM53HIpZwHg2+juW/94eKpHwrPovHi/7btnoavRAmx
         saRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mgorman@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=mgorman@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mgorman@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=mgorman@suse.de
Date: Mon, 19 Feb 2018 13:10:24 +0000
From: Mel Gorman <mgorman@suse.de>
To: Robert Harris <robert.m.harris@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kemi Wang <kemi.wang@intel.com>,
	David Rientjes <rientjes@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Kangmin Park <l4stpr0gr4m@gmail.com>,
	Yisheng Xie <xieyisheng1@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huang Ying <ying.huang@intel.com>,
	Vinayak Menon <vinmenon@codeaurora.org>
Subject: Re: [PATCH 1/1] mm, compaction: correct the bounds of
 __fragmentation_index()
Message-ID: <20180219131024.oqonm6ba3pl2l4qa@suse.de>
References: <1518972475-11340-1-git-send-email-robert.m.harris@oracle.com>
 <1518972475-11340-2-git-send-email-robert.m.harris@oracle.com>
 <20180219094735.g4sm4kxawjnojgyd@suse.de>
 <CB73A16F-5B32-4681-86E3-00786C67ADEF@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CB73A16F-5B32-4681-86E3-00786C67ADEF@oracle.com>
User-Agent: NeoMutt/20170912 (1.9.0)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592757962533260207?=
X-GMAIL-MSGID: =?utf-8?q?1592834998398395425?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 12:26:39PM +0000, Robert Harris wrote:
> 
> 
> > On 19 Feb 2018, at 09:47, Mel Gorman <mgorman@suse.de> wrote:
> > 
> > On Sun, Feb 18, 2018 at 04:47:55PM +0000, robert.m.harris@oracle.com wrote:
> >> From: "Robert M. Harris" <robert.m.harris@oracle.com>
> >> 
> >> __fragmentation_index() calculates a value used to determine whether
> >> compaction should be favoured over page reclaim in the event of allocation
> >> failure.  The calculation itself is opaque and, on inspection, does not
> >> match its existing description.  The function purports to return a value
> >> between 0 and 1000, representing units of 1/1000.  Barring the case of a
> >> pathological shortfall of memory, the lower bound is instead 500.  This is
> >> significant because it is the default value of sysctl_extfrag_threshold,
> >> i.e. the value below which compaction should be avoided in favour of page
> >> reclaim for costly pages.
> >> 
> >> This patch implements and documents a modified version of the original
> >> expression that returns a value in the range 0 <= index < 1000.  It amends
> >> the default value of sysctl_extfrag_threshold to preserve the existing
> >> behaviour.
> >> 
> >> Signed-off-by: Robert M. Harris <robert.m.harris@oracle.com>
> > 
> > You have to update sysctl_extfrag_threshold as well for the new bounds.
> 
> This patch makes its default value zero.
> 

Sorry, I'm clearly blind.

> > It effectively makes it a no-op but it was a no-op already and adjusting
> > that default should be supported by data indicating it's safe.
> 
> Would it be acceptable to demonstrate using tracing that in both the
> pre- and post-patch cases
> 
>   1. compaction is attempted regardless of fragmentation index,
>      excepting that
> 
>   2. reclaim is preferred even for non-zero fragmentation during
>      an extreme shortage of memory
> 

If you can demonstrate that for both reclaim-intensive and
compaction-intensive workloads then yes. Also include the reclaim and
compaction stats from /proc/vmstat and not just tracepoints to demonstrate
that reclaim doesn't get out of control and reclaim the world in
response to failed high-order allocations such as THP.

-- 
Mel Gorman
SUSE Labs
