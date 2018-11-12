Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F21C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E098F223CB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E098F223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeKMAdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:33:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37175 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbeKMAdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:33:15 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13B8CC0C0562;
        Mon, 12 Nov 2018 14:39:43 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD60D1019632;
        Mon, 12 Nov 2018 14:39:41 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/kvm/nVMX: tweak shadow fields
In-Reply-To: <CALMp9eQ4493qH4sA4e5UibaHhatEKnztGNBO2s40jc2jXXCdUQ@mail.gmail.com>
References: <20181019141603.15995-1-vkuznets@redhat.com> <31279dfd-d0a1-3720-46a2-52395a124057@redhat.com> <CALMp9eQ4493qH4sA4e5UibaHhatEKnztGNBO2s40jc2jXXCdUQ@mail.gmail.com>
Date:   Mon, 12 Nov 2018 15:39:40 +0100
Message-ID: <87pnvas6kz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 12 Nov 2018 14:39:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> I'm not convinced that the "one size fits all" and "context-free"
> approaches to VMCS shadowing are terribly effective.
>
> For example, we never shadow VMX_INSTRUCTION_INFO, but if we just
> reflected an exit to L1 for which that field is defined, there's
> probably a good chance that L1 will use it. We always shadow
> VM_EXIT_INTR_INFO, but if we didn't just reflect exit reason 0 to L1,
> it's not likely to be read. If the L2 guest is in legacy mode or
> compatibility mode, L1 is much more likely to be interested in the
> contents of the descriptor cache than if the guest is in 64-bit mode.
>
> Some hypervisors write TSC_OFFSET quite frequently. Others rarely.
> Last time I checked (it's been a while), VirtualBox was always
> interested in everything. :-) Kvm, Hyper-V, VMware, VirtualBox,
> Parallels...they all have different patterns, and they change from
> release to release.
>
> Is it worth having a set of VMCS shadowing bitmaps per-vCPU, in order
> to make better use of this feature?

Per CPU or not, to improve the feature we'll probably need some sort of
an 'adaptive' algorithm picking which fields to shadow. I haven't
thought this through, especially read/write shadowing, but we can
probably start with an empty bitmap and later shadow it when we get over
some threshold of vmread/vmwrite exits we enabling shadowing. The
question is when we un-shadow it. For example, we can un-shadow a field
for writing every time we see it was not changed between two exits to L0
(so we're trying to write the same value to vmcs12).

-- 
Vitaly
