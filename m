Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A5BC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F2B218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RGXr9WLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389793AbeLTVEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:04:50 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37917 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbeLTVEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:04:49 -0500
Received: by mail-qt1-f194.google.com with SMTP id p17so3430166qtl.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 13:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=40o5Oy7hDwmt2u6+dlhmoS7n7OKNWc5BjZgibEpQDOg=;
        b=RGXr9WLhK1buTTXJHJajtUgPlrUEOxrKtuQ4PrjbZMZmsvAN8c3rqfUUTgCy13uC/A
         WqfJItJU2+zXE2v2VFo1LxPRLhvY5uBDLhqFRCdeV23GQ3tW29tAfSIhY48FoUd9GlzE
         f2xGY0NBoFyKW5guhkvhjclikYP95/4ke2sov0QXpIuCWSgcn1rF4SbhlNNjAuV0YRjo
         ETlbCISSIgit7VjFS8ziKrNUe0Ep4+IzoxCj38tOtDt3o5BQb0Tl5w7Pf2AOkxAM7EXE
         9/kE2Biwtqjne10I1ST9Y9H8gtX3UTIe/LaxlNZKU0kg37eI0JIypd+fyAtn3Uht4IHv
         JysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=40o5Oy7hDwmt2u6+dlhmoS7n7OKNWc5BjZgibEpQDOg=;
        b=aOLNdfyU3muZxYIGUxR2RpLOW4M0aKyocNqM0F21780lqSJ5T73e2vzDSm3Zu5YRKu
         W+5JGye/rmvXISnHUOPTfvh8Ddsgn89EVJ5sKjHygLdXcWb+Xxsbn36uxmlI9MLVTD7D
         t7BzP5LrFqYNYvf+2L0bl2owITtUqP230o5jrbC6XKnRW0yiL4uuz4hyBD09WCNHocMB
         Fr2hBXu/37kOigNHHrtp/96ZRhiUat+sj3Y9EUYS5mbReDg8rUhZq518IG6QsGs0yrDw
         KhVp+FpVdfuu3QnJExS5BAPEu0edLsHHxMfK3uA5NdzOP8YHNEtpfdN7jAbhf3owdEzc
         IYBA==
X-Gm-Message-State: AA+aEWYvU04QPOJ/mxv8PA7zMWyBlrSev9uNhTfA+ZmA6UMZWGVkWX2o
        6rR/9XeqsGDwCE04ip0eGgp/1w==
X-Google-Smtp-Source: AFSGD/XbSTAr4I1DC+05jTpum05aDzoBFdNVh04bS9bxA1o3YaoP3QrygbYxrtJc8MyOKkPxD8jymQ==
X-Received: by 2002:a0c:9531:: with SMTP id l46mr27092597qvl.175.1545339888399;
        Thu, 20 Dec 2018 13:04:48 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x5sm4557736qtc.43.2018.12.20.13.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 13:04:47 -0800 (PST)
Message-ID: <1545339886.18411.31.camel@lca.pw>
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
From:   Qian Cai <cai@lca.pw>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        Pavel.Tatashin@microsoft.com, mingo@kernel.org, hpa@zytor.com,
        mgorman@techsingularity.net, iamjoonsoo.kim@lge.com,
        tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 20 Dec 2018 16:04:46 -0500
In-Reply-To: <E084FF0A-88CD-4E61-88F2-7D542D67DDF1@oracle.com>
References: <20181220185031.43146-1-cai@lca.pw>
         <20181220203156.43441-1-cai@lca.pw>
         <E084FF0A-88CD-4E61-88F2-7D542D67DDF1@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-20 at 14:00 -0700, William Kucharski wrote:
> > On Dec 20, 2018, at 1:31 PM, Qian Cai <cai@lca.pw> wrote:
> > 
> > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > index ae44f7adbe07..d76fd51e312a 100644
> > --- a/mm/page_ext.c
> > +++ b/mm/page_ext.c
> > @@ -399,9 +399,8 @@ void __init page_ext_init(void)
> > 			 * -------------pfn-------------->
> > 			 * N0 | N1 | N2 | N0 | N1 | N2|....
> > 			 *
> > -			 * Take into account DEFERRED_STRUCT_PAGE_INIT.
> > 			 */
> > -			if (early_pfn_to_nid(pfn) != nid)
> > +			if (pfn_to_nid(pfn) != nid)
> > 				continue;
> > 			if (init_section_page_ext(pfn, nid))
> > 				goto oom;
> > -- 
> > 2.17.2 (Apple Git-113)
> > 
> 
> Is there any danger in the fact that in the CONFIG_NUMA case in mmzone.h
> (around line 1261), pfn_to_nid() calls page_to_nid(), possibly causing the
> same issue seen in v2?
> 

No. If CONFIG_DEFERRED_STRUCT_PAGE_INIT=y, page_ext_init() is called after
page_alloc_init_late() where all the memory has already been initialized,
so page_to_nid() will work then.
