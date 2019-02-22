Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C98C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD33E20657
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfBVStk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:49:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33562 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfBVStk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:49:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so3491144wrw.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aFJBiKsmmBPPLrxLVXF8P2JEeeJ4+/wn0sRZiXO8I+o=;
        b=ohst1g7HbAdhAZrobZnshSCZlUzZSvMS1cgbxnT+RAk2Xpmc9pICQhC1kr3Vwxmhts
         D7wtW4IKD+Yzz4ikIZn6XTpdh+PsyP3qzalHz2Ww+jZ5/O4t5GsMa/Ro02BDNvMk7QOn
         l5RWJQiY/04OeXpx6WHXkYXTPB8AtmBgrYBGCnRPB/8MRpKKyxRGgERjKZQ/0MlpTz0R
         Uk8KuR1tjdURmwPwbh628/QJ7Viqcq4pCcvHRHp+fl+rTEkL/asbH5lImUHRtDzwIKDP
         Owy0AcxkYAYf/NTeNP8edwxG0waScXIoTjavhNQfsLdWDDDFO1nVF/pZoOcOOYk7Cqn+
         x0Xw==
X-Gm-Message-State: AHQUAuaer3Lnma271y93I9ZTjlk70fcfZMhXhpXRBxtyD4hgeapsYNgO
        NNuQlRO4IZyjQ3G+jzsAsX9Exyt7gsU=
X-Google-Smtp-Source: AHgI3IYUVjlUdSTGcvEbR7NN1AulsARyDzWms2M5F46h3NKshX6ihKSxIgXmEVsPOin4rsaCvQZXuw==
X-Received: by 2002:a5d:6b8f:: with SMTP id n15mr4096298wrx.110.1550861377923;
        Fri, 22 Feb 2019 10:49:37 -0800 (PST)
Received: from vitty.brq.redhat.com (ip-213-220-248-130.net.upcbroadband.cz. [213.220.248.130])
        by smtp.gmail.com with ESMTPSA id n129sm2119063wmf.21.2019.02.22.10.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 10:49:37 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kvm/mmu: make mmu->prev_roots cache work for NPT case
In-Reply-To: <bb45499b-bdb2-f170-74ee-09c4eaf41e1a@redhat.com>
References: <20190222164616.13859-1-vkuznets@redhat.com> <bb45499b-bdb2-f170-74ee-09c4eaf41e1a@redhat.com>
Date:   Fri, 22 Feb 2019 19:49:35 +0100
Message-ID: <87tvgvslog.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 22/02/19 17:46, Vitaly Kuznetsov wrote:
>> I noticed that fast_cr3_switch() always fails when we switch back from L2
>> to L1 as it is not able to find a cached root. This is odd: host's CR3
>> usually stays the same, we expect to always follow the fast path. Turns
>> out the problem is that page role is always mismatched because
>> kvm_mmu_get_page() filters out cr4_pae when direct, the value is stored
>> in page header and later compared with new_role in cached_root_available().
>> As cr4_pae is always set in long mode prev_roots cache is dysfunctional.
>
> Really cr4_pae means "are the PTEs 8 bytes".  So I think your patch is
> correct but on top we should set it to 1 (not zero!!) for
> kvm_calc_shadow_ept_root_page_role, init_kvm_nested_mmu and
> kvm_calc_tdp_mmu_root_page_role.  Or maybe everything breaks with that
> change.
>

Yes, exactly. If we put '1' there kvm_mmu_get_page() will again filter
it out and we won't be able to find the root in prev_roots cache :-(

>> - Do not clear cr4_pae in kvm_mmu_get_page() and check direct on call sites
>>  (detect_write_misaligned(), get_written_sptes()).
>
> These only run with shadow page tables, by the way.
>

Yes, and that's why I think it may make sense to move the filtering
logic there. At least in other cases cr4_pae will always be equal to
is_pae().

It seems I know too little about shadow paging and all these corner
cases :-(

-- 
Vitaly
