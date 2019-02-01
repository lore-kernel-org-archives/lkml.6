Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B4BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F192218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549037320;
	bh=SFcGONuGYdCO4nDQv9W+w2Ih9mIupb5zlOZHgBXFn04=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=fAqgEw9vjIsEuWzlJZqPHrKMVOeakytdnlFYVHtgW1vZxCAfejqRfx9Mk8vqXy7fE
	 Q/cLfJlnWzb8Zr8kfDqEBvKU07zhW3pzxuh/K8PRosW5ja8nGShkYR8a0Hz1j1zXLw
	 cYRQW7Sz9YC5Gmyye9Lda+wLOSm/vPNz3WnZLOI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfBAQIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:08:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAQIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:08:38 -0500
Received: from [192.168.0.101] (unknown [49.65.250.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1F3921872;
        Fri,  1 Feb 2019 16:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549037317;
        bh=SFcGONuGYdCO4nDQv9W+w2Ih9mIupb5zlOZHgBXFn04=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=RpPD5p9uvQAmNmz4Q0U8ordvgXp5kaxOIJEhNUZGYrUF1Py0kHXSo9GpZp4ANhN49
         71306E/zjQfpcL94AECyUma/CD/1ttnxzF1I6Sg0LOCBWPpS/hBw0/LtYbIiV+WtOl
         yW6RTnrY9IvK8mzFWClT2jcQCTEieag4pz7hxKsk=
Subject: Re: [f2fs-dev] [PATCH 6/7] f2fs: flush quota blocks after turnning it
 off
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20190128234717.77225-1-jaegeuk@kernel.org>
 <20190128234717.77225-6-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <629f4b34-381e-7860-c717-3fe54ee15694@kernel.org>
Date:   Sat, 2 Feb 2019 00:08:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190128234717.77225-6-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-1-29 7:47, Jaegeuk Kim wrote:
> After quota_off, we'll get some dirty blocks. If put_super don't have a chance
> to flush them by checkpoint, it causes NULL pointer exception in end_io after
> iput(node_inode). (e.g., by checkpoint=disable)
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/super.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 5e1f8573a17f..7694cb350734 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2026,6 +2026,12 @@ void f2fs_quota_off_umount(struct super_block *sb)
>  			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>  		}
>  	}
> +	/*
> +	 * In case of checkpoint=disable, we must flush quota blocks.

checkpoint=disable is one of the cases, right? e.g. IO error can be another case?

So here I guess we need to change the comments a bit for that.

Thanks,

> +	 * This can cause NULL exception for node_inode in end_io, since
> +	 * put_super already dropped it.
> +	 */
> +	sync_filesystem(sb);
>  }
>  
>  static void f2fs_truncate_quota_inode_pages(struct super_block *sb)
> 
