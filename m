Return-Path: <david@redhat.com>
X-Google-Smtp-Source: AIpwx4/BbxWa5WBGnE9OVtV+wckg71Da9i+VDtHO2rUYgG+O7DKKgRSXW2i8Dvr3gqjT+U9Ij2zG
ARC-Seal: i=1; a=rsa-sha256; t=1523965809; cv=none;
        d=google.com; s=arc-20160816;
        b=Q+vgmdpBMqzL55uUmyUML/kJazkFDXsb7XciRrSI9Z5wzd2KPJtFNBX8CSh9QteD0A
         pujrjikl5CmAJFKStKR7oL3JsIRscrFyF3duJmE3T0J2V4MYH0tEbtFvadG7cS/1gyyt
         mXSccj2vAs7F1WcuyB4Mzblh0RzpbPpj5/v3V5TKBSgt1OfXT7Ektf9w4uGD/+dhmetW
         g0aT4ilT1mZTL7xxgkaE3emZXp7glQvYfqMZQFeAfPVmg3E9v1DDGpxmk0muUyYbClvK
         fbLHxc+bezzOW+rYKu3PrJx8FkoKZFEnrRlRbiEI5Wb1fY6ewOqQlYdE27IVnz4MqzIX
         fXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=i6Ls7PfehVy/vJgTxP7SaiJPyZGvFKx/orOPCXa8kIs=;
        b=Ol5P8KTwbaJxvuRQrE8yL3VYulTIUfBkvM3drP0K3TMaHGNxMVJDL71eD2w7B9r39u
         An/92ixAp1mvqwFAa6W31VM8BJ1OlMt/17AXEtjPJ7LhwUfrAsfPcshIdOvfgPZEVw2V
         J4WT6YDs/52R7swMXJNOnTppnnFIYsc3MGdp+F19mLOMLQSC96Unk6rdXWAukuwsEEUO
         H2jCx50TKRTg2qcL5ZmgVbTsJb8qPOxQUqQZTkqtqZHF+ljT5yMQtn9NK0yDLHLXU/Et
         3DuHLIUpeXUgyrxWMB2qT7bfKFit9goJ8P8Vl8gjrAa384vGwqqW+pfxXzj5tEKkEMGv
         RNng==
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
Message-ID: <86717b44-7aad-19d9-b55f-7f9eb40bcaa1@redhat.com>
Date: Tue, 17 Apr 2018 13:50:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413134047.GR17484@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597637040722220932?=
X-GMAIL-MSGID: =?utf-8?q?1597993973146194369?=
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

BTW, looking at the possible layouts of page->flags, I don't think it
will be a problem adding this flag. Especially if we compile this flag
only if really needed.

We could glue this flag to CONFIG_MEMORY_HOTPLUG_SUBSECTION to something
like that, that will be set when our new driver is compiled. So this
would not affect anybody just wanting to use ordinary DIMM based hotplug
(CONFIG_MEMORY_HOTPLUG).

But I am open for other suggestions. I don't think PG_reserved is the
right thing to use. And storing for each section which parts are
online/offline is also something I would like to avoid.

-- 

Thanks,

David / dhildenb
