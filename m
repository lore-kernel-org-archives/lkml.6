Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26253C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D129C21354
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D129C21354
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeGDSkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 14:40:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48398 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbeGDSkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 14:40:04 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1famh0-00045a-7y; Wed, 04 Jul 2018 20:39:54 +0200
Date:   Wed, 4 Jul 2018 20:39:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
cc:     Jingqi Liu <jingqi.liu@intel.com>, rkrcmar@redhat.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        wei.w.wang@intel.com, Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v2] KVM: Expose the split lock detection feature to guest
 VM
In-Reply-To: <a83b9b41-afbb-016d-528b-029f1b6228ae@redhat.com>
Message-ID: <alpine.DEB.2.21.1807042035340.12092@nanos.tec.linutronix.de>
References: <1530709593-87702-1-git-send-email-jingqi.liu@intel.com> <7813a04b-8058-538b-8c9b-cdd01ce119ac@redhat.com> <alpine.DEB.2.21.1807041636340.1752@nanos.tec.linutronix.de> <a83b9b41-afbb-016d-528b-029f1b6228ae@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, Paolo Bonzini wrote:
> On 04/07/2018 16:51, Thomas Gleixner wrote:
> > There is no rush for this to be in KVM/QEMU now because all what exists for
> > this new split lock thing is 'silicon' running on an emulator. And w/o
> > support in the kernel proper this is completely useless.
> 
> That's good.  I assumed it was IceLake, in which case the feature would
> block the definition of a standard IceLake CPU model in QEMU.
> 
> > So this needs the following things:
> > 
> >   1) Proper enumeration via CPUID or MISC_FEATURES. The current detection
> >      hack is just broken.
> 
> Yes please.
> 
> >   2) A proper host side implementation, which then automatically makes the
> >      stuff usable in a guest once it is exposed.
> 
> If the CPUID bit or MISC_FEATURES is added, you don't even need the host
> side for the guests to use it.  It's only needed now because of the ugly
> MSR-based detection.
> 
> >   3) A proper way how to expose MSR_TEST_CTL to the guest, but surely not
> >      with extra split_lock_ctrl voodoo. It's an MSR nothing else. KVM/QEMU
> >      have standartized ways to deal with MSRs and the required selective
> >      bitwise access control.
> 
> That part is pretty much standard, I'm not worried about it.  We have
> one variable in struct kvm_vcpu_arch for each MSR (or set of MSRs) that
> we expose, so that's the split_lock_ctrl voodoo. :)
> 
> Once the detection is sorted out, KVM is easy.

That's what I thought and even if it was IceLeak then they still can flip a
CPUID/MISC FEATURE bit in their binary BIOS blob or ucode. We really need
to push back hard on these half baken features which need voodoo
programming to detect.

Thanks,

	tglx
