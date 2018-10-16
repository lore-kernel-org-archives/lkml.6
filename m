Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963BDC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D3620869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D3620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeJPNly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:41:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14076 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727196AbeJPNlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:41:53 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E9ABC9019A6B6;
        Tue, 16 Oct 2018 13:53:03 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Tue, 16 Oct 2018
 13:52:59 +0800
Subject: Re: [PATCH] jffs2: free jffs2_sb_info through jffs2_kill_sb()
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <dwmw2@infradead.org>, <stable@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brian Norris <computersforpeace@gmail.com>
References: <20181006090935.41714-1-houtao1@huawei.com>
Message-ID: <6401cb90-a1fe-afd5-c302-ddae40876736@huawei.com>
Date:   Tue, 16 Oct 2018 13:52:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181006090935.41714-1-houtao1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.14]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ?

On 2018/10/6 17:09, Hou Tao wrote:
> When an invalid mount option is passed to jffs2, jffs2_parse_options()
> will fail and jffs2_sb_info will be freed, but then jffs2_sb_info will
> be used (use-after-free) and freeed (double-free) in jffs2_kill_sb().
> 
> Fix it by removing the buggy invocation of kfree() when getting invalid
> mount options.
> 
> Cc: stable@kernel.org
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  fs/jffs2/super.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
> index 87bdf0f4cba1..902a7dd10e5c 100644
> --- a/fs/jffs2/super.c
> +++ b/fs/jffs2/super.c
> @@ -285,10 +285,8 @@ static int jffs2_fill_super(struct super_block *sb, void *data, int silent)
>  	sb->s_fs_info = c;
>  
>  	ret = jffs2_parse_options(c, data);
> -	if (ret) {
> -		kfree(c);
> +	if (ret)
>  		return -EINVAL;
> -	}
>  
>  	/* Initialize JFFS2 superblock locks, the further initialization will
>  	 * be done later */
> 

