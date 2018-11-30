Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE430C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92792145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92792145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeLAAy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:54:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbeLAAy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:54:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70F173154849;
        Fri, 30 Nov 2018 13:45:06 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54498165FA;
        Fri, 30 Nov 2018 13:44:56 +0000 (UTC)
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
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/hyper-v: define structures from TLFS as packed
In-Reply-To: <20181130131122.GA2358@rkaganb.sw.ru>
References: <20181130121511.12331-1-vkuznets@redhat.com> <20181130131122.GA2358@rkaganb.sw.ru>
Date:   Fri, 30 Nov 2018 14:44:54 +0100
Message-ID: <87va4ewug9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 30 Nov 2018 13:45:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Fri, Nov 30, 2018 at 01:15:11PM +0100, Vitaly Kuznetsov wrote:
>> Without 'packed' compiler is free to add optimization paddings and re-order
>> structure fields for randomization/optimization. And structures from
>> hyperv-tlfs.h are used for hypervisor-guest communication, we need to
>> ultimately forbid such practices.
>
> Note that __packed also reduces the structure alignment to 1, which is
> not necessarily what you want.
>
> E.g. some of these structures are passed by pointer to the hypercall,
> which requires its arguments to be 8byte-aligned.

Hm,

I thought we always take precautions for Hyper-V hypercall arguments, in
particular

PV IPI/TLB flush use pre-allocated hyperv_pcpu_input_arg,
hv_post_message() uses pre-allocated message page, other call sites use
fast hypercalls where we use registers.

I also checked this patch before sending out, WS2016 guest boots without
issues. Any particular places you're worried about?

>  I'm also not sure
> that passing unaligned argument to [rw]msr is ok, need to
> double-check.

My understanding is that rdmsr/wrmsr instuctions are registers-only.

We can, of course, just add __aligned(8) to some structures but I'd like
to find the reason first.

-- 
Vitaly
