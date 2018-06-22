Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECB6C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882FC248E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YuJ/vtOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882FC248E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754566AbeFVVND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:13:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754537AbeFVVNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CLD6dnZ41aLBLUck+TNu4DPtRb0BkDHuB2R0mhNEnww=; b=YuJ/vtOW5D085m+U3hcGovr1N
        F7ejVIupjw930Pz2ebK7s+yphlLuPtBlEp6qg/lJiGDplitHTaJM3EnkBAIeMsqnoxpZouhjgykF4
        A6kgS3m/RxYCxc37R0zrb43mlTzOMMfRUjCDSjGINt77dttVRZBfs8yZaPWpmsSrp9pCE1C7ErWv2
        KLbbglOmERNQJ0DVSp3YTOK6Ohcf8am4e65F1WvQp3xcR9y3LG+oQ3OQ82jXRjTsBdk3A5yLlCF7e
        9cK9Z6B2yAirxFjQPcw9iRLXnJ86Cq7zCIze62ILXQiILXvI07+ci5Bc63sTHlD1PbVifO+WpaQW5
        dLlXbhcrg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWTMZ-0004QO-PK; Fri, 22 Jun 2018 21:12:59 +0000
Date:   Fri, 22 Jun 2018 14:12:59 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/26] fs: Convert unnamed_dev_ida to new API
Message-ID: <20180622211259.GB18630@bombadil.infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-6-willy@infradead.org>
 <a403bace-a7b4-aa3e-8fa7-4c47051a7916@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a403bace-a7b4-aa3e-8fa7-4c47051a7916@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:45:10PM -0700, Randy Dunlap wrote:
> > + * Context: Any context.  Frequently called while holding sb_lock.
> > + * Return: 0 on success, -EMFILE if there are no anonymous bdevs left
> > + * or -EAGAIN if memory allocation failed.
> 
> Looks to me like the code used to return -ENOMEM and used -EAGAIN as an
> internal retry code.
> 
> confused?  (/me)

Quite right.

+++ b/fs/super.c
@@ -989,7 +989,7 @@ static DEFINE_IDA(unnamed_dev_ida);
  *
  * Context: Any context.  Frequently called while holding sb_lock.
  * Return: 0 on success, -EMFILE if there are no anonymous bdevs left
- * or -EAGAIN if memory allocation failed.
+ * or -ENOMEM if memory allocation failed.
  */
 int get_anon_bdev(dev_t *p)
 {
@@ -1002,9 +1002,9 @@ int get_anon_bdev(dev_t *p)
        dev = ida_alloc_range(&unnamed_dev_ida, 1, (1 << MINORBITS) - 1,
                        GFP_ATOMIC);
        if (dev == -ENOSPC)
-               return -EMFILE;
+               dev = -EMFILE;
        if (dev < 0)
-               return -EAGAIN;
+               return dev;
 
        *p = MKDEV(0, dev);
        return 0;

