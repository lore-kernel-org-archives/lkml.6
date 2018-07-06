Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA81C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A3F22B59
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A3F22B59
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbeGFVc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:32:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50590 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753672AbeGFVc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:32:27 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 95888BC6;
        Fri,  6 Jul 2018 21:32:26 +0000 (UTC)
Date:   Fri, 6 Jul 2018 14:32:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ross Zwisler <ross.zwisler@linux.intel.com>
Cc:     pasha.tatashin@oracle.com, linux-nvdimm@lists.01.org,
        osalvador@techadventures.net, bhe@redhat.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        osalvador@suse.de
Subject: Re: [PATCH] mm/sparse.c: fix error path in sparse_add_one_section
Message-Id: <20180706143225.1cf9569f240dccf91bdc3788@linux-foundation.org>
In-Reply-To: <20180706190658.6873-1-ross.zwisler@linux.intel.com>
References: <CAOxpaSVkLh23jN_=0GpZ77EhKdAYaiWKkppnxWwf_MRa5FvopA@mail.gmail.com>
        <20180706190658.6873-1-ross.zwisler@linux.intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Jul 2018 13:06:58 -0600 Ross Zwisler <ross.zwisler@linux.intel.com> wrote:

> commit 054620849110 ("mm/sparse.c: make sparse_init_one_section void and
> remove check")
> 
> changed how the error handling in sparse_add_one_section() works.
> 
> Previously sparse_index_init() could return -EEXIST, and the function would
> continue on happily.  'ret' would get unconditionally overwritten by the
> result from sparse_init_one_section() and the error code after the 'out:'
> label wouldn't be triggered.
> 
> With the above referenced commit, though, an -EEXIST error return from
> sparse_index_init() now takes us through the function and into the error
> case after 'out:'.  This eventually causes a kernel BUG, probably because
> we've just freed a memory section that we successfully set up and marked as
> present:

Thanks.

And gee it would be nice if some of this code was commented.  I
*assume* what's happening with that -EEXIST is that
sparse_add_one_section() is discovering that the root mem_section was
already initialized so things are OK.  Maybe.  My mind-reading skills
aren't so good on Fridays.

And sparse_index_init() sure looks like it needs locking to avoid races
around mem_section[root].  Or perhaps we're known to be single-threaded
here.
