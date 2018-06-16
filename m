Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA2CC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 08:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B33420896
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 08:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQdDsmDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B33420896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934966AbeFPIiF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 04:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932376AbeFPIiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 04:38:03 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA8DA20896;
        Sat, 16 Jun 2018 08:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529138283;
        bh=2rIa9GJ3pMpoYd9V7rWpQ9MPpx4nFPNMFbxP5Zz2qUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQdDsmDhFA4yYw0YTBVEyYJBBEWIgLnYVWU71yI36aF2wkKYAEtt437RcT7KsBc6b
         /dd6kYjRdk4jOSOnl/UHALydGmRDmLiQnUtzgQDQJs8ERgAWuScf8Tf6/o89AQ31Xh
         gCLt1I6kUEYIf9OHhe+ovf2xUU8I/uf03n8nbxCQ=
Date:   Sat, 16 Jun 2018 10:37:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     linux-kernel@vger.kernel.org, rajatxjain@gmail.com
Subject: Re: [PATCH v2] sysfs: Fix internal_create_group() for named group
 updates
Message-ID: <20180616083740.GA23039@kroah.com>
References: <CAA93t1rOdj4zorR=iU1=9qJmzeTeqD9L5GdX8pm7=NHXzSiy_g@mail.gmail.com>
 <20180616081837.62730-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180616081837.62730-1-rajatja@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 01:18:37AM -0700, Rajat Jain wrote:
> There are a couple of problems with named group updates in the code
> today:
> 
> * sysfs_update_group() will always fail for a named group, because
>   internal_create_group() will try to create a new sysfs directory
>   unconditionally, which will ofcourse fail with -EEXIST.
> 
> * We can leak the kernfs_node for grp->name if some one tries to:
>   - rename a group (change grp->name), or
>   - update a named group, to an unnamed group
> 
> It appears that the whole purpose of sysfs_update_group() was to
> allow changing the permissions or visibility of attributes and not
> the names. So make it clear in the comments, and allow it to update
> an existing named group.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v2: Use pr_warn() instead of WARN()

Looks good, I'll queue it up after 4.18-rc1 is out, thanks for the
update so quickly.

greg k-h
