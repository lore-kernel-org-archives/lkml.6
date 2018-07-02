Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58364C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C35A2425A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C35A2425A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753046AbeGBTvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:51:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56716 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752639AbeGBTvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:51:51 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 300B0D6E;
        Mon,  2 Jul 2018 19:51:51 +0000 (UTC)
Date:   Mon, 2 Jul 2018 12:51:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, linux-mm@kvack.org, mgorman@techsingularity.net,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] mm: teach dump_page() to correctly output poisoned
 struct pages
Message-Id: <20180702125150.a7b69e852d9b7bd52f1f451d@linux-foundation.org>
In-Reply-To: <20180702180536.2552-1-pasha.tatashin@oracle.com>
References: <20180702180536.2552-1-pasha.tatashin@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Jul 2018 14:05:36 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> If struct page is poisoned, and uninitialized access is detected via
> PF_POISONED_CHECK(page) dump_page() is called to output the page. But,
> the dump_page() itself accesses struct page to determine how to print
> it, and therefore gets into a recursive loop.
> 
> For example:
> dump_page()
>  __dump_page()
>   PageSlab(page)
>    PF_POISONED_CHECK(page)
>     VM_BUG_ON_PGFLAGS(PagePoisoned(page), page)
>      dump_page() recursion loop.
> 
> Fixes: f165b378bbdf ("mm: uninitialized struct page poisoning sanity checking")
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.  I added a cc:stable to make sure this gets into 4.17.x.

