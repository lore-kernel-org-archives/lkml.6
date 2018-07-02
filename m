Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17875C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D8725906
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D8725906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbeGBOUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:20:10 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:48578 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeGBOUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:20:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BE9FC60A04A9;
        Mon,  2 Jul 2018 16:20:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6Lu7JyAcDQJt; Mon,  2 Jul 2018 16:20:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2785A60A3585;
        Mon,  2 Jul 2018 16:20:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9VjKaXNiJrvu; Mon,  2 Jul 2018 16:20:06 +0200 (CEST)
Received: from blindfold.localnet (089144195003.atnat0004.highway.a1.net [89.144.195.3])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 6A5D460A04A9;
        Mon,  2 Jul 2018 16:20:06 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        y2038@lists.linaro.org, Eric Biggers <ebiggers@google.com>,
        Jan Kara <jack@suse.cz>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Hyunchul Lee <cheol.lee@lge.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubifs: use timespec64 for inode timestamps
Date:   Mon, 02 Jul 2018 16:20:04 +0200
Message-ID: <61251850.EbJPfQiGNC@blindfold>
In-Reply-To: <20180620081311.126158-1-arnd@arndb.de>
References: <20180620081311.126158-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 20. Juni 2018, 10:12:58 CEST schrieb Arnd Bergmann:
> Both vfs and the on-disk inode structures can deal with fine-grained
> timestamps now, so this is the last missing piece to make ubifs
> y2038-safe on 32-bit architectures.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/ubifs/file.c | 11 +++++------
>  fs/ubifs/sb.c   |  6 +++---
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> index fd7eb6fe9090..02fab5c322c7 100644
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@ -1365,11 +1365,10 @@ int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>   * granularity, they are not updated. This is an optimization.
>   */
>  static inline int mctime_update_needed(const struct inode *inode,
> -				       const struct timespec *now)
> +				       const struct timespec64 *now)
>  {
> -	struct timespec64 now64 = timespec_to_timespec64(*now);
> -	if (!timespec64_equal(&inode->i_mtime, &now64) ||
> -	    !timespec64_equal(&inode->i_ctime, &now64))
> +	if (!timespec64_equal(&inode->i_mtime, now) ||
> +	    !timespec64_equal(&inode->i_ctime, now))
>  		return 1;
>  	return 0;
>  }
> @@ -1425,7 +1424,7 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time,
>   */
>  static int update_mctime(struct inode *inode)
>  {
> -	struct timespec now = timespec64_to_timespec(current_time(inode));
> +	struct timespec64 now = current_time(inode);
>  	struct ubifs_inode *ui = ubifs_inode(inode);
>  	struct ubifs_info *c = inode->i_sb->s_fs_info;
>  
> @@ -1519,7 +1518,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fault *vmf)
>  	struct page *page = vmf->page;
>  	struct inode *inode = file_inode(vmf->vma->vm_file);
>  	struct ubifs_info *c = inode->i_sb->s_fs_info;
> -	struct timespec now = timespec64_to_timespec(current_time(inode));
> +	struct timespec64 now = current_time(inode);
>  	struct ubifs_budget_req req = { .new_page = 1 };
>  	int err, update_time;
>  
> diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
> index 8c25081a5109..fa0a982a6797 100644
> --- a/fs/ubifs/sb.c
> +++ b/fs/ubifs/sb.c
> @@ -85,7 +85,7 @@ static int create_default_filesystem(struct ubifs_info *c)
>  	long long tmp64, main_bytes;
>  	__le64 tmp_le64;
>  	__le32 tmp_le32;
> -	struct timespec ts;
> +	struct timespec64 ts;
>  
>  	/* Some functions called from here depend on the @c->key_len filed */
>  	c->key_len = UBIFS_SK_LEN;
> @@ -301,8 +301,8 @@ static int create_default_filesystem(struct ubifs_info *c)
>  	ino->creat_sqnum = cpu_to_le64(++c->max_sqnum);
>  	ino->nlink = cpu_to_le32(2);
>  
> -	ktime_get_real_ts(&ts);
> -	ts = timespec_trunc(ts, DEFAULT_TIME_GRAN);
> +	ktime_get_real_ts64(&ts);
> +	ts = timespec64_trunc(ts, DEFAULT_TIME_GRAN);
>  	tmp_le64 = cpu_to_le64(ts.tv_sec);
>  	ino->atime_sec   = tmp_le64;
>  	ino->ctime_sec   = tmp_le64;

Acked-by: Richard Weinberger <richard@nod.at>

Shall this patch go through the ubifs tree?

Thanks,
//richard

