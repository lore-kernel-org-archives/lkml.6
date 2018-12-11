Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C301DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B6220855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B6220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeLKRxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:53:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:9639 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbeLKRxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:53:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 09:53:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="106633106"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga007.fm.intel.com with ESMTP; 11 Dec 2018 09:53:52 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 3D5F130237E; Tue, 11 Dec 2018 09:53:52 -0800 (PST)
Date:   Tue, 11 Dec 2018 09:53:52 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        tim.c.chen@linux.intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [PATCH v4 1/2] x86/fpu: track AVX-512 usage of tasks
Message-ID: <20181211175352.GC25620@tassilo.jf.intel.com>
References: <20181211002448.3520-1-aubrey.li@intel.com>
 <df1a1b5b-3e8b-5d96-12df-25be30c391af@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df1a1b5b-3e8b-5d96-12df-25be30c391af@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 09:18:25AM -0800, Dave Hansen wrote:
> On 12/10/18 4:24 PM, Aubrey Li wrote:
> > The tracking turns on the usage flag at the next context switch of
> > the task, but requires 3 consecutive context switches with no usage
> > to clear it. This decay is required because well-written AVX-512
> > applications are expected to clear this state when not actively using
> > AVX-512 registers.
> 
> One concern about this:  Given a HZ=1000 system, this means that the
> flag needs to get scanned every ~3ms.  That's a pretty good amount of
> scanning on a system with hundreds or thousands of tasks running around.
> 
> How many tasks does this scale to until you're eating up an entire CPU
> or two just scanning /proc?

Yes that's why we may need to propagate it to cgroups in the kernel,
because user daemons don't really want to track every TID.

But per pid is a start so that people can start experimenting with this.

Then with some experience fancier interfaces for it can be implemented.

-Andi
