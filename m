Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FD3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0E4208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0E4208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeK0Hx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:53:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39512 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbeK0Hx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:53:57 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 70798723;
        Mon, 26 Nov 2018 20:58:34 +0000 (UTC)
Date:   Mon, 26 Nov 2018 12:58:33 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2 6/7] zram: add bd_stat statistics
Message-Id: <20181126125833.e95a21088ae60ccc6fd55022@linux-foundation.org>
In-Reply-To: <20181126082813.81977-7-minchan@kernel.org>
References: <20181126082813.81977-1-minchan@kernel.org>
        <20181126082813.81977-7-minchan@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 17:28:12 +0900 Minchan Kim <minchan@kernel.org> wrote:

> +File /sys/block/zram<id>/bd_stat
> +
> +The stat file represents device's backing device statistics. It consists of
> +a single line of text and contains the following stats separated by whitespace:
> + bd_count	size of data written in backing device.
> +		Unit: pages
> + bd_reads	the number of reads from backing device
> +		Unit: pages
> + bd_writes	the number of writes to backing device
> +		Unit: pages

Using `pages' is a bad choice.  And I assume this means that
writeback_limit is in pages as well, which is worse.

Page sizes are not constant!  We want userspace which was developed on
4k pagesize to work the same on 64k pagesize.

Arguably, we could require that well-written userspace remember to use
getpagesize().  However we have traditionally tried to avoid that by
performing the pagesize normalization within the kernel.


