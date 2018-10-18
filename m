Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196B3ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CE62087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CE62087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbeJRTPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:15:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbeJRTPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:15:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B879030F8BEC;
        Thu, 18 Oct 2018 11:14:42 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D58310018F8;
        Thu, 18 Oct 2018 11:14:40 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Liran Alon <liran.alon@oracle.com>,
        kvm list <kvm@vger.kernel.org>
Subject: Re: [PATCH v6 06/13] KVM: nVMX: optimize prepare_vmcs02{,_full} for Enlightened VMCS case
In-Reply-To: <173cc977-58fd-9431-6199-c2eb8e898f7c@redhat.com>
References: <20181016165011.6607-1-vkuznets@redhat.com> <20181016165011.6607-7-vkuznets@redhat.com> <2064be05-4286-e3d5-cd22-13fd957b7003@redhat.com> <8736t4sk8w.fsf@vitty.brq.redhat.com> <0ff3acb0-1d20-cbb0-5f40-887d9db93d9e@redhat.com> <CALMp9eTtSuguXb=gCWKL9ZKWy5kUve0SNY1Toduf8x2Qn=1s9Q@mail.gmail.com> <173cc977-58fd-9431-6199-c2eb8e898f7c@redhat.com>
Date:   Thu, 18 Oct 2018 13:14:38 +0200
Message-ID: <87sh13qzfl.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 18 Oct 2018 11:14:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 17/10/2018 19:08, Jim Mattson wrote:
>> I believe that ESXi reads GUEST_CS_AR_BYTES on every VM-exit to
>> determine code size.
>
> Which makes me wonder, maybe we should add GUEST_SS_AR_BYTES which is
> where the CPL lives.  But then your tests from last year didn't find it.
>

Hyper-V does read GUEST_SS_AR_BYTES. Way less frequent than
GUEST_CS_AR_BYTES but still.

Based on that my suggestion would be to shadow GUEST_SS_AR_BYTES, keep
GUEST_SS_AR_BYTES and unshadow the rest (GUEST_ES_BASE,
GUEST_CS_SELECTOR, GUEST_CS_LIMIT, GUEST_CS_BASE). I can do this as a
separate patch as I see this series is already in kvm/queue.

-- 
Vitaly
