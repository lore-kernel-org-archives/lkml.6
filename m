Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26B5ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430DD2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="uQki5q84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430DD2152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbeITQso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:48:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43896 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeITQsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:48:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id q19-v6so3409846pgn.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 04:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y2uwsEGQ+BDYSb3DzxFrlsSXGgyFnLshtKaWsj8HMKU=;
        b=uQki5q84D5V98ziKis+wI+rterX2GzsmzRt//ioACPppa8+W9GimN/2aB4aco0mUSV
         XWJb7aelYzKW56np73uzch5bIPoGqidaCgfxNdy7gFsYb1eSNW68ee9uSIv7m77reY3e
         56jURtbMUFjSL1sDnQ0N1iDVUkUrg53F2hoE9ztxCaEz8lumHwLYLvSMLc21O07VbGMf
         P9OgZJvKwy95ROWiki88n94Ezavs7/wRfwra5BPWKDlsM/5hyg/I+ARvQzq02qF82GZh
         KxD32EgUpwypfj0KUe2auUibwfNYwV0pqEpIvpSXVuCOEmIC7T0T64mn85/S0gUGRvHe
         uB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y2uwsEGQ+BDYSb3DzxFrlsSXGgyFnLshtKaWsj8HMKU=;
        b=b/+5C/MzLU4/cDdj+gP/DHyD+U5GW6giWWbtSkRpOQliCz1nXYkKVgaMqd4kxzQSlS
         AmUUDNOYNvBjvoDSifv6Ut4XrJjuTTKO6uLvwhtAzfAGXzunWydFdUM7i66OrvBMAIJW
         a2WcD+1BxnWgIwHqD7YjwwlbK6Uc0TbBhlW0671JPl9mnT+K1XxPsHHcLXk46zJg041B
         oK6Z93gmPtEWhPfjv5/R/Vbu80IINPDkAwRhu9w/glcQo+JO9hW8k6tk5VbXNyben3iw
         xgA/MlrQ/KZavJ9CpHcfwJp+vQbPrhiw/XHAMeVGC7HeNMZWDFhrXycQMvn756id8RfI
         9GQA==
X-Gm-Message-State: APzg51CN9yqNyabnwLSPH44TRHRP7nX9MFM8YXd3aL8KnYXIA4ftK7lI
        /sY27Rz49wB2APNCkoSeRRpimg==
X-Google-Smtp-Source: ANB0VdapmfTtTmSoGSojcJeOw5fboGtLWV4EHXUfOV2X89NHLdqH6r8+sttsSZ2eY9uIEVGyuw2H6w==
X-Received: by 2002:a62:5b85:: with SMTP id p127-v6mr40840708pfb.33.1537441547048;
        Thu, 20 Sep 2018 04:05:47 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id c1-v6sm38343176pfg.25.2018.09.20.04.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 04:05:45 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 6A320300527; Thu, 20 Sep 2018 14:05:38 +0300 (+03)
Date:   Thu, 20 Sep 2018 14:05:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Recheck page table entry with page table lock held
Message-ID: <20180920110538.rlcpw75eabkqudkl@kshutemo-mobl1>
References: <20180920092408.9128-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920092408.9128-1-aneesh.kumar@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 02:54:08PM +0530, Aneesh Kumar K.V wrote:
> We clear the pte temporarily during read/modify/write update of the pte. If we
> take a page fault while the pte is cleared, the application can get SIGBUS. One
> such case is with remap_pfn_range without a backing vm_ops->fault callback.
> do_fault will return SIGBUS in that case.

It would be nice to show the path that clears pte temporarily.

> Fix this by taking page table lock and rechecking for pte_none.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  mm/memory.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c467102a5cbc..c2f933184303 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3745,10 +3745,33 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
>  	struct vm_area_struct *vma = vmf->vma;
>  	vm_fault_t ret;
>  
> -	/* The VMA was not fully populated on mmap() or missing VM_DONTEXPAND */
> -	if (!vma->vm_ops->fault)
> -		ret = VM_FAULT_SIGBUS;
> -	else if (!(vmf->flags & FAULT_FLAG_WRITE))
> +	/*
> +	 * The VMA was not fully populated on mmap() or missing VM_DONTEXPAND
> +	 */
> +	if (!vma->vm_ops->fault) {
> +
> +		/*
> +		 * pmd entries won't be marked none during a R/M/W cycle.
> +		 */
> +		if (unlikely(pmd_none(*vmf->pmd)))
> +			ret = VM_FAULT_SIGBUS;
> +		else {
> +			vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
> +			/*
> +			 * Make sure this is not a temporary clearing of pte
> +			 * by holding ptl and checking again. A R/M/W update
> +			 * of pte involves: take ptl, clearing the pte so that
> +			 * we don't have concurrent modification by hardware
> +			 * followed by an update.
> +			 */
> +			spin_lock(vmf->ptl);
> +			if (unlikely(pte_none(*vmf->pte)))
> +				ret = VM_FAULT_SIGBUS;
> +			else
> +				ret = VM_FAULT_NOPAGE;

We return 0 if we did nothing in fault path.

-- 
 Kirill A. Shutemov
