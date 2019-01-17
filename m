Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A38AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D83520851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfAQRUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:20:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfAQRUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:20:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 553A681DED;
        Thu, 17 Jan 2019 17:20:10 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A702B61B63;
        Thu, 17 Jan 2019 17:20:07 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, thomas.lendacky@amd.com,
        fengguang.wu@intel.com, dave@sr71.net, linux-nvdimm@lists.01.org,
        tiwai@suse.de, zwisler@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com,
        baiyaowei@cmss.chinamobile.com, ying.huang@intel.com,
        bhelgaas@google.com, akpm@linux-foundation.org, bp@suse.de
Subject: Re: [PATCH 0/4] Allow persistent memory to be used like normal RAM
References: <20190116181859.D1504459@viggo.jf.intel.com>
        <x49sgxr9rjd.fsf@segfault.boston.devel.redhat.com>
        <20190117164736.GC31543@localhost.localdomain>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 17 Jan 2019 12:20:06 -0500
In-Reply-To: <20190117164736.GC31543@localhost.localdomain> (Keith Busch's
        message of "Thu, 17 Jan 2019 09:47:37 -0700")
Message-ID: <x49pnsv8am1.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 17 Jan 2019 17:20:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Busch <keith.busch@intel.com> writes:

> On Thu, Jan 17, 2019 at 11:29:10AM -0500, Jeff Moyer wrote:
>> Dave Hansen <dave.hansen@linux.intel.com> writes:
>> > Persistent memory is cool.  But, currently, you have to rewrite
>> > your applications to use it.  Wouldn't it be cool if you could
>> > just have it show up in your system like normal RAM and get to
>> > it like a slow blob of memory?  Well... have I got the patch
>> > series for you!
>> 
>> So, isn't that what memory mode is for?
>>   https://itpeernetwork.intel.com/intel-optane-dc-persistent-memory-operating-modes/
>> 
>> Why do we need this code in the kernel?
>
> I don't think those are the same thing. The "memory mode" in the link
> refers to platforms that sequester DRAM to side cache memory access, where
> this series doesn't have that platform dependency nor hides faster DRAM.

OK, so you are making two arguments, here.  1) platforms may not support
memory mode, and 2) this series allows for performance differentiated
memory (even though applications may not modified to make use of
that...).

With this patch set, an unmodified application would either use:

1) whatever memory it happened to get
2) only the faster dram (via numactl --membind=)
3) only the slower pmem (again, via numactl --membind1)
4) preferentially one or the other (numactl --preferred=)

The other options are:
- as mentioned above, memory mode, which uses DRAM as a cache for the
  slower persistent memory.  Note that it isn't all or nothing--you can
  configure your system with both memory mode and appdirect.  The
  limitation, of course, is that your platform has to support this.

  This seems like the obvious solution if you want to make use of the
  larger pmem capacity as regular volatile memory (and your platform
  supports it).  But maybe there is some other limitation that motivated
  this work?

- libmemkind or pmdk.  These options typically* require application
  modifications, but allow those applications to actively decide which
  data lives in fast versus slow media.

  This seems like the obvious answer for applications that care about
  access latency.

* you could override the system malloc, but some libraries/application
  stacks already do that, so it isn't a universal solution.

Listing something like this in the headers of these patch series would
considerably reduce the head-scratching for reviewers.

Keith, you seem to be implying that there are platforms that won't
support memory mode.  Do you also have some insight into how customers
want to use this, beyond my speculation?  It's really frustrating to see
patch sets like this go by without any real use cases provided.

Cheers,
Jeff
