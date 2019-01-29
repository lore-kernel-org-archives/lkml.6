Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D073C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E9421473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfA3Bfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:35:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:29151 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbfA3Bfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 20:35:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 17:35:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,538,1539673200"; 
   d="scan'208";a="134272440"
Received: from local-michael-cet-test.sh.intel.com (HELO localhost) ([10.239.159.128])
  by orsmga001.jf.intel.com with ESMTP; 29 Jan 2019 17:35:27 -0800
Date:   Tue, 29 Jan 2019 16:29:17 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        jmattson@google.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, mst@redhat.com, yu-cheng.yu@intel.com,
        yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v2 1/7] KVM:VMX: Define CET VMCS fields and bits
Message-ID: <20190129082917.GA32725@local-michael-cet-test.sh.intel.com>
References: <20190122205909.24165-1-weijiang.yang@intel.com>
 <20190122205909.24165-2-weijiang.yang@intel.com>
 <5a31eef0-2b6c-bdc2-c54b-5dc4cecf084d@redhat.com>
 <20190128103345.GA29895@local-michael-cet-test.sh.intel.com>
 <4d9a5393-163b-f32a-4657-cec54093ee88@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d9a5393-163b-f32a-4657-cec54093ee88@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 04:19:34PM +0100, Paolo Bonzini wrote:
> On 28/01/19 11:33, Yang Weijiang wrote:
> >> There is no code in this series to pass these fields to and from
> >> userspace, and also to save/restore U_CET, INT_SSP_TAB, PL0_SSP and
> >> PL3_SSP across context switches.
> >>
> > The kernel consumes these MSRs, please see kernel CET patch:
> > https://lkml.org/lkml/fancy/2018/11/20/225
> 
> Still, even if the kernel saves these fields across context switch in
> XSAVE areas, KVM must support accesses to the MSRs from userspace, for
> example in order to perform live migration.
> 
> For example, when reading/writing these in kvm_set_msr or
> kvm_get_msr_common, you would have to do a read/write from the host
> MSRs.  You also have to put kvm_load_guest_fpu/kvm_put_guest_fpu calls
> in __msr_io.
Thanks, you're right, if we want to support live migration we need do that.
However, this feature relies on quite a few external
dependencies, e.g., cpu capabilities, kernel version and configuration, we
don't support live migration right now. what's your opinion?
> 
> Thanks,
> 
> Paolo
> 
> >> In addition, PL1_SSP and PL2_SSP should be supported even if the guest
> >> doesn't use them.  It makes sense to avoid intercepting them, but they
> >> should still be supported and switched (possibly only if nonzero).
> >>
> >> Am I missing something, for example a dependency on host CET support?
> >> If not, how was this series tested?
> >>
> > The guest CET feature is tested with kernel CET patches on internal
> > virtual platform.
> > 
