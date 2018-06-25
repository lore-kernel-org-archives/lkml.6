Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E4BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED63261F3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED63261F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754485AbeFYWfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:35:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:12908 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752248AbeFYWfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:35:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 15:35:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,272,1526367600"; 
   d="scan'208";a="235530833"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.135])
  by orsmga005.jf.intel.com with ESMTP; 25 Jun 2018 15:35:16 -0700
Date:   Mon, 25 Jun 2018 15:35:16 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Nathaniel McCallum <npmccallum@redhat.com>
Cc:     Neil Horman <nhorman@redhat.com>, jethro@fortanix.com,
        luto@kernel.org, jarkko.sakkinen@linux.intel.com, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, intel-sgx-kernel-dev@lists.01.org, hpa@zytor.com,
        dvhart@infradead.org, tglx@linutronix.de, andy@infradead.org,
        Peter Jones <pjones@redhat.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
Message-ID: <20180625223516.GA1626@linux.intel.com>
References: <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
 <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com>
 <e3f8e5b9-aa1e-20da-37ac-3c3caafa66bc@fortanix.com>
 <b5c81504-83cd-8150-ebe4-41355026590f@fortanix.com>
 <20180620210158.GA24328@linux.intel.com>
 <CAOASepN1AtgEhobJUVh=rcsQ_Qt8ujoEhnivV-29y=-AiyJwZQ@mail.gmail.com>
 <20180621152903.GB1324@hmswarspite.think-freely.org>
 <CAOASepOPxte6aDHQB2dsd+VMPqWOuZZH4j8OKoqaHZ2cBsc38g@mail.gmail.com>
 <20180621212044.GA26021@linux.intel.com>
 <CAOASepNwsXAj7FeD8xw+8AvQ3z=b9CG5zd-OSrg9zLC-nP_JWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOASepNwsXAj7FeD8xw+8AvQ3z=b9CG5zd-OSrg9zLC-nP_JWg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 05:00:05PM -0400, Nathaniel McCallum wrote:
