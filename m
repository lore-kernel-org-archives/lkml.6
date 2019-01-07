Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFA0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13B32085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfAGUOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:14:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:47023 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfAGUOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:14:48 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 12:14:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="114886619"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jan 2019 12:14:47 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 80A1B301BEF; Mon,  7 Jan 2019 12:14:47 -0800 (PST)
Date:   Mon, 7 Jan 2019 12:14:47 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Wei Wang <wei.w.wang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        like.xu@intel.com, Jann Horn <jannh@google.com>,
        arei.gonglei@huawei.com
Subject: Re: [PATCH v4 05/10] KVM/x86: expose MSR_IA32_PERF_CAPABILITIES to
 the guest
Message-ID: <20190107201447.GM6118@tassilo.jf.intel.com>
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
 <1545816338-1171-6-git-send-email-wei.w.wang@intel.com>
 <CALMp9eTOV3Twep9gL-9S+Pe_k-=v17CcJTLb5=+7_pjvWf9RfQ@mail.gmail.com>
 <5C2DC132.9050103@intel.com>
 <CALMp9eQ0nzKBP7az72G+eRe8C4KQQUBdj+7oD_WJHSFfYkj+Vw@mail.gmail.com>
 <5C3318A1.9090009@intel.com>
 <CALMp9eSyC5arXkrFdJKCx=cG7uF6tVgkbSJbUJArf4cFje13rQ@mail.gmail.com>
 <20190107182012.GL6118@tassilo.jf.intel.com>
 <CALMp9eT2J=qFTEEpsym_aqeCRwyCquTYnY8=taZ3nY3rs8WeJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eT2J=qFTEEpsym_aqeCRwyCquTYnY8=taZ3nY3rs8WeJA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 10:48:38AM -0800, Jim Mattson wrote:
> On Mon, Jan 7, 2019 at 10:20 AM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > > The issue is compatibility. Prior to your change, reading this MSR
> > > from a VM would raise #GP. After your change, it won't. That means
> > > that if you have a VM migrating between hosts with kernel versions
> > > before and after this change, the results will be inconsistent. In the
> >
> > No it will not be. All Linux kernel uses of this MSR are guarded
> > by a CPUID check.
> 
> Linux usage is irrelevant to the architected behavior of the virtual
> CPU. According to volume 4 of the SDM, this MSR is only supported when
> CPUID.01H:ECX.PDCM [bit 15] is set. Therefore, kvm should raise #GP
> whenever a guest tries to read this MSR and the guest's
> CPUID.01H:ECX.PDCM [bit 15] is clear.

That's not general practice in KVM. There are lots of MSRs
that don't fault even if their CPUID doesn't support them.

It's also not generally true for instructions, where it is even
impossible.

You could argue it should be done for MSRs, but that would
be a much larger patch for lots of MSRs. It seems pointless
to single out this particular one.

In practice I doubt it will make any difference for
real software either way.

-Andi

