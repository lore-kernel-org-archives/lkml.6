Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A618C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BE92064D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BE92064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbeGDOv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:51:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47846 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753294AbeGDOv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:51:56 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faj8F-0000at-9m; Wed, 04 Jul 2018 16:51:47 +0200
Date:   Wed, 4 Jul 2018 16:51:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
cc:     Jingqi Liu <jingqi.liu@intel.com>, rkrcmar@redhat.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        wei.w.wang@intel.com, Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v2] KVM: Expose the split lock detection feature to guest
 VM
In-Reply-To: <7813a04b-8058-538b-8c9b-cdd01ce119ac@redhat.com>
Message-ID: <alpine.DEB.2.21.1807041636340.1752@nanos.tec.linutronix.de>
References: <1530709593-87702-1-git-send-email-jingqi.liu@intel.com> <7813a04b-8058-538b-8c9b-cdd01ce119ac@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, Paolo Bonzini wrote:
> On 04/07/2018 15:06, Jingqi Liu wrote:
> > A new control bit(bit 29) in the TEST_CTRL MSR will be introduced
> > to enable detection of split locks.
> > 
> > When bit 29 of the TEST_CTRL(33H) MSR is set, the processor
> > causes an #AC exception to be issued instead of suppressing LOCK on
> > bus(during split lock access). A previous control bit (bit 31)
> > in this MSR causes the processor to disable LOCK# assertion for
> > split locked accesses when set. When bits 29 and 31 are both set,
> > bit 29 takes precedence.
> > 
> > The release document ref below link:
> > https://software.intel.com/sites/default/files/managed/c5/15/\
> > architecture-instruction-set-extensions-programming-reference.pdf
> > This patch has a dependency on https://lkml.org/lkml/2018/5/27/78.

That dependency is useless, because that series is going nowhere.

> > Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h |  1 +
> >  arch/x86/kvm/vmx.c              | 77 +++++++++++++++++++++++++++++++++++++++++
> >  arch/x86/kvm/x86.c              | 10 ++++++
> >  arch/x86/kvm/x86.h              |  5 +++
> >  include/uapi/linux/kvm.h        |  1 +
> >  5 files changed, 94 insertions(+)
> 
> Checking for split lock is done with the MSR_TEST_CTL too, so you should
> not use a capability to expose the availability to KVM userspace.
> Instead you should expose the contents of MSR_TEST_CTL on the host, in a
> similar way to https://marc.info/?l=kvm&m=152998661713547&w=2.
> 
> Please coordinate with Robert Hu on the QEMU patches too, because he's
> working on the infrastructure to use KVM_GET_MSR_FEATURE_INDEX_LIST in QEMU.

Can we please sort out the whole AC mess on the host first including the
detection stuff?

There is no rush for this to be in KVM/QEMU now because all what exists for
this new split lock thing is 'silicon' running on an emulator. And w/o
support in the kernel proper this is completely useless.

So this needs the following things:

  1) Proper enumeration via CPUID or MISC_FEATURES. The current detection
     hack is just broken.
  
  2) A proper host side implementation, which then automatically makes the
     stuff usable in a guest once it is exposed.

  3) A proper way how to expose MSR_TEST_CTL to the guest, but surely not
     with extra split_lock_ctrl voodoo. It's an MSR nothing else. KVM/QEMU
     have standartized ways to deal with MSRs and the required selective
     bitwise access control.

Thanks,

	tglx
