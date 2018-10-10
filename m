Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691D2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F312086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F312086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbeJKFvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 01:51:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44956 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKFvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 01:51:09 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4A4AFD7D;
        Wed, 10 Oct 2018 22:26:57 +0000 (UTC)
Date:   Wed, 10 Oct 2018 15:26:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/6] mm/gup_benchmark: Time put_page
Message-Id: <20181010152655.8510270e5db753f6666f12d3@linux-foundation.org>
In-Reply-To: <20181010195605.10689-1-keith.busch@intel.com>
References: <20181010195605.10689-1-keith.busch@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018 13:56:00 -0600 Keith Busch <keith.busch@intel.com> wrote:

> We'd like to measure time to unpin user pages, so this adds a second
> benchmark timer on put_page, separate from get_page.
> 
> Adding the field will breaks this ioctl ABI, but should be okay since
> this an in-tree kernel selftest.
> 
> ...
>
> --- a/mm/gup_benchmark.c
> +++ b/mm/gup_benchmark.c
> @@ -8,7 +8,8 @@
>  #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
>  
>  struct gup_benchmark {
> -	__u64 delta_usec;
> +	__u64 get_delta_usec;
> +	__u64 put_delta_usec;
>  	__u64 addr;
>  	__u64 size;
>  	__u32 nr_pages_per_call;

If we move put_delta_usec to the end of this struct, the ABI remains
back-compatible?


