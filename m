Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1937BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CB021473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfA3Bkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:40:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:41012 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727640AbfA3Bkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 20:40:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 17:40:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,538,1539673200"; 
   d="scan'208";a="271009569"
Received: from local-michael-cet-test.sh.intel.com (HELO localhost) ([10.239.159.128])
  by orsmga004.jf.intel.com with ESMTP; 29 Jan 2019 17:40:38 -0800
Date:   Tue, 29 Jan 2019 16:34:28 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, yu-cheng.yu@intel.com,
        yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v2 1/7] KVM:VMX: Define CET VMCS fields and bits
Message-ID: <20190129083428.GA4526@local-michael-cet-test.sh.intel.com>
References: <20190122205909.24165-1-weijiang.yang@intel.com>
 <20190122205909.24165-2-weijiang.yang@intel.com>
 <CALMp9eQGg-g54zjWRcU3kkSR2kSHA0g18PURVvC1QLnC4fSYTA@mail.gmail.com>
 <CALMp9eR_KbgNWfpXJr+FzP2e68isK3RsXwN1QgH72ni8VHwzfA@mail.gmail.com>
 <20190129182750.GB8156@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129182750.GB8156@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 10:27:50AM -0800, Sean Christopherson wrote:
> On Tue, Jan 29, 2019 at 10:01:15AM -0800, Jim Mattson wrote:
> > On Tue, Jan 29, 2019 at 9:47 AM Jim Mattson <jmattson@google.com> wrote:
> > >
> > > On Wed, Jan 23, 2019 at 6:06 AM Yang Weijiang <weijiang.yang@intel.com> wrote:
> > > > Note: Although these VMCS fields are 64-bit, they don't have high fields.
> > >
> > > This statement directly contradicts the SDM, volume 3, appendix B.2:
> > >
> > > "A value of 1 in bits 14:13 of an encoding indicates a 64-bit field.
> > > There are 64-bit fields only for controls and for guest state. As
> > > noted in Section 24.11.2, every 64-bit field has two encodings, which
> > > differ on bit 0, the access type. Thus, each such field has an even
> > > encoding for full access and an odd encoding for high access."
> > 
> > Ah! They're not actually 64-bit fields. If you look at the encodings
> > (0x68XX and 0x6cxx), they're natural-width fields! Natural-width
> > fields don't have a high component.
> 
> They're indeed natural width (I actually looked at the spec this time).
> 
> The "_FULL" postfix on VMX_HOST_IA32_INTERRUPT_SSP_TABLE_ADDR_FULL and
> VMX_HOST_SSP_FULL is confusing as it generally only shows up on 64-bit
> fields.  I'll see if we can get the fields renamed to drop "_FULL".  I
> suggest we preemptively do the same for KVM.
Thank you for making it clear! I should have modified the annotation
correctly. I'll add a note for this in next version.
