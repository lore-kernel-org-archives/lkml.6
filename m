Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBD2C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAAD21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDiBC8hR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAAD21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbeIRSTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbeIRSTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:19:41 -0400
Received: from [192.168.0.101] (unknown [49.77.217.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D46222146D;
        Tue, 18 Sep 2018 12:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537274834;
        bh=A3I1suWM6Cwyuo/nHOr/Lj/BFmg2DAV4/83PwJ0KVro=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=YDiBC8hRywUFRwbHR9mXvM06VSUfPpO3GM/aV3Xbq6Vbanl4kIgS1yWtWqIDfgfF+
         LtDMhcPcw6tFnEMHL5DWEoEv+qutF6JphHiwWL7xOGWWLHr1RYaxb91rDJ/iMLtp9Q
         aRNxBn7bdF69Y74dEgUiNH1QrQScXhAWRyPT5Vug=
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: report ENOENT correct in f2fs_rename
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180918021805.85032-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <f2d06f89-4f84-8492-eeea-e1c07e5104c3@kernel.org>
Date:   Tue, 18 Sep 2018 20:47:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918021805.85032-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/18 10:18, Jaegeuk Kim wrote:
> This fixes wrong error report in f2fs_rename.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/namei.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 98d3ab7c3ce6..d653be777529 100644
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

I didn't get what's the difference after moving initialization of 'err' here...

Thanks,

>  	if (new_inode) {
>  		err = dquot_initialize(new_inode);
>  		if (err)
> 
