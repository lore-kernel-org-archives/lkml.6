Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4415FECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD405208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD405208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbeGLW5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:57:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45544 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733234AbeGLW5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:57:36 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DBF33D58;
        Thu, 12 Jul 2018 22:45:53 +0000 (UTC)
Date:   Thu, 12 Jul 2018 15:45:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        jack@suse.cz, jglisse@redhat.com, jrdr.linux@gmail.com,
        bhe@redhat.com, gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org,
        osalvador@techadventures.net, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH v5 1/5] mm/sparse: abstract sparse buffer allocations
Message-Id: <20180712154552.db99d1893bcba7f9503534a0@linux-foundation.org>
In-Reply-To: <20180712203730.8703-2-pasha.tatashin@oracle.com>
References: <20180712203730.8703-1-pasha.tatashin@oracle.com>
        <20180712203730.8703-2-pasha.tatashin@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 16:37:26 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> When struct pages are allocated for sparse-vmemmap VA layout, we first
> try to allocate one large buffer, and than if that fails allocate struct
> pages for each section as we go.
> 
> The code that allocates buffer is uses global variables and is spread
> across several call sites.
> 
> Cleanup the code by introducing three functions to handle the global
> buffer:
> 
> sparse_buffer_init()	initialize the buffer
> sparse_buffer_fini()	free the remaining part of the buffer
> sparse_buffer_alloc()	alloc from the buffer, and if buffer is empty
> return NULL
> 
> Define these functions in sparse.c instead of sparse-vmemmap.c because
> later we will use them for non-vmemmap sparse allocations as well.
> 
> ...
>
> +void * __meminit sparse_buffer_alloc(unsigned long size)
> +{
> +	void *ptr = NULL;
> +
> +	if (sparsemap_buf) {
> +		ptr = (void *)ALIGN((unsigned long)sparsemap_buf, size);
> +		if (ptr + size > sparsemap_buf_end)
> +			ptr = NULL;
> +		else
> +			sparsemap_buf = ptr + size;
> +	}
> +	return ptr;
> +}

tweak...

diff -puN mm/sparse.c~mm-sparse-abstract-sparse-buffer-allocations-fix mm/sparse.c
--- a/mm/sparse.c~mm-sparse-abstract-sparse-buffer-allocations-fix
+++ a/mm/sparse.c
@@ -491,7 +491,7 @@ void * __meminit sparse_buffer_alloc(uns
 	void *ptr = NULL;
 
 	if (sparsemap_buf) {
-		ptr = (void *)ALIGN((unsigned long)sparsemap_buf, size);
+		ptr = PTR_ALIGN(sparsemap_buf, size);
 		if (ptr + size > sparsemap_buf_end)
 			ptr = NULL;
 		else

