Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ED2ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811A020864
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811A020864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbeGMUSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:18:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57342 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbeGMUSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:18:50 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A4DD0AF8;
        Fri, 13 Jul 2018 20:02:44 +0000 (UTC)
Date:   Fri, 13 Jul 2018 13:02:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Oscar Salvador <osalvador@techadventures.net>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        jack@suse.cz, jglisse@redhat.com, jrdr.linux@gmail.com,
        bhe@redhat.com, gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH v5 1/5] mm/sparse: abstract sparse buffer allocations
Message-Id: <20180713130243.13d02e94bedc8cc3caf275ca@linux-foundation.org>
In-Reply-To: <23f6e4e5-6e32-faf6-433d-67e50d2895a2@oracle.com>
References: <20180712203730.8703-1-pasha.tatashin@oracle.com>
        <20180712203730.8703-2-pasha.tatashin@oracle.com>
        <20180713131749.GA16765@techadventures.net>
        <23f6e4e5-6e32-faf6-433d-67e50d2895a2@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018 09:24:44 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> On 07/13/2018 09:17 AM, Oscar Salvador wrote:
> > On Thu, Jul 12, 2018 at 04:37:26PM -0400, Pavel Tatashin wrote:
> >> +static void *sparsemap_buf __meminitdata;
> >> +static void *sparsemap_buf_end __meminitdata;
> >> +
> >> +void __init sparse_buffer_init(unsigned long size, int nid)
> >> +{
> >> +	BUG_ON(sparsemap_buf);
> > 
> > Why do we need a BUG_ON() here?
> > Looking at the code I cannot really see how we can end up with sparsemap_buf being NULL.
> > Is it just for over-protection?
> 
> This checks that we do not accidentally leak memory by calling sparse_buffer_init() consequently without sparse_buffer_fini() in-between.

A memory leak isn't serious enough to justify crashing the kernel. 
Therefore

--- a/mm/sparse.c~mm-sparse-abstract-sparse-buffer-allocations-fix-fix
+++ a/mm/sparse.c
@@ -469,7 +469,7 @@ static void *sparsemap_buf_end __meminit
 
 void __init sparse_buffer_init(unsigned long size, int nid)
 {
-	BUG_ON(sparsemap_buf);
+	WARN_ON(sparsemap_buf);	/* forgot to call sparse_buffer_fini()? */
 	sparsemap_buf =
 		memblock_virt_alloc_try_nid_raw(size, PAGE_SIZE,
 						__pa(MAX_DMA_ADDRESS),
_

