Return-Path: <mgorman@suse.de>
X-Google-Smtp-Source: AH8x2246lrw19XvYx7SfkQAn9wUgd8THpqDaCgCwGs2m80hsAR8r2jXu0h0IyhWWunkgkPK0EGp8
ARC-Seal: i=1; a=rsa-sha256; t=1519033659; cv=none;
        d=google.com; s=arc-20160816;
        b=Q0Og/gcwsyNm741a+f/OjfwlgZ8DohRUYA3Tgb8zJ2FZs2bozUDP95CIdB8QLKzKhX
         Cgjmtyer2viAYLihQ8+3wAGKZGfHj1qaijx94h1B39CTGfgPTyUIwHTfhqQB9lSvItMA
         K3tAoGHNMJHB6z0bWISHU6zepZjP8DaFSSMCj+cchT8Zse4piHSWxvNdXA4pdhHccbC3
         A/spszaUSmnlfVbcsi24fzMrt84kPvBOkJuiqXm3m79iEFC7yndOUVNJtMbc1sKIRWdS
         Po3D9kpWKSIpZjPkb+Hl1IxCUd9oueKx/A78I5gjvm9pywpdbx4vk+TjPjb0Gf6byd0X
         OVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=8MVtlbpjpphJFPtGRR5iKxG7Ule2OEPIZHoiYIoWofA=;
        b=YT3t/uNTkYPriks0j8iF3UX8mpuY5sJz1dT4Pp5TxiIBkoC3FVsrx7YbVVOtZ1mxBO
         74REAlKONfeV3VSA/LgRAHQviNBh4byaSs4nKUPLjIKjloo2CPx3os1KE3P3zVfHOgMN
         N8fUlu87pHx7ckxrIF1Rx5qQRS6qs9ClKuPYjB014DRCLSKGjWTx+CjHFevCdUcE5h6q
         4tawlXdZYqjZ9SeqgnjOQgy8ouuSCXMerxiBKbHPwtn6tcMSJ9SKcenmMPHWsc4vfmLq
         ffTrIx4jm41NBgfoX/Yj8Onil5rEiPCJYLABgbVhMzA0BkY4VAwcgD8uBVg/NnTuPb0L
         wQ5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mgorman@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=mgorman@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mgorman@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=mgorman@suse.de
Date: Mon, 19 Feb 2018 09:47:35 +0000
From: Mel Gorman <mgorman@suse.de>
To: robert.m.harris@oracle.com
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
Message-ID: <20180219094735.g4sm4kxawjnojgyd@suse.de>
References: <1518972475-11340-1-git-send-email-robert.m.harris@oracle.com>
 <1518972475-11340-2-git-send-email-robert.m.harris@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1518972475-11340-2-git-send-email-robert.m.harris@oracle.com>
User-Agent: NeoMutt/20170912 (1.9.0)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592757962533260207?=
X-GMAIL-MSGID: =?utf-8?q?1592822238717517562?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 18, 2018 at 04:47:55PM +0000, robert.m.harris@oracle.com wrote:
> From: "Robert M. Harris" <robert.m.harris@oracle.com>
> 
> __fragmentation_index() calculates a value used to determine whether
> compaction should be favoured over page reclaim in the event of allocation
> failure.  The calculation itself is opaque and, on inspection, does not
> match its existing description.  The function purports to return a value
> between 0 and 1000, representing units of 1/1000.  Barring the case of a
> pathological shortfall of memory, the lower bound is instead 500.  This is
> significant because it is the default value of sysctl_extfrag_threshold,
> i.e. the value below which compaction should be avoided in favour of page
> reclaim for costly pages.
> 
> This patch implements and documents a modified version of the original
> expression that returns a value in the range 0 <= index < 1000.  It amends
> the default value of sysctl_extfrag_threshold to preserve the existing
> behaviour.
> 
> Signed-off-by: Robert M. Harris <robert.m.harris@oracle.com>

You have to update sysctl_extfrag_threshold as well for the new bounds.
It effectively makes it a no-op but it was a no-op already and adjusting
that default should be supported by data indicating it's safe.

-- 
Mel Gorman
SUSE Labs
