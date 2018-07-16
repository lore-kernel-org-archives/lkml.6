Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D157ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C10208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eXQ4rBPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C10208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbeGPUVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 16:21:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbeGPUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 16:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vgru6mCXblOtVcGBcYglADQgqrK9xp8e8cVQc7K986Q=; b=eXQ4rBPAUBsHn2QUgW7KcYARb
        TRJd5jYAOfh4PH/hmoBf0WS/2VlMDxKOxQD9bDQW9i3WLTE2h96zLDgBerDrPUb1CMe0Brh9UHvm9
        TDzxQ6I+iY4NY6gjzxMNSWleq/sZ0Z9srqUu6ZvRkleAf/RzZAe1nd4OvcS+kFR7+om9A9Q58hKmh
        o1e1OIfo/MdUqpxNrDLXZAzX/oL2U6AwYsLu14xTtsMWhRnho4y3AVIYifSAnKo4DhAyCEyh6g3pI
        T32O9k1WRKIKUuEiuBPJ6vRWBaJOOU+aps1kMbAopCnxvxs6yMK+UO0PDtxhlYX4/jPq6C8HPW7d5
        ytT2J5pLg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ff9Y9-0000EI-60; Mon, 16 Jul 2018 19:52:49 +0000
Date:   Mon, 16 Jul 2018 12:52:49 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ross Zwisler <ross.zwisler@linux.intel.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH 1/5] radix tree test suite: fix mapshift build target
Message-ID: <20180716195249.GA14380@bombadil.infradead.org>
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
> On Sun, Jul 15, 2018 at 04:00:52PM -0700, Matthew Wilcox wrote:
> > On Thu, May 03, 2018 at 01:24:26PM -0600, Ross Zwisler wrote:
> > > Unfortunately, this phony target doesn't actually work as a dependency, so
> > > you end up getting:
> > > 
> > > $ make
> > > make: *** No rule to make target 'generated/map-shift.h', needed by 'main.o'.  Stop.
> > > make: *** Waiting for unfinished jobs....
> > > 
> > > Fix this by making the file generated/map-shift.h our real makefile target,
> > > and add this a dependency of the top level build target.
> > 
> > This commit breaks typing 'make SHIFT=6'.  It doesn't rebuild the
> > test suite any more.  If I revert this patch, it works.  Also, I can't
> > reproduce the problem you're reporting here.  So ... how do I reproduce
> > it?  Otherwise, I'm just going to revert this patch since it regresses
> > a feature I find useful.
> 
> The test suite builds fine for me in v4.17.  From a completely clean tree, in
> tools/testing/radix-tree:
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
>   cc -fsanitize=address  multiorder.o radix-tree.o idr.o linux.o test.o find_bit.o  -lpthread -lurcu -o multiorder
>   cc -fsanitize=address  main.o radix-tree.o idr.o linux.o test.o find_bit.o regression1.o regression2.o regression3.o tag_check.o multiorder.o idr-test.o iteration_check.o benchmark.o  -lpthread -lurcu -o main
>   cc -fsanitize=address  idr-test.o radix-tree.o idr.o linux.o test.o find_bit.o  -lpthread -lurcu -o idr-test
> 
> and you can successfully run the radix tree test suite by running 'main'.
> 
> With the above mentioned commit reverted, this build fails:
> 
>   $ make
>   make: *** No rule to make target 'generated/map-shift.h', needed by 'main.o'.  Stop.
>   make: *** Waiting for unfinished jobs....

OK ... what version of make are you using?  Because this works fine for me:

$ git clone linux clean
$ cd clean
$ git checkout v4.17
$ cd tools/testing/radix-tree/ 
$ git revert 8d9fa88edd5e360b71765feeadb915d4066c9684
$ make

$ make --version
GNU Make 4.1
Built for x86_64-pc-linux-gnu

It's Debian's Version: 4.1-9.1

> If you want generated/map-shift.h to be rebuilt each time you run 'make' so
> that it can take a new SHIFT argument, that's fine, but let's not make users
> run 'make mapshift' before an actual 'make' will work, which is where we're at
> with v4.17 with my commit reverted.

I don't want it to be rebuilt, I want it to be checked before each
build, regenerated if SHIFT has changed, and everything to rebuild if
it has changed.

> Incidentally, in the current linux/master the radix tree test suite again
> fails to build:
> 
>   cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o radix-tree.o radix-tree.c
>   idr.c:7:10: fatal error: linux/xarray.h: No such file or directory
>    #include <linux/xarray.h>
>             ^~~~~~~~~~~~~~~~
>   compilation terminated.
>   make: *** [<builtin>: idr.o] Error 1
> 
> Can you look into this?  

Ah ... Andrew broke it fixing something else ;-)  The first commit in
my xarray branch fixes it -- looks like I tested my own commits but not
the commit I based on ;-)

diff --git a/tools/testing/radix-tree/linux/xarray.h b/tools/testing/radix-tree/linux/xarray.h
new file mode 100644
index 000000000000..df3812cda376
--- /dev/null
+++ b/tools/testing/radix-tree/linux/xarray.h
@@ -0,0 +1,2 @@
+#include "generated/map-shift.h"
+#include "../../../../include/linux/xarray.h"


> 0-day folks, would it be possible for you to add a radix tree build & test
> runs to your automated tests?  We would really appreciate any help in reducing
> this kind of breakage, which seems to happen pretty often.

Yeah, that would be good.
