Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D6EC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2A422562
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2A422562
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753418AbeGEH64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:58:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753041AbeGEH6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:58:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A41687A84;
        Thu,  5 Jul 2018 07:58:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-118.ams2.redhat.com [10.36.116.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41213111DD02;
        Thu,  5 Jul 2018 07:58:52 +0000 (UTC)
Subject: Re: [kvmtool test PATCH 24/24] kvmtool: arm: Add support for creating
 VM with PA size
To:     Peter Maydell <peter.maydell@linaro.org>,
        Will Deacon <will.deacon@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-25-git-send-email-suzuki.poulose@arm.com>
 <20180704142241.GG4828@arm.com> <8636wzysfl.wl-marc.zyngier@arm.com>
 <20180704155123.GO4828@arm.com>
 <CAFEAcA9wgnbK8PHMvksezHqgN1BQZd_+sxXCe85AW+E+cfrcXg@mail.gmail.com>
Cc:     Christoffer Dall <cdall@kernel.org>,
        kvm-devel <kvm@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        kvmarm@lists.cs.columbia.edu,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <c04ac446-ec16-6ec9-383a-e93f0e2d7275@redhat.com>
Date:   Thu, 5 Jul 2018 09:58:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9wgnbK8PHMvksezHqgN1BQZd_+sxXCe85AW+E+cfrcXg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 05 Jul 2018 07:58:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 05 Jul 2018 07:58:54 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/05/2018 09:51 AM, Peter Maydell wrote:
> On 4 July 2018 at 16:51, Will Deacon <will.deacon@arm.com> wrote:
>> On Wed, Jul 04, 2018 at 03:41:18PM +0100, Marc Zyngier wrote:
>>> Not really. Let's say I want my IPA space split in two: memory covers
>>> the low 47 bit, and I want MMIO spanning the top 47 bit. With your
>>> scheme, you'd end-up with a 47bit IPA space, while you really want 48
>>> bits (MMIO space implemented by userspace isn't registered to the
>>> kernel).
>>
>> That still sounds quite niche for a VM. Does QEMU do that?
> 
> Not at 47 bits, but we have RAM up to the 256GB mark, and
> MMIO above that (including a large PCI window), so the general
> arrangement of having the top end of the IPA space not
> necessarily be things we've told the kernel about definitely
> exists.

Is this document (2012) still a reference document?
http://infocenter.arm.com/help/topic/com.arm.doc.den0001c/DEN0001C_principles_of_arm_memory_maps.pdf
(especially Fig 5?)

Peter, comments in QEMU hw/arm/virt.c suggested next RAM chunk should be
added at 2TB. This doc suggests to put it at 8TB. I understand the PA
memory map only is suggested but shouldn't we align?

Thanks

Eric


> 
> thanks
> -- PMM
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 
