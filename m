Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8544EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441E520870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjCMMxzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441E520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394500AbeKVVn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:43:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388478AbeKVVn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:43:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E755320820;
        Thu, 22 Nov 2018 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542884703;
        bh=LEOnr9wkHOC0x+X9N6qk5scbIFuXanQsINY/tt8oPT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TjCMMxzUFSRNGffTqz+yv5awLPzDZgGHQD1wjWhzvmtb9MzxGodHd618CnkLv3kD2
         2VZym8f63cUh67LYTlEHEDKVQKpqAZXHu++vXmXOAFGmCnFYk1XcqyvQk3Oz/MKSZ1
         sVN+XccSSBgaTeBoRqe8/zC//W6edfOtU0rmQ/lA=
Date:   Thu, 22 Nov 2018 12:05:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 07/10] staging: erofs: separate into init_once / always
Message-ID: <20181122110500.GC5287@kroah.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-8-gaoxiang25@huawei.com>
 <20181122102339.GG3189@kroah.com>
 <66b90226-5d0e-7344-5220-908aa243b014@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b90226-5d0e-7344-5220-908aa243b014@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 06:34:10PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2018/11/22 18:23, Greg Kroah-Hartman wrote:
> >> +
> >> +	DBG_BUGON(work->nr_pages);
> >> +	DBG_BUGON(work->vcnt);
> > How can these ever be triggered?  I understand the need for debugging
> > code when you are writing code, but at this point it shouldn't be needed
> > anymore, right?
> 
> I need to avoid some fields is not 0 when the new workgroup is created (because
> work->nr_pages and work->vcnt == 0 usually after the previous workgroup is freed).
> But that is not obvious, it is promised by the current logic.

Then delete these lines if they can never happen :)

> In order to not introduce such a issue in the future, or there are some potential
> race (work->nr_pages and work->vcnt != 0 when the previous workgroup == 0), it need
> to be noticed to developpers as early as possible.

Then make it a real call, do not wrap it in odd macros that do not
really explain why it is "debugging only".  Your code is "real" now,
make the logic real for all developers and users.

thanks,

greg k-h
