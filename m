Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6FFC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC3120839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC3120839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeLLSAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:00:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:55573 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727748AbeLLSAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:00:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 10:00:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,345,1539673200"; 
   d="scan'208";a="109849189"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga003.jf.intel.com with ESMTP; 12 Dec 2018 10:00:46 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E4BDA30237E; Wed, 12 Dec 2018 10:00:46 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:00:46 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Aubrey Li' <aubrey.li@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [PATCH v4 1/2] x86/fpu: track AVX-512 usage of tasks
Message-ID: <20181212180046.GG25620@tassilo.jf.intel.com>
References: <20181211002448.3520-1-aubrey.li@intel.com>
 <c87224bd48bc4296a38ae4852bf28071@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c87224bd48bc4296a38ae4852bf28071@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Isn't a thread likely to clear the AVX registers at the end of a function
> that uses them.
> In particular this removes the massive overhead on certain cpus of
> switching between two AVX modes.
> So it is actually unlikely that XSAVE will need to save them at all?

Only if context switches only happened on function boundaries, which
is obviously not the case.

Yes the detection mechanism is not 100% accurate, but if AVX
is used significantly it should eventually detect it. 
Think of it as a statistical sampling heuristic.

> 
> As I've also said before the registers are caller saved and since
> systems calls are normal function calls the application code
> would have to save them across a system call.
> This allows the kernel to zero the registers on system call entry
> again meaning that XSAVE won't normally have to save them.

While I agree this would be nice, the Linux system call ABI 
wasn't defined like this, so it cannot be done at this point.

-Andi

