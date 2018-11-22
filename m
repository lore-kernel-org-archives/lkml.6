Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301E9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF3A20831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxF/QzmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF3A20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436659AbeKWAAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:00:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729195AbeKWAAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:00:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3629E20684;
        Thu, 22 Nov 2018 13:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542892843;
        bh=aGroXbhvpIWVabPHAhJEsC6o5J2bGv1s5u4svYZ7W3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CxF/QzmS9aHflJJ6rnjP8qOC+BL4rqpZzV1dnTRf9I4S/eN0FGRUjAgPazRvDrTfU
         8nJbFWCPEjSGFhpXp9NBq3x2AgdlWKHel/pv3CjKQlD818aiTT9f1Q2U65J99X9NrA
         /+kbgWoi+ruYxwEpyghFYiUSqpbTbNrR1gpS4fXw=
Date:   Thu, 22 Nov 2018 14:20:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 02/10] staging: erofs: fix race when the managed cache is
 enabled
Message-ID: <20181122132041.GA14300@kroah.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-3-gaoxiang25@huawei.com>
 <20181122101711.GA3189@kroah.com>
 <55aed87f-196e-9048-6aae-db09bc497664@huawei.com>
 <20181122110642.GE5287@kroah.com>
 <78f8bed5-5f7f-8ca6-5d7a-3a94a2062425@huawei.com>
 <20181122122627.GC10212@kroah.com>
 <fa61d737-216e-c644-5d23-28d520182262@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa61d737-216e-c644-5d23-28d520182262@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 08:41:15PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2018/11/22 20:26, Greg Kroah-Hartman wrote:
> > Ugh, every page?  Ok, nevermind, I take back my objections.  You all are
> > crazy and need to do crazy things like this :)
> 
> ...Do you have some idea about this? ... I think it is fairly normal... :(
> 
> We have a large number of managed workgroups, the current use case is the 4k compressed size,
> each compressed page has a workgroup, but erofs also has reclaim paths to free them for low memory cases.
> 
> But since the structure (z_erofs_vle_workgroup, erofs_workgroup) is critical,
> I need to make it as small as possible.

I do not know "real" filesystems (i.e. ones that put stuff on disks),
only virtual ones (like sysfs/kernfs), so I do not know what to suggest
here, sorry.  I thought this was a much higner-level structure, if this
is per-compressed-page, then you are more than welcome to optimize for
this.  Good luck with your "fake" spinlocks though :)

thanks,

greg k-h
