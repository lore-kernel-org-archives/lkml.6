Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B017C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202BC21782
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYPP+Ili"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202BC21782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeHRSYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 14:24:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbeHRSYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 14:24:03 -0400
Received: from localhost (c-67-160-202-76.hsd1.ca.comcast.net [67.160.202.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0804821581;
        Sat, 18 Aug 2018 15:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534605361;
        bh=smmP57ydSAntDo4implqdJ1Y42t5muyPSApoAA+WaAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYPP+IliUf9o1BQ0KQhKuKiuB//wC3tCvJbjGCOMuyjtRVTqcAgLqiqCUJX5AJUXj
         B8KC/xAdtKXnqKX0XlkugXYC4OoWYgtio+KcIdK5kSycprST+2GBonL+eF/UDtJUQF
         M/ut+Lz/7oNDaRusBmsAAF3CHjsOqlqs8ob8ZJbk=
Date:   Sat, 18 Aug 2018 08:16:00 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 1/2] f2fs: fix to avoid quota inode leak in ->put_super
Message-ID: <20180818151600.GA84798@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180817091840.50792-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817091840.50792-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17, Chao Yu wrote:
> generic/019 reports below error:
> 
>  __quota_error: 1160 callbacks suppressed
>  Quota error (device zram1): write_blk: dquota write failed
>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>  Quota error (device zram1): write_blk: dquota write failed
>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>  Quota error (device zram1): write_blk: dquota write failed
>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>  Quota error (device zram1): write_blk: dquota write failed
>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>  Quota error (device zram1): write_blk: dquota write failed
>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>  VFS: Busy inodes after unmount of zram1. Self-destruct in 5 seconds.  Have a nice day...
> 
> If we failed in below path due to fail to write dquot block, we will miss
> to release quota inode, fix it.
> 
> - f2fs_put_super
>  - f2fs_quota_off_umount
>   - f2fs_quota_off
>    - f2fs_quota_sync   <-- failed
>    - dquot_quota_off   <-- missed to call
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index a5df9fbc6355..9647bbcdfd2b 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1977,10 +1977,12 @@ void f2fs_quota_off_umount(struct super_block *sb)
>  	for (type = 0; type < MAXQUOTAS; type++) {
>  		err = f2fs_quota_off(sb, type);
>  		if (err) {
> +			int ret = dquot_quota_off(sb, type);
> +

Could you check the mainline version?

>  			f2fs_msg(sb, KERN_ERR,
>  				"Fail to turn off disk quota "
> -				"(type: %d, err: %d), Please "
> -				"run fsck to fix it.", type, err);
> +				"(type: %d, err: %d, ret:%d), Please "
> +				"run fsck to fix it.", type, err, ret);
>  			set_sbi_flag(F2FS_SB(sb), SBI_NEED_FSCK);
>  		}
>  	}
> -- 
> 2.18.0.rc1
