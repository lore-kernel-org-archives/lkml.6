Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F334CECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A581B20BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QhvFEvk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A581B20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbeGQDsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 23:48:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52834 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbeGQDsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 23:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uh+yC8sZttwKRfsEBk+RnohXrDNjY/TvrKJwjLSgZRo=; b=QhvFEvk/sRZwFWWIvjtuXVC/H
        NwvXHQ1GvZ3merTgqhvA98FFJRxBvNoTAdclzIM/hxTC9Dl5Dhd9fr9xxsE+egF6ZdIoCUwsUPHtH
        1QmZO+iQBpgVxUB8eNwWzCKgg6ET8sMyxBRxolGT3998CeW5SEJBAtMmoZpWwYo04VrzVXMWVHzMq
        tv4RJihWVP5mt9X6scyCM7gM3d0vI4wYFrQ/5hzyEkaAwXZoGzEAXDlww1LhR5G0xBAAYQCM0wH9b
        S6j2Ztev0TfDMbVY64z6DkEcEnkPvn+h1i2wGrXgeDBaiQrNe2dN8Htp+4EnJgzdcpPyYlt3byvys
        KYGF+MBpg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffGVA-0000Nm-25; Tue, 17 Jul 2018 03:18:12 +0000
Date:   Mon, 16 Jul 2018 20:18:11 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ross Zwisler <ross.zwisler@linux.intel.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH 1/5] radix tree test suite: fix mapshift build target
Message-ID: <20180717031811.GD7934@bombadil.infradead.org>
References: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
 <20180503192430.7582-2-ross.zwisler@linux.intel.com>
 <20180715230052.GA6486@bombadil.infradead.org>
 <20180716160710.GA2287@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716160710.GA2287@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 10:07:10AM -0600, Ross Zwisler wrote:
> Incidentally, in the current linux/master the radix tree test suite again
> fails to build:
> 
>   $ make
>   sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < ../../../lib/radix-tree.c > radix-tree.c
>   sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < ../../../lib/idr.c > idr.c
>   cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o main.o main.c
>   cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o linux.o linux.c
>   cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o test.o test.c
>   cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o find_bit.o ../../lib/find_bit.c
>   cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o regression1.o regression1.c
>   cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o regression2.o regression2.c
>   cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o regression3.o regression3.c
>   cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o tag_check.o tag_check.c
>   cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o multiorder.o multiorder.c
>   cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o idr-test.o idr-test.c
>   cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o iteration_check.o iteration_check.c
>   cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o benchmark.o benchmark.c
>   cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o idr.o idr.c
>   cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o radix-tree.o radix-tree.c
>   idr.c:7:10: fatal error: linux/xarray.h: No such file or directory
>    #include <linux/xarray.h>
>             ^~~~~~~~~~~~~~~~
>   compilation terminated.

Umm.  I think I know the problem here.  I have a suspicion that either
Fedora or you have changed make to be parallel by default (or you're
lying to me and saying you typed 'make' when you actually typed 'make
-j4', but I'm pretty sure you wouldn't do that).  Because there's no
way you'd get this output if you were compiling with make -j1.

Indeed, if I revert your commit and then build with make -j4, I see the
same error as you.  I'll look at how to fix this properly tomorrow.
