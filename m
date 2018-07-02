Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBE4C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3579E25846
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3579E25846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933039AbeGBDR1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 23:17:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752937AbeGBDR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 23:17:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6081381663D1;
        Mon,  2 Jul 2018 03:17:25 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0D672156880;
        Mon,  2 Jul 2018 03:17:24 +0000 (UTC)
Date:   Mon, 2 Jul 2018 11:17:21 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        gregkh@linuxfoundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, osalvador@techadventures.net
Subject: Re: [PATCH v3 1/2] mm/sparse: add sparse_init_nid()
Message-ID: <20180702031721.GQ3223@MiWiFi-R3L-srv>
References: <20180702020417.21281-1-pasha.tatashin@oracle.com>
 <20180702020417.21281-2-pasha.tatashin@oracle.com>
 <20180702021121.GL3223@MiWiFi-R3L-srv>
 <CAGM2rebY1_-3hvp_+kqF==nLawC0FN6Q1J5X5pm5qxHdDJzjiQ@mail.gmail.com>
 <20180702023130.GM3223@MiWiFi-R3L-srv>
 <CAGM2rebUsJ2r-2F38Vv13zbaEPPgTn0w6H3j6fpg0WVa9wB6Uw@mail.gmail.com>
 <20180702025343.GN3223@MiWiFi-R3L-srv>
 <CAGM2reatQzroymAb8kaPKgd8sEehtScH9DAELeWpYCaNNnAU6w@mail.gmail.com>
 <20180702031417.GP3223@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702031417.GP3223@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 02 Jul 2018 03:17:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 02 Jul 2018 03:17:25 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 at 11:14am, Baoquan He wrote:
> On 07/01/18 at 11:03pm, Pavel Tatashin wrote:
> > > Ah, yes, I misunderstood it, sorry for that.
> > >
> > > Then I have only one concern, for vmemmap case, if one section doesn't
> > > succeed to populate its memmap, do we need to skip all the remaining
> > > sections in that node?
> > 
> > Yes, in sparse_populate_node() we have the following:
> > 
> > 294         for (pnum = pnum_begin; map_index < map_count; pnum++) {
> > 295                 if (!present_section_nr(pnum))
> > 296                         continue;
> > 297                 if (!sparse_mem_map_populate(pnum, nid, NULL))
> > 298                         break;
> > 
> > So, on the first failure, we even stop trying to populate other
> > sections. No more memory to do so.
> 
> This is the thing I worry about. In old sparse_mem_maps_populate_node()
> you can see, when not present or failed to populate, just continue. This
> is the main difference between yours and the old code. The key logic is
> changed here.
> 
Forgot mentioning it's the vervion in mm/sparse-vmemmap.c

> void __init sparse_mem_maps_populate_node(struct page **map_map,
>                                           unsigned long pnum_begin,
>                                           unsigned long pnum_end,
>                                           unsigned long map_count, int nodeid)
> {
> 	...
> 	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
>                 struct mem_section *ms;
> 
>                 if (!present_section_nr(pnum))
>                         continue;
> 
>                 map_map[pnum] = sparse_mem_map_populate(pnum, nodeid, NULL);
>                 if (map_map[pnum])                                                                                                                
>                         continue;
>                 ms = __nr_to_section(pnum);
>                 pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
>                        __func__);
>                 ms->section_mem_map = 0;
>         }
> 	...
> }
> 