> On Thu, Jun 21, 2018 at 5:21 PM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > On Thu, Jun 21, 2018 at 03:11:18PM -0400, Nathaniel McCallum wrote:
> > > If this is acceptable for everyone, my hope is the following:
> > >
> > > 1. Intel would split the existing code into one of the following
> > > schemas (I don't care which):
> > >   A. three parts: UEFI module, FLC-only kernel driver and user-space
> > > launch enclave
> > >   B. two parts: UEFI module (including launch enclave) and FLC-only
> > > kernel driver
> >
> > To make sure I understand correctly...
> >
> > The UEFI module would lock the LE MSRs with a public key hardcoded
> > into both the UEFI module and the kernel at build time?
> >
> > And for the kernel, it would only load its SGX driver if FLC is
> > supported and the MSRs are locked to the expected key?
> >
> > IIUC, this approach will cause problems for virtualization.  Running
> > VMs with different LE keys would require the bare metal firmware to
> > configure the LE MSRs to be unlocked, which would effectively make
> > using SGX in the host OS mutually exlusive with exposing SGX to KVM
> > guests.  Theoretically it would be possible for KVM to emulate the
> > guest's LE and use the host's LE to generate EINIT tokens, but
> > emulating an enclave would likely require a massive amount of code
> > and/or complexity.
> 
> How is this different from any other scenario where you lock the LE
> MSRs? Unless Intel provides hardware support between the LE MSRs and
> the VMX instructions, I don't see any way around this besides letting
> any launch enclave run.

It's not.  All prior discussions have effectively required unlocked
MSRs, so that's my baseline.

> > > 2. Intel would release a reproducible build of the GPL UEFI module
> > > sources signed with a SecureBoot trusted key and provide an
> > > acceptable[0] binary redistribution license.
> > >
> > > 3. The kernel community would agree to merge the kernel driver given
> > > the above criteria (and, obviously, acceptable kernel code).
> > >
> > > The question of how to distribute the UEFI module and possible launch
> > > enclave remains open. I see two options: independent distribution and
> > > bundling it in linux-firmware. The former may be a better
> > > technological fit since the UEFI module will likely need to be run
> > > before the kernel (and the boot loader; and shim). However, the latter
> > > has the benefit of already being a well-known entity to our downstream
> > > distributors. I could go either way on this.
> >
> > Writing and locks the LE MSRs effectively needs to be done before
> > running the bootloader/kernel/etc...  Delaying activation would
> > require, at a minimum, leaving IA32_FEATURE_CONTROL unlocked since
> > IA32_FEATURE_CONTROL's SGX bits can't be set until SGX is activated.
> >
> > > I know this plan is more work for everyone involved, but I think it
> > > manages to actually maximize both security and freedom.
> > >
> > > [0]: details here -
> > > https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/README#n19
> > > On Thu, Jun 21, 2018 at 11:29 AM Neil Horman <nhorman@redhat.com> wrote:
> > > >
> > > > On Thu, Jun 21, 2018 at 08:32:25AM -0400, Nathaniel McCallum wrote:
> > > > > On Wed, Jun 20, 2018 at 5:02 PM Sean Christopherson
> > > > > <sean.j.christopherson@intel.com> wrote:
> > > > > >
> > > > > > On Wed, Jun 20, 2018 at 11:39:00AM -0700, Jethro Beekman wrote:
> > > > > > > On 2018-06-20 11:16, Jethro Beekman wrote:
> > > > > > > > > This last bit is also repeated in different words in Table 35-2 and
> > > > > > > > > Section 42.2.2. The MSRs are *not writable* before the write-lock bit
> > > > > > > > > itself is locked. Meaning the MSRs are either locked with Intel's key
> > > > > > > > > hash, or not locked at all.
> > > > > > >
> > > > > > > Actually, this might be a documentation bug. I have some test hardware and I
> > > > > > > was able to configure the MSRs in the BIOS and then read the MSRs after boot
> > > > > > > like this:
> > > > > > >
> > > > > > > MSR 0x3a 0x0000000000040005
> > > > > > > MSR 0x8c 0x20180620aaaaaaaa
> > > > > > > MSR 0x8d 0x20180620bbbbbbbb
> > > > > > > MSR 0x8e 0x20180620cccccccc
> > > > > > > MSR 0x8f 0x20180620dddddddd
> > > > > > >
> > > > > > > Since this is not production hardware, it could also be a CPU bug of course.
> > > > > > >
> > > > > > > If it is indeed possible to configure AND lock the MSR values to non-Intel
> > > > > > > values, I'm very much in favor of Nathaniels proposal to treat the launch
> > > > > > > enclave like any other firmware blob.
> > > > > >
> > > > > > It's not a CPU or documentation bug (though the latter is arguable).
> > > > > > SGX has an activation step that is triggered by doing a WRMSR(0x7a)
> > > > > > with bit 0 set.  Until SGX is activated, the SGX related bits in
> > > > > > IA32_FEATURE_CONTROL cannot be set, i.e. SGX can't be enabled.  But,
> > > > > > the LE hash MSRs are fully writable prior to activation, e.g. to
> > > > > > allow firmware to lock down the LE key with a non-Intel value.
> > > > > >
> > > > > > So yes, it's possible to lock the MSRs to a non-Intel value.  The
> > > > > > obvious caveat is that whatever blob is used to write the MSRs would
> > > > > > need be executed prior to activation.
> > > > >
> > > > > This implies that it should be possible to create MSR activation (and
> > > > > an embedded launch enclave?) entirely as a UEFI module. The kernel
> > > > > would still get to manage who has access to /dev/sgx and other
> > > > > important non-cryptographic policy details. Users would still be able
> > > > > to control the cryptographic policy details (via BIOS Secure Boot
> > > > > configuration that exists today). Distributions could still control
> > > > > cryptographic policy details via signing of the UEFI module with their
> > > > > own Secure Boot key (or using something like shim). The UEFI module
> > > > > (and possibly the external launch enclave) could be distributed via
> > > > > linux-firmware.
> > > > >
> > > > > Andy/Neil, does this work for you?
> > > > >
> > > > I need some time to digest it.  Who in your mind is writing the UEFI module.  Is
> > > > that the firmware vendor or IHV?
> > > >
> > > > Neil
> > > >
> > > > > > As for the SDM, it's a documentation... omission?  SGX activation
> > > > > > is intentionally omitted from the SDM.  The intended usage model is
> > > > > > that firmware will always do the activation (if it wants SGX enabled),
> > > > > > i.e. post-firmware software will only ever "see" SGX as disabled or
> > > > > > in the fully activated state, and so the SDM doesn't describe SGX
> > > > > > behavior prior to activation.  I believe the activation process, or
> > > > > > at least what is required from firmware, is documented in the BIOS
> > > > > > writer's guide.
> > > > > >
> > > > > > > Jethro Beekman | Fortanix
> > > > > > >
> > > > > >
> > > > > >
