Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5ADC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C102075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C102075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967344AbeFSVhX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:37:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:1759 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967205AbeFSVhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:37:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 14:37:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,244,1526367600"; 
   d="scan'208";a="60583867"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga003.jf.intel.com with ESMTP; 19 Jun 2018 14:37:10 -0700
Date:   Tue, 19 Jun 2018 14:36:44 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 1/8] x86/cpufeatures: Enumerate MOVDIRI instruction
Message-ID: <20180619213644.GC112652@romley-ivt3.sc.intel.com>
References: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
 <1529118375-90191-2-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1806191057210.1692@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806191057210.1692@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:57:44AM +0200, Thomas Gleixner wrote:
> On Fri, 15 Jun 2018, Fenghua Yu wrote:
> 
> > MOVDIRI moves doubleword or quadword from register to memory through
> > direct store which is implemented by using write combining (WC) for
> > writing data directly into memory without caching the data.
> 
> And that is useful for what?

Programmable agents can handle streaming offload (e.g. high speed packet
processing in network). Hardware implements a doorbell (tail pointer)
register that is updated by software when adding new work-elements to
the streaming offload work-queue.

MOVDIRI can be used as the doorbell write which is a 4-byte or 8-byte
uncachable write to MMIO. MOVDIRI has lower overhead than other ways
to write the doorbell.

In low latency offload (e.g. Non-Volatile Memory, etc), MOVDIR64B writes
work descriptors (and data in some cases) to device-hosted work-queues
with atomicity.

Thanks.

-Fenghua
