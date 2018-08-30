Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFBFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703202073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703202073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeH3La3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:30:29 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:57337 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeH3La3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:30:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id A7EB01848F;
        Thu, 30 Aug 2018 09:29:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id oiXPsN6a6gZt; Thu, 30 Aug 2018 09:29:40 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 5030D18488;
        Thu, 30 Aug 2018 09:29:40 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2352B1E06A;
        Thu, 30 Aug 2018 09:29:40 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17E841E056;
        Thu, 30 Aug 2018 09:29:40 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Thu, 30 Aug 2018 09:29:40 +0200 (CEST)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 0BCC03099;
        Thu, 30 Aug 2018 09:29:40 +0200 (CEST)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 08B11801F9; Thu, 30 Aug 2018 09:29:40 +0200 (CEST)
Date:   Thu, 30 Aug 2018 09:29:40 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] scripts: add kmemleak2pprof.py for slab usage
 analysis
Message-ID: <20180830072939.i33m43mj7uslhvmz@axis.com>
References: <20180828103914.30434-1-vincent.whitchurch@axis.com>
 <20180828103914.30434-2-vincent.whitchurch@axis.com>
 <20180828162804.4ee225124cbde3f39f53fd80@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828162804.4ee225124cbde3f39f53fd80@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 04:28:04PM -0700, Andrew Morton wrote:
> On Tue, 28 Aug 2018 12:39:14 +0200 Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> 
> > Add a script which converts /sys/kernel/debug/kmemleak_all to the pprof
> > format, which can be used for analysing memory usage.  See
> > https://github.com/google/pprof.
> 
> Why is this better than /proc/slabinfo?

slabinfo just tells you how much memory is being used in a particular
slab, it doesn't give you a breakdown of who allocated all that memory.
slabinfo can't also tell you how much memory a particular subsystem is
using.

For example, here we can see that tracer_init_tracefs() and its callers
are using ~12% of the total tracked memory:

 $ pprof -top -compact_labels -cum prof 
 Showing nodes accounting for 13418.95kB, 92.07% of 14575.28kB total
 Dropped 4069 nodes (cum <= 72.88kB)
       flat  flat%   sum%        cum   cum%
       ...
          0     0% 56.71%  1832.15kB 12.57%  tracer_init_tracefs+0x74/0x1cc

 
And that tracefs' dentrys use 500 KiB and its inodes use 1+ MiB:
 	
 $ pprof -text -compact_labels -focus tracer_init_tracefs -nodecount 2 prof
 Main binary filename not available.
 Showing nodes accounting for 1794.85kB, 12.31% of 14575.28kB total
 Dropped 1912 nodes (cum <= 72.88kB)
 Showing top 2 nodes out of 32
       flat  flat%   sum%        cum   cum%
  1294.56kB  8.88%  8.88%  1294.56kB  8.88%  new_inode_pseudo+0x8/0x4c
   500.29kB  3.43% 12.31%   500.29kB  3.43%  d_alloc+0x10/0x78
   ...

> 
> >  $ ./kmemleak2pprof.py kmemleak_all
> >  $ pprof -text -ignore free_area_init_node -compact_labels -nodecount 10 prof
> 
> Are we missing an argument here?  s/prof/kmemleak_all/?

No, the default output filename of this script is called "prof".
