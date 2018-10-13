Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741A9C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8F620659
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eNBHvBGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8F620659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJMX7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 19:59:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45520 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJMX7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 19:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x4O2hnMK3ivZixLfSIEiDWuEI7e2xM9wTrjw8QvfE0w=; b=eNBHvBGsqItvyKYNzdLjyaaN1g
        hjCpE4/dBoDW62t3y6w0t5TJ3RQ4XE/iYzQ4602YV8MmEN87somwaDKjEArTjv1FoZqhnQDYSKk6M
        qovbLFDBmS8yt6hB6hnpHcGCUuPsXNSO/iWm5X9b5WtmK9Ops8Ps8m+p5liz57ijQ62u6Qh+XfNS5
        Sx0JO5ohb5Tr6S+r+IXUVyCyHUqVHWO2nDk08ieBEz/7l+UlakIBxBjycqIv2nbZFST5GWjGqymc9
        JGI6c6RzsK2oOqSyt2NC/pwhyPmCDT43EAlP9xJ7baOZoHPbWGmWA9zt//xVz+sikxwJh1xAWb0N9
        mi7Kn7AA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBMfg-0006lj-N8; Sat, 13 Oct 2018 16:21:44 +0000
Subject: Re: [PATCH] ubifs: Fix WARN_ON logic in exit path
To:     Richard Weinberger <richard@nod.at>, gregkh@linuxfoundation.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        dunlap@infradead.org
References: <20181013081841.13369-1-richard@nod.at>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ab4fe8b1-330d-3aa9-a45b-761f65a31f2c@infradead.org>
Date:   Sat, 13 Oct 2018 09:21:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181013081841.13369-1-richard@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/18 1:18 AM, Richard Weinberger wrote:
> ubifs_assert() is not WARN_ON(), so we have to invert
> the checks.
> Randy faced this warning with UBIFS being a module, since
> most users use UBIFS as builtin because UBIFS is the rootfs
> nobody noticed so far. :-(
> Including me.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 54169ddd382d ("ubifs: Turn two ubifs_assert() into a WARN_ON()")
> Signed-off-by: Richard Weinberger <richard@nod.at>

Thanks.  Works for me.

> ---
> Greg,
> 
> can you please take this patch directly?
> It fixes a brown paper bug which was introduced in rc1, I'd like to avoid
> having it in a release and going the -stable path.
> 
> Thanks,
> //richard
> ---
>  fs/ubifs/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index bf000c8aeffb..fec62e9dfbe6 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -2337,8 +2337,8 @@ late_initcall(ubifs_init);
>  
>  static void __exit ubifs_exit(void)
>  {
> -	WARN_ON(list_empty(&ubifs_infos));
> -	WARN_ON(atomic_long_read(&ubifs_clean_zn_cnt) == 0);
> +	WARN_ON(!list_empty(&ubifs_infos));
> +	WARN_ON(atomic_long_read(&ubifs_clean_zn_cnt) != 0);
>  
>  	dbg_debugfs_exit();
>  	ubifs_compressors_exit();
> 


-- 
~Randy
