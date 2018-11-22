Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41574C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3F020866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ywJemyRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3F020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394718AbeKVWFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:05:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394706AbeKVWFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:05:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECF002081C;
        Thu, 22 Nov 2018 11:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542886007;
        bh=pU1qPP1/AKTwSHQ/U082dtbWU8c1fm3+mclqzstKDFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ywJemyRoNSSMwbEpt1bknXoGFGjlDdoiyyt9A6si1Z7fn6GheD0SER00+6vyd9GpY
         ZVzY0k55dLk2Ndu/6BneCqO2QtFptD30dAxKQ0JtulgcXBbXd9/4kaCNeD6C/gRjGG
         RmebiTljTUSQWBisFM1cHQ+DNRd+U2Wad+hAgwH4=
Date:   Thu, 22 Nov 2018 12:26:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 07/10] staging: erofs: separate into init_once / always
Message-ID: <20181122112645.GA7527@kroah.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-8-gaoxiang25@huawei.com>
 <20181122102339.GG3189@kroah.com>
 <66b90226-5d0e-7344-5220-908aa243b014@huawei.com>
 <20181122110500.GC5287@kroah.com>
 <ef49bf11-b937-46b4-1b9a-c068182aa7d9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef49bf11-b937-46b4-1b9a-c068182aa7d9@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 07:11:08PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2018/11/22 19:05, Greg Kroah-Hartman wrote:
> > On Thu, Nov 22, 2018 at 06:34:10PM +0800, Gao Xiang wrote:
> >> Hi Greg,
> >>
> >> On 2018/11/22 18:23, Greg Kroah-Hartman wrote:
> >>>> +
> >>>> +	DBG_BUGON(work->nr_pages);
> >>>> +	DBG_BUGON(work->vcnt);
> >>> How can these ever be triggered?  I understand the need for debugging
> >>> code when you are writing code, but at this point it shouldn't be needed
> >>> anymore, right?
> >>
> >> I need to avoid some fields is not 0 when the new workgroup is created (because
> >> work->nr_pages and work->vcnt == 0 usually after the previous workgroup is freed).
> >> But that is not obvious, it is promised by the current logic.
> > 
> > Then delete these lines if they can never happen :)
> 
> I don't know how to observe such a race in our beta test and community users.

	/*
	 * Let developers know something went really wrong with their
	 * initialization code
	 */
	if (!work->nr_pages) {
		pr_err("nr_pages == NULL!");
		WARN_ON(1);
	}
	if (!work->vcnt) {
		pr_err("vcnt == NULL!");
		WARN_ON(1);
	}

or something like that.

Don't make people rebuild your code with different options for
debugging.  That will never work in the 'real world' when people start
using the code.  You need to have things enabled for people all the
time, which is why we have dynamic debugging in the kernel now, and not
a zillion different "DRIVER_DEBUG" build options anymore.

> Because if the kernel is crashed, we could collect the whole kernel dump to observe the memory
> and all registers, if we only have some warning, it will be not easy to get the state as early as possible.

When the kernel crashes, geting a dump is hard on almost all hardware.
It is only rare systems that you can get a kernel dump.

thanks,

greg k-h
