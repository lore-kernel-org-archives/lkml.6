Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D82C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FFA2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfA2Wwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:52:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:58236 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfA2Wwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:52:55 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8B9F834A2;
        Tue, 29 Jan 2019 22:52:54 +0000 (UTC)
Date:   Tue, 29 Jan 2019 14:52:53 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrea Arcangeli <aarcange@redhat.com>, mpe@ellerman.id.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V7 1/4] mm/cma: Add PF flag to force non cma alloc
Message-Id: <20190129145253.8ac345bf7ca6e66cf08bd985@linux-foundation.org>
In-Reply-To: <20190114095438.32470-2-aneesh.kumar@linux.ibm.com>
References: <20190114095438.32470-1-aneesh.kumar@linux.ibm.com>
        <20190114095438.32470-2-aneesh.kumar@linux.ibm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 15:24:33 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> This patch adds PF_MEMALLOC_NOCMA which make sure any allocation in that context
> is marked non-movable and hence cannot be satisfied by CMA region.
> 
> This is useful with get_user_pages_longterm where we want to take a page pin by
> migrating pages from CMA region. Marking the section PF_MEMALLOC_NOCMA ensures
> that we avoid unnecessary page migration later.
> 
> ...
>
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1406,6 +1406,7 @@ extern struct pid *cad_pid;
>  #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
>  #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
>  #define PF_MEMSTALL		0x01000000	/* Stalled due to lack of memory */
> +#define PF_MEMALLOC_NOCMA	0x02000000	/* All allocation request will have _GFP_MOVABLE cleared */
>  #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_allowed */
>  #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
>  #define PF_MUTEX_TESTER		0x20000000	/* Thread belongs to the rt mutex tester */

This flag has been taken by PF_UMH so I moved it to 0x10000000.

And we have now run out of PF_ flags.
