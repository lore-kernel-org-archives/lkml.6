Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FACAC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D941E2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDSmY9HX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D941E2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeILEwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbeILEwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:52:53 -0400
Received: from [192.168.0.101] (unknown [49.77.238.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2EC220865;
        Tue, 11 Sep 2018 23:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536709874;
        bh=U1drtpxKWwPkfzdZNsdnPBErJKydUNbb5eCM4cDIBbY=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=tDSmY9HXwLGxz/wrD+y/PYWtB1ujRhsL1AHVriL4ZbMZaIXebfVpPXIyA1EwY4G9p
         Ij9K1j+PT2mIhsudw9GUVxx7QD46OdzK5tV5w8dGx5a1RwRnv/AtnF7ffJS/gSXvw5
         3UJCIctmSp2eHCk8ck7Rlgtw3Mf0WJ2TX5cGiA5s=
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix quota info to adjust recovered data
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180911201546.56566-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <7aa2e6f3-a4b2-dfdd-6205-f19c4bc952e6@kernel.org>
Date:   Wed, 12 Sep 2018 07:51:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911201546.56566-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/12 4:15, Jaegeuk Kim wrote:
> fsck.f2fs is able to recover the quota structure, since roll-forward recovery
> can recover it based on previous user information.

I didn't get it, both fsck and kernel recover quota file based all inodes'
uid/gid/prjid, if {x}id didn't change, wouldn't those two recovery result be the
same?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/recovery.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 95511ed11a22..1fde86a2107e 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -675,6 +675,9 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>  
>  	need_writecp = true;
>  
> +	/* quota is not fully updated due to the lack of user information. */
> +	set_sbi_flag(sbi, SBI_NEED_FSCK);
> +
>  	/* step #2: recover data */
>  	err = recover_data(sbi, &inode_list, &dir_list);
>  	if (!err)
> 
