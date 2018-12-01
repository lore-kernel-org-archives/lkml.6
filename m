Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88B7C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9364820867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKkiWZY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9364820867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeLARd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 12:33:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46811 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeLARd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 12:33:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so3849684pfe.13;
        Fri, 30 Nov 2018 22:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=X+/Miiw+HZl3PBTPXOya5567q84kd2r2b989Ug38Kz8=;
        b=rKkiWZY8+50CZcKmo5s9sEyj0fjxJ4VT6zKbmwdqzyTCKtjqy450TIBUxFW+4SLrrA
         6pRE/MW06GpJ0wPC5HosRhg19YKSmgE0wMurOuWHWCDwn7ZEOCq7YkOTlkR9HG2RHCwL
         WKIZvpsJNMMjkvU7U5hMX5rFE6J7ZndindIIRA4lVHNkoMRxKVV0TKTACk+wrCwm/8Po
         7X5azknQ8X65LPWqbqd6kCmayhhXEpVKIPSuIuL1vF2ffXTIQ+DirIaJwT4b1h6mCcSe
         qcllVGQTpdeCniuN7XwJGzWBSMi6ShiJl96X4Uc7rjbMaSepBWqu4y5OAU3Rb/UC/e8K
         erOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=X+/Miiw+HZl3PBTPXOya5567q84kd2r2b989Ug38Kz8=;
        b=ZV6CwBjmNTOwKYDrzP7gZQR8CJktCoinp+MIzl7uk/yIxXHQxU1WJMKCJai54hpmiS
         caxjjT/KxATZDpswKT9LvlX/JIoov9GkXc9SQ4IARUEfsbfEzVOITYfuOQGMuORd1+9q
         xddgq7FtY3O22S7g7Y7W5EKtK0U4pOyuvig8iyCfBWG9kKZhklAUZGbUWyZJpk201eeA
         96MPfV5WcSW3tOec6HW+I9kPWPcr5VTAv0msmosQPDDKBrpOSaNj1FgyYZnbkASi3W2N
         M4FzIM7aYnD/9pFsZ+6+iw0cKl8iG1/Unutoqyhh4JOAEGV/ka/1aJckafIjSwpli9JL
         +MOA==
X-Gm-Message-State: AA+aEWZvw7qHwaBDSlLNMciZXMcTCknxp0I/KorbCvc1jKAT+vgq3CjP
        q0UlVFKwR9E9eeu+iY9AvQ0=
X-Google-Smtp-Source: AFSGD/XcaUyGtJmCaCazio75SKYO/l17TTpEWNE1jjNmSerl85uiTWUp8YxSI+EhG+n87YTFqfXZXA==
X-Received: by 2002:a63:2586:: with SMTP id l128mr7257069pgl.104.1543645298909;
        Fri, 30 Nov 2018 22:21:38 -0800 (PST)
Received: from ?IPv6:2601:647:4580:b719:7176:5f0b:7fa8:674c? ([2601:647:4580:b719:7176:5f0b:7fa8:674c])
        by smtp.gmail.com with ESMTPSA id e123sm8487254pgc.58.2018.11.30.22.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 22:21:37 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH v2] x86/hyper-v: Mark TLFS structures packed
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20181130125422.21494-1-vkuznets@redhat.com>
Date:   Fri, 30 Nov 2018 22:21:35 -0800
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: 7bit
Message-Id: <DC5975C2-6517-4D20-9DC9-574C5439C426@gmail.com>
References: <20181130125422.21494-1-vkuznets@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Nov 30, 2018, at 4:54 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> 
> The TLFS structures are used for hypervisor-guest communication and must
> exactly meet the specification.
> 
> Compilers can add alignment padding to structures or reorder struct members
> for randomization and optimization, which would break the hypervisor ABI.
> 
> Mark the structures as packed to prevent this.

Seems good to me (I made sure you remembered to set __packed for the nested
structs ;-) )

If needed:

Acked-by: Nadav Amit <nadav.amit@gmail.com>


Having said that, something else is sort of strange in the TLFS definitions,
I think (I really know little about this whole protocol). Look at the
following definitions from hyperv-tlfs.h:

> struct hv_vpset {
>         u64 format;
>         u64 valid_bank_mask;
>         u64 bank_contents[];
> };
> 
> struct hv_tlb_flush_ex {
>         u64 address_space;
>         u64 flags;
>         struct hv_vpset hv_vp_set;
>         u64 gva_list[];
> };

It seems you have two flexible array members at the end of hv_tlb_flush_ex.
This causes bank_contents[x] and gva_list[x] to overlap. So unless they have
the same meaning, this asks for trouble IMHO.

