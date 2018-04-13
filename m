Return-Path: <david@redhat.com>
X-Google-Smtp-Source: AIpwx48WWUJE3qbxEk993/ISWisgE4JgreSUMf+ISJag3Q3AQUd61zdMkIsvfE/nBhr64LVt224E
ARC-Seal: i=1; a=rsa-sha256; t=1523627184; cv=none;
        d=google.com; s=arc-20160816;
        b=JFoA15AYYyIELl7vu5DAcVH+oeNQZ6Sd/8aM2P1V5e5YkpLA7LcOKpSL7Kka1O+7Ot
         bML59F1MAWClPAtvIU2g1URBxkJbv/LBYRbXhlIJ9Bq/d1lAsdAxthqXHnND3h6O/3p8
         zuIdUplhbIEmChG72uR0yGic5NfkuJd9yx97CJqg7DbNQKProf/03u2cX/3A/43LETA5
         BMU9DlAdRg18r3zdK639Fy4mjwGoEpRko3mPnom68iwaK9iJhGL3/1Bp/fIRlRGq8HRS
         RQxSYL48VNdq/eeM/rhw3NVwFeq351G/Izg0cDIB6u/aF9HB6keU1WLRLp9egEStPbH4
         kcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=Tbil2r5wYr+SJ9hV7qaMT4TQ7kBsw6cvffCqNqnOfho=;
        b=bxAYmB10WvVuspAFPT45ALzJAbPuWbUv4BCeTa+LwpiaR0A1DkajXOBgH731hDrZm2
         11U4Dt7C2EhOUYy/xiB1Th7FOO8+tpdbeeiiZM51m2Id1xOGa8EW1BLul+bi0M9UVzEp
         YTyTLQTzAYEu1cmj0awDODpQBYrd5HK963qiBkW7ZcluZdX4FehAw0eb8856mgJUhWS1
         zA5siY2cK0saju0MfMYVtdygjNYClbE6/sMvFHxj/2u5BsAxE+UqB5V5sFhHAC395iBZ
         oKkBsAowEi+GPXcrtTg5jZqmGnsYH5jfmhIKPQRv1KgYV7nub75RCuRkOSnonLNXhTIP
         8sqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH RFC 2/8] mm: introduce PG_offline
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
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
 <20180413134047.GR17484@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <28ab2758-b514-fce1-0697-2df09f396972@redhat.com>
Date: Fri, 13 Apr 2018 15:46:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413134047.GR17484@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597637040722220932?=
X-GMAIL-MSGID: =?utf-8?q?1597638898231408432?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13.04.2018 15:40, Michal Hocko wrote:
> On Fri 13-04-18 15:16:26, David Hildenbrand wrote:
>> online_pages()/offline_pages() theoretically allows us to work on
>> sub-section sizes. This is especially relevant in the context of
>> virtualization. It e.g. allows us to add/remove memory to Linux in a VM in
>> 4MB chunks.
> 
> Well, theoretically possible but this would require a lot of auditing
> because the hotplug and per section assumption is quite a spread one.

Indeed. But besides changing section sizes / size of memory blocks this
seems to be the only way to do it. (btw, I think Windows allows to add
1MB chunks - e.g. 1MB DIMMs)

But as these pages "belong to nobody" nobody (besides kdump) should dare
to access the content, although the section is online.

> 
>> While the whole section is marked as online/offline, we have to know
>> the state of each page. E.g. to not read memory that is not online
>> during kexec() or to properly mark a section as offline as soon as all
>> contained pages are offline.
> 
> But you cannot use a page flag for that, I am afraid. Page flags are
> extremely scarce resource. I haven't looked at the rest of the series
> but _if_ we have a bit spare which I am not really sure about then you
> should prove there are no other ways around this.

Open for suggestions. We could remember per segment/memory block which
parts are online/offline and use that to decide if a section can go offline.

However: kdump will also have to (easily) know which pages are offline,
so it can skip reading them. (see the other patch)

>  
>> Signed-off-by: David Hildenbrand <david@redhat.com>


-- 

Thanks,

David / dhildenb
