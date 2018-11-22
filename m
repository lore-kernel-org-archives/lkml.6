Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDD2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD02F20870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wc7zpghU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD02F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405477AbeKVVpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:45:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388478AbeKVVpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:45:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DC3620820;
        Thu, 22 Nov 2018 11:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542884806;
        bh=SMIg++zaY+IyXYtdl6FokJtICJoz0vXF9/f3pAGgnJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wc7zpghU0yLT+PrLvaxlNHLXOvBQ/cI2wSIrZNnAt3pMoexypCdkyS4CXp1uzhB4d
         5Rz7bxWg16b9tJws9jESTsCDHBbe7169ejE6OZVFd9gb2acb7KPRxx8ZaMxo2LtRPI
         6xW2AX5/+R5zFZbKp2H22T9AWBJIuB9HBs2EB6Ek=
Date:   Thu, 22 Nov 2018 12:06:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 02/10] staging: erofs: fix race when the managed cache is
 enabled
Message-ID: <20181122110642.GE5287@kroah.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-3-gaoxiang25@huawei.com>
 <20181122101711.GA3189@kroah.com>
 <55aed87f-196e-9048-6aae-db09bc497664@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55aed87f-196e-9048-6aae-db09bc497664@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 06:42:52PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2018/11/22 18:17, Greg Kroah-Hartman wrote:
> > Any specific reason why you are not using the refcount.h api instead of
> > "doing it yourself" with atomic_inc/dec()?
> > 
> > I'm not rejecting this, just curious.
> 
> As I explained in the previous email,
> Re: [PATCH 04/10] staging: erofs: fix `erofs_workgroup_{try_to_freeze, unfreeze}'
> 
> we need such a function when the value is >= 0, it plays as a refcount,
> but when the refcount == EROFS_LOCKED_MAGIC (<0, but not 0 as refcount.h),
> and actually there is no need to introduce a seperate spinlock_t because
> we don't actually care about its performance (rarely locked). and
> the corresponding struct is too large for now, we need to decrease its size.

Why do you need to decrease the size?  How many of these structures are
created?

And you will care about the performance when a lock is being held, as is
evident by your logic to try to fix those issues in this patch series.
Using a "real" lock will solve all of that and keep you from having to
implement it all "by hand".

thanks,

greg k-h
