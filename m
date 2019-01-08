Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0B9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58865205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbfAHTgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:36:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49910 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732434AbfAHTgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:36:05 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BFF6BA64;
        Tue,  8 Jan 2019 19:36:04 +0000 (UTC)
Date:   Tue, 8 Jan 2019 11:36:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        "David S . Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/vmalloc: Make vmalloc_32_user() align base
 kernel virtual address to SHMLBA
Message-Id: <20190108113603.ea664e55869346bcb30c1433@linux-foundation.org>
In-Reply-To: <20190108110944.23591-1-rpenyaev@suse.de>
References: <20190108110944.23591-1-rpenyaev@suse.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Jan 2019 12:09:44 +0100 Roman Penyaev <rpenyaev@suse.de> wrote:

> This patch repeats the original one from David S. Miller:
> 
>   2dca6999eed5 ("mm, perf_event: Make vmalloc_user() align base kernel virtual address to SHMLBA")
> 
> but for missed vmalloc_32_user() case, which also requires correct
> alignment of virtual address on kernel side to avoid D-caches
> aliases.  A bit of copy-paste from original patch to recover in
> memory of what is all about:
> 
>   When a vmalloc'd area is mmap'd into userspace, some kind of
>   co-ordination is necessary for this to work on platforms with cpu
>   D-caches which can have aliases.
> 
>   Otherwise kernel side writes won't be seen properly in userspace
>   and vice versa.
> 
>   If the kernel side mapping and the user side one have the same
>   alignment, modulo SHMLBA, this can work as long as VM_SHARED is
>   shared of VMA and for all current users this is true.  VM_SHARED
>   will force SHMLBA alignment of the user side mmap on platforms with
>   D-cache aliasing matters.

What are the user-visible runtime effects of this change?

Is a -stable backport needed?
