Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9DAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E694921904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392020AbfBNBxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:53:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:45167 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732776AbfBNBxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:53:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 17:53:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,367,1544515200"; 
   d="scan'208";a="116051781"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga006.jf.intel.com with ESMTP; 13 Feb 2019 17:53:22 -0800
Date:   Wed, 13 Feb 2019 17:53:14 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz,
        cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com,
        atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
Message-ID: <20190214015314.GB1151@iweiny-DESK2.sc.intel.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211225447.GN24692@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211225447.GN24692@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 03:54:47PM -0700, Jason Gunthorpe wrote:
> On Mon, Feb 11, 2019 at 05:44:32PM -0500, Daniel Jordan wrote:
> 
> > All five of these places, and probably some of Davidlohr's conversions,
> > probably want to be collapsed into a common helper in the core mm for
> > accounting pinned pages.  I tried, and there are several details that
> > likely need discussion, so this can be done as a follow-on.
> 
> I've wondered the same..

I'm really thinking this would be a nice way to ensure it gets cleaned up and
does not happen again.

Also, by moving it to the core we could better manage any user visible changes.

From a high level, pinned is a subset of locked so it seems like we need a 2
sets of helpers.

try_increment_locked_vm(...)
decrement_locked_vm(...)

try_increment_pinned_vm(...)
decrement_pinned_vm(...)

Where try_increment_pinned_vm() also increments locked_vm...  Of course this
may end up reverting the improvement of Davidlohr  Bueso's atomic work...  :-(

Furthermore it would seem better (although I don't know if at all possible) if
this were accounted for in core calls which tracked them based on how the pages
are being used so that drivers can't call try_increment_locked_vm() and then
pin the pages...  Thus getting the account wrong vs what actually happened.

And then in the end we can go back to locked_vm being the value checked against
RLIMIT_MEMLOCK.

Ira

