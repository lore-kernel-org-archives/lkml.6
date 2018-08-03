Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C692DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772C52178F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772C52178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbeHDB0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 21:26:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47516 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732033AbeHDB0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 21:26:42 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 30302CD0;
        Fri,  3 Aug 2018 23:28:19 +0000 (UTC)
Date:   Fri, 3 Aug 2018 16:28:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tino Lehnig <tino.lehnig@contabo.de>, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] zram: remove BD_CAP_SYNCHRONOUS_IO with writeback
 feature
Message-Id: <20180803162818.8c4719232d6dfece21ebea30@linux-foundation.org>
In-Reply-To: <20180803025143.GA86818@rodete-desktop-imager.corp.google.com>
References: <20180802051112.86174-1-minchan@kernel.org>
        <20180802141304.d0589ddc5f8213429ab3b565@linux-foundation.org>
        <20180803025143.GA86818@rodete-desktop-imager.corp.google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2018 11:51:43 +0900 Minchan Kim <minchan@kernel.org> wrote:

> > Is it legitimate to be altering the bdi capabilities at this level?  Or
> > is this hacky?
> 
> Most of device's bdi capability seems to be static but there are few drivers
> which can change capability. For example, BDI_CAP_STABLE_WRITES
> 
> drivers/scsi/iscsi_tcp.c
> drivers/md/raid5.c
> 
> I believe it's driver itself advertisement stuff so I hope it's not hack.

The bdi is per-disk (per-queue).  So if zram changes the bdi for a
particular partition then it is accidentally mucking with the other
partitions as well, and it shouldn't do that.  At least, I think that's
how it works - it's been a while.  Jens, wake up ;)
