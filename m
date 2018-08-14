Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9029AC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A14621742
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="09jeifqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A14621742
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbeHNG6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 02:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbeHNG6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 02:58:49 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 801F821742;
        Tue, 14 Aug 2018 04:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534220010;
        bh=TVIKhfsg3TbXJ5NRPPMa9KgwZ2YcqtRLU3/qcHpEEHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=09jeifqBJBixYZFqd92bb41yS5GHKD0Q09/mkjcr1f1vmh+kF269XZX4Qr9+QMam2
         hKQt4Y33XYiJ87lnc9QLvhuRji3UG7Uu1QPoc3a6nVteRWTS0G3zki76CnDV5kLbE3
         imAmvkhJwfLszlfS2UZzdkjJYbBV3ldDW/5t4KF8=
Date:   Mon, 13 Aug 2018 21:13:29 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 1/2] f2fs: set 4KB discard granularity by default
Message-ID: <20180814041329.GB52730@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180810100806.9298-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810100806.9298-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10, Chao Yu wrote:
> Small granularity (size < 64K) fragmentation will cause f2fs suspending
> all pending discards, result in performance regression, so let's set
> 4KB discard granularity by default.
> 
> So that without fstrim, we also have the ability to avoid any performance
> regression caused by non-alignment mapping between fs and flash device.

This is why we added a sysfs entry. Why do we need to change the default
value every time?

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 58431b9bfd8f..273ffdaf4891 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -248,7 +248,7 @@ struct discard_entry {
>  };
>  
>  /* default discard granularity of inner discard thread, unit: block count */
> -#define DEFAULT_DISCARD_GRANULARITY		16
> +#define DEFAULT_DISCARD_GRANULARITY		1
>  
>  /* max discard pend list number */
>  #define MAX_PLIST_NUM		512
> -- 
> 2.18.0.rc1
