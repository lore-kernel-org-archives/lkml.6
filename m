Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A208C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E41C20862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E41C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbeGaRjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:39:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732333AbeGaRjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:39:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F5087C6A9;
        Tue, 31 Jul 2018 15:58:56 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FE401C701;
        Tue, 31 Jul 2018 15:58:55 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH rebase/RFC 0/4] x86/kvm/nVMX: optimize MMU switch between L1 and L2
References: <1532710601-45449-1-git-send-email-pbonzini@redhat.com>
Date:   Tue, 31 Jul 2018 17:58:54 +0200
In-Reply-To: <1532710601-45449-1-git-send-email-pbonzini@redhat.com> (Paolo
        Bonzini's message of "Fri, 27 Jul 2018 18:56:37 +0200")
Message-ID: <87bmano0qp.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 31 Jul 2018 15:58:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 31 Jul 2018 15:58:56 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> This is a rebased version of Vitaly's RFC series.  This isn't
> quite ready for application as I haven't yet thought through
> the interactions between the root_mmu/guest_mmu split and
> the multi-root caching.
>
> Speaking of the multi-root caching, it is a bit of a duplicate work
> with Vitaly's last three patches that avoided reinitialization if
> the parameters and CR3 matched, so the series got smaller too.
>

Thank you for the rebase,

it seems that with multi-root caching this series should just ignore CR3
changes for both root_mmu and guest_mmu: we now have two separate
'prev_roots' caches and these work well. However, we still can optimize
MMU re-initialization on L1->L2 and L2->L1 switches out using e.g. my
'scache' idea (which can be orthogonal to page_role check on CR3).

In my Hyper-V-on-KVM environment I'm seeing an additional 1000 CPU
cycles win for a nested vmexit.

I'll pull things together and re-send the whole series.

-- 
  Vitaly
