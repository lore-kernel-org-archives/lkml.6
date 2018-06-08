Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BdPyLfycGlu4RgAAmS7hNA
	; Fri, 08 Jun 2018 15:17:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7064D607E4; Fri,  8 Jun 2018 15:17:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E908160590;
	Fri,  8 Jun 2018 15:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E908160590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeFHPRy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:17:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751496AbeFHPRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:17:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53F6E859A2;
        Fri,  8 Jun 2018 15:17:52 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BD2E10EE6D6;
        Fri,  8 Jun 2018 15:17:51 +0000 (UTC)
Date: Fri, 8 Jun 2018 23:17:48 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pagupta@redhat.com, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v4 3/4] mm/sparse: Add a new parameter 'data_unit_size'
 for alloc_usemap_and_memmap
Message-ID: <20180608151748.GE16231@MiWiFi-R3L-srv>
References: <20180521101555.25610-1-bhe@redhat.com>
 <20180521101555.25610-4-bhe@redhat.com>
 <8ff7638c-d3ee-a40c-e5cf-deded8d19e93@intel.com>
 <20180608062733.GB16231@MiWiFi-R3L-srv>
 <74359df3-76a8-6dc7-51c5-27019130224f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74359df3-76a8-6dc7-51c5-27019130224f@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 08 Jun 2018 15:17:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 08 Jun 2018 15:17:52 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/18 at 07:20am, Dave Hansen wrote:
> On 06/07/2018 11:27 PM, Baoquan He wrote:
> > In alloc_usemap_and_memmap(), it will call
> > sparse_early_usemaps_alloc_node() or sparse_early_mem_maps_alloc_node()
> > to allocate usemap and memmap for each node and install them into
> > usemap_map[] and map_map[]. Here we need pass in the number of present
> > sections on this node so that we can move pointer of usemap_map[] and
> > map_map[] to right position.
> > 
> > How do think about above words?
> 
> But you're now passing in the size of the data structure.  Why is that
> needed all of a sudden?

Oh, it's the size of the data structure. Because
alloc_usemap_and_memmap() is reused for both usemap and memmap
allocation, then inside alloc_usemap_and_memmap(), we need move forward
the passed in pointer which points at the starting address of usemap_map
or memmap_map, to a new position which points at the next starting
address on new node.

You can see we passed the usemap_map, map_map, and the array element
size.  

void __init sparse_init(void)
{
	...
        alloc_usemap_and_memmap(sparse_early_usemaps_alloc_node,                                                                                  
                                (void *)usemap_map,
                                sizeof(usemap_map[0]));
	...
        alloc_usemap_and_memmap(sparse_early_mem_maps_alloc_node,
                                (void *)map_map,
                                sizeof(map_map[0]));
	...
}

Then inside alloc_usemap_and_memmap(), For each node, we get how many
present sections on this node, call hook alloc_func(). Then we update
the pointer to point at a new position of usemap_map[] or map_map[].

Here usemap_map[] is (unsigned long *), map_map[] is (struct page*).
Even though both of them are pointer, I think it might be not good to
assume that in alloc_usemap_and_memmap() because
alloc_usemap_and_memmap() doesn't know what is stored in its 2nd
parameter, namely (void * data). So add this new parameter to tell it.

Combine with patch 4/4, it might be easier to understand.

static void __init alloc_usemap_and_memmap(void (*alloc_func)
..
{
	...
	for_each_present_section_nr(pnum_begin + 1, pnum) {
                alloc_func(data, pnum_begin, pnum,                                                                                                
                                                map_count, nodeid_begin);
		...
		data += map_count * data_unit_size; 
		...
	}
	...
}
