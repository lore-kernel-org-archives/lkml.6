Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD75C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9C721104
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8N1I8nA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9C721104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405298AbeKVVBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:01:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405283AbeKVVBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:01:23 -0500
Received: from localhost (unknown [95.99.132.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E237320684;
        Thu, 22 Nov 2018 10:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542882155;
        bh=z7AGX3R207QN9rszFYIZXQje4VZbYRok3hW/+QUAMa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E8N1I8nArpzm387Zw3RDqQBYUa8+a2dREw41WjQ+gEPUdsJ3mYTz6mHxoapoPvHbq
         t1kpRWql1S+QaoDVNNDRoF2Odmq5f2KpEfayuelGa7ZRzd+jHuY+a+H8bLCoxMfLAw
         ox5oJ0pV7X5hJt26/T0oTzTkxD7GvtC0G25e0hUQ=
Date:   Thu, 22 Nov 2018 11:22:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 05/10] staging: erofs: add a full barrier in
 erofs_workgroup_unfreeze
Message-ID: <20181122102230.GF3189@kroah.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-6-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120143425.43637-6-gaoxiang25@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:34:20PM +0800, Gao Xiang wrote:
> Just like other generic locks, insert a full barrier
> in case of memory reorder.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  drivers/staging/erofs/internal.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
> index 2e0ef92c138b..f77653d33633 100644
> --- a/drivers/staging/erofs/internal.h
> +++ b/drivers/staging/erofs/internal.h
> @@ -209,6 +209,7 @@ static inline bool erofs_workgroup_try_to_freeze(struct erofs_workgroup *grp,
>  static inline void erofs_workgroup_unfreeze(struct erofs_workgroup *grp,
>  					    int orig_val)
>  {
> +	smp_mb();

Please document this memory barrier.  It does not make much sense to
me...

thanks,

greg k-h
