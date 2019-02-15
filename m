Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA16C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0199D21B1C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389194AbfBOHCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:02:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726766AbfBOHCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:02:40 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5FE4113098AF59727D6E;
        Fri, 15 Feb 2019 15:02:35 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Fri, 15 Feb 2019
 15:02:27 +0800
Subject: Re: [PATCH v2] staging: erofs: keep corrupted fs from crashing kernel
 in erofs_namei()
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, <stable@vger.kernel.org>
References: <20190201121631.15179-1-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a9381c0d-9857-4d03-710d-80006d426bbc@huawei.com>
Date:   Fri, 15 Feb 2019 15:02:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190201121631.15179-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/1 20:16, Gao Xiang wrote:
> As Al pointed out, "
> ... and while we are at it, what happens to
> 	unsigned int nameoff = le16_to_cpu(de[mid].nameoff);
> 	unsigned int matched = min(startprfx, endprfx);
> 
> 	struct qstr dname = QSTR_INIT(data + nameoff,
> 		unlikely(mid >= ndirents - 1) ?
> 			maxsize - nameoff :
> 			le16_to_cpu(de[mid + 1].nameoff) - nameoff);
> 
> 	/* string comparison without already matched prefix */
> 	int ret = dirnamecmp(name, &dname, &matched);
> if le16_to_cpu(de[...].nameoff) is not monotonically increasing?  I.e.
> what's to prevent e.g. (unsigned)-1 ending up in dname.len?
> 
> Corrupted fs image shouldn't oops the kernel.. "
> 
> Revisit the related lookup flow to address the issue.
> 
> Fixes: d72d1ce60174 ("staging: erofs: add namei functions")
> Cc: <stable@vger.kernel.org> # 4.19+
> Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> [ It should be better get reviewed first and for linux-next... ]
> 
> change log v2:
>  - fix the missing "kunmap_atomic" pointed out by Dan;
>  - minor cleanup;
> 
>  drivers/staging/erofs/namei.c | 187 ++++++++++++++++++++++--------------------
>  1 file changed, 99 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/staging/erofs/namei.c b/drivers/staging/erofs/namei.c
> index 5596c52e246d..321c881d720f 100644
> --- a/drivers/staging/erofs/namei.c
> +++ b/drivers/staging/erofs/namei.c
> @@ -15,74 +15,77 @@
>  
>  #include <trace/events/erofs.h>
>  
> -/* based on the value of qn->len is accurate */
> -static inline int dirnamecmp(struct qstr *qn,
> -	struct qstr *qd, unsigned int *matched)
> +struct erofs_qstr {
> +	const unsigned char *name;
> +	const unsigned char *end;
> +};
> +
> +/* based on the end of qn is accurate and it must have the trailing '\0' */
> +static inline int dirnamecmp(const struct erofs_qstr *qn,
> +			     const struct erofs_qstr *qd,
> +			     unsigned int *matched)
>  {
> -	unsigned int i = *matched, len = min(qn->len, qd->len);
> -loop:
> -	if (unlikely(i >= len)) {
> -		*matched = i;
> -		if (qn->len < qd->len) {
> -			/*
> -			 * actually (qn->len == qd->len)
> -			 * when qd->name[i] == '\0'
> -			 */
> -			return qd->name[i] == '\0' ? 0 : -1;
> +	unsigned int i = *matched;
> +
> +	/*
> +	 * on-disk error, let's only BUG_ON in the debugging mode.
> +	 * otherwise, it will return 1 to just skip the invalid name
> +	 * and go on (in consideration of the lookup performance).
> +	 */
> +	DBG_BUGON(qd->name > qd->end);

qd->name == qd->end is not allowed as well?

So will it be better to return directly here?

	if (unlikely(qd->name >= qd->end)) {
		DBG_BUGON(1);
		return 1;
	}

> +
> +	/* qd could not have trailing '\0' */
> +	/* However it is absolutely safe if < qd->end */
> +	while (qd->name + i < qd->end && qd->name[i] != '\0') {
> +		if (qn->name[i] != qd->name[i]) {
> +			*matched = i;
> +			return qn->name[i] > qd->name[i] ? 1 : -1;
>  		}
> -		return (qn->len > qd->len);
> +		++i;
>  	}
> -
> -	if (qn->name[i] != qd->name[i]) {
> -		*matched = i;
> -		return qn->name[i] > qd->name[i] ? 1 : -1;
> -	}
> -
> -	++i;
> -	goto loop;
> +	*matched = i;
> +	/* See comments in __d_alloc on the terminating NUL character */
> +	return qn->name[i] == '\0' ? 0 : 1;
>  }
>  
> -static struct erofs_dirent *find_target_dirent(
> -	struct qstr *name,
> -	u8 *data, int maxsize)
> +#define nameoff_from_disk(off, sz)	(le16_to_cpu(off) & ((sz) - 1))
> +
> +static struct erofs_dirent *find_target_dirent(struct erofs_qstr *name,
> +					       u8 *data,
> +					       unsigned int dirblksize,
> +					       const int ndirents)
>  {
> -	unsigned int ndirents, head, back;
> +	int head, back;
>  	unsigned int startprfx, endprfx;
>  	struct erofs_dirent *const de = (struct erofs_dirent *)data;
>  
> -	/* make sure that maxsize is valid */
> -	BUG_ON(maxsize < sizeof(struct erofs_dirent));
> -
> -	ndirents = le16_to_cpu(de->nameoff) / sizeof(*de);
> -
> -	/* corrupted dir (may be unnecessary...) */
> -	BUG_ON(!ndirents);
> -
> -	head = 0;
> +	/* since the 1st dirent has been evaluated previously */
> +	head = 1;
>  	back = ndirents - 1;
>  	startprfx = endprfx = 0;
>  
>  	while (head <= back) {
> -		unsigned int mid = head + (back - head) / 2;
> -		unsigned int nameoff = le16_to_cpu(de[mid].nameoff);
> +		const int mid = head + (back - head) / 2;
> +		const int nameoff = nameoff_from_disk(de[mid].nameoff,
> +						      dirblksize);
>  		unsigned int matched = min(startprfx, endprfx);
> -
> -		struct qstr dname = QSTR_INIT(data + nameoff,
> -			unlikely(mid >= ndirents - 1) ?
> -				maxsize - nameoff :
> -				le16_to_cpu(de[mid + 1].nameoff) - nameoff);
> +		struct erofs_qstr dname = {
> +			.name = data + nameoff,
> +			.end = unlikely(mid >= ndirents - 1) ?
> +				data + dirblksize :
> +				data + nameoff_from_disk(de[mid + 1].nameoff,
> +							 dirblksize)
> +		};
>  
>  		/* string comparison without already matched prefix */
>  		int ret = dirnamecmp(name, &dname, &matched);
>  
> -		if (unlikely(!ret))
> +		if (unlikely(!ret)) {
>  			return de + mid;
> -		else if (ret > 0) {
> +		} else if (ret > 0) {
>  			head = mid + 1;
>  			startprfx = matched;
> -		} else if (unlikely(mid < 1))	/* fix "mid" overflow */
> -			break;
> -		else {
> +		} else {
>  			back = mid - 1;
>  			endprfx = matched;
>  		}
> @@ -91,12 +94,12 @@ static struct erofs_dirent *find_target_dirent(
>  	return ERR_PTR(-ENOENT);
>  }
>  
> -static struct page *find_target_block_classic(
> -	struct inode *dir,
> -	struct qstr *name, int *_diff)
> +static struct page *find_target_block_classic(struct inode *dir,
> +					      struct erofs_qstr *name,
> +					      int *_ndirents)
>  {
>  	unsigned int startprfx, endprfx;
> -	unsigned int head, back;
> +	int head, back;
>  	struct address_space *const mapping = dir->i_mapping;
>  	struct page *candidate = ERR_PTR(-ENOENT);
>  
> @@ -105,41 +108,43 @@ static struct page *find_target_block_classic(
>  	back = inode_datablocks(dir) - 1;
>  
>  	while (head <= back) {
> -		unsigned int mid = head + (back - head) / 2;
> +		const int mid = head + (back - head) / 2;
>  		struct page *page = read_mapping_page(mapping, mid, NULL);
>  
> -		if (IS_ERR(page)) {
> -exact_out:
> -			if (!IS_ERR(candidate)) /* valid candidate */
> -				put_page(candidate);
> -			return page;
> -		} else {
> -			int diff;
> -			unsigned int ndirents, matched;
> -			struct qstr dname;
> +		if (!IS_ERR(page)) {
>  			struct erofs_dirent *de = kmap_atomic(page);
> -			unsigned int nameoff = le16_to_cpu(de->nameoff);
> -
> -			ndirents = nameoff / sizeof(*de);
> +			const int nameoff = nameoff_from_disk(de->nameoff,
> +							      EROFS_BLKSIZ);
> +			const int ndirents = nameoff / sizeof(*de);
> +			int diff;
> +			unsigned int matched;
> +			struct erofs_qstr dname;
>  
> -			/* corrupted dir (should have one entry at least) */
> -			BUG_ON(!ndirents || nameoff > PAGE_SIZE);
> +			if (unlikely(!ndirents)) {
> +				DBG_BUGON(1);
> +				kunmap_atomic(de);
> +				put_page(page);
> +				page = ERR_PTR(-EIO);
> +				goto out;
> +			}
>  
>  			matched = min(startprfx, endprfx);
>  
>  			dname.name = (u8 *)de + nameoff;
> -			dname.len = ndirents == 1 ?
> -				/* since the rest of the last page is 0 */
> -				EROFS_BLKSIZ - nameoff
> -				: le16_to_cpu(de[1].nameoff) - nameoff;
> +			if (ndirents == 1)
> +				dname.end = (u8 *)de + EROFS_BLKSIZ;
> +			else
> +				dname.end = (u8 *)de +
> +					nameoff_from_disk(de[1].nameoff,
> +							  EROFS_BLKSIZ);
>  
>  			/* string comparison without already matched prefix */
>  			diff = dirnamecmp(name, &dname, &matched);
>  			kunmap_atomic(de);
>  
>  			if (unlikely(!diff)) {
> -				*_diff = 0;
> -				goto exact_out;
> +				*_ndirents = 0;
> +				goto out;
>  			} else if (diff > 0) {
>  				head = mid + 1;
>  				startprfx = matched;
> @@ -147,47 +152,53 @@ static struct page *find_target_block_classic(
>  				if (likely(!IS_ERR(candidate)))
>  					put_page(candidate);
>  				candidate = page;
> +				*_ndirents = ndirents;
>  			} else {
>  				put_page(page);
>  
> -				if (unlikely(mid < 1))	/* fix "mid" overflow */
> -					break;
> -
>  				back = mid - 1;
>  				endprfx = matched;
>  			}
> +			continue;
>  		}
> +out:		/* free if the candidate is valid */
> +		if (!IS_ERR(candidate))
> +			put_page(candidate);
> +		return page;
>  	}
> -	*_diff = 1;
>  	return candidate;
>  }
>  
>  int erofs_namei(struct inode *dir,
> -	struct qstr *name,
> -	erofs_nid_t *nid, unsigned int *d_type)
> +		struct qstr *name,
> +		erofs_nid_t *nid, unsigned int *d_type)
>  {
> -	int diff;
> +	int ndirents;
>  	struct page *page;
> -	u8 *data;
> +	void *data;
>  	struct erofs_dirent *de;
> +	struct erofs_qstr qn;
>  
>  	if (unlikely(!dir->i_size))
>  		return -ENOENT;
>  
> -	diff = 1;
> -	page = find_target_block_classic(dir, name, &diff);
> +	qn.name = name->name;
> +	qn.end = name->name + name->len;
> +
> +	ndirents = 0;
> +	page = find_target_block_classic(dir, &qn, &ndirents);
>  
> -	if (unlikely(IS_ERR(page)))
> +	if (IS_ERR(page))
>  		return PTR_ERR(page);
>  
>  	data = kmap_atomic(page);
>  	/* the target page has been mapped */
> -	de = likely(diff) ?
> -		/* since the rest of the last page is 0 */
> -		find_target_dirent(name, data, EROFS_BLKSIZ) :
> -		(struct erofs_dirent *)data;
> +	if (ndirents)
> +		de = find_target_dirent(&qn, data, EROFS_BLKSIZ, ndirents);

If we want to support different blksize during dirent lookup, how about
adding parameter for find_target_block_classic() as find_target_dirent()?

Thanks,

> +	else
> +		de = (struct erofs_dirent *)data;
>  
> -	if (likely(!IS_ERR(de))) {
> +	if (!IS_ERR(de)) {
>  		*nid = le64_to_cpu(de->nid);
>  		*d_type = de->file_type;
>  	}
> 

