Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5DEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B38520869
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TkuS7n/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B38520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeH1VmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:42:12 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44051 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH1VmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:42:12 -0400
Received: by mail-qt0-f193.google.com with SMTP id k38-v6so2680773qtk.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fkLBf0mt6rIUOjKi+HyEd3CtJE9o4jMq+rTZDSd//zs=;
        b=TkuS7n/x4pGRXb/Xvy51eyXadOFdycKF6X3V8ce31ypZg1SzA1cKPT5e9SQQIGN/gl
         ykibjzaFqAYkedS9Il/Az2/uteGVseUuis0Q9LWJJ6k9J0BOh5VnQvbFX8l6qEav5z0m
         lx5sU9OKJB5k1OXhQwrwskFGxaSn/sgsb0X6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fkLBf0mt6rIUOjKi+HyEd3CtJE9o4jMq+rTZDSd//zs=;
        b=iPRSiZtg0KkLf6yhNPSxkl+kVh3tXZKdi73MwbQPU5wNhke084q3ZX+ad9BxCmDjCf
         aXPXkwWr0JMsh3f4udBiT4W8ZVstbbOvcT6KkA3fEKYbWEv64yvfu1Vxs8xqmhOC75M1
         /b9V/7JzgGWfpH2m56VLBaGnPv6oGguvSePbUUxT9JfJt7S8VboJHByNrH1InUh7XSYH
         MW345T7UsFj7elZnULn2yyJ6gJiEz4B87lY86rTuitTpyULCYXbTFKgFYQ2ST2G1R0zS
         pg+CNGPPlHV+yKSm8+uPfUG/c0CH/DfPCEUhkPL8a3HfviVfbgmgkc2Q/OHEDNvbgCO5
         WVEw==
X-Gm-Message-State: APzg51Boaz9HG94uAKgGjiZEe3YBhYhRDdg8D2XFvlFQgkyV+0shAGSk
        ll+xfPn7a6o3N3q8D5xAdghfpr1qEgU=
X-Google-Smtp-Source: ANB0VdaOBH90CDAqym2DIeAo0nrfZ67mkaltkFDl2/RBasw+okmYYhXnVB7aFs+pRZUXKwhQ+KpEJw==
X-Received: by 2002:ac8:7311:: with SMTP id x17-v6mr2877274qto.204.1535478567127;
        Tue, 28 Aug 2018 10:49:27 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id a26-v6sm1023194qtc.74.2018.08.28.10.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 10:49:26 -0700 (PDT)
Date:   Tue, 28 Aug 2018 13:49:25 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Matthew Wilcox <willy@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] cramfs: Convert to use vmf_insert_mixed
In-Reply-To: <20180828145728.11873-2-willy@infradead.org>
Message-ID: <nycvar.YSQ.7.76.1808281235060.10215@knanqh.ubzr>
References: <20180828145728.11873-1-willy@infradead.org> <20180828145728.11873-2-willy@infradead.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018, Matthew Wilcox wrote:

> cramfs is the only remaining user of vm_insert_mixed; convert it.
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---
>  fs/cramfs/inode.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index f408994fc632..b72449c19cd1 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -417,10 +417,15 @@ static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
>  		 */
>  		int i;
>  		vma->vm_flags |= VM_MIXEDMAP;
> -		for (i = 0; i < pages && !ret; i++) {
> +		for (i = 0; i < pages; i++) {
> +			vm_fault_t vmf;
>  			unsigned long off = i * PAGE_SIZE;
>  			pfn_t pfn = phys_to_pfn_t(address + off, PFN_DEV);
> -			ret = vm_insert_mixed(vma, vma->vm_start + off, pfn);
> +			vmf = vmf_insert_mixed(vma, vma->vm_start + off, pfn);
> +			if (vmf & VM_FAULT_ERROR) {
> +				pages = i;
> +				break;
> +			}

I'd suggest this to properly deal with errers instead:

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index f408994fc6..0c35e62f10 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -418,9 +418,12 @@ static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
 		int i;
 		vma->vm_flags |= VM_MIXEDMAP;
 		for (i = 0; i < pages && !ret; i++) {
+			vm_fault_t vmf;
 			unsigned long off = i * PAGE_SIZE;
 			pfn_t pfn = phys_to_pfn_t(address + off, PFN_DEV);
-			ret = vm_insert_mixed(vma, vma->vm_start + off, pfn);
+			vmf = vmf_insert_mixed(vma, vma->vm_start + off, pfn);
+			if (vmf & VM_FAULT_ERROR)
+				ret = vm_fault_to_errno(vmf, 0);
 		}
 	}
 

Nicolas
