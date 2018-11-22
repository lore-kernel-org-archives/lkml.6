Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BD4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB15D206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXtwnPnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB15D206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391253AbeKVXFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:05:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731683AbeKVXFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:05:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAA9420684;
        Thu, 22 Nov 2018 12:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542889589;
        bh=bzEOeGfx6R+iYfswBeNaB5BHMcnRpPPCcmXVV4b6RmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FXtwnPnXgGCYTfUFIV/cAHQJjNhiSxJ11uMX2s80NTS1flEKLO/oWJ2afAY8iCSSa
         P/eYwWGMPRD2MhZam4e5IIKZqW0KETac0AbP1ifo/bTkNDZ6q+wAs/PU01D4YzUa+e
         ZnxPyyw+mCbNvl8ufGSuWnzzwTLiy6ehgeNs45iA=
Date:   Thu, 22 Nov 2018 13:26:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 02/10] staging: erofs: fix race when the managed cache is
 enabled
Message-ID: <20181122122627.GC10212@kroah.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-3-gaoxiang25@huawei.com>
 <20181122101711.GA3189@kroah.com>
 <55aed87f-196e-9048-6aae-db09bc497664@huawei.com>
 <20181122110642.GE5287@kroah.com>
 <78f8bed5-5f7f-8ca6-5d7a-3a94a2062425@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78f8bed5-5f7f-8ca6-5d7a-3a94a2062425@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 07:43:50PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2018/11/22 19:06, Greg Kroah-Hartman wrote:
> > On Thu, Nov 22, 2018 at 06:42:52PM +0800, Gao Xiang wrote:
> >> Hi Greg,
> >>
> >> On 2018/11/22 18:17, Greg Kroah-Hartman wrote:
> >>> Any specific reason why you are not using the refcount.h api instead of
> >>> "doing it yourself" with atomic_inc/dec()?
> >>>
> >>> I'm not rejecting this, just curious.
> >> As I explained in the previous email,
> >> Re: [PATCH 04/10] staging: erofs: fix `erofs_workgroup_{try_to_freeze, unfreeze}'
> >>
> >> we need such a function when the value is >= 0, it plays as a refcount,
> >> but when the refcount == EROFS_LOCKED_MAGIC (<0, but not 0 as refcount.h),
> >> and actually there is no need to introduce a seperate spinlock_t because
> >> we don't actually care about its performance (rarely locked). and
> >> the corresponding struct is too large for now, we need to decrease its size.
> > Why do you need to decrease the size?  How many of these structures are
> > created?
> 
> As I said in the previous email, every compressed page will have a managed structure
> called erofs_workgroup, and it is heavily allocated like page/inode/dentry in the erofs.

Ugh, every page?  Ok, nevermind, I take back my objections.  You all are
crazy and need to do crazy things like this :)

greg k-h
