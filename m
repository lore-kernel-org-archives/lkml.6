Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF6EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3963D20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3963D20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeLMK0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:26:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeLMK0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:26:06 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E9F43078A50;
        Thu, 13 Dec 2018 10:26:06 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB5D41059585;
        Thu, 13 Dec 2018 10:26:03 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v6 05/13] KVM: nVMX: implement enlightened VMPTRLD and VMCLEAR
In-Reply-To: <CALMp9eTqBJsZ0L36CGeRy20BVTryJgQtmqAUs0Lg_+NJnbyxzw@mail.gmail.com>
References: <20181016165011.6607-1-vkuznets@redhat.com> <20181016165011.6607-6-vkuznets@redhat.com> <CALMp9eTqBJsZ0L36CGeRy20BVTryJgQtmqAUs0Lg_+NJnbyxzw@mail.gmail.com>
Date:   Thu, 13 Dec 2018 11:26:02 +0100
Message-ID: <87k1kd4tad.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 13 Dec 2018 10:26:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Tue, Oct 16, 2018 at 9:50 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> +
>> +               vmx->nested.hv_evmcs = kmap(vmx->nested.hv_evmcs_page);
>
> Are you sure that directly mapping guest memory isn't going to lead to
> time-of-check vs. time-of-use bugs? This is a very hard programming
> model to get right.

The basic assumption here is that Enlightened VMCS (just like normal or
shadow VMCSes) is being access by one L1 vCPU only. When we access it
from KVM the vCPU is not running. Yes, L1 guest can screw itself up by
breaking this assumption but honestly I don't see how this is different
from normal VMCS: we can always break things by writing to the page from
a different vCPU.

Enlightened VMCS is (mostly) not used directly: we copy it to vmcs12 and
then back before entry. The only field we always access directly is
hv_clean_fields. We can, of course, copy it to vmcs12 too but I failed
to find a reason to do so: L1 guest is in control of the field, it can
always write junk there and L2 guest will likely get broken.

I remember having map/copy/unmap sequences for eVMCS on entry/exit in
some early version of this series but it was just slowing things down so
I switched to having it permanently mapped. In case you see (potential)
grave bugs with this we can of course re-consider.

Thanks,

-- 
Vitaly
