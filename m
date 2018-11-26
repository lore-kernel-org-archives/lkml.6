Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA23C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1BD205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1BD205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeK0HuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:50:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37826 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbeK0HuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:50:09 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 49014B0A;
        Mon, 26 Nov 2018 20:54:47 +0000 (UTC)
Date:   Mon, 26 Nov 2018 12:54:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2 7/7] zram: writeback throttle
Message-Id: <20181126125446.562aca37cc7c0dd8456c3a25@linux-foundation.org>
In-Reply-To: <20181126082813.81977-8-minchan@kernel.org>
References: <20181126082813.81977-1-minchan@kernel.org>
        <20181126082813.81977-8-minchan@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 17:28:13 +0900 Minchan Kim <minchan@kernel.org> wrote:

> On small memory system, there are lots of write IO so if we use
> flash device as swap, there would be serious flash wearout.
> To overcome the problem, system developers need to design write
> limitation strategy to guarantee flash health for entire product life.
> 
> This patch creates a new konb "writeback_limit" on zram. With that,
> if current writeback IO count(/sys/block/zramX/io_stat) excceds
> the limitation, zram stops further writeback until admin can reset
> the limit.
> 
> +++ b/Documentation/ABI/testing/sysfs-block-zram
> @@ -121,3 +121,12 @@ Contact:	Minchan Kim <minchan@kernel.org>
>  		The bd_stat file is read-only and represents backing device's
>  		statistics (bd_count, bd_reads, bd_writes) in a format
>  		similar to block layer statistics file format.
> +
> +What:		/sys/block/zram<id>/writeback_limit
> +Date:		November 2018
> +Contact:	Minchan Kim <minchan@kernel.org>
> +Description:
> +		The writeback_limit file is read-write and specifies the maximum
> +		amount of writeback ZRAM can do. The limit could be changed
> +		in run time and "0" means disable the limit.
> +		No limit is the initial state.
> diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.txt
> index 550bca77d322..41748d52712d 100644
> --- a/Documentation/blockdev/zram.txt
> +++ b/Documentation/blockdev/zram.txt
> @@ -164,6 +164,8 @@ reset             WO    trigger device reset
>  mem_used_max      WO    reset the `mem_used_max' counter (see later)
>  mem_limit         WO    specifies the maximum amount of memory ZRAM can use
>                          to store the compressed data
> +writeback_limit	  WO	specifies the maximum amount of write IO zram can
> +			write out to backing device

Neither the changelog nor the Documentation specify the units of
writeback_limit.  Bytes?  Pages?  Blocks?

This gets so confusing that in many /proc/sys/vm files we actually put
the units into the filenames.

