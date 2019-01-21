Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D44C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F0821721
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfAUSgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:36:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:16099 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfAUSgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:36:20 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 10:36:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="127480945"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jan 2019 10:36:18 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 6743F301202; Mon, 21 Jan 2019 10:36:18 -0800 (PST)
Date:   Mon, 21 Jan 2019 10:36:18 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Julian Stecklina <jsteckli@amazon.de>
Cc:     linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [RFC] x86/speculation: add L1 Terminal Fault / Foreshadow demo
Message-ID: <20190121183618.GP6118@tassilo.jf.intel.com>
References: <1548076208-6442-1-git-send-email-jsteckli@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548076208-6442-1-git-send-email-jsteckli@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> + 	/* Check the start address: needs to be page-aligned.. */
> +-	if (start & ~PAGE_MASK)
> ++	if (start & ~PAGE_MASK) {
> ++
> ++		/*
> ++		 * XXX Hack
> ++		 *
> ++		 * We re-use this error case to show case a cache load gadget:
> ++		 * There is a mispredicted branch, which leads to prefetching
> ++		 * the cache with attacker controlled data.
> ++		 */
> ++		asm volatile (

Obviously that can never be added to a standard kernel.

And I don't see much point in shipping test cases that require non
standard kernel patching. The idea of shipping test cases is that
you can easily test them, but in this form it can't.

Also even without that problem, not sure what benefit including such a thing 
would have.

If you want to improve regression test coverage, it would be far better to have
test cases which do more directed unit testing against specific software 
parts of the mitigation.

For example some automated testing that the host page tables are inverted as
expected for different scenarios. I checked that manually during development,
but something automated would be great as a regression test. It would
need some way to translate VA->PA in user space.

Or have some tests that run test cases with PT or the MSR tracer with
a guest and automatically check that the MSR writes for VM entries are in
the right location.

-Andi

