Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D63BC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C611F223A6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C611F223A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeHJEJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 00:09:38 -0400
Received: from nautica.notk.org ([91.121.71.147]:51515 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725724AbeHJEJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 00:09:38 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id ED6F2C01B; Fri, 10 Aug 2018 03:42:02 +0200 (CEST)
Date:   Fri, 10 Aug 2018 03:41:47 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>
Cc:     v9fs-developer@lists.sourceforge.net,
        Dominique Martinet <dominique.martinet@cea.fr>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 2/2] net/9p: add a per-client fcall kmem_cache
Message-ID: <20180810014147.GB14699@nautica>
References: <1533177452-2165-1-git-send-email-asmadeus@codewreck.org>
 <1533825236-22896-1-git-send-email-asmadeus@codewreck.org>
 <1533825236-22896-2-git-send-email-asmadeus@codewreck.org>
 <5B6CE900.1010103@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B6CE900.1010103@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piaojun wrote on Fri, Aug 10, 2018:
> Could you help paste the test result of before-after-applied this patch in
> comment? And please see my comments below.

Thanks the the review, do you mean the commit message?

I'll add the summary I wrote in reply to your question a few mails
before.


> > diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
> > index e23896116d9a..645266b74652 100644
> > --- a/include/net/9p/9p.h
> > +++ b/include/net/9p/9p.h
> > @@ -336,6 +336,9 @@ enum p9_qid_t {
> >  #define P9_NOFID	(u32)(~0)
> >  #define P9_MAXWELEM	16
> >  
> > +/* Minimal header size: len + id + tag */
> 
> Here should be 'size + id + tag'.

hm I didn't want to repeat size, but I guess people do refer to that
field as size.
I'll actually rewrite it as:
 Minimal header size: size[4] type[1] tag[2]

> > +	kmem_cache_destroy(clnt->fcall_cache);
> 
> I'm afraid that we should check NULL for clnt->fcall_cache.

kmem_cache_destroy() in mm/slab_common.c does the null check for us:
------
void kmem_cache_destroy(struct kmem_cache *s)
{
        int err;
        
        if (unlikely(!s))
                return;
------

-- 
Dominique
