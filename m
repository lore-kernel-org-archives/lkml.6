Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC01C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E3C28058
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E3C28058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936719AbeF2P0B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:26:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935115AbeF2PZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:25:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3360440201C7;
        Fri, 29 Jun 2018 15:25:59 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 562E02026D68;
        Fri, 29 Jun 2018 15:25:57 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Roman Kagan <rkagan@virtuozzo.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] KVM: x86: hyperv: introduce vp_index_to_vcpu_idx mapping
References: <20180628135313.17468-1-vkuznets@redhat.com>
        <20180628135313.17468-3-vkuznets@redhat.com>
        <20180629101134.GA15656@rkaganb.sw.ru>
        <87y3exdh2o.fsf@vitty.brq.redhat.com>
        <20180629111227.GB15656@rkaganb.sw.ru>
        <87tvplddrr.fsf@vitty.brq.redhat.com>
        <20180629125216.GC15656@rkaganb.sw.ru>
        <87h8lld9hl.fsf@vitty.brq.redhat.com>
        <20180629143212.GD15656@rkaganb.sw.ru>
Date:   Fri, 29 Jun 2018 17:25:56 +0200
In-Reply-To: <20180629143212.GD15656@rkaganb.sw.ru> (Roman Kagan's message of
        "Fri, 29 Jun 2018 17:32:13 +0300")
Message-ID: <878t6xd37f.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 29 Jun 2018 15:25:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 29 Jun 2018 15:25:59 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Fri, Jun 29, 2018 at 03:10:14PM +0200, Vitaly Kuznetsov wrote:
>> Roman Kagan <rkagan@virtuozzo.com> writes:
>> 
>> > On Fri, Jun 29, 2018 at 01:37:44PM +0200, Vitaly Kuznetsov wrote:
>> >> The problem we're trying to solve here is: with PV TLB flush and IPI we
>> >> need to walk through the supplied list of VP_INDEXes and get VCPU
>> >> ids. Usually they match. But in case they don't [...]
>> >
>> > Why wouldn't they *in practice*?  Only if the userspace wanted to be
>> > funny and assigned VP_INDEXes randomly?  I'm not sure we need to
>> > optimize for this case.
>> 
>> Can someone please remind me why we allow userspace to change it in the
>> first place?
>
> I can ;)
>
> We used not to, and reported KVM's vcpu index as the VP_INDEX.  However,
> later we realized that VP_INDEX needed to be persistent across
> migrations and otherwise also known to userspace.  Relying on the kernel
> to always initialize its indices in the same order was unacceptable, and
> we came up with no better way of synchronizing VP_INDEX between the
> userspace and the kernel than to let the former to set it explicitly.
>
> However, this is basically a future-proofing feature; in practice, both
> QEMU and KVM initialize their indices in the same order.


Thanks!

But in the theoretical case when these indices start to differ after
migration, users will notice a slowdown which will be hard to explain,
right? Does it justify the need for vp_idx_to_vcpu_idx?

In any case I sent v3 with vp_idx_to_vcpu_idx dropped for now, hope
Radim is OK with us de-coupling these discussions.

-- 
  Vitaly
