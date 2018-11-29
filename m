Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10919C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A490720673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A490720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeK2Wl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:41:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbeK2Wl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:41:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB1D1C0578FA;
        Thu, 29 Nov 2018 11:36:22 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 742C85DD8A;
        Thu, 29 Nov 2018 11:36:20 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW0=?= =?utf-8?B?w6HFmQ==?= 
        <rkrcmar@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH v2 1/4] x86/hyper-v: move synic/stimer control structures definitions to hyperv-tlfs.h
In-Reply-To: <B310522C-8D67-4143-8281-2C870A881F6B@gmail.com>
References: <20181126154732.23025-1-vkuznets@redhat.com> <20181126154732.23025-2-vkuznets@redhat.com> <20181126200413.GA7852@rkaganb.sw.ru> <87wooyk6na.fsf@vitty.brq.redhat.com> <20181127184835.GA5147@rkaganip.lan> <8A215F49-BB8F-4E93-AC62-EC33B4734F24@gmail.com> <87a7ltjxnz.fsf@vitty.brq.redhat.com> <alpine.DEB.2.21.1811281404230.1532@nanos.tec.linutronix.de> <B310522C-8D67-4143-8281-2C870A881F6B@gmail.com>
Date:   Thu, 29 Nov 2018 12:36:18 +0100
Message-ID: <87bm68i099.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 29 Nov 2018 11:36:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav Amit <nadav.amit@gmail.com> writes:

>> On Nov 28, 2018, at 5:07 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> 
>> On Wed, 28 Nov 2018, Vitaly Kuznetsov wrote:
>> 
>>> Nadav Amit <nadav.amit@gmail.com> writes:
>>> 
>>>> On a different note: how come all of the hyper-v structs are not marked
>>>> with the “packed" attribute?
>>> 
>>> "packed" should not be needed with proper padding; I vaguely remember
>>> someone (from x86@?) arguing _against_ "packed".
>> 
>> Packed needs to be used, when describing fixed format data structures in
>> hardware or other ABIs, so the compiler cannot put alignment holes into
>> them.
>> 
>> Using packed for generic data structures might result in suboptimal layouts
>> and prevents layout randomization.
>
> Right, I forgot about the structs randomization. So at least for it, the
> attribute should be needed.
>

Not sure when randomization.s used but Hyper-V drivers will of course be
utterly broken with it.

> To prevent conflicts, I think that this series should also add the
> attribute in a first patch, which would be tagged for stable.

As the patchset doesn't add new definitions and as Paolo already queued
it I'd go with a follow-up patch adding "packed" to all hyperv-tlfs.h
structures. The question is how to avoid conflicts when Linus will be
merging this. We can do:
- Topic branch in kvm
- Send the patch to x86, make topic branch and reabse kvm
- Send the patch to kvm
- ... ?

Paolo/Thomas, what would be your preference?

-- 
Vitaly
