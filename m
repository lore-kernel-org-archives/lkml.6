Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2230C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 15:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A89A2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 15:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeL2PWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 10:22:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:44537 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbeL2PWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 10:22:06 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Dec 2018 07:22:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,414,1539673200"; 
   d="scan'208";a="129997676"
Received: from unknown (HELO localhost) ([10.239.13.104])
  by fmsmga002.fm.intel.com with ESMTP; 29 Dec 2018 07:22:03 -0800
Date:   Sat, 29 Dec 2018 23:26:43 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     qemu-devel@nongnu.org, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: Re: [Qemu-devel][PATCH 2/4] Add CET SHSTK and IBT CPUID feature-word
 definitions.
Message-ID: <20181229152642.GA6590@localhost.localdomain>
References: <cover.1545806972.git.weijiang.yang@intel.com>
 <30d79c2d6fa0658cd2818c21da852fd4dfeeae1c.1545806972.git.weijiang.yang@intel.com>
 <97d6366b-df95-cf00-d652-3176547ae5ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97d6366b-df95-cf00-d652-3176547ae5ca@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 03:25:10PM +0100, Paolo Bonzini wrote:
Thanks a lot Paolo for the comments!

I'll fix the issue in next version.

> On 26/12/18 09:25, Yang Weijiang wrote:
> > @@ -1233,6 +1252,14 @@ static const ExtSaveArea x86_ext_save_areas[] = {
> >            { .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_PKU,
> >              .offset = offsetof(X86XSaveArea, pkru_state),
> >              .size = sizeof(XSavePKRU) },
> > +    [XSTATE_CET_U_BIT] = {
> > +            .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_CET_SHSTK,
> > +            .offset = offsetof(X86XSaveArea, cet_u),
> 
> These offsets are incorrect, since supervisor states are only stored in
> the compacted format.  In fact, in patch 4, supervisor states should
> return 0 in CPUID(EAX=0Dh,ECX=n).EBX.
> 
> You can use offset == 0 to distinguish supervisor and user states, so
> that supervisor states are skipped in xsave_area_size and x86_cpu_reset.
> 
> Thanks,
> 
> Paolo
> 
> > +            .size = sizeof(XSaveCETU) },
> > +    [XSTATE_CET_S_BIT] = {
> > +            .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_CET_SHSTK,
> > +            .offset = offsetof(X86XSaveArea, cet_s),
> > +            .size = sizeof(XSaveCETS) },
> >  };
> >  
> >  static uint32_t xsave_area_size(uint64_t mask)
