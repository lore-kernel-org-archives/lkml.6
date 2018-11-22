Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7C3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFB220820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANkwKq3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFB220820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405282AbeKVVAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:00:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731554AbeKVVAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:00:46 -0500
Received: from localhost (unknown [95.99.132.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12CC620684;
        Thu, 22 Nov 2018 10:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542882118;
        bh=ZF1UiHbVfoauqPUc1Gtjs0M13r9ab07jaMuqyfiYK6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANkwKq3DJnZDQ7GrKTm/3K392CZF23y/wW0juWjd//ZV0xSnjt21rvK4Cw2I08513
         kgFK+QSNZCdN1G4TcyQyz5ic1Y3yKoFS/83uJy/fwDSPx87Nwp3+3lgOT7EOrNyZcp
         MP4LJCiGnw7B7xtzMKpwyG3VMib4/UtwHS3RXmag=
Date:   Thu, 22 Nov 2018 11:21:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 04/10] staging: erofs: fix
 `erofs_workgroup_{try_to_freeze, unfreeze}'
Message-ID: <20181122102155.GE3189@kroah.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-5-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120143425.43637-5-gaoxiang25@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:34:19PM +0800, Gao Xiang wrote:
> There are two minor issues in the current freeze interface:
> 
>    1) Freeze interfaces have not related with CONFIG_DEBUG_SPINLOCK,
>       therefore fix the incorrect conditions;
> 
>    2) For SMP platforms, it should also disable preemption before
>       doing atomic_cmpxchg in case that some high priority tasks
>       preempt between atomic_cmpxchg and disable_preempt, then spin
>       on the locked refcount later.

spinning on a refcount implies that you are trying to do your own type
of locking.  Why not use the in-kernel locking api instead?  It will
always do better than trying to do your own logic as the developers
there know locking across all types of cpus better than filesystem
developers :)

thanks,

greg k-h
