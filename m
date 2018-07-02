Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D6DC6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDC62475B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDC62475B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbeGBBwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:52:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753025AbeGBBwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:52:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47B067C6A9;
        Mon,  2 Jul 2018 01:52:17 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B60EE111DCEE;
        Mon,  2 Jul 2018 01:52:15 +0000 (UTC)
Date:   Mon, 2 Jul 2018 09:52:11 +0800
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
Subject: Re: [PATCH v2 2/2] mm/sparse: start using sparse_init_nid(), and
 remove old code
Message-ID: <20180702015211.GK3223@MiWiFi-R3L-srv>
References: <20180630030944.9335-1-pasha.tatashin@oracle.com>
 <20180630030944.9335-3-pasha.tatashin@oracle.com>
 <20180702013918.GJ3223@MiWiFi-R3L-srv>
 <CAGM2reYRYNOe0nweMrSxLZ_RRQbu500iSRKWrbO4_CzyWTEtjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reYRYNOe0nweMrSxLZ_RRQbu500iSRKWrbO4_CzyWTEtjQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 02 Jul 2018 01:52:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 02 Jul 2018 01:52:17 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/18 at 09:46pm, Pavel Tatashin wrote:
>                          ~~~
> > Here, node id passed to sparse_init_nid() should be 'nid_begin', but not
> > 'nid'. When you found out the current section's 'nid' is diferent than
> > 'nid_begin', handle node 'nid_begin', then start to next node 'nid'.
> 
> Thank you for reviewing this work. Here nid equals to nid_begin:
> 
> See, "if" at 501, and this call is at 505.

Yes, if they are equal at 501, 'continue' to for loop. If nid is not
equal to nid_begin, we execute sparse_init_nid(), here should it be that
nid_begin is the current node, nid is next node?

> 
> 492 void __init sparse_init(void)
> 493 {
> 494         unsigned long pnum_begin = first_present_section_nr();
> 495         int nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
> 496         unsigned long pnum_end, map_count = 1;
> 497
> 498         for_each_present_section_nr(pnum_begin + 1, pnum_end) {
> 499                 int nid = sparse_early_nid(__nr_to_section(pnum_end));
> 500
> 501                 if (nid == nid_begin) {
> 502                         map_count++;
> 503                         continue;
> 504                 }
> 505                 sparse_init_nid(nid, pnum_begin, pnum_end, map_count);
> 506                 nid_begin = nid;
> 507                 pnum_begin = pnum_end;
> 508                 map_count = 1;
> 509         }
> 510         sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
> 511         vmemmap_populate_print_last();
> 512 }
> 
> Thank you,
> Pavel
