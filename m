Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A49ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0AF20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0AF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbeGTOPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:15:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731176AbeGTOPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:15:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B26B840704BB;
        Fri, 20 Jul 2018 13:26:59 +0000 (UTC)
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id C90A62026D69;
        Fri, 20 Jul 2018 13:26:57 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Fri, 20 Jul 2018 15:26:56 +0200
Date:   Fri, 20 Jul 2018 15:26:56 +0200
From:   Radim Krcmar <rkrcmar@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v3 5/6] KVM: X86: Add NMI support to PV IPIs
Message-ID: <20180720132656.GB8330@flask>
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
 <1530598891-21370-6-git-send-email-wanpengli@tencent.com>
 <20180719163138.GC11749@flask>
 <CANRm+CwzG8jcsVhhGa2w55KcCTpwm-yokFR2Oi6LYaoS0ameqQ@mail.gmail.com>
 <825c953c-ec48-84cf-f1ca-bdee5d327427@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <825c953c-ec48-84cf-f1ca-bdee5d327427@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 20 Jul 2018 13:26:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 20 Jul 2018 13:26:59 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-20 10:04+0200, Paolo Bonzini:
> On 20/07/2018 05:53, Wanpeng Li wrote:
> >>> -     ret = kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap_low, ipi_bitmap_high, vector);
> >>> +     switch (vector) {
> >>> +     default:
> >>> +             icr = APIC_DM_FIXED | vector;
> >>> +             break;
> >>> +     case NMI_VECTOR:
> >>> +             icr = APIC_DM_NMI;
> >> I think it would be better to say that KVM interprets NMI_VECTOR and
> >> sends the interrupt as APIC_DM_NMI.
> 
> It's not KVM, this is arch/x86/kernel/kvm.c so the guest side.

Yes, I was preparing to drop the delivery mode bits as they are not
needed for NMI_VECTOR: real APIC can't send nor receive vectors 0-15, so
we could just say that NMI_VECTOR is sendable through this interface and
is delivered as APIC_DM_NMI.

I didn't realize that this allows the other delivery modes.  They are
not useful [1], but we don't really have a better use for the three
bits.  The only other option so far is extending the cluster index to
increase addressability ... I'm starting to reconsider as addressing
another few millions VCPUs would probably be even more useless.

Wanpeng, sorry for the confusion, feel free to use any version.
Document the hypercall layout, though,

thanks.

---
1: I think that OSes will use unicast INIT+SIPI as it's easier to call
   it after preparing structures for the new CPU;  SMI is pointless;
   LowestPriority shouldn't be supported; and Reserved (APIC_DM_REMRD)
   is reused for KVM unhalt, where unicast is most likely.
