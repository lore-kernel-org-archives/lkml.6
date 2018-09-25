Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1016C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821B320842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821B320842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeIYMFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:05:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:58148 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbeIYMFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:05:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC1CFAC52;
        Tue, 25 Sep 2018 05:59:07 +0000 (UTC)
Date:   Tue, 25 Sep 2018 07:59:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     zhe.he@windriver.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com, osalvador@suse.de,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/page_alloc: Fix panic caused by passing
 debug_guardpage_minorder or kernelcore to command line
Message-ID: <20180925055904.GM18685@dhcp22.suse.cz>
References: <1537628013-243902-1-git-send-email-zhe.he@windriver.com>
 <20180924142408.GC18685@dhcp22.suse.cz>
 <20180924144217.6cabee9f41d0d0ad1757866a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924144217.6cabee9f41d0d0ad1757866a@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24-09-18 14:42:17, Andrew Morton wrote:
> On Mon, 24 Sep 2018 16:24:08 +0200 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Sat 22-09-18 22:53:32, zhe.he@windriver.com wrote:
> > > From: He Zhe <zhe.he@windriver.com>
> > > 
> > > debug_guardpage_minorder_setup and cmdline_parse_kernelcore do not check
> > > input argument before using it. The argument would be a NULL pointer if
> > > "debug_guardpage_minorder" or "kernelcore", without its value, is set in
> > > command line and thus causes the following panic.
> > > 
> > > PANIC: early exception 0xe3 IP 10:ffffffffa08146f1 error 0 cr2 0x0
> > > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc4-yocto-standard+ #11
> > > [    0.000000] RIP: 0010:parse_option_str+0x11/0x90
> > > ...
> > > [    0.000000] Call Trace:
> > > [    0.000000]  cmdline_parse_kernelcore+0x19/0x41
> > > [    0.000000]  do_early_param+0x57/0x8e
> > > [    0.000000]  parse_args+0x208/0x320
> > > [    0.000000]  ? rdinit_setup+0x30/0x30
> > > [    0.000000]  parse_early_options+0x29/0x2d
> > > [    0.000000]  ? rdinit_setup+0x30/0x30
> > > [    0.000000]  parse_early_param+0x36/0x4d
> > > [    0.000000]  setup_arch+0x336/0x99e
> > > [    0.000000]  start_kernel+0x6f/0x4ee
> > > [    0.000000]  x86_64_start_reservations+0x24/0x26
> > > [    0.000000]  x86_64_start_kernel+0x6f/0x72
> > > [    0.000000]  secondary_startup_64+0xa4/0xb0
> > > 
> > > This patch adds a check to prevent the panic
> > 
> > Is this something we deeply care about? The kernel command line
> > interface is to be used by admins who know what they are doing.  Using
> > random or wrong values for these parameters can have detrimental effects
> > on the system. This particular case would blow up early, good. At least
> > it is visible immediately. This and many other parameters could have a
> > seemingly valid input (e.g. not a missing value) and subtle runtime
> > effect. You won't blow up immediately but the system is hardly usable
> > and the early checking cannot possible catch all those cases. Take a
> > mem=$N copied from one machine to another with a different memory
> > layout. While 2G can be perfectly fine on one a different machine might
> > result on a completely unusable system because the available RAM is
> > place higher.
> > 
> > So I am really wondering. Do we really want a lot of code to catch
> > kernel command line incorrect inputs? Does it really lead to better
> > quality overall? IMHO, we do have a proper documentation and we should
> > trust those starting the kernel.
> 
> No, it's not very important.  It might help some people understand why
> their kernel went splat in rare circumstances.  And it's __init code so
> the runtime impact is nil.
> 
> It bothers me that there are many other kernel parameters which have
> the same undesirable behaviour.  I'd much prefer a general fixup which
> gave all of them this treatment, but it's unclear how to do this.

If early_param took an additional argument to tell "this really requires
a parameter" then we could do it in the common code.

$ git grep "early_param(\"" | wc -l
251

quite a lot of work for something that hasn't been a problem for years I
guess. But maybe this would allow to remove ad-hoc checks in handlers
and reduce the overal code size (in LOC) in the end.
-- 
Michal Hocko
SUSE Labs
