Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1156BC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24ED208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dD/A+y/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24ED208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLGBlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:41:00 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:41324 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGBlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:41:00 -0500
Received: by mail-pf1-f173.google.com with SMTP id b7so1084993pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 17:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rdQMAag42WIh6sWwSVc114NUpg7aB2gq0mS9tdQMK5M=;
        b=dD/A+y/OaWqgJYJoRW8nOyV6X4wOp9QU8xZVE6zrZKhtHmxgfO02gM/zkhJRLTtxjc
         8fdpr1hTRhdTyee9lRr+I3x3tDDUcxWM33/6gkUytGDjHj7L7J3VueV6LHH+bCeMB/CH
         hU0tpx5INr0qKH8YupsfKx1K041YdxaXoa0OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rdQMAag42WIh6sWwSVc114NUpg7aB2gq0mS9tdQMK5M=;
        b=SU4sIieWGUIEz+G3PYVURYZt157Bq/4mnbw4g4YJQawOc2a8E63j97BajQBMDFFUoP
         4+W3+Vkyt+aBy9ZVzrG6HKvK8/z+QBqariCi3+l8v58qZNI4GdJfMpAl4wEuGNCE4I8m
         kdgLxZC9hsrZd19D+wVNZ9YhlVi3hUz86ei4BFvvNSIpEvlFVA44jaBPvxSk8joDjfrs
         7k+6GcMTvty1iMYagSXvSfBN337EqDDMne/nBx6VaBaYM8mMZHq8h2VuKpMTJHUqtNrv
         nGKqLhSqN7xHUk9FhqnCHn6SYrrGQvbrSoTPhl1pHapVcqDm7ZF8BwsXgYqm2xVKP+73
         7cfw==
X-Gm-Message-State: AA+aEWYTyC0wouZuC6wyMD1GVHg4uuYRJFRi1CYptM1esh7ArjTvdzkL
        Q51ckpOKvd8lkZFpDJ0OtS2/jg==
X-Google-Smtp-Source: AFSGD/U2dL8RZDcQsBinURn3VPAoo/B4dU/fXSeO2fsL+wbHy6pOaFMkRxB5VW5FnGwwvPLRfJIkYg==
X-Received: by 2002:a62:1709:: with SMTP id 9mr272611pfx.249.1544146858813;
        Thu, 06 Dec 2018 17:40:58 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id x7sm1777232pga.68.2018.12.06.17.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 17:40:57 -0800 (PST)
Date:   Thu, 6 Dec 2018 17:40:57 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 powerpc tree
Message-ID: <20181207014057.GA214249@google.com>
References: <20181206174417.45fe3e7a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206174417.45fe3e7a@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 05:44:17PM +1100, Stephen Rothwell wrote:
> Hi Andrew,
> 
> Today's linux-next merge of the akpm-current tree got conflicts in:
> 
>   arch/powerpc/include/asm/book3s/32/pgalloc.h
>   arch/powerpc/include/asm/nohash/32/pgalloc.h
>   arch/powerpc/mm/pgtable-book3s64.c
> 
> between commits:
> 
>   a95d133c8643 ("powerpc/mm: Move pte_fragment_alloc() to a common location")
>   32ea4c149990 ("powerpc/mm: Extend pte_fragment functionality to PPC32")
> 
> from the powerpc tree and commit:
> 
>   913c2d755b39 ("mm: treewide: remove unused address argument from pte_alloc functions")
> 
> from the akpm-current tree.
> 
> I fixed it up (see below, plus the extra merge fix patch) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

The conflict resolution looks good to me.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel
