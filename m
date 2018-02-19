Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AH8x227yfSuCAR+bFJQOE+5qJ3j6+AMVe/KzpCb+9VpsfPOJglaxUDa5jt5v0cPWnTM1kLYx2tdV
ARC-Seal: i=1; a=rsa-sha256; t=1519043976; cv=none;
        d=google.com; s=arc-20160816;
        b=xlsVrO9kUjUuylt6bmm0Tv51FfiL3VBKyDI6sK9065EG0cgC/P6BLfu6onKFjw0t6p
         kCgiSoTyth9JaPmjkEIjADvwWvL+iqiCsf8gaj/WEwFt2ErByobGjqBhpOBIpDyCiDL9
         frEyyqqAokEJKo8XO0/ultGtvVN/GN78H82GPrWQF0uHg/+zKymjZD/q3ZJpMdQw3BTB
         Sxo3CuWBauRUbHZ69Zzpin46325G3FVaVEcgfQ1YYP2CFeo1wyVeAyZgVV21Q4Sy08+A
         EORvRN/ARRbBACd4DR1gfCvaME2wJISyImKnvLQbITGfbyuSz6Bme867ObKgJzaNP6rB
         gm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=2LxWSJ1l/zZSAfgsWXPO7pVoABOqp6Dbvw2UMUCIeg8=;
        b=xe/hEU15C+Qd9dtOqWMoRqgyIWHkontDxqbllKLlN04OocOiARkIDVceB51P+rr5Jc
         xAIeI3aVjtkJr/TznZ9FXVPQsD8jwKff9QDcbBU4dZD4+YSSLh/rrRTECyD/zBJwREnK
         +DTqzg574mapTzp9Rj1HjiWX9yr2U7x+VVQMd+qwGPNOI/bgqFA0fsJ2QRawZa/oK4m5
         9TX+p+Q3hlw/yi88WgF1/3ETqVTBzLOZP5kjuPZeUYEXg2bMzHin/A+VYHawazTTL7js
         On3nU9U8GkIPPaGqSVFII/rdit5FuCKW1eoPyaNVnikbvgP3OdSwValb/tRU4oIF+8hZ
         NnFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Mon, 19 Feb 2018 13:39:32 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Robert Harris <robert.m.harris@oracle.com>
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
Subject: Re: [PATCH 1/1] mm, compaction: correct the bounds of
 __fragmentation_index()
Message-ID: <20180219123932.GF21134@dhcp22.suse.cz>
References: <1518972475-11340-1-git-send-email-robert.m.harris@oracle.com>
 <1518972475-11340-2-git-send-email-robert.m.harris@oracle.com>
 <20180219082649.GD21134@dhcp22.suse.cz>
 <E718672A-91A0-4A5A-91B5-A6CF1E9BD544@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E718672A-91A0-4A5A-91B5-A6CF1E9BD544@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592757962533260207?=
X-GMAIL-MSGID: =?utf-8?q?1592833056590648125?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 19-02-18 12:14:26, Robert Harris wrote:
> 
> 
> > On 19 Feb 2018, at 08:26, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > On Sun 18-02-18 16:47:55, robert.m.harris@oracle.com wrote:
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
> > 
> > It is not really clear to me what is the actual problem you are trying
> > to solve by this patch. Is there any bug or are you just trying to
> > improve the current implementation to be more effective?
> 
> There is not a significant bug.
> 
> The first problem is that the mathematical expression in
> __fragmentation_index() is opaque, particularly given the lack of
> description in the comments or the original commit message.  This patch
> provides such a description.
> 
> Simply annotating the expression did not make sense since the formula
> doesn't work as advertised.  The fragmentation index is described as
> being in the range 0 to 1000 but the bounds of the formula are instead
> 500 to 1000.  This patch changes the formula so that its lower bound is
> 0.

But why do we want to fix that in the first place? Why don't we simply
deprecate the tunable and remove it altogether? Who is relying on tuning
this option. Considering how it doesn't work as advertised and nobody
complaining I have that feeling that it is not really used in wild...
-- 
Michal Hocko
SUSE Labs
