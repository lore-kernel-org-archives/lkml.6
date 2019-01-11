Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D68AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20DD2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lTCr9aGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbfAKSQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:16:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46526 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfAKSQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Nmx4asMzroV5sBI0wqplHX3gob/sn7xzkvUWEPDo4YU=; b=lTCr9aGG28zQaVC/ak9w+BxbBq
        Yl6l4kuGG4gV8wGelcfDSp/tx+qs1FzJJdpZ753xYJXbGv1FINzBAx3qH0McDCjGEC4dbeiTAULud
        3Ofv2ZNrZFXaVaVAwuLQcdZCvSMX+Edz/X7N2Gi2d5pi8CfYgvYvOR89CBOgUd/aPSqJqCx/H9495
        +PCa105LqDzWedVTQCcoXt+KmENBUcHRFeQhK8DShVKMVoy320P1jUvG+hGjabTYThv2LCyG+3l2G
        +e4mNscbG0l/26QPj+THE81fHfhwrVWhhDoJp9YaO6TGZk5l4cIZLO0ikROozRkAYrH1qu58NRYkp
        Qksf27cA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gi1Lc-0000qm-Ns; Fri, 11 Jan 2019 18:16:00 +0000
Date:   Fri, 11 Jan 2019 10:16:00 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, esploit@protonmail.ch,
        jejb@linux.ibm.com, dgilbert@interlog.com,
        martin.petersen@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, walken@google.com,
        David.Woodhouse@intel.com
Subject: Re: [PATCH] rbtree: fix the red root
Message-ID: <20190111181600.GJ6310@bombadil.infradead.org>
References: <YrcPMrGmYbPe_xgNEV6Q0jqc5XuPYmL2AFSyeNmg1gW531bgZnBGfEUK5_ktqDBaNW37b-NP2VXvlliM7_PsBRhSfB649MaW1Ne7zT9lHc=@protonmail.ch>
 <20190111165145.23628-1-cai@lca.pw>
 <20190111173132.GH6310@bombadil.infradead.org>
 <1547230356.6911.23.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547230356.6911.23.camel@lca.pw>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 01:12:36PM -0500, Qian Cai wrote:
> On Fri, 2019-01-11 at 09:31 -0800, Matthew Wilcox wrote:
> > On Fri, Jan 11, 2019 at 11:51:45AM -0500, Qian Cai wrote:
> > > Reported-by: Esme <esploit@protonmail.ch>
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> > 
> > What change introduced this bug?  We need a Fixes: line so the stable
> > people know how far to backport this fix.
> 
> It looks like,
> 
> Fixes: 6d58452dc06 (rbtree: adjust root color in rb_insert_color() only when
> necessary)
> 
> where it no longer always paint the root as black.
> 
> Also, copying this fix for the original author and reviewer.
> 
> https://lore.kernel.org/lkml/20190111165145.23628-1-cai@lca.pw/

Great, thanks!  We have a test-suite (lib/rbtree_test.c); could you add
a test to it that will reproduce this bug without your patch applied?

