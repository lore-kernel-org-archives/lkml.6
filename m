Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F0BC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1E92075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1E92075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937081AbeFRXgd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:36:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38744 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935955AbeFRXgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:36:18 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9060ACF8;
        Mon, 18 Jun 2018 23:36:17 +0000 (UTC)
Date:   Mon, 18 Jun 2018 16:36:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Oscar Salvador <osalvador@techadventures.net>,
        Oscar Salvador <osalvador@suse.de>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v3] x86/e820: put !E820_TYPE_RAM regions into
 memblock.reserved
Message-Id: <20180618163616.52645949a8e4a0f73819fd62@linux-foundation.org>
In-Reply-To: <20180615140000.44tht4f3ek3lh2u2@xakep.localdomain>
References: <20180607100256.GA9129@hori1.linux.bs1.fc.nec.co.jp>
        <20180613054107.GA5329@hori1.linux.bs1.fc.nec.co.jp>
        <20180613090700.GG13364@dhcp22.suse.cz>
        <20180614051618.GB17860@hori1.linux.bs1.fc.nec.co.jp>
        <20180614053859.GA9863@techadventures.net>
        <20180614063454.GA32419@hori1.linux.bs1.fc.nec.co.jp>
        <20180614213033.GA19374@techadventures.net>
        <20180615010927.GC1196@hori1.linux.bs1.fc.nec.co.jp>
        <20180615072947.GB23273@hori1.linux.bs1.fc.nec.co.jp>
        <20180615084142.GE24039@dhcp22.suse.cz>
        <20180615140000.44tht4f3ek3lh2u2@xakep.localdomain>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018 10:00:00 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> > > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > > Tested-by: Oscar Salvador <osalvador@suse.de>
> > 
> > OK, this makes sense to me. It is definitely much better than the
> > original attempt.
> > 
> > Unless I am missing something this should be correct
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> First of all thank you Naoya for finding and root causing this issue.
> 
> So, with this fix we reserve any hole and !E820_TYPE_RAM or
> !E820_TYPE_RESERVED_KERN in e820.  I think, this will work because we
> do pfn_valid() check in zero_resv_unavail(), so the ranges that do not have
> backing struct pages will be skipped. But, I am worried on the performance
> implications of when the holes of invalid memory are rather large. We would
> have to loop through it in zero_resv_unavail() one pfn at a time.
> 
> Therefore, we might also need to optimize zero_resv_unavail() a little like
> this:
> 
> 6407			if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages)))
> 6408				continue;
> 
> Add before "continue":
> 	pfn = ALIGN_DOWN(pfn, pageblock_nr_pages) + pageblock_nr_pageas - 1.
> At least, this way, we would skip a section of invalid memory at a time.
> 
> For the patch above:
> Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> 
> But, I think the 2nd patch with the optimization above should go along this
> this fix.

So I expect this patch needs a cc:stable, which I'll add.

The optimiation patch seems less important and I'd like to hold that
off for 4.19-rc1?

