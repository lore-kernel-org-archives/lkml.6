Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5A3C43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABE420865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vtF58Wea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABE420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeIKEQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbeIKEQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:16:30 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22C8A20658;
        Mon, 10 Sep 2018 23:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536621609;
        bh=4CpZOdcwmHs11c9gWLr2AtSO9gxucYZLdZ2Rn9/XNq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vtF58WeaT6J87hXvMmJWNetigDFVHfbIqs96WHQTHfWn5YpLRLQB4+wzJbxFDEzr6
         2xYY9EbOmQtzTn6RDN8GY9PUfdhIKopH7fjqft3ycTi+Kp8HjCNsWZkF2hE4UOD3MB
         8k2fyCMXTJ9DW5FDBu9j3LP6QliMrCc19PKbQUv8=
Date:   Mon, 10 Sep 2018 16:20:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        weidu.du@huawei.com
Subject: Re: [RFC PATCH v2 2/2] fscrypt: enable RCU-walk path for
 .d_revalidate
Message-ID: <20180910232007.GA19951@gmail.com>
References: <1536584468-15695-2-git-send-email-gaoxiang25@huawei.com>
 <1536584937-16960-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536584937-16960-1-git-send-email-gaoxiang25@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gao,

On Mon, Sep 10, 2018 at 09:08:57PM +0800, Gao Xiang wrote:
> This patch attempts to enable RCU-walk for fscrypt.
> It looks harmless at glance and could have better
> performance than do ref-walk only.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> change log v2:
> 	- READ_ONCE(dir->d_parent) -> READ_ONCE(dentry->d_parent)
> 
>  fs/crypto/crypto.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
> index b38c574..9bd21c0 100644
> --- a/fs/crypto/crypto.c
> +++ b/fs/crypto/crypto.c
> @@ -319,20 +319,24 @@ static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
>  {
>  	struct dentry *dir;
>  	int dir_has_key, cached_with_key;
> -
> -	if (flags & LOOKUP_RCU)
> -		return -ECHILD;
> -
> -	dir = dget_parent(dentry);
> -	if (!IS_ENCRYPTED(d_inode(dir))) {
> -		dput(dir);
> +	struct inode *dir_inode;
> +
> +	rcu_read_lock();
> +repeat:
> +	dir = READ_ONCE(dentry->d_parent);
> +	dir_inode = d_inode_rcu(dir);
> +	if (!IS_ENCRYPTED(dir_inode)) {
> +		rcu_read_unlock();
>  		return 0;
>  	}
> +	dir_has_key = (dir_inode->i_crypt_info != NULL);
> +	if (unlikely(READ_ONCE(dir->d_lockref.count) < 0 ||
> +		READ_ONCE(dentry->d_parent) != dir))
>
>
> +	rcu_read_unlock();
>  
>  	cached_with_key = READ_ONCE(dentry->d_flags) &
>  		DCACHE_ENCRYPTED_WITH_KEY;
> -	dir_has_key = (d_inode(dir)->i_crypt_info != NULL);
> -	dput(dir);
>  

I think you're right that we don't have to drop out of RCU mode here, but can
you please Cc linux-fsdevel so that people more knowledgeable about path lookup
can review this too?  This kind of stuff is very tricky.  Please resend both
patches.

Also please indent properly:

	if (unlikely(READ_ONCE(dir->d_lockref.count) < 0 ||
                     READ_ONCE(dentry->d_parent) != dir))
		goto repeat;

Why read d_lockref.count directly instead of using __lockref_is_dead()?

Also since there's no longer any reference to the parent dentry taken, how do
you know it's still positive (non-NULL d_inode), i.e. that the directory hasn't
been removed and turned into a negative dentry (NULL d_inode)?

I'm also wondering whether the retry loop is actually needed.  Can you explain
your thoughts more?  But if it is needed, in principle you'd actually need to
wait until after the loop before taking any action based on dir_inode, right?
That would mean the 'rcu_read_unlock(); return 0;' is in the wrong place.

Thanks,

- Eric
