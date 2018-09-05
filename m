Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB8AC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534782075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534782075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeIFB3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:29:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58894 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIFB3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:29:14 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4D583FA1;
        Wed,  5 Sep 2018 20:57:18 +0000 (UTC)
Date:   Wed, 5 Sep 2018 13:57:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Omar Sandoval <osandov@osandov.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: Re: [PATCH v3] proc/kcore: fix invalid memory access in multi-page
 read optimization
Message-Id: <20180905135717.ff763b34c4a3f1ca500d715b@linux-foundation.org>
In-Reply-To: <1536100702-28706-1-git-send-email-asmadeus@codewreck.org>
References: <1536100545-26905-1-git-send-email-asmadeus@codewreck.org>
        <1536100702-28706-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Sep 2018 00:38:22 +0200 Dominique Martinet <asmadeus@codewreck.org> wrote:

> The 'm' kcore_list item could point to kclist_head, and it is incorrect to
> look at m->addr / m->size in this case.
> There is no choice but to run through the list of entries for every address
> if we did not find any entry in the previous iteration
> 
> Reset 'm' to NULL in that case at Omar Sandoval's suggestion.
> 
> ...
>
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -464,6 +464,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  				ret = -EFAULT;
>  				goto out;
>  			}
> +			m = NULL;
>  		} else if (m->type == KCORE_VMALLOC) {
>  			vread(buf, (char *)start, tsz);
>  			/* we have to zero-fill user buffer even if no read */

lgtm.  Let's add a nice little why-were-doing-this?

--- a/fs/proc/kcore.c~proc-kcore-fix-invalid-memory-access-in-multi-page-read-optimization-v3-fix
+++ a/fs/proc/kcore.c
@@ -464,7 +464,7 @@ read_kcore(struct file *file, char __use
 				ret = -EFAULT;
 				goto out;
 			}
-			m = NULL;
+			m = NULL;	/* skip the list anchor */
 		} else if (m->type == KCORE_VMALLOC) {
 			vread(buf, (char *)start, tsz);
 			/* we have to zero-fill user buffer even if no read */
_

