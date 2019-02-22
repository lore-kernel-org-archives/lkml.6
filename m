Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F505C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203AB2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfBVSyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:54:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34350 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVSyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:54:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so3502555wrg.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=n5jPGy560HPL/hS/4t1roEBeD6KfdTVPUqDRzqUAzCI=;
        b=s66ls6HbLv3g253rGOsny95WVuWlo/SI1aie67sXFsHvXZ0JjHsp5BqU9AS6oXBzQh
         brwBb4aZ0ni91zrV6bgaRoEiRyjEYHyQxdt7rGQMXTSXqAuIgDaM9cREucUETdyPTIZo
         cMnmaKOr3OpuTdG7J0sMHRp1zcSWszFy1AiayEzr4EfcuGll51OViVj1OfWj4LsKL/Ap
         +PvcicYbJPm3ScKZIeAULIDLiM7T18E92YDPsQpPghxU9JEdSjnNgkASni8AdW0ReNLK
         imebzSLYD2kAc70n0X5DWXwcljZqSP2GjlRucCjKJrnXgDWq6cot+KobYwxBKqzqxApn
         HWUw==
X-Gm-Message-State: AHQUAuZYC6HUNjuPc6ZkQHbNhlyfZwbT43Jts4TpsMNJanHeljfkI089
        6He+DkqSB/Cn/y4CHG2RRONHdvdI5Fw=
X-Google-Smtp-Source: AHgI3IajZZ6vaLT8DjhyUI6sIibLPhHAXppEytb9uQV7GyXEliy2ezqXqoEaJwpbpy2xq55mSEGXOg==
X-Received: by 2002:adf:ffcd:: with SMTP id x13mr3944698wrs.20.1550861670318;
        Fri, 22 Feb 2019 10:54:30 -0800 (PST)
Received: from vitty.brq.redhat.com (ip-213-220-248-130.net.upcbroadband.cz. [213.220.248.130])
        by smtp.gmail.com with ESMTPSA id t14sm2708496wrr.49.2019.02.22.10.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 10:54:29 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kvm/mmu: fix switch between root and guest MMUs
In-Reply-To: <9516b2a1-875e-1850-ed2f-0c8e94eab980@redhat.com>
References: <20190222164501.13605-1-vkuznets@redhat.com> <9516b2a1-875e-1850-ed2f-0c8e94eab980@redhat.com>
Date:   Fri, 22 Feb 2019 19:54:27 +0100
Message-ID: <87r2bzslgc.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 22/02/19 17:45, Vitaly Kuznetsov wrote:
>> Commit 14c07ad89f4d ("x86/kvm/mmu: introduce guest_mmu") brought one subtle
>> change: previously, when switching back from L2 to L1, we were resetting
>> MMU hooks (like mmu->get_cr3()) in kvm_init_mmu() called from
>> nested_vmx_load_cr3() and now we do that in nested_ept_uninit_mmu_context()
>> when we re-target vcpu->arch.mmu pointer.
>> The change itself looks logical: if nested_ept_init_mmu_context() changes
>> something than nested_ept_uninit_mmu_context() restores it back. There is,
>> however, one thing: the following call chain:
>> 
>>  nested_vmx_load_cr3()
>>   kvm_mmu_new_cr3()
>>     __kvm_mmu_new_cr3()
>>       fast_cr3_switch()
>>         cached_root_available()
>> 
>> now happens with MMU hooks pointing to the new MMU (root MMU in our case)
>> while previously it was happening with the old one. cached_root_available()
>> tries to stash current root but it is incorrect to read current CR3 with
>> mmu->get_cr3(), we need to use old_mmu->get_cr3() which in case we're
>> switching from L2 to L1 is guest_mmu. (BTW, in shadow page tables case this
>> is a non-issue because we don't switch MMU).
>> 
>> While we could've tried to guess that we're switching between MMUs and call
>> the right ->get_cr3() from cached_root_available() this seems to be overly
>> complicated. Instead, just stash the corresponding CR3 when setting
>> root_hpa and make cached_root_available() use the stashed value.
>> 
>> Fixes: 14c07ad89f4d ("x86/kvm/mmu: introduce guest_mmu")
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> Is the bug latent until the other patch?  Or are they completely
> separate issues?
>

This one was reported as https://bugs.launchpad.net/qemu/+bug/1813165
(and I still don't completely understand why it is only SMM which is
broken - or is it?). While working on it I noticed that
fast_cr3_switch() actually doesn't work (even after this patch when we
stop putting incorrect values in the cache with
cached_root_available()). So in the end they seem to be fairly
independent.

-- 
Vitaly
