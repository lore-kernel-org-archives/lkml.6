Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959E1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508B321783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PNKxCRqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfAKXRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:17:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfAKXRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CqUrK5dNQEzXqROC1W6wTAlH6VB8x27DzSSJz0NWLaA=; b=PNKxCRqE8uKre6yZ5mT4/I1c1
        bvKOeLTqnmOUbxaqEWvawGxK3QjgzVohm/VDasY1WtbMMgLj3/Nvd6lSlAymxjGrEIalUj6zuWea4
        fpETwvZWV9x+Dtyj0Ke8EOjKofcI3Z8BeJxiNSexYAZ36xpVw8glRbxLm4N1zlfmSP0cVDARTb0jz
        aHVp3rV0GbRSXLBULKV0xXJWAb5cDfKYODa/eVJRYZd+PcR7F0QrlXgiWbdliZx8qUthYIBXLArB6
        yqlB6yIRZZwiXZawAe8Yj99xfqn0xnu+tN6go4xBdxBZZs12NfsXPdATPOIb4jg2HHnxk/RzsY2WV
        TziJUY5dA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gi62m-000375-Cm; Fri, 11 Jan 2019 23:16:52 +0000
Date:   Fri, 11 Jan 2019 15:16:52 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, esploit@protonmail.ch,
        jejb@linux.ibm.com, dgilbert@interlog.com,
        martin.petersen@oracle.com, joeypabalinas@gmail.com,
        walken@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rbtree: fix the red root
Message-ID: <20190111231652.GN6310@bombadil.infradead.org>
References: <20190111181600.GJ6310@bombadil.infradead.org>
 <20190111205843.25761-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111205843.25761-1-cai@lca.pw>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 03:58:43PM -0500, Qian Cai wrote:
> diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
> index b7055b2a07d3..afad0213a117 100644
> --- a/lib/rbtree_test.c
> +++ b/lib/rbtree_test.c
> @@ -345,6 +345,17 @@ static int __init rbtree_test_init(void)
>  		check(0);
>  	}
>  
> +	/*
> +	 * a little regression test to catch a bug may be introduced by
> +	 * 6d58452dc06 (rbtree: adjust root color in rb_insert_color() only when
> +	 * necessary)
> +	 */
> +	insert(nodes, &root);
> +	nodes->rb.__rb_parent_color = RB_RED;
> +	insert(nodes + 1, &root);
> +	erase(nodes + 1, &root);
> +	erase(nodes, &root);

That's not a fair test!  You're poking around in the data structure to
create the situation.  This test would have failed before 6d58452dc06 too.
How do we create a tree that has a red parent at root, only using insert()
and erase()?
