Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DD7C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA852151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA852151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeHUX6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:58:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:32366 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbeHUX6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:58:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2018 13:36:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,271,1531810800"; 
   d="scan'208";a="83755307"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2018 13:36:31 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B4EC1301B91; Tue, 21 Aug 2018 13:36:31 -0700 (PDT)
Date:   Tue, 21 Aug 2018 13:36:31 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     yang.shi@linux.alibaba.com
Cc:     David Woodhouse <dwmw2@infradead.org>, gregkh@linuxfoundation.org,
        tglx@linutronix.de, dave.hansen@intel.com, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] madvise05 leads kernel panic on 4.9.122
Message-ID: <20180821203631.GU12066@tassilo.jf.intel.com>
References: <b205fec4-a1ed-dd44-7ba4-7b78f7429689@linux.alibaba.com>
 <1534876981.7459.1.camel@infradead.org>
 <a080e61a-70a2-872a-8849-d6599762ac7c@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a080e61a-70a2-872a-8849-d6599762ac7c@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 01:30:20PM -0700, yang.shi@linux.alibaba.com wrote:
> 
> 
> On 8/21/18 11:43 AM, David Woodhouse wrote:
> > On Tue, 2018-08-21 at 11:37 -0700, Yang Shi wrote:
> > > I just ran some regression test on stable 4.9.122 with LTP. madvise05
> > > triggers the below kernel panic:
> 
> Thanks, David. It works. A silly question, I don't get why this commit could
> solve this issue, it looks just like a code refactor. Just because it
> changed how to get pfn from page table entries? And, this may cause some
> mismatch on 4.9 stable without it?

With the L1TF patches open coded pte_val() to get the PFN can cause problems
because it doesn't do the invert for PROT_NONE mappings

The cleanup changes the open coded versions to use p*_pfn(), which always
works correctly.

-Andi
