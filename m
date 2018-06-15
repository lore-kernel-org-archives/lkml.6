Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 47F1AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB859208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YCQjHxZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB859208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965975AbeFOQC5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:02:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36238 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965593AbeFOQC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:02:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5FFxwgE006452
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 16:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=wYQ66LD5VUuFPy3szLXDE6z0vGCUwqAaMx7o9Sz0jTI=;
 b=YCQjHxZnUG7wVLzIcEXce9B6IoIZ5iR7/Id2QBPXCjxWGqzHgZblUGJT1755SfUV0mRK
 YzS9HTAHnmqmPSkYcc2KNrW8LLQE5DmgBhtsET2meZSo6Fe5R80Z+e4kgH5jOeq4n++4
 eVG8mVM4ko5kHp7MOBezI6wjZMYZlbklj3SSY10mUcYblJVWPoE0KfAbhtG4CHk4t7rS
 YS2N8lgyN7YCbzFJfNhiO1lPy2KfTk3xrRdclsLMxYgdxJQsEGa7S3bDuiYzJe/LrC4W
 N7cIyNntefhNZsVB4Glqsr9x4ZBrFBZK5k7znWA3wuXErXc3rctsc9jOJKaILb+cHUCa AA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jk0xrskqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 16:02:55 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5FG2slF007623
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 16:02:54 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5FG2sXa029369
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 16:02:54 GMT
Received: from mail-ot0-f171.google.com (/74.125.82.171)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jun 2018 09:02:54 -0700
Received: by mail-ot0-f171.google.com with SMTP id w9-v6so11518018otj.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 09:02:54 -0700 (PDT)
X-Gm-Message-State: APt69E1VfCV/M28L4u37CQYV4PD/ZGPmWGatKhEb7sE6CyXwb2qYc6ae
        LKhXsY3g9ccT/AQ6AySj2We0Rs2ZiAVnWg4j1sE=
X-Google-Smtp-Source: ADUXVKINprqxXaV4gjHe8Shln9kOcG7kIFOGFoNLIFvPfbRMBf7bFByfsSfGEyJHLp1mBT49BfzbSvt8i4aISGDWrVM=
X-Received: by 2002:a9d:ef7:: with SMTP id 110-v6mr1249571otj.323.1529078573862;
 Fri, 15 Jun 2018 09:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180613054107.GA5329@hori1.linux.bs1.fc.nec.co.jp>
 <20180613090700.GG13364@dhcp22.suse.cz> <20180614051618.GB17860@hori1.linux.bs1.fc.nec.co.jp>
 <20180614053859.GA9863@techadventures.net> <20180614063454.GA32419@hori1.linux.bs1.fc.nec.co.jp>
 <20180614213033.GA19374@techadventures.net> <20180615010927.GC1196@hori1.linux.bs1.fc.nec.co.jp>
 <20180615072947.GB23273@hori1.linux.bs1.fc.nec.co.jp> <20180615084142.GE24039@dhcp22.suse.cz>
 <20180615140000.44tht4f3ek3lh2u2@xakep.localdomain> <20180615143308.GA26321@techadventures.net>
In-Reply-To: <20180615143308.GA26321@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 15 Jun 2018 12:02:17 -0400
X-Gmail-Original-Message-ID: <CAGM2reYA=jqL7KO6j9Tcjxyeb_=7aCfyekdO_aaRSZYv7_WeVg@mail.gmail.com>
Message-ID: <CAGM2reYA=jqL7KO6j9Tcjxyeb_=7aCfyekdO_aaRSZYv7_WeVg@mail.gmail.com>
Subject: Re: [PATCH v3] x86/e820: put !E820_TYPE_RAM regions into memblock.reserved
To:     osalvador@techadventures.net
Cc:     mhocko@kernel.org, n-horiguchi@ah.jp.nec.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        osalvador@suse.de, Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        willy@infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, mingo@kernel.org,
        dan.j.williams@intel.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8925 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=934
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Pavel,
>
> I think this makes a lot of sense.
> Since Naoya is out until Wednesday, maybe I give it a shot next week and see if I can gather some numbers.

Hi Oscar,

Thank you for the offer to do this. Since, sched_clock() is not yet
initialized at the time zero_resv_unavail() is called, it is difficult
to measure it during boot. But, I had x86 early boot timestamps
patches handy, so I could measure, thus decided to submit the patch.
http://lkml.kernel.org/r/20180615155733.1175-1-pasha.tatashin@oracle.com

Thank you,
Pavel

>
> >
> > Thank you,
> > Pasha
> >
> > >
> > > > ---
> > > >  arch/x86/kernel/e820.c | 15 ++++++++++++---
> > > >  1 file changed, 12 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > > > index d1f25c831447..c88c23c658c1 100644
> > > > --- a/arch/x86/kernel/e820.c
> > > > +++ b/arch/x86/kernel/e820.c
> > > > @@ -1248,6 +1248,7 @@ void __init e820__memblock_setup(void)
> > > >  {
> > > >   int i;
> > > >   u64 end;
> > > > + u64 addr = 0;
> > > >
> > > >   /*
> > > >    * The bootstrap memblock region count maximum is 128 entries
> > > > @@ -1264,13 +1265,21 @@ void __init e820__memblock_setup(void)
> > > >           struct e820_entry *entry = &e820_table->entries[i];
> > > >
> > > >           end = entry->addr + entry->size;
> > > > +         if (addr < entry->addr)
> > > > +                 memblock_reserve(addr, entry->addr - addr);
> > > > +         addr = end;
> > > >           if (end != (resource_size_t)end)
> > > >                   continue;
> > > >
> > > > +         /*
> > > > +          * all !E820_TYPE_RAM ranges (including gap ranges) are put
> > > > +          * into memblock.reserved to make sure that struct pages in
> > > > +          * such regions are not left uninitialized after bootup.
> > > > +          */
> > > >           if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
> > > > -                 continue;
> > > > -
> > > > -         memblock_add(entry->addr, entry->size);
> > > > +                 memblock_reserve(entry->addr, entry->size);
> > > > +         else
> > > > +                 memblock_add(entry->addr, entry->size);
> > > >   }
> > > >
> > > >   /* Throw away partial pages: */
> > > > --
> > > > 2.7.4
> > >
> > > --
> > > Michal Hocko
> > > SUSE Labs
> > >
> >
>
> Best Regards
> Oscar Salvador
>
