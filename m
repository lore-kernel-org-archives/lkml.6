Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEED8C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7C121872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iNF33/Dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfAWSaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:30:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45683 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfAWSaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:30:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so1570180pfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 10:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mxVLM0hi0r57HRWjlFQ0MmFAI0ikleTkkJmNBfps9rk=;
        b=iNF33/DwQ1eZVRU0xNA5xiBwsrhYQPlwMi7GLJPS/Ejd6arZM4DeyoZATVO8GnzOYq
         Vqs5VS0WZiLL+hlimcO4TPxjgQkqlTzH96p3CVyikfzaVQcqRkpnMuhOgqtpZKS3/j7y
         be9OJNrw2dCgby0IEIsdEFEENGlJa0zJtJEOGiX+2a/c2N/FsE3VdXJrdzrav2hd9PUx
         J9n1p1VgibvLf2txM3Erk4T3sPsNKyexhdWhfOqjty9eBys8jjadBpzqb9bHPMgmqHph
         C8I+R6wDsWn+jAEAmYZsVZd/m6tWNLVZXLd5eJDpjgLa2i8Uvh9W4hab8/JLduMmlVYE
         X/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mxVLM0hi0r57HRWjlFQ0MmFAI0ikleTkkJmNBfps9rk=;
        b=HGHBcnEp9KdQC8bIKyADwgpbCLKqFMJS/8dpqOxSN53OaDiFFbKxHQUMX9Ib0AXxM1
         kGQcG3teC6bq+A63KDBTR2z10OCvd2nFQNROGmMAOVB2mjHH4H5XnXY6eabEr34Rtzri
         Wdm971XHLLpquyA8/l+c0gQvkSUsJDTwaUk19aeOfpZXDEPAYx2CXtV69WmZMsyA/Ju7
         S1ncM3gbsLTq9NAtoBnZVcRrbqfoGi0YcWs6r3ZkziQ+QZt/ZuZQDvuA9zk2uN2EeqqQ
         DpKSR8GOL+Wp29NAVy3kaOPnBC+tPmfsbah1I3JKuhBwxpItWiExWEo9INDplcnDd6Lc
         cvhw==
X-Gm-Message-State: AJcUukcFeq4GJNxDHtssR1E7garVAmC5Cj3SdyASQmFQNSGY0gfg7YAu
        BIS2eGzwbWTLdHCPq65aYIlVOA==
X-Google-Smtp-Source: ALg8bN4Ooc+HqZJWvq9MR0p9beWP1zswkvtG278YdYZreM+wkOeFxT1zP3k9MO4l4Clqm+4O7vxonw==
X-Received: by 2002:a62:4b4d:: with SMTP id y74mr3038129pfa.186.1548268210233;
        Wed, 23 Jan 2019 10:30:10 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id v2sm20745748pgs.0.2019.01.23.10.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 10:30:09 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gmNHs-00045g-JN; Wed, 23 Jan 2019 11:30:08 -0700
Date:   Wed, 23 Jan 2019 11:30:08 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Steve Wise <swise@chelsio.com>, Doug Ledford <dledford@redhat.com>,
        Raju Rangoju <rajur@chelsio.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iw_cxgb4: drop check - dead code
Message-ID: <20190123183008.GA15698@ziepe.ca>
References: <1547947633-10515-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547947633-10515-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 02:27:13AM +0100, Nicholas Mc Guire wrote:
> The kmalloc is called with  | __GFP_NOFAIL  so there is no point in
> checking the return value - it either returns valid storage or it would
> hang/terminate there. But it is not possible to say if the use of
> __GFP_NOFAIL is really needed and the check should be removed or
> vice-versa (use of __GFP_NOFAIL should be only in exceptional
> cases as I understand it and alloc_srq_queue() is called in quite
> a few places)
> In either way it would need fixing.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 6a0b6174d35a ("rdma/cxgb4: Add support for kernel mode SRQ's")
> ---

Steve? It seems weird to have NOFAIL and then have an error unwind
path, what is the deal here?

> diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
> index 917ce5c..c2a12ba 100644
> --- a/drivers/infiniband/hw/cxgb4/qp.c
> +++ b/drivers/infiniband/hw/cxgb4/qp.c
> @@ -2597,8 +2597,6 @@ static int alloc_srq_queue(struct c4iw_srq *srq, struct c4iw_dev_ucontext *uctx,
>  	wr_len = sizeof(*res_wr) + sizeof(*res);
>  
>  	skb = alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
> -	if (!skb)
> -		goto err_free_queue;
>  	set_wr_txq(skb, CPL_PRIORITY_CONTROL, 0);
>  
>  	res_wr = (struct fw_ri_res_wr *)__skb_put(skb, wr_len);
> -- 
> 2.1.4
> 
