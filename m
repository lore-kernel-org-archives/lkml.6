Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE03C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD5A20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7dpqGuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD5A20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbeLEThI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:37:08 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39137 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeLEThH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:37:07 -0500
Received: by mail-oi1-f194.google.com with SMTP id i6so18583250oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 11:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgiayQV6bLZ8M1mFXFts+Svs4WSMBnsKV1Qp7QnpNMw=;
        b=q7dpqGuEeUHhAlld/n5424wIaTkNVCIs2hNG45a9wO6EY2SQg0s/7GNTo87FeDNtYm
         Jctc12Zkml/ar0Nd1OLDUR9Xj1Lqbw6w7cAFeDdbAEqAqpOBDTGtk7WeCRgC3oYeauG7
         dOBLD46CL4Pbnt4e/6xTPvRANF5kuaMBtNgULk12OM6TADbL/9a5vI4KGg1t1doS0PTf
         ElnTyWiAa4RsdCwMJPkZge5T5Zhk3S3743dbIR7ZNWh9i/vOR4sZm0rFvj/117Jf2q7C
         hQeS8rF2ygLuP/DOuIXIfLiqxK1iFqs36MJcpIWAElRF5NkEkLTxd7K5HdWFeDNG60V3
         suZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgiayQV6bLZ8M1mFXFts+Svs4WSMBnsKV1Qp7QnpNMw=;
        b=EMM213FmubB8gIQ7cJiagxZ52tnN2jeWor27FaxAEwD9N+MehpTjfrnWXZhgLHwchk
         wjcJB44nEt+AbWedpgGKTwp0YT43jiUGC70zCiWGj55JLNgB6tOfLgyzWb+LI8PqFJFH
         h9IL30w8L+5JCxphu6wcCSpEguwOOKQ33XRTKszlqhF6SSOMkKfciFNVxOTT+UAutMCu
         yz7excpYsgu80q+0m9ykqY095j9IVToECPvkfR2Fw3W7QyRcDpzbx3KWJ8WI1SpTwKHI
         tk7FQ9mE4UMUy5ePF7bQgaCfbU7iJPjXtQAn+g4E+EHtcazLeuvYxn/+uicpgAEnLg9m
         PvSQ==
X-Gm-Message-State: AA+aEWZ93U7Xv2JBPc1kGO6KqHNNdAWd0ngb33dvTS5GwAhh09NzRW/h
        O1sXaPK2RDL6j0m1RC22cIZB+b35NlSl4LP0gSbr+Y+lv98=
X-Google-Smtp-Source: AFSGD/V69CODSMmTysjbr8VDCau4zEStibhxyskGvLviKDHtDqg/QAkkW6+75W7Wjkf1b9wIv8ByVjlsCLf00xfqZy4=
X-Received: by 2002:aca:c7cc:: with SMTP id x195mr16733159oif.196.1544038625842;
 Wed, 05 Dec 2018 11:37:05 -0800 (PST)
MIME-Version: 1.0
References: <20181205191956.31480-1-ehabkost@redhat.com>
In-Reply-To: <20181205191956.31480-1-ehabkost@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 5 Dec 2018 11:36:54 -0800
Message-ID: <CALMp9eRZtRb-tUSwomtPg7BCrY4dzny9HMVr+SvanAw3hdN7Dg@mail.gmail.com>
Subject: Re: [PATCH] kvm: x86: Report STIBP on GET_SUPPORTED_CPUID
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 11:19 AM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Months ago, we have added code to allow direct access to MSR_IA32_SPEC_CTRL
> to the guest, which makes STIBP available to guests.  This was implemented
> by commits d28b387fb74d ("KVM/VMX: Allow direct access to
> MSR_IA32_SPEC_CTRL") and b2ac58f90540 ("KVM/SVM: Allow direct access to
> MSR_IA32_SPEC_CTRL").
>
> However, we never updated GET_SUPPORTED_CPUID to let userspace know that
> STIBP can be enabled in CPUID.  Fix that by updating
> kvm_cpuid_8000_0008_ebx_x86_features and kvm_cpuid_7_0_edx_x86_features.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
