Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0FFC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9149A2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfA2Dj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 22:39:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:37683 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfA2Dj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 22:39:57 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 19:39:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,535,1539673200"; 
   d="scan'208";a="138698371"
Received: from local-michael-cet-test.sh.intel.com (HELO localhost) ([10.239.159.128])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2019 19:39:54 -0800
Date:   Mon, 28 Jan 2019 18:33:45 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        jmattson@google.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, mst@redhat.com, yu-cheng.yu@intel.com,
        yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v2 1/7] KVM:VMX: Define CET VMCS fields and bits
Message-ID: <20190128103345.GA29895@local-michael-cet-test.sh.intel.com>
References: <20190122205909.24165-1-weijiang.yang@intel.com>
 <20190122205909.24165-2-weijiang.yang@intel.com>
 <5a31eef0-2b6c-bdc2-c54b-5dc4cecf084d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a31eef0-2b6c-bdc2-c54b-5dc4cecf084d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 07:02:37PM +0100, Paolo Bonzini wrote:
> On 22/01/19 21:59, Yang Weijiang wrote:
> > On processors that support CET, VMX saves/restores
> > the states of IA32_S_CET, SSP and IA32_INTERRUPT_SSP_TABLE_ADDR MSR
> > to the VMCS area for Guest/Host unconditionally.
> > 
> > If VM_EXIT_LOAD_HOST_CET_STATE = 1, the host CET MSRs are
> > restored from VMCS host-state area at VM exit as follows:
> > 
> > - HOST_IA32_S_CET: Host supervisor mode IA32_S_CET MSR is loaded
> >                    from this field.
> > 
> > - HOST_SSP : Host SSP is loaded from this field.
> > 
> > - HOST_INTR_SSP_TABLE_ADDR : Host IA32_INTERRUPT_SSP_TABLE_ADDR
> >                              MSR is loaded from this field.
> > 
> > If VM_ENTRY_LOAD_GUEST_CET_STATE = 1, the guest CET MSRs are loaded
> > from VMCS guest-state area at VM entry as follows:
> > 
> > - GUEST_IA32_S_CET : Guest supervisor mode IA32_S_CET MSR is loaded
> >                      from this field.
> > 
> > - GUEST_SSP : Guest SSP is loaded from this field.
> > 
> > - GUEST_INTR_SSP_TABL_ADDR : Guest IA32_INTERRUPT_SSP_TABLE_ADDR
> >                              MSR is loaded from this field.
>
Thanks for review.

> There is no code in this series to pass these fields to and from
> userspace, and also to save/restore U_CET, INT_SSP_TAB, PL0_SSP and
> PL3_SSP across context switches.
> 
The kernel consumes these MSRs, please see kernel CET patch:
https://lkml.org/lkml/fancy/2018/11/20/225

> In addition, PL1_SSP and PL2_SSP should be supported even if the guest
> doesn't use them.  It makes sense to avoid intercepting them, but they
> should still be supported and switched (possibly only if nonzero).
> 
> Am I missing something, for example a dependency on host CET support?
> If not, how was this series tested?
> 
The guest CET feature is tested with kernel CET patches on internal
virtual platform.

> Paolo
