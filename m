Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DEDC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A737F20851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A737F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeLJOx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:53:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32127 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbeLJOx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:53:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2E3B308429C;
        Mon, 10 Dec 2018 14:53:57 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB6DA60BF1;
        Mon, 10 Dec 2018 14:53:55 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Roman Kagan <rkagan@virtuozzo.com>
Cc:     "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>
Subject: Re: [PATCH v2 3/4] x86/kvm/hyper-v: direct mode for synthetic timers
In-Reply-To: <20181210132134.GA5888@rkaganb.sw.ru>
References: <20181126154732.23025-1-vkuznets@redhat.com> <20181126154732.23025-4-vkuznets@redhat.com> <20181210120637.GA13294@rkaganb.sw.ru> <87va41czk5.fsf@vitty.brq.redhat.com> <20181210132134.GA5888@rkaganb.sw.ru>
Date:   Mon, 10 Dec 2018 15:53:54 +0100
Message-ID: <87sgz5cu0t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 10 Dec 2018 14:53:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Mon, Dec 10, 2018 at 01:54:18PM +0100, Vitaly Kuznetsov wrote:
>> Roman Kagan <rkagan@virtuozzo.com> writes:
>> > Just noticed that the patch seems to assume that "direct" timers are
>> > allowed to use any vectors including 0-15.  I guess this is incorrect,
>> > and instead stimer_set_config should error out on direct mode with a
>> > vector less than HV_SYNIC_FIRST_VALID_VECTOR.
>> 
>> The spec is really vague about this and I'm not sure that this has
>> anything to do with HV_SYNIC_FIRST_VALID_VECTOR (as these are actually
>> not "synic" vectors, I *think* that SynIC doesn't even need to be
>> enabled to make them work).
>> 
>> I checked and Hyper-V 2016 uses vector '0xff', not sure if it proves
>> your point :-)
>> 
>> Do you envision any issues in KVM if we keep allowing vectors <
>> HV_SYNIC_FIRST_VALID_VECTOR?
>
> It's actually lapic that treats vectors 0..15 as illegal.  Nothing
> Hyper-V specific here.

Oh, right you are,

Intel SDM 10.5.2 "Valid Interrupt Vectors" says:

"The Intel 64 and IA-32 architectures define 256 vector numbers, ranging
from 0 through 255 (see Section 6.2, “Exception and Interrupt
Vectors”). Local and I/O APICs support 240 of these vectors (in the
range of 16 to 255) as valid interrupts.

When an interrupt vector in the range of 0 to 15 is sent or received
through the local APIC, the APIC indicates an illegal vector in its
Error Status Register (see Section 10.5.3, “Error Handling”). The Intel
64 and IA-32 architectures reserve vectors 16 through 31 for predefined
interrupts, exceptions, and Intel-reserved encodings (see Table
6-1). However, the local APIC does not treat vectors in this range as
illegal."

Out of pure curiosity I checked what Hyper-V does by hacking up linux
and I got "unchecked MSR access error: WRMSR to 0x400000b0" so we know
they follow the spec.

I'll send a patch to fix this, thanks!

-- 
Vitaly
