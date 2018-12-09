Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC75DC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9B22086E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9B22086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbeLIWyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:54:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbeLIWyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:54:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8D1585363;
        Sun,  9 Dec 2018 22:54:14 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25B3E608EF;
        Sun,  9 Dec 2018 22:54:09 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 4/6] x86/kvm/hyper-v: Introduce KVM_GET_SUPPORTED_HV_CPUID
In-Reply-To: <20181206165825.1832-5-vkuznets@redhat.com>
References: <20181206165825.1832-1-vkuznets@redhat.com> <20181206165825.1832-5-vkuznets@redhat.com>
Date:   Sun, 09 Dec 2018 23:54:11 +0100
Message-ID: <871s6qe2gc.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sun, 09 Dec 2018 22:54:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> With every new Hyper-V Enlightenment we implement we're forced to add a
> KVM_CAP_HYPERV_* capability. While this approach works it is fairly
> inconvenient: the majority of the enlightenments we do have corresponding
> CPUID feature bit(s) and userspace has to know this anyways to be able to
> expose the feature to the guest.
>
> Add KVM_GET_SUPPORTED_HV_CPUID ioctl (backed by KVM_CAP_HYPERV_CPUID, "one
> cap to rule them all!") returning all Hyper-V CPUID feature leaves.
>
> Using the existing KVM_GET_SUPPORTED_CPUID doesn't seem to be possible:
> Hyper-V CPUID feature leaves intersect with KVM's (e.g. 0x40000000,
> 0x40000001) and we would probably confuse userspace in case we decide to
> return these twice.
>
> KVM_CAP_HYPERV_CPUID's number is interim: we're intended to drop
> KVM_CAP_HYPERV_STIMER_DIRECT and use its number instead.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c    | 127 +++++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/hyperv.h    |   2 +
>  arch/x86/kvm/x86.c       |  20 ++++++
>  include/uapi/linux/kvm.h |   4 ++

Well, this is a bit embarrassing but apparently I forgot to document both
KVM_GET_SUPPORTED_HV_CPUID and KVM_CAP_HYPERV_CPUID (I, as usual was
postponing documentation writing for as long as I could - and then just
sent this out).

Stay tuned, v2 is coming.

-- 
Vitaly
