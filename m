Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED23EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEBF20866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zP3HATwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEBF20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394512AbeKVVoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:44:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388478AbeKVVob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:44:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C949B20820;
        Thu, 22 Nov 2018 11:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542884737;
        bh=NEl5SfX9wQ5A50uQSuYsdNM2UBgxb0nU8m4gfyAu8R4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zP3HATwJbcT4PSLL1i143eyjWYfWVyMSn1Cikx2JAqx92BgcO8+EhNFDQ/+4XqPPv
         GgMrdCJ1RxkBEmwz0+1c+HzdfVu2XTDDkdElthoHaQ678cL1WW8oqsnyiOT+gODoo3
         bCTsvHl/Ai0jI1F++vdJgEYm1tTes79QnL/3glP0=
Date:   Thu, 22 Nov 2018 12:05:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 04/10] staging: erofs: fix
 `erofs_workgroup_{try_to_freeze, unfreeze}'
Message-ID: <20181122110534.GD5287@kroah.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-5-gaoxiang25@huawei.com>
 <20181122102155.GE3189@kroah.com>
 <ee829ce6-e59e-3ed6-b9a4-16c29c9eb59f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee829ce6-e59e-3ed6-b9a4-16c29c9eb59f@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 06:29:34PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2018/11/22 18:21, Greg Kroah-Hartman wrote:
> > On Tue, Nov 20, 2018 at 10:34:19PM +0800, Gao Xiang wrote:
> >> There are two minor issues in the current freeze interface:
> >>
> >>    1) Freeze interfaces have not related with CONFIG_DEBUG_SPINLOCK,
> >>       therefore fix the incorrect conditions;
> >>
> >>    2) For SMP platforms, it should also disable preemption before
> >>       doing atomic_cmpxchg in case that some high priority tasks
> >>       preempt between atomic_cmpxchg and disable_preempt, then spin
> >>       on the locked refcount later.
> > 
> > spinning on a refcount implies that you are trying to do your own type
> > of locking.  Why not use the in-kernel locking api instead?  It will
> > always do better than trying to do your own logic as the developers
> > there know locking across all types of cpus better than filesystem
> > developers :)
> 
> It is because refcount also plays a role as a spinlock on a specific value
> (== EROFS_LOCKED_MAGIC), no need to introduce such a value since the spin
> window is small.

As I said in another email, doing two things with one variable is odd as
those are two different types of functions.

greg k-h
