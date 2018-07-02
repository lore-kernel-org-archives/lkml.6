Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6803BC6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2098024DD5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2098024DD5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932747AbeGBCxt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 22:53:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753047AbeGBCxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 22:53:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9421776F91;
        Mon,  2 Jul 2018 02:53:47 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 92830111DCEA;
        Mon,  2 Jul 2018 02:53:46 +0000 (UTC)
Date:   Mon, 2 Jul 2018 10:53:43 +0800
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
Message-ID: <20180702025343.GN3223@MiWiFi-R3L-srv>
References: <20180702020417.21281-1-pasha.tatashin@oracle.com>
 <20180702020417.21281-2-pasha.tatashin@oracle.com>
 <20180702021121.GL3223@MiWiFi-R3L-srv>
 <CAGM2rebY1_-3hvp_+kqF==nLawC0FN6Q1J5X5pm5qxHdDJzjiQ@mail.gmail.com>
 <20180702023130.GM3223@MiWiFi-R3L-srv>
 <CAGM2rebUsJ2r-2F38Vv13zbaEPPgTn0w6H3j6fpg0WVa9wB6Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2rebUsJ2r-2F38Vv13zbaEPPgTn0w6H3j6fpg0WVa9wB6Uw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 02 Jul 2018 02:53:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 02 Jul 2018 02:53:47 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/18 at 10:43pm, Pavel Tatashin wrote:
> On Sun, Jul 1, 2018 at 10:31 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 07/01/18 at 10:18pm, Pavel Tatashin wrote:
> > > > Here, I think it might be not right to jump to 'failed' directly if one
> > > > section of the node failed to populate memmap. I think the original code
> > > > is only skipping the section which memmap failed to populate by marking
> > > > it as not present with "ms->section_mem_map = 0".
> > > >
> > >
> > > Hi Baoquan,
> > >
> > > Thank you for a careful review. This is an intended change compared to
> > > the original code. Because we operate per-node now, if we fail to
> > > allocate a single section, in this node, it means we also will fail to
> > > allocate all the consequent sections in the same node and no need to
> > > check them anymore. In the original code we could not simply bailout,
> > > because we still might have valid entries in the following nodes.
> > > Similarly, sparse_init() will call sparse_init_nid() for the next node
> > > even if previous node failed to setup all the memory.
> >
> > Hmm, say the node we are handling is node5, and there are 100 sections.
> > If you allocate memmap for section at one time, you have succeeded to
> > handle for the first 99 sections, now the 100th failed, so you will mark
> > all sections on node5 as not present. And the allocation failure is only
> > for single section memmap allocation case.
> 
> No, unless I am missing something, that's not how code works:
> 
> 463                 if (!map) {
> 464                         pr_err("%s: memory map backing failed.
> Some memory will not be available.",
> 465                                __func__);
> 466                         pnum_begin = pnum;
> 467                         goto failed;
> 468                 }
> 
> 476 failed:
> 477         /* We failed to allocate, mark all the following pnums as
> not present */
> 478         for_each_present_section_nr(pnum_begin, pnum) {
> 
> We continue from the pnum that failed as we set pnum_begin to pnum,
> and mark all the consequent sections as not-present.

Ah, yes, I misunderstood it, sorry for that.

Then I have only one concern, for vmemmap case, if one section doesn't
succeed to populate its memmap, do we need to skip all the remaining
sections in that node?

> 
> The only change compared to the original code is that once we found an
> empty pnum we stop checking the consequent pnums in this node, as we
> know they are empty as well, because there is no more memory in this
> node to allocate from.
> 
