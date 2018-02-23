Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AH8x224GasKl0JBtab1kvxpFWhY4/gP7daUKnpsPy1moJWFvcRlTNgzFNbuPgHfIa7J96HzZQbeg
ARC-Seal: i=1; a=rsa-sha256; t=1519393965; cv=none;
        d=google.com; s=arc-20160816;
        b=BT27/osmiZg1ZrTdKbkTxjgVmdD08uRrnb7DU6yXszSlHSzxs57hW9W8zQ32czrJ+G
         N25jTRRSbANqwKcE2qWkMQ3qALbVNsSKBCru8xX2y1ESDx1pKTvFHfRM2Uo+fk/s/7dE
         K/XDA5DnBJ9gYvHsoBSSU5MSxfj7D3/2OQCm7rIDO/+XW0auYYXLW/0wCyZ12B7D3mhY
         1b5hJZxebOgt4VHacjUVdd3ie9iN/w99JajtZaaNi9Dzxw4hbCv1HPOXMBvwlp+kuyIH
         AbSTck1c0E58yCR8/Muv2LzbR5SOXPx+bwE0aH4kw/NYncu/s+lBA1gO/BE+Iz7VaUbO
         PXQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=+3HBWuKnyIydw7a1AwWnN4lFrGxXK5jf4R45KKzj5Ak=;
        b=XfDcILkHpw65GXY/yH9OWmWTXoTfKpd0LgDBIYryW5N+gbPk0RBf+JZbbK5NxUy9OG
         urImSZqKxp1mUvhkkdkxrmhTJmXMwqNR+y8SslnF121q8Yo5iAH95c/qH6j6vHURbKLL
         PBHo+geLvs3k1AkSPM6zdMmK9EqxsjPba3JFhPc9da2zWKUkC0FGoCE4DDXo+ntLy/e/
         DekVRpanJWNPr3LlObneg8sY4CJW/T74RNablfhmBiVrEtP2MokW3ruu1pWrzy/Nc56h
         9/Gq4LxzVU6DoK9TyBC4Tsi1EziEsrG4FlojlhO+JhxeEHZB32Y/W3zkvkuzZHcJfqAv
         Engw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Fri, 23 Feb 2018 14:52:39 +0100
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
Message-ID: <20180223135239.GV30681@dhcp22.suse.cz>
References: <1518972475-11340-1-git-send-email-robert.m.harris@oracle.com>
 <1518972475-11340-2-git-send-email-robert.m.harris@oracle.com>
 <20180219082649.GD21134@dhcp22.suse.cz>
 <E718672A-91A0-4A5A-91B5-A6CF1E9BD544@oracle.com>
 <20180219123932.GF21134@dhcp22.suse.cz>
 <90E01411-7511-4E6C-BDDF-74E0334E24FC@oracle.com>
 <20180223091020.GS30681@dhcp22.suse.cz>
 <2958E989-B084-4DA3-8350-CD20AD04392B@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2958E989-B084-4DA3-8350-CD20AD04392B@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592757962533260207?=
X-GMAIL-MSGID: =?utf-8?q?1593200046390015581?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 23-02-18 13:40:09, Robert Harris wrote:
> If you are asking me to prove whether modifying the tuneable in the
> manner above, thereby preferring compaction for more fragmented systems,
> is successful then I can't answer now.  I assume that the onus would
> have been on Mel to show this at the time of the original commit.
> However, I interpret his last comment on this patch as a request to
> verify that changing the preference yields sane results.

Yes, this is exactly were I was aiming... This might have been useful
during the initial compaction implementation but I am not aware of any
real users and I am also quite skeptical it is very much useful. I do
realize that this is hand waving because I do not have any numbers at
hands. The bottom line is that the users should care, really. The
compaction should be as automatic as possible. We can argue about
tuning for certain allocation orders and make the compaction more
pro-active to provide lower latencies for those requests but deciding
whether to reclaim or compact sounds like a too low level decision for
admin to make and kind of unstable interface for different kernels as
the implementation of the compaction changes over time.

So I would really prefer to kill the tuning than try to "fix" it.
-- 
Michal Hocko
SUSE Labs
