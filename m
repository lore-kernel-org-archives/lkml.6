Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7579EC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DEA21A03
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DEA21A03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbeHFTuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:50:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732388AbeHFTuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:50:08 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9322630E6864;
        Mon,  6 Aug 2018 17:40:00 +0000 (UTC)
Received: from sky.random (ovpn-120-41.rdu2.redhat.com [10.10.120.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F442308BDA4;
        Mon,  6 Aug 2018 17:40:00 +0000 (UTC)
Date:   Mon, 6 Aug 2018 13:39:59 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Xiao Guangrong <guangrong.xiao@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rkrcmar@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Junaid Shahid <junaids@google.com>,
        Xiao Guangrong <xiaoguangrong@tencent.com>
Subject: Re: [PATCH] KVM: try __get_user_pages_fast even if not in atomic
 context
Message-ID: <20180806173959.GF1967@redhat.com>
References: <1532706407-11380-1-git-send-email-pbonzini@redhat.com>
 <54a94492-bb0a-3d2c-6c34-64b6c4336b0a@gmail.com>
 <6552edb5-f874-494a-08a4-381d0f438077@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6552edb5-f874-494a-08a4-381d0f438077@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 06 Aug 2018 17:40:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Aug 06, 2018 at 01:44:49PM +0200, Paolo Bonzini wrote:
> On 06/08/2018 09:51, Xiao Guangrong wrote:
> > 
> > 
> > On 07/27/2018 11:46 PM, Paolo Bonzini wrote:
> >> We are currently cutting hva_to_pfn_fast short if we do not want an
> >> immediate exit, which is represented by !async && !atomic.  However,
> >> this is unnecessary, and __get_user_pages_fast is *much* faster
> >> because the regular get_user_pages takes pmd_lock/pte_lock.
> >> In fact, when many CPUs take a nested vmexit at the same time
> >> the contention on those locks is visible, and this patch removes
> >> about 25% (compared to 4.18) from vmexit.flat on a 16 vCPU
> >> nested guest.
> >>
> > 
> > Nice improvement.
> > 
> > Then after that, we will unconditionally try hva_to_pfn_fast(), does
> > it hurt the case that the mappings in the host's page tables have not
> > been present yet?
> 
> I don't think so, because that's quite slow anyway.

There will be a minimal impact, but it's worth it.

The reason it's worth is that we shouldn't be calling
get_user_pages_unlocked in hva_to_pfn_slow if we could pass
FOLL_HWPOISON to get_user_pages_fast.

And get_user_pages_fast is really just __get_user_pages_fast +
get_user_pages_unlocked with just a difference (see below).

Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>

> 
> > Can we apply this tech to other places using gup or even squash it
> > into  get_user_pages()?
> 
> That may make sense.  Andrea, do you have an idea?

About further improvements looking at commit
5b65c4677a57a1d4414212f9995aa0e46a21ff80 it looks like it may be worth
adding a new gup variant __get_user_pages_fast_irq_enabled to make our
slow path "__get_user_pages_fast_irq_enabled +
get_user_pages_unlocked" really as fast as get_user_pages_fast (which
we can't call in the atomic case and can't take the foll flags, making
it take the foll flags would also make it somewhat slower by adding
branches).

If I understand correctly the commit header Before refers to when
get_user_pages_fast was calling __get_user_pages_fast, and After is
the optimized version without local_irq_save/restore but instead using
local_irq_disable/enable.

So we'd need to call a new __get_user_pages_fast_irq_enabled instead
of __get_user_pages_fast that would only safe to call when irq are
enabled and that's always the case for KVM also for the atomic case
(KVM's atomic case is atomic only because of the spinlock, not because
irqs are disabled). Such new method would then also be ok to be called
from interrupts as long as irq are enabled when it is being called.

Such change would also contribute to reduce the minimal impact to the
_slow case. x86 would be sure fine with the generic version and it's
trivial to implement, I haven't checked other arch details.

Thanks,
Andrea
