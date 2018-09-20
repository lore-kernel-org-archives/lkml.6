Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00C5C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C8D21524
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C8D21524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbeITL4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 07:56:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59089 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725725AbeITL4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 07:56:21 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A91996B067AA4;
        Thu, 20 Sep 2018 14:14:28 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Thu, 20 Sep 2018
 14:14:26 +0800
Subject: Re: [f2fs-dev] [PATCH 1/2 v2] f2fs: report ENOENT correct in
 f2fs_rename
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180918021805.85032-1-jaegeuk@kernel.org>
 <20180919225037.GC79681@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <740d4c02-0fdd-d9bb-2079-2cb0947bf581@huawei.com>
Date:   Thu, 20 Sep 2018 14:14:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919225037.GC79681@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/20 6:50, Jaegeuk Kim wrote:
> This fixes wrong error report in f2fs_rename.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> Change log from v1:
>  - cover rename2 case
> 
>  fs/f2fs/namei.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 98d3ab7c3ce6..48f919469151 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -833,7 +833,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	struct f2fs_dir_entry *old_entry;
>  	struct f2fs_dir_entry *new_entry;
>  	bool is_old_inline = f2fs_has_inline_dentry(old_dir);
> -	int err = -ENOENT;
> +	int err;
>  
>  	if (unlikely(f2fs_cp_error(sbi)))
>  		return -EIO;
> @@ -854,6 +854,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	if (err)
>  		goto out;
>  
> +	err = -ENOENT;

It should be assigned after dquot_initialize(), otherwise, err's value can
still be reset to 0 due to dquot_initialize().

>  	if (new_inode) {
>  		err = dquot_initialize(new_inode);
>  		if (err)
> @@ -1049,6 +1050,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	if (err)
>  		goto out;
>  
> +	err = -ENOENT;

We can remove err initialization like f2fs_rename()

int err;

Thanks,

>  	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
>  	if (!old_entry) {
>  		if (IS_ERR(old_page))
> 

