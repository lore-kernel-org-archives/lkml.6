Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA6EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19635216FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19635216FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeHTRgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 13:36:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:28438 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeHTRgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 13:36:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 07:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,265,1531810800"; 
   d="scan'208";a="83316772"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga001.jf.intel.com with ESMTP; 20 Aug 2018 07:20:27 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B8BDF300B48; Mon, 20 Aug 2018 07:20:27 -0700 (PDT)
Date:   Mon, 20 Aug 2018 07:20:27 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>, stable@vger.kernel.org,
        Adrian Schroeter <adrian@suse.de>,
        Dominique Leuenberger <dimstar@suse.de>
Subject: Re: [PATCH] x86/speculation/l1tf: fix overflow on l1tf_pfn_limit()
 on 32bit
Message-ID: <20180820142027.GL12066@tassilo.jf.intel.com>
References: <20180820095835.5298-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820095835.5298-1-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 11:58:35AM +0200, Vlastimil Babka wrote:
> On 32bit PAE kernels on 64bit hardware with enough physical bits,
> l1tf_pfn_limit() will overflow unsigned long. This in turn affects
> max_swapfile_size() and can lead to swapon returning -EINVAL. This has been
> observed in a 32bit guest with 42 bits physical address size, where
> max_swapfile_size() overflows exactly to 1 << 32, thus zero, and produces the
> following warning to dmesg:
> 
> [    6.396845] Truncating oversized swap area, only using 0k out of 2047996k
> 
> Fix this by using unsigned long long instead.

Looks good.

Acked-by: Andi Kleen <ak@linux.intel.com>

BTW our much worse problems right now are crash reports on several 
stable kernels, especially with large pages 

I'll dig into this more today, but if you have any hints from testing/fixing
your own backports please share them.

-Andi
