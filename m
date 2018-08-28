Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DF1C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373F720880
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o0oUUrY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373F720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeH2B6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:58:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH2B6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KLDEt+uQCAiMUZcj+l7cWxyM2azHLk+NlXUdok09dRg=; b=o0oUUrY5xBqhwfs2emUh4eTb2
        JKYxAdgckP3sZ6m06c7N2Ye3X8Dfke+yH/XyAVmZBkUPc/7YxZxREGSijJFoQrk6fgqr14PnIrDwM
        sAYxMkJeJ3mBKEcBD66Hgtxog+o6sBkPeNQuud/gdfv3hlpOjRFEHPl8ZPtuA1z7SgvlIAiURsOsb
        aV8MiWph3saiiUFD3NYpMFLW45wpOylgqh9kC857WXEaGm1CAUEz5LfgeF0DQmSVMHX+tERgBcTQ8
        NYBmF+mhsrwdsSFC7wtYn3o0Xgpy8YTb6Jfqnqo27SS0QBx9VEPpk3BMqmfQ+LkA82RdmxXUjBtoZ
        X1eHU5+6g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fum67-000610-EN; Tue, 28 Aug 2018 22:04:27 +0000
Date:   Tue, 28 Aug 2018 15:04:27 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] cramfs: Convert to use vmf_insert_mixed
Message-ID: <20180828220427.GA11400@bombadil.infradead.org>
References: <20180828145728.11873-1-willy@infradead.org>
 <20180828145728.11873-2-willy@infradead.org>
 <nycvar.YSQ.7.76.1808281235060.10215@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1808281235060.10215@knanqh.ubzr>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 01:49:25PM -0400, Nicolas Pitre wrote:
> On Tue, 28 Aug 2018, Matthew Wilcox wrote:
> > -			ret = vm_insert_mixed(vma, vma->vm_start + off, pfn);
> > +			vmf = vmf_insert_mixed(vma, vma->vm_start + off, pfn);
> > +			if (vmf & VM_FAULT_ERROR) {
> > +				pages = i;
> > +				break;
> > +			}
> 
> I'd suggest this to properly deal with errers instead:
> 
> -			ret = vm_insert_mixed(vma, vma->vm_start + off, pfn);
> +			vmf = vmf_insert_mixed(vma, vma->vm_start + off, pfn);
> +			if (vmf & VM_FAULT_ERROR)
> +				ret = vm_fault_to_errno(vmf, 0);

By my reading of this function, the intent is actually to return 0
here and allow demand paging to work.  Of course, I've spent all of
twenty minutes staring at this function, so I defer to the maintainer.
I think you'd need to be running a make-memory-allocations-fail fuzzer
to hit this, so it's likely never been tested.

