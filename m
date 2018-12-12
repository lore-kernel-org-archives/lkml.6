Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9363CC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBC32080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBC32080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeLLRn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:43:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbeLLRn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:43:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C24CC070477;
        Wed, 12 Dec 2018 17:43:26 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0128B600CC;
        Wed, 12 Dec 2018 17:43:23 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] x86/hyper-v: Mark TLFS structures packed
In-Reply-To: <20181203140636.21912-1-vkuznets@redhat.com>
References: <20181203140636.21912-1-vkuznets@redhat.com>
Date:   Wed, 12 Dec 2018 18:43:23 +0100
Message-ID: <87mupa4p50.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 12 Dec 2018 17:43:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

>  /* Define virtual processor assist page structure. */
>  struct hv_vp_assist_page {
> @@ -519,7 +519,7 @@ struct hv_vp_assist_page {
>  	__u64 nested_enlightenments_control[2];
>  	__u32 enlighten_vmentry;
>  	__u64 current_nested_vmcs;
> -};
> +} __packed;
>  

This particular structure wasn't properly padded: u32 padding is missing
between 'enlighten_vmentry' and 'current_nested_vmcs'.

>  struct hv_enlightened_vmcs {
>  	u32 revision_id;
> @@ -693,7 +693,7 @@ struct hv_enlightened_vmcs {
>  		u32 nested_flush_hypercall:1;
>  		u32 msr_bitmap:1;
>  		u32 reserved:30;
> -	} hv_enlightenments_control;
> +	}  __packed hv_enlightenments_control;
>  	u32 hv_vp_id;
>  
>  	u64 hv_vm_id;
> @@ -703,7 +703,7 @@ struct hv_enlightened_vmcs {
>  	u64 padding64_5[7];
>  	u64 xss_exit_bitmap;
>  	u64 padding64_6[7];
> -};
> +} __packed;

struct hv_enlightened_vmcs also has a hole: we need an u16 padding after
'u16 host_tr_selector'.

Both these problems led to Enlightened VMCS for Hyper-V on KVM being
completely broken.

As this is not yet merged, v4 is coming to rescue!

-- 
Vitaly
