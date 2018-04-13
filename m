Return-Path: <david@redhat.com>
X-Google-Smtp-Source: AIpwx48tw8hhFTIUvTdfkmqQB9OjQwXwoY7pMXbntnGzFe1gg+rR4oTZl+Bj8pL4oh99gSNxPEJD
ARC-Seal: i=1; a=rsa-sha256; t=1523637163; cv=none;
        d=google.com; s=arc-20160816;
        b=y9VjVwSamwe60GVbf6TRkCjh4alvoHhQvH20gQMogzzh0a4WRAlgg0HqiVxno+tjT/
         3tfC2XCOevLjdC5MBQvDNrN83Is9KJJET1zNRV6kc4FMd6zFpY2FKPRCcurQnVaK6gA1
         V1c52hR6EqcCrHzw1wRmG1JPTphXJR7DY3ZOrEr6Z62Bmx4groxXis5bh96KNSrXxa4l
         DIK9IpH7UrWBBHBcL0k5c5e+h9JEKcIMAOIQwbAjq91xXR1ouoFXF5qr/AOPkzkYkSpF
         TBlAe/oEEknjqEsqUgK+LjSj36xtqWVc3kQH6JZ9XQieMitUXnQaUAEVDUme4hNTe0Ne
         1nTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=TNWuwXf+Bjbg6htCpR1835jJL3xxi4YTg8J4cZezuWw=;
        b=zK/H9k93BGdU8XJVNHjNldmzK5UC1JMUPE2N4cPrRFIa6GlI0WXC1zCViFhpDUF91u
         lzWLKQZOkMb35FnK+CBMWj1kTS8lByKKKEvFrpjHeq7jgrjUaTLanIhhTLEcwqrVGbS6
         /Rf6A7pkE/yzU8Si+maZyxo/06nA5Mpdd9x1YIt1YtITN7BsmJJBkIorxiVdBlx5lBhU
         6vgfaphQiL/7dgIqJHK/p+Epgi6WFj9x1cIxZ/Gor9rKPL1gDdqtGnnndeTtgRYlYH5m
         UklrfRsqKbvLqxQw2BDTfNs+0RwuVcYh66Kai0KbLmRQu4H28fGm97WPW2XU7XCztGoC
         7nNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH RFC 7/8] mm: allow to control onlining/offlining of memory
 by a driver
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross
 <jgross@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>, Ingo Molnar <mingo@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Reza Arbab <arbab@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
References: <20180413131632.1413-1-david@redhat.com>
 <20180413133334.3612-1-david@redhat.com>
 <20180413155943.GY17484@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <92ff9057-7f1e-d9b7-610e-0a7022b8da01@redhat.com>
Date: Fri, 13 Apr 2018 18:32:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413155943.GY17484@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597638095318503698?=
X-GMAIL-MSGID: =?utf-8?q?1597649362155053308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13.04.2018 17:59, Michal Hocko wrote:
> On Fri 13-04-18 15:33:28, David Hildenbrand wrote:
>> Some devices (esp. paravirtualized) might want to control
>> - when to online/offline a memory block
>> - how to online memory (MOVABLE/NORMAL)
>> - in which granularity to online/offline memory
>>
>> So let's add a new flag "driver_managed" and disallow to change the
>> state by user space. Device onlining/offlining will still work, however
>> the memory will not be actually onlined/offlined. That has to be handled
>> by the device driver that owns the memory.
> 
> Is there any reason to create the memblock sysfs interface to this
> memory at all? ZONE_DEVICE mem hotplug users currently do not do that
> and manage the memory themselves. It seems you want to achieve the same
> thing, no?
> 

Yes, I think so, namely kdump. We have to retrigger kexec() whenever a
memory block is added/removed. udev events are sent for that reason when
a memory block is created/deleted. And I think this is not done for
ZONE_DEVICE devices, or am I wrong?

-- 

Thanks,

David / dhildenb
