Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CA5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BA12083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfBURPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:15:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:56028 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbfBURPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:15:47 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 09:15:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,396,1544515200"; 
   d="scan'208";a="119753743"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga008.jf.intel.com with ESMTP; 21 Feb 2019 09:15:43 -0800
Date:   Thu, 21 Feb 2019 09:15:42 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joerg Roedel <jroedel@suse.de>, Joerg Roedel <joro@8bytes.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable-4.4.y] KVM: VMX: Fix x2apic check in
 vmx_msr_bitmap_mode()
Message-ID: <20190221171541.GA7019@linux.intel.com>
References: <20190221135213.23926-1-joro@8bytes.org>
 <20190221141530.GA18436@kroah.com>
 <20190221144701.GB8380@suse.de>
 <20190221162032.GF25800@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221162032.GF25800@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 05:20:32PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 21, 2019 at 03:47:01PM +0100, Joerg Roedel wrote:
> > On Thu, Feb 21, 2019 at 03:15:30PM +0100, Greg Kroah-Hartman wrote:
> > > Ugh, good catch!
> > > 
> > > Any hint as to what type of testing that you did that caught this?  I
> > > keep asking people to run some kvm tests, but so far no one is :(
> > 
> > We caught this at SUSE while testing candidate kernel updates for one of
> > our service packs using a 4.4-based kernel and debugging turned
> > out that this is issue came in via stable-updates. We also build a
> > vanilla-flavour of the kernel which is nearly identical to the upstream
> > stable tree, but what usually ends up in testing is the full tree with
> > other backports.
> > 
> > This particular issue was found by updating some openstack machines with
> > the candidate kernel, which then triggered the problem in some guests.
> > It is also a very special one, since I was only able to trigger the
> > problem on Westmere-based machines with a specific guest-config.
> 
> Nice work.  Any chance that "test" could be added to the kvm testing
> scripts that I think are being worked on somewhere?  Ideally we would
> have caught this before it ever hit the stable tree.  Due to the lack of
> good KVM testing, that's one of the areas I am always most worried about

This bug exists only in the 4.4.y backport; upstream, 4.9.y and 4.14.y
all had the correct code from the get-go.  And there is already a KVM
unit test that *should* hit this, albeit somewhat indirectly.  I'll
verify the tests that touch the TPR actually run with x2APIC enabled.

Assuming the KVM unit test actually works, it's not a stretch for the
bug to esacpe, e.g. if the tests weren't run on 4.4.y at all, or were
only run on hardware with x2APIC.
