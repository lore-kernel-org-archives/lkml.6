Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1308C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A9921479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fL4X30ox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A9921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbeLFWIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:08:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44360 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLFWIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:08:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so834876pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 14:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Jc4+r1+KRNg5ApN7yRaVR3YMPcB24dDfcf2dtVWpBg4=;
        b=fL4X30oxB9nzFzEsZ47WWvxj2ZUlOeCT3FnenxMkNAK4GnydAizWg9Tft8RwsYKRnH
         XGoafSPTW2oQytSHRjeBS8r9XYjrTq9NhkIYCBfU1HvDE3pMb97IlNBb3ziO/xHJjUia
         t4mOP5lOF4spj/B0hDqxehjdjZjWEU5t3KL4/BZRT+Gpa+rl5yT8mGQsYmivPmp69ChW
         P9r5uJV+JVGjoa22ieGStlKRsigyyLg3u3oOYc/cLiVLNqadVwSvSn1kcy4s0blSCt5B
         pxQagb1RTy+r2X4qJu3jiUYDNLgjQhoU/jOPMYNmorP96jTY0L/vs18OIQR88x/Cl56v
         +xMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Jc4+r1+KRNg5ApN7yRaVR3YMPcB24dDfcf2dtVWpBg4=;
        b=CK+ZYH3QUgk68mtnRIYLfjNxXmNx+5nf4Dfv9yGvGWFG9i0oNI9RkO4nYfxmoWchEd
         J6mxdRvmz7p9McxGEp1yxO9b54YiwD0PiI+W9plMCRFEX+OSWFx4bmbPslZR2wfR+Iu3
         8pJMdN+w54adsazwBKgoCdDZCh8mLITwd5FoF+IBfLmCrk5IVuwrht6c4763U8iERBN4
         HGSVukrTBeu4S1DPSX0Ty+3KuYrp1JTeIOaquuS8MabYEuVOz3uUP1pcquu5Sdt/uQ2o
         dtTcOHw1xnZpkAGQdo6AZbFZvC3s74xWAiLRpZ1DRUYN8AutjjK1Sk6oMkOj/WP7Kmjk
         tcDA==
X-Gm-Message-State: AA+aEWYPnO54K0GgexWGLNPTdamdZexQPD1Ngsr4TmX09fEPfg5SVqLt
        Lfr/cqpop0sA8NKU7O8UzCct43LJFvo=
X-Google-Smtp-Source: AFSGD/VkifSFyr0IeDsv/q59Uxn/vzSFwvkRER2tW3Irc4RidDF8f+aLTpKDaCExQ6I2Hcq7BNA3ng==
X-Received: by 2002:a62:16d6:: with SMTP id 205mr30154729pfw.256.1544134080922;
        Thu, 06 Dec 2018 14:08:00 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id 85sm1759798pfw.17.2018.12.06.14.07.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 14:08:00 -0800 (PST)
Date:   Thu, 6 Dec 2018 14:07:51 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jann Horn <jannh@google.com>, Peter Xu <peterx@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/1] userfaultfd: check VM_MAYWRITE was set after verifying
 the uffd is registered
In-Reply-To: <20181206212028.18726-2-aarcange@redhat.com>
Message-ID: <alpine.LSU.2.11.1812061406300.1616@eggly.anvils>
References: <20181206212028.18726-1-aarcange@redhat.com> <20181206212028.18726-2-aarcange@redhat.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018, Andrea Arcangeli wrote:

> Calling UFFDIO_UNREGISTER on virtual ranges not yet registered in uffd
> could trigger an harmless false positive WARN_ON. Check the vma is
> already registered before checking VM_MAYWRITE to shut off the
> false positive warning.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 29ec90660d68 ("userfaultfd: shmem/hugetlbfs: only allow to register VM_MAYWRITE vmas")
> Reported-by: syzbot+06c7092e7d71218a2c16@syzkaller.appspotmail.com
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>

Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  fs/userfaultfd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index cd58939dc977..7a85e609fc27 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1566,7 +1566,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  		cond_resched();
>  
>  		BUG_ON(!vma_can_userfault(vma));
> -		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
>  
>  		/*
>  		 * Nothing to do: this vma is already registered into this
> @@ -1575,6 +1574,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  		if (!vma->vm_userfaultfd_ctx.ctx)
>  			goto skip;
>  
> +		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
> +
>  		if (vma->vm_start > start)
>  			start = vma->vm_start;
>  		vma_end = min(end, vma->vm_end);
> 
