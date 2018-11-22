Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA4DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA6920684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0rA0XS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA6920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394315AbeKVVD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:03:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387908AbeKVVDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:03:25 -0500
Received: from localhost (unknown [95.99.132.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C3B720684;
        Thu, 22 Nov 2018 10:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542882276;
        bh=wQ8QMnG0422IEoY3sw3jmvoOVmTswSFA5Z3QgydH0YE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y0rA0XS1+OEnu901SR1hpgxygIudh6iSqOF0wpxdeS7+0IuE2QrT3G4Sthr6/vRNL
         ejXwmxaG8tbuScxvcCq2WBrWlbt8c2gGHE6FKjgmS066cDV3FKKvWTi9LLN/wLo6Mi
         XcQ/8gBRDV6hPIx1Ew/+CKM+QpRfZdVkCdbhMOP0=
Date:   Thu, 22 Nov 2018 11:24:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 08/10] staging: erofs: locked before registering for all
 new workgroups
Message-ID: <20181122102431.GH3189@kroah.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-9-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120143425.43637-9-gaoxiang25@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:34:23PM +0800, Gao Xiang wrote:
> Let's make sure that the one registering a workgroup will also
> take the primary work lock at first for two reasons:
>   1) There's no need to introduce such a race window (and consequently
>      overhead) between registering and locking, other tasks could break
>      in by chance, and the race seems unnecessary (no benefit at all);
> 
>   2) It's better to take the primary work when a workgroup
>      is registered to apply the cache managed policy, for example,
>      if some other tasks break in, it could turn into the in-place
>      decompression rather than use as the cached decompression.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  drivers/staging/erofs/unzip_vle.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> index 4e5843e8ee35..a1376f3c6065 100644
> --- a/drivers/staging/erofs/unzip_vle.c
> +++ b/drivers/staging/erofs/unzip_vle.c
> @@ -420,18 +420,22 @@ z_erofs_vle_work_register(const struct z_erofs_vle_work_finder *f,
>  	work = z_erofs_vle_grab_primary_work(grp);
>  	work->pageofs = f->pageofs;
>  
> +	/* lock all primary followed works before visible to others */
> +	if (unlikely(!mutex_trylock(&work->lock)))
> +		/* for a new workgroup, try_lock *never* fails */
> +		DBG_BUGON(1);

Again, drop this, if it never fails, then there's no need for this.  If
it can fail, then properly handle it.

And trylock can fail, so this needs to be fixed.

thanks,

greg k-h
