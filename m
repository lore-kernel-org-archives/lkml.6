Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4844C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC0D20839
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC0D20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeHaDi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 23:38:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeHaDi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 23:38:29 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5FDA7E29;
        Thu, 30 Aug 2018 23:33:53 +0000 (UTC)
Date:   Thu, 30 Aug 2018 16:33:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     konishi.ryusuke@lab.ntt.co.jp, viro@zeniv.linux.org.uk,
        tytso@mit.edu, adilger.kernel@dilger.ca, axboe@kernel.dk,
        darrick.wong@oracle.com, ebiggers@google.com, pombredanne@nexb.com,
        agruenba@redhat.com, gregkh@linuxfoundation.org,
        kemi.wang@intel.com, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: Re: [PATCH v2] fs: Convert return type int to vm_fault_t
Message-Id: <20180830163352.5a96cc721ce069bed95fdbe8@linux-foundation.org>
In-Reply-To: <20180830172547.GA4408@jordon-HP-15-Notebook-PC>
References: <20180830172547.GA4408@jordon-HP-15-Notebook-PC>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 22:55:47 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:

> Return type for fault handlers  in ext4 and nilfs are
> changed to use vm_fault_t.
> 
> Return type of block_page_mkwrite() is changed from
> int to vm_fault_t. The function signature of
> block_page_mkwrite() is changed to add one new parameter
> int *err. This will provide a way for caller functions
> to get error value along with return value and use it
> further.
> 
> Return type of block_page_mkwrite_return() is also changed
> to use new vm_fault_t type.
> --- a/fs/nilfs2/file.c
> +++ b/fs/nilfs2/file.c
> @@ -51,13 +51,14 @@ int nilfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>  	return err;
>  }
>  
> -static int nilfs_page_mkwrite(struct vm_fault *vmf)
> +static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)

nilfs_page_mkwrite() already has return type vm_fault_t in Linus's
kernel, due to the now-merged
fs-nilfs2-adding-new-return-type-vm_fault_t.patch.  Looks like a simple
fix.

I'm beginning to feel vm_fault_t exhaustion.  Please remind me what
benefit we're going to get out of all this churn?

> 
> ...
>
