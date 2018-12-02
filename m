Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF9EC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9A020892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9A020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbeLBXfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:35:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbeLBXfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:35:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 173123082125;
        Sun,  2 Dec 2018 23:35:44 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (ovpn-204-16.brq.redhat.com [10.40.204.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 843255D75E;
        Sun,  2 Dec 2018 23:35:34 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] x86/hyper-v: Mark TLFS structures packed
In-Reply-To: <DC5975C2-6517-4D20-9DC9-574C5439C426@gmail.com>
References: <20181130125422.21494-1-vkuznets@redhat.com> <DC5975C2-6517-4D20-9DC9-574C5439C426@gmail.com>
Date:   Mon, 03 Dec 2018 00:35:35 +0100
Message-ID: <87k1krh588.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sun, 02 Dec 2018 23:35:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav Amit <nadav.amit@gmail.com> writes:

[skip]

>
> Having said that, something else is sort of strange in the TLFS definitions,
> I think (I really know little about this whole protocol). Look at the
> following definitions from hyperv-tlfs.h:
>
>> struct hv_vpset {
>>         u64 format;
>>         u64 valid_bank_mask;
>>         u64 bank_contents[];
>> };
>> 
>> struct hv_tlb_flush_ex {
>>         u64 address_space;
>>         u64 flags;
>>         struct hv_vpset hv_vp_set;
>>         u64 gva_list[];
>> };
>
> It seems you have two flexible array members at the end of hv_tlb_flush_ex.
> This causes bank_contents[x] and gva_list[x] to overlap. So unless they have
> the same meaning, this asks for trouble IMHO.
>

This is weird but intentional :-) We're just following Hyper-V spec
here.

E.g. HvFlushVirtualAddressListEx hypercall has the following input ABI:

[Fixed len head][[Fixed len VP set spec]Var len VP set][Var len addr List]

"Fixed len VP set spec" defines the true length of "Var len VP set" and
"Address List" starts right after that. The length of the whole
structure is also known.

So bank_contents[] and gva_list[] do overlap (and have different
meaning). We take special precautions when forming the structure
(e.g. fill_gva_list() takes 'offset').

-- 
Vitaly
