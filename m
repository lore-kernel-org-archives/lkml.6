Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCB0C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF23521470
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTp8WZts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF23521470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeJMPGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbeJMPGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:06:12 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF93020835;
        Sat, 13 Oct 2018 07:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539415807;
        bh=PlkFMCC7uBIxha7zR+q79uW+4GWMGFSslmiJgb/Kq80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bTp8WZtsTMWmiXjs93E8aCRYbckFWr4MXg8BclpX+ZDcPYb13K4vQGDS+/APT8vPj
         r3W56z+hB9P/aF09019Qg/2nMHURdH/WiVYQMe7OURNd+NrYA5RaiTq+O2OTYwPpUt
         c9viHKH5gbwp1PVkUcwMoLE1e9wEof69sC7Va4eM=
Date:   Sat, 13 Oct 2018 09:30:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <chao@kernel.org>
Subject: Re: [RFC PATCH] bit_spinlock: introduce smp_cond_load_relaxed
Message-ID: <20181013073004.GA29921@kroah.com>
References: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
 <20181013070420.GA29914@kroah.com>
 <99c4d824-7bd2-a91f-eaaa-8cfe55c66232@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99c4d824-7bd2-a91f-eaaa-8cfe55c66232@aol.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 03:22:08PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2018/10/13 15:04, Greg Kroah-Hartman wrote:
> > On Sat, Oct 13, 2018 at 02:47:29PM +0800, Gao Xiang wrote:
> >> It is better to use smp_cond_load_relaxed instead
> >> of busy waiting for bit_spinlock.
> > 
> > Why?  I think we need some kind of "proof" that this is true before
> > being able to accept a patch like this, don't you agree?
> 
> There are some materials which discuss smp_cond_load_* earlier.
> https://patchwork.kernel.org/patch/10335991/
> https://patchwork.kernel.org/patch/10325057/
> 
> In ARM64, they implements a function called "cmpwait", which uses
> hardware instructions to monitor a value change, I think it is more
> energy efficient than just do a open-code busy loop...
> 
> And it seem smp_cond_load_* is already used in the current kernel, such as:
> ./kernel/locking/mcs_spinlock.h
> ./kernel/locking/qspinlock.c
> ./kernel/sched/core.c
> ./kernel/smp.c
> 
> For other architectures like x86/arm64, I think they could implement
> smp_cond_load_* later.

And have you benchmarked this change to show that it provides any
benifit?

You need to do that...

thanks,

greg k-h
