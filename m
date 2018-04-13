Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AIpwx49KOVFZJhenKkprxS4Nlsai9qS4jn3kkZpjZu5ZMihiWfGyQqfZ/apBGci1lYVfqxArKbvz
ARC-Seal: i=1; a=rsa-sha256; t=1523626851; cv=none;
        d=google.com; s=arc-20160816;
        b=dDI2czalPQzFcHXAhkqloYfJ1qY2mJeQXFe1lP6PY6PjK/P45nK+kapi7/YTpZfnYo
         qvoixSQgpxtndMJhtPI3HRKzD34oP1mMbSoSW8AI5pS9DLrlvK5mH6T2xMW9rSWZ+zD0
         Z1UsrSleHg48GvxWkowYRJU40zFHdjt179vryomK8S+HM/TV/gORJEdI8nj0dlK+nmyI
         tbPnF8POnr9fjEpv/kabUCtpicDUWGemXVMQzYHlcG99iIuaYR8BLU5tEmt3SjiVGM56
         6pen1w02Pcwh4qfKbE7S36U4rwT6oY+xSwloMz1mfeXy8VAZVKgW5i1CcHEvzBR20Yuo
         y9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=IAHHr6h6mQp1Evxb54K6b8RyK78N0P+DS3fG/yt5dlU=;
        b=LJD1yTufht7gMfCOkgH134PMIU3a4W0TtfYIkPicz0CrNv81esTxjjDlX+nMxiSKr/
         +0+nILetBEw9tCLvW4yl40eoonc1IYYCMI3BJp9S+D+YB8erBac8BWNL3G/kQ1XfVirf
         2m+d0ZGIYsMmUTAdsBLiMzO/cDIrW8mnJ80l1AWFA4nIIurt03LpLiqJeV0dan4PNl1j
         S6LThPcQxApwjbo1LSsrIgcrd62ASrKLF40EGr0IANLqnOOv1OIfkvWe9pcRTDTI1vjh
         o+WjMLW9idAcyjptLiEE8f/DurcQeolxUEuH8D8vm6Rs47XsdW5D5SmNLwDlD4J5rKld
         j/Sw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Fri, 13 Apr 2018 15:40:47 +0200
From: Michal Hocko <mhocko@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Miles Chen <miles.chen@mediatek.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rik van Riel <riel@redhat.com>, James Hogan <jhogan@kernel.org>,
	"Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/8] mm: introduce PG_offline
Message-ID: <20180413134047.GR17484@dhcp22.suse.cz>
References: <20180413131632.1413-1-david@redhat.com>
 <20180413131632.1413-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413131632.1413-3-david@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597637040722220932?=
X-GMAIL-MSGID: =?utf-8?q?1597638549023605936?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 13-04-18 15:16:26, David Hildenbrand wrote:
> online_pages()/offline_pages() theoretically allows us to work on
> sub-section sizes. This is especially relevant in the context of
> virtualization. It e.g. allows us to add/remove memory to Linux in a VM in
> 4MB chunks.

Well, theoretically possible but this would require a lot of auditing
because the hotplug and per section assumption is quite a spread one.

> While the whole section is marked as online/offline, we have to know
> the state of each page. E.g. to not read memory that is not online
> during kexec() or to properly mark a section as offline as soon as all
> contained pages are offline.

But you cannot use a page flag for that, I am afraid. Page flags are
extremely scarce resource. I haven't looked at the rest of the series
but _if_ we have a bit spare which I am not really sure about then you
should prove there are no other ways around this.
 
> Signed-off-by: David Hildenbrand <david@redhat.com>
-- 
Michal Hocko
SUSE Labs
