Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x226se2mXOyyYRKxb1bz5lUczUYLvCNNygrb+umhaOrt5Opw+wAKGvFjiE7oFzvnrll+jSo0f
ARC-Seal: i=1; a=rsa-sha256; t=1518702396; cv=none;
        d=google.com; s=arc-20160816;
        b=sGqzTvMwMhDoAhnxwpAYwmdmmkx3dCADl+Ziizz1raCvkgtzUpgcKfxIeBqB49C5aT
         LO0c9p23KX+xqJP/0+/aPqdF9CAvXTBk1d5iMHbqtiG4XCmCzVtnTPjd6p6zy9jSFZOW
         922cnl/8NoPbTSicRI2AtiTSAIhVZlGn6gM+WuGBdslJtB80rXL6UFVBYMGNEoVJWfKm
         laiF52/IVcmtFQN6CRkqZbzKhUZssPCVrcwY3AWVfVIoKpYogGdRXGAZtlHm+sgJ2kV1
         Jl7wEjVkYN2EcPrwW1Xcb4ZSWRkyuhpfFvRB7jEQVn4DQnYyI0a4pUtVKY06CxSgLkIK
         GyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=yGFA18Qni6Km5+wEwJN8IUoAYDxCZwRuWQ24Z8vphwo=;
        b=W3otOn9OWlNsY2onUyV5I86WA/lPiZdYqoIEl6YBn33J4s3ZwqGnut7rmxj32oalUk
         4+6XQ9ODS/mBaeljJV6VafPMd1EQndZiBPmMEM0kIucOZeBMrdnJTXCwzBkrltbcZGtQ
         h5f0aXUWqBqGtpGiS6BFnlOhJnuMAK1YM7vz01FESortz33Qlgcmv+x7YdgTskZOLTlW
         U3KByODSDHjvudqiTzFS78aZ52CKZOQUU6Ry+pSsys6bqcKWdHX8BpmtMn2mCDsBOPnM
         psFm3mthKCc4ywszP/iLXJ+jp1lKb8yeQa0t2DjA/vSmz+cB4zrrTb9BN3SLFELsSp0l
         vbYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=tgmlUToZ;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=tgmlUToZ;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
MIME-Version: 1.0
In-Reply-To: <20180215124320.GE7275@dhcp22.suse.cz>
References: <20180213193159.14606-1-pasha.tatashin@oracle.com>
 <20180213193159.14606-5-pasha.tatashin@oracle.com> <20180215124320.GE7275@dhcp22.suse.cz>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 15 Feb 2018 08:46:33 -0500
X-Gmail-Original-Message-ID: <CAOAebxsf21pKsHoJQ7+5mWnfj=TA_Nd2h=YvuEfj=SmpFfvjxQ@mail.gmail.com>
Message-ID: <CAOAebxsf21pKsHoJQ7+5mWnfj=TA_Nd2h=YvuEfj=SmpFfvjxQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm/memory_hotplug: optimize memory hotplug
To: Michal Hocko <mhocko@kernel.org>
Cc: Steve Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dan.j.williams@intel.com,
        kirill.shutemov@linux.intel.com, bhe@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8805 signatures=668671
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=776
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150171
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446931456044?=
X-GMAIL-MSGID: =?utf-8?q?1592474884159601942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> This should be a separate patch IMHO. It is an optimization on its
> own. The original code tries to be sparse neutral but we do depend on
> sparse anyway.

Yes, Mingo already asked me to split this patch. I've done just that
and will send it out soon.

>
> [...]
>>  /* register memory section under specified node if it spans that node */
>> -int register_mem_sect_under_node(struct memory_block *mem_blk, int nid)
>> +int register_mem_sect_under_node(struct memory_block *mem_blk, int nid,
>> +                              bool check_nid)
>
> This check_nid begs for a documentation. When do we need to set it? I
> can see that register_new_memory path doesn't check node id. It is quite
> reasonable to expect that a new memblock doesn't span multiple numa
> nodes which can be the case for register_one_node but a word or two are
> really due.

OK, I will add a comment, and BTW, this is also going to be a separate
patch for ease of review.

>
>>  {
>>       int ret;
>>       unsigned long pfn, sect_start_pfn, sect_end_pfn;
>> @@ -423,11 +424,13 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, int nid)
>>                       continue;
>>               }
>>
>> -             page_nid = get_nid_for_pfn(pfn);
>> -             if (page_nid < 0)
>> -                     continue;
>> -             if (page_nid != nid)
>> -                     continue;
>> +             if (check_nid) {
>> +                     page_nid = get_nid_for_pfn(pfn);
>> +                     if (page_nid < 0)
>> +                             continue;
>> +                     if (page_nid != nid)
>> +                             continue;
>> +             }
>>               ret = sysfs_create_link_nowarn(&node_devices[nid]->dev.kobj,
>>                                       &mem_blk->dev.kobj,
>>                                       kobject_name(&mem_blk->dev.kobj));
>> @@ -502,7 +505,7 @@ int link_mem_sections(int nid, unsigned long start_pfn, unsigned long nr_pages)
>>
>>               mem_blk = find_memory_block_hinted(mem_sect, mem_blk);
>>
>> -             ret = register_mem_sect_under_node(mem_blk, nid);
>> +             ret = register_mem_sect_under_node(mem_blk, nid, true);
>>               if (!err)
>>                       err = ret;
>>
>
> I would be tempted to split this into a separate patch as well. The
> review will be much easier.

Yes, but that would be the last patch in the series.

> This is quite ugly. You allocate 256MB for small numa systems and 512MB
> for larger NUMAs unconditionally for MEMORY_HOTPLUG. I see you need it
> to safely replace page_to_nid by get_section_nid but this is just too
> high of the price. Please note that this shouldn't be really needed. At
> least not for onlining. We already _do_ know the node association with
> the pfn range. So we should be able to get the nid from memblock.

OK, I will think for a different place to store nid temporarily, or
how to get it.

Thank you,
Pavel
