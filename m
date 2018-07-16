Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE59ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0947F2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0947F2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbeGPQfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:35:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:2041 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbeGPQfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:35:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 09:07:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,361,1526367600"; 
   d="scan'208";a="65077952"
Received: from theros.lm.intel.com (HELO linux.intel.com) ([10.232.112.164])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jul 2018 09:07:11 -0700
Date:   Mon, 16 Jul 2018 10:07:10 -0600
From:   Ross Zwisler <ross.zwisler@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org
Cc:     Ross Zwisler <ross.zwisler@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH 1/5] radix tree test suite: fix mapshift build target
Message-ID: <20180716160710.GA2287@linux.intel.com>
References: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
 <20180503192430.7582-2-ross.zwisler@linux.intel.com>
 <20180715230052.GA6486@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715230052.GA6486@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 04:00:52PM -0700, Matthew Wilcox wrote:
> On Thu, May 03, 2018 at 01:24:26PM -0600, Ross Zwisler wrote:
> > The following commit
> > 
> >   commit c6ce3e2fe3da ("radix tree test suite: Add config option for map
> >   shift")
> > 
> > Introduced a phony makefile target called 'mapshift' that ends up
> > generating the file generated/map-shift.h.  This phony target was then
> > added as a dependency of the top level 'targets' build target, which is
> > what is run when you go to tools/testing/radix-tree and just type 'make'.
> > 
> > Unfortunately, this phony target doesn't actually work as a dependency, so
> > you end up getting:
> > 
> > $ make
> > make: *** No rule to make target 'generated/map-shift.h', needed by 'main.o'.  Stop.
> > make: *** Waiting for unfinished jobs....
> > 
> > Fix this by making the file generated/map-shift.h our real makefile target,
> > and add this a dependency of the top level build target.
> 
> This commit breaks typing 'make SHIFT=6'.  It doesn't rebuild the
> test suite any more.  If I revert this patch, it works.  Also, I can't
> reproduce the problem you're reporting here.  So ... how do I reproduce
> it?  Otherwise, I'm just going to revert this patch since it regresses
> a feature I find useful.

The test suite builds fine for me in v4.17.  From a completely clean tree, in
tools/testing/radix-tree:

  $ make
  sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < ../../../lib/radix-tree.c > radix-tree.c
  sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < ../../../lib/idr.c > idr.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o main.o main.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o linux.o linux.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o test.o test.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o find_bit.o ../../lib/find_bit.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o regression1.o regression1.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o regression2.o regression2.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o regression3.o regression3.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o tag_check.o tag_check.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o multiorder.o multiorder.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o idr-test.o idr-test.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o iteration_check.o iteration_check.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o benchmark.o benchmark.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o idr.o idr.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o radix-tree.o radix-tree.c
  cc -fsanitize=address  multiorder.o radix-tree.o idr.o linux.o test.o find_bit.o  -lpthread -lurcu -o multiorder
  cc -fsanitize=address  main.o radix-tree.o idr.o linux.o test.o find_bit.o regression1.o regression2.o regression3.o tag_check.o multiorder.o idr-test.o iteration_check.o benchmark.o  -lpthread -lurcu -o main
  cc -fsanitize=address  idr-test.o radix-tree.o idr.o linux.o test.o find_bit.o  -lpthread -lurcu -o idr-test

and you can successfully run the radix tree test suite by running 'main'.

With the above mentioned commit reverted, this build fails:

  $ make
  make: *** No rule to make target 'generated/map-shift.h', needed by 'main.o'.  Stop.
  make: *** Waiting for unfinished jobs....

If you want generated/map-shift.h to be rebuilt each time you run 'make' so
that it can take a new SHIFT argument, that's fine, but let's not make users
run 'make mapshift' before an actual 'make' will work, which is where we're at
with v4.17 with my commit reverted.

Incidentally, in the current linux/master the radix tree test suite again
fails to build:

  $ make
  sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < ../../../lib/radix-tree.c > radix-tree.c
  sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < ../../../lib/idr.c > idr.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o main.o main.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o linux.o linux.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o test.o test.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o find_bit.o ../../lib/find_bit.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o regression1.o regression1.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o regression2.o regression2.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o regression3.o regression3.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o tag_check.o tag_check.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o multiorder.o multiorder.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o idr-test.o idr-test.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o iteration_check.o iteration_check.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o benchmark.o benchmark.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o idr.o idr.c
  cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address   -c -o radix-tree.o radix-tree.c
  idr.c:7:10: fatal error: linux/xarray.h: No such file or directory
   #include <linux/xarray.h>
            ^~~~~~~~~~~~~~~~
  compilation terminated.
  make: *** [<builtin>: idr.o] Error 1

Can you look into this?  

0-day folks, would it be possible for you to add a radix tree build & test
runs to your automated tests?  We would really appreciate any help in reducing
this kind of breakage, which seems to happen pretty often.
