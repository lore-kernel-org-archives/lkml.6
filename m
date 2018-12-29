Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF621C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CF920866
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbeL2Ams (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 19:42:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40090 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeL2Ams (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 19:42:48 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 79E1F8B1;
        Sat, 29 Dec 2018 00:42:47 +0000 (UTC)
Date:   Fri, 28 Dec 2018 16:42:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ying.huang@intel.com, tim.c.chen@intel.com, minchan@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 1/2] mm: swap: check if swap backing device is
 congested or not
Message-Id: <20181228164246.4867201125a2123c8f6a6f9c@linux-foundation.org>
In-Reply-To: <1545428420-126557-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1545428420-126557-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2018 05:40:19 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> Swap readahead would read in a few pages regardless if the underlying
> device is busy or not.  It may incur long waiting time if the device is
> congested, and it may also exacerbate the congestion.
> 
> Use inode_read_congested() to check if the underlying device is busy or
> not like what file page readahead does.  Get inode from swap_info_struct.
> Although we can add inode information in swap_address_space
> (address_space->host), it may lead some unexpected side effect, i.e.
> it may break mapping_cap_account_dirty().  Using inode from
> swap_info_struct seems simple and good enough.
> 
> Just does the check in vma_cluster_readahead() since
> swap_vma_readahead() is just used for non-rotational device which
> much less likely has congestion than traditional HDD.
> 
> Although swap slots may be consecutive on swap partition, it still may be
> fragmented on swap file. This check would help to reduce excessive stall
> for such case.

Some words about the observed effects of the patch would be more than
appropriate!

