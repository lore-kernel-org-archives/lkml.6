Return-Path: <vbabka@suse.cz>
X-Google-Smtp-Source: AIpwx48+I0uFins4E4fzSdkFDyPbzs22apwqlf36hBi+E2cLBW2BKRnshF/gxrvx4kpMjLL2nJeK
ARC-Seal: i=1; a=rsa-sha256; t=1524352537; cv=none;
        d=google.com; s=arc-20160816;
        b=qhPNzn0QALsMVKFCwUyWrPH8S4yQN4+nKDHFwtZb+ST+t8Nc/Ap+FcmNqN6keQ1yZ1
         fbMz2QV94v6vX5OBE/ksq8NgSQueBpEg4+kGO+vszS8By+pqgGcobAZzTUvZ1RshFqWx
         5pDRGIfNHIvUK6Q0PVuoBngYUde7IdRDcxAPodJHK4BVYY+xk/AtJWkqsH2pPBcEYmiy
         KWa/prKKzD3r/7D1tsoNqtEhRGnx03yVqKtjD5l+lJ8AtS+VAD1G54yODCCIZxQ6TOag
         hVRdyNkPd20IP9dMCYOiUF43oiHoOHljDwfiLwd61eZ4nJaXS5u99RCQMXav48qmzu77
         ehgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=4VZ1bNUM6I1iTWBeoIttDAJvcbhjpwKvmTA7bUXQA9g=;
        b=VqWXIRR03GS6gL1ZTjirzXI2fjxcvI1ksfbdD63BLW3Ta1brvMma2t8fw0edLCO6Iy
         EEPw/7us+BgE7ys10UhHIdy9S7m9vYfx7I5c+EVUkjaATgKOaTvpot4g3fFMq7ZA84L0
         Uzdv77lu/Rx1Agl3YmnAJKwpETa5o0LkUFSAerqHAK4AquJDybyfPn9kz0Tuk3eq+8Hs
         mCEPaMLHLd9A5sihK5muioKrxdwtI9x0Oea51EMBcQ9/H34uhGrFooIwrauFFmc/nSA3
         1yu172g+ySxD0+JsPY2R9OR3iV63XmhF+wp1BVmY9StBcUFZrpvNgx0kaXWmT5d89WMl
         yK2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vbabka@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=vbabka@suse.cz
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vbabka@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=vbabka@suse.cz
Subject: Re: [PATCH RFC 2/8] mm: introduce PG_offline
To: Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Michal Hocko <mhocko@suse.com>, Huang Ying <ying.huang@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Miles Chen <miles.chen@mediatek.com>,
 Mel Gorman <mgorman@techsingularity.net>, Rik van Riel <riel@redhat.com>,
 James Hogan <jhogan@kernel.org>,
 "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20180413131632.1413-1-david@redhat.com>
 <20180413131632.1413-3-david@redhat.com>
 <20180413171120.GA1245@bombadil.infradead.org>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <89329958-2ff8-9447-408e-fd478b914ec4@suse.cz>
Date: Sat, 21 Apr 2018 18:52:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413171120.GA1245@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597637040722220932?=
X-GMAIL-MSGID: =?utf-8?q?1598399486995985186?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/13/2018 07:11 PM, Matthew Wilcox wrote:
> On Fri, Apr 13, 2018 at 03:16:26PM +0200, David Hildenbrand wrote:
>> online_pages()/offline_pages() theoretically allows us to work on
>> sub-section sizes. This is especially relevant in the context of
>> virtualization. It e.g. allows us to add/remove memory to Linux in a VM in
>> 4MB chunks.
>>
>> While the whole section is marked as online/offline, we have to know
>> the state of each page. E.g. to not read memory that is not online
>> during kexec() or to properly mark a section as offline as soon as all
>> contained pages are offline.
> 
> Can you not use PG_reserved for this purpose?

Sounds like your newly introduced "page types" could be useful here? I
don't suppose those offline pages would be using mapcount which is
aliased there?

>> + * PG_offline indicates that a page is offline and the backing storage
>> + * might already have been removed (virtualization). Don't touch!
> 
>  * PG_reserved is set for special pages, which can never be swapped out. Some
>  * of them might not even exist...
> 
> They seem pretty congruent to me.
> 
