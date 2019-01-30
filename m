Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C365C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F68D2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548877079;
	bh=7IyaaytftFK+TVRANl8rgtHODjqJVOGcVqqKJmnJyIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ky+rcRmpSRKOGxKvJQO0oOYcCgVRcH98FLLwBAMRmz0Tcr3yi0HjIvzjHtIuPRY1q
	 LclBxvWpPcHIarvBynFbhn5vUiSxWXwGBATmLRLpSYhFB5jN5hXAdI2InSUToC5LtW
	 PJkQMdKRaVrdFmYf6gwYbvSm4/HqN8MSFOnUFGjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbfA3Th6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:37:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387654AbfA3Thz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:37:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AED9218AF;
        Wed, 30 Jan 2019 19:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548877075;
        bh=7IyaaytftFK+TVRANl8rgtHODjqJVOGcVqqKJmnJyIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N7KC9/qMsa+VOi5UhVX8mMeAwtbcArqh4MmNzLE28CpbGNcR3JtxdAubTlz9sWF3O
         9nDifrjSp9mUihgD9nrGbRJjqCCvZJtZt7tBQwGP5BSO0bwXFvIgaAQdiegxQlt81T
         dK/xUvI6JLZqb5W6N3cpsZMVMWoEQWGRWQ6bPjUM=
Date:   Wed, 30 Jan 2019 20:37:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Josh Poulson <jopoulso@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [PATCH] nfit: Collect shutdown status for NVDIMM_FAMILY_HYPERV
Message-ID: <20190130193752.GA21181@kroah.com>
References: <PU1P153MB01691690696D8F83FC1872C7BF900@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB01691690696D8F83FC1872C7BF900@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 06:48:40PM +0000, Dexuan Cui wrote:
> 
> See http://www.uefi.org/RFIC_LIST ("Virtual NVDIMM 0x1901"):
> "Get Unsafe Shutdown Count (Function Index 2)".
> 
> Let's expose the info to the userspace (e.g. ntctl) via sysfs.

If you add a new sysfs file, you need to add a new Documentation/ABI/
update as well :(

