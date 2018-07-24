Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354CDECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA43720875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA43720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388269AbeGXBYZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 21:24:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388177AbeGXBYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 21:24:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5409881A4EA9;
        Tue, 24 Jul 2018 00:20:41 +0000 (UTC)
Received: from ovpn-12-29.pek2.redhat.com (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D2612166BA0;
        Tue, 24 Jul 2018 00:20:36 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2] fs: ceph: Adding new return type vm_fault_t
From:   "Yan, Zheng" <zyan@redhat.com>
In-Reply-To: <20180723160224.GA6942@jordon-HP-15-Notebook-PC>
Date:   Tue, 24 Jul 2018 08:20:31 +0800
Cc:     willy@infradead.org, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ajitn.linux@gmail.com,
        brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <BCEB8666-0DFE-4AC4-95BE-9B1FF1442724@redhat.com>
References: <20180723160224.GA6942@jordon-HP-15-Notebook-PC>
To:     Souptick Joarder <jrdr.linux@gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 24 Jul 2018 00:20:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 24 Jul 2018 00:20:41 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'zyan@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 24, 2018, at 00:02, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> 
> Use new return type vm_fault_t for page_mkwrite
> and fault handler.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
> v2: Fixed kbuild warning
> 
> fs/ceph/addr.c | 62 ++++++++++++++++++++++++++++++----------------------------
> 1 file changed, 32 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 292b3d7..26beebe 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1431,7 +1431,7 @@ static void ceph_restore_sigs(sigset_t *oldset)
> /*
>  * vm ops
>  */
> -static int ceph_filemap_fault(struct vm_fault *vmf)
> +static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
> {
> 	struct vm_area_struct *vma = vmf->vma;
> 	struct inode *inode = file_inode(vma->vm_file);
> @@ -1439,8 +1439,9 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
> 	struct ceph_file_info *fi = vma->vm_file->private_data;
> 	struct page *pinned_page = NULL;
> 	loff_t off = vmf->pgoff << PAGE_SHIFT;
> -	int want, got, ret;
> +	int want, got, err;
> 	sigset_t oldset;
> +	vm_fault_t ret = VM_FAULT_SIGBUS;
> 
> 	ceph_block_sigs(&oldset);
> 
> @@ -1452,8 +1453,8 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
> 		want = CEPH_CAP_FILE_CACHE;
> 
> 	got = 0;
> -	ret = ceph_get_caps(ci, CEPH_CAP_FILE_RD, want, -1, &got, &pinned_page);
> -	if (ret < 0)
> +	err = ceph_get_caps(ci, CEPH_CAP_FILE_RD, want, -1, &got, &pinned_page);
> +	if (err < 0)
> 		goto out_restore;
> 
> 	dout("filemap_fault %p %llu~%zd got cap refs on %s\n",
> @@ -1465,16 +1466,17 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
> 		ceph_add_rw_context(fi, &rw_ctx);
> 		ret = filemap_fault(vmf);
> 		ceph_del_rw_context(fi, &rw_ctx);
> +		dout("filemap_fault %p %llu~%zd drop cap refs %s ret %x\n",
> +			inode, off, (size_t)PAGE_SIZE,
> +				ceph_cap_string(got), ret);
> 	} else
> -		ret = -EAGAIN;
> +		err = -EAGAIN;
> 
> -	dout("filemap_fault %p %llu~%zd dropping cap refs on %s ret %d\n",
> -	     inode, off, (size_t)PAGE_SIZE, ceph_cap_string(got), ret);
> 	if (pinned_page)
> 		put_page(pinned_page);
> 	ceph_put_cap_refs(ci, got);
> 
> -	if (ret != -EAGAIN)
> +	if (err != -EAGAIN)
> 		goto out_restore;
> 
> 	/* read inline data */
> @@ -1482,7 +1484,6 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
> 		/* does not support inline data > PAGE_SIZE */
> 		ret = VM_FAULT_SIGBUS;
> 	} else {
> -		int ret1;
> 		struct address_space *mapping = inode->i_mapping;
> 		struct page *page = find_or_create_page(mapping, 0,
> 						mapping_gfp_constraint(mapping,
> @@ -1491,32 +1492,32 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
> 			ret = VM_FAULT_OOM;
> 			goto out_inline;
> 		}
> -		ret1 = __ceph_do_getattr(inode, page,
> +		err = __ceph_do_getattr(inode, page,
> 					 CEPH_STAT_CAP_INLINE_DATA, true);
> -		if (ret1 < 0 || off >= i_size_read(inode)) {
> +		if (err < 0 || off >= i_size_read(inode)) {
> 			unlock_page(page);
> 			put_page(page);
> -			if (ret1 < 0)
> -				ret = ret1;
> +			if (err == -ENOMEM)
> +				ret = VM_FAULT_OOM;
> 			else
> 				ret = VM_FAULT_SIGBUS;
> 			goto out_inline;
> 		}
> -		if (ret1 < PAGE_SIZE)
> -			zero_user_segment(page, ret1, PAGE_SIZE);
> +		if (err < PAGE_SIZE)
> +			zero_user_segment(page, err, PAGE_SIZE);
> 		else
> 			flush_dcache_page(page);
> 		SetPageUptodate(page);
> 		vmf->page = page;
> 		ret = VM_FAULT_MAJOR | VM_FAULT_LOCKED;
> out_inline:
> -		dout("filemap_fault %p %llu~%zd read inline data ret %d\n",
> +		dout("filemap_fault %p %llu~%zd read inline data ret %x\n",
> 		     inode, off, (size_t)PAGE_SIZE, ret);
> 	}
> out_restore:
> 	ceph_restore_sigs(&oldset);
> -	if (ret < 0)
> -		ret = (ret == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
> +	if (err < 0)
> +		ret = vmf_error(err);
> 
> 	return ret;
> }
> @@ -1524,7 +1525,7 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
> /*
>  * Reuse write_begin here for simplicity.
>  */
> -static int ceph_page_mkwrite(struct vm_fault *vmf)
> +static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
> {
> 	struct vm_area_struct *vma = vmf->vma;
> 	struct inode *inode = file_inode(vma->vm_file);
> @@ -1535,8 +1536,9 @@ static int ceph_page_mkwrite(struct vm_fault *vmf)
> 	loff_t off = page_offset(page);
> 	loff_t size = i_size_read(inode);
> 	size_t len;
> -	int want, got, ret;
> +	int want, got, err;
> 	sigset_t oldset;
> +	vm_fault_t ret = VM_FAULT_SIGBUS;
> 
> 	prealloc_cf = ceph_alloc_cap_flush();
> 	if (!prealloc_cf)
> @@ -1550,10 +1552,10 @@ static int ceph_page_mkwrite(struct vm_fault *vmf)
> 			lock_page(page);
> 			locked_page = page;
> 		}
> -		ret = ceph_uninline_data(vma->vm_file, locked_page);
> +		err = ceph_uninline_data(vma->vm_file, locked_page);
> 		if (locked_page)
> 			unlock_page(locked_page);
> -		if (ret < 0)
> +		if (err < 0)
> 			goto out_free;
> 	}
> 
> @@ -1570,9 +1572,9 @@ static int ceph_page_mkwrite(struct vm_fault *vmf)
> 		want = CEPH_CAP_FILE_BUFFER;
> 
> 	got = 0;
> -	ret = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, off + len,
> +	err = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, off + len,
> 			    &got, NULL);
> -	if (ret < 0)
> +	if (err < 0)
> 		goto out_free;
> 
> 	dout("page_mkwrite %p %llu~%zd got cap refs on %s\n",
> @@ -1590,13 +1592,13 @@ static int ceph_page_mkwrite(struct vm_fault *vmf)
> 			break;
> 		}
> 
> -		ret = ceph_update_writeable_page(vma->vm_file, off, len, page);
> -		if (ret >= 0) {
> +		err = ceph_update_writeable_page(vma->vm_file, off, len, page);
> +		if (err >= 0) {
> 			/* success.  we'll keep the page locked. */
> 			set_page_dirty(page);
> 			ret = VM_FAULT_LOCKED;
> 		}
> -	} while (ret == -EAGAIN);
> +	} while (err == -EAGAIN);
> 
> 	if (ret == VM_FAULT_LOCKED ||
> 	    ci->i_inline_version != CEPH_INLINE_NONE) {
> @@ -1610,14 +1612,14 @@ static int ceph_page_mkwrite(struct vm_fault *vmf)
> 			__mark_inode_dirty(inode, dirty);
> 	}
> 
> -	dout("page_mkwrite %p %llu~%zd dropping cap refs on %s ret %d\n",
> +	dout("page_mkwrite %p %llu~%zd dropping cap refs on %s ret %x\n",
> 	     inode, off, len, ceph_cap_string(got), ret);
> 	ceph_put_cap_refs(ci, got);
> out_free:
> 	ceph_restore_sigs(&oldset);
> 	ceph_free_cap_flush(prealloc_cf);
> -	if (ret < 0)
> -		ret = (ret == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
> +	if (err < 0)
> +		ret = vmf_error(err);
> 	return ret;
> }
> 

Applied, Thanks

Yan, Zheng

> -- 
> 1.9.1
> 

